-- AlmaBetter Project 3 | PostgreSQL validation queries
-- These queries DO NOT modify data. Execute each separately in pgAdmin.

-- V01: Order amount must equal sum of order line amounts
SELECT o.order_id, o.total_amount AS stored_total,
       COALESCE(SUM(oi.quantity * oi.unit_price), 0) AS calculated_total
FROM orders o LEFT JOIN order_items oi ON oi.order_id=o.order_id
GROUP BY o.order_id, o.total_amount
HAVING o.total_amount <> COALESCE(SUM(oi.quantity * oi.unit_price), 0);

-- V02: Shipping address must belong to the ordering customer
SELECT o.order_id, o.customer_id, a.customer_id AS address_customer_id
FROM orders o JOIN addresses a ON a.address_id=o.shipping_address_id
WHERE o.customer_id <> a.customer_id;

-- V03: A shipment seller must be represented among that order's line items
SELECT s.shipment_id, s.order_id, s.seller_id
FROM shipments s
WHERE NOT EXISTS (
 SELECT 1 FROM order_items oi JOIN seller_listings sl ON sl.listing_id=oi.listing_id
 WHERE oi.order_id=s.order_id AND sl.seller_id=s.seller_id
);

-- V04: A return must not exceed quantity purchased (per return)
SELECT r.return_id, r.return_quantity, oi.quantity AS purchased_quantity
FROM returns r JOIN order_items oi ON oi.order_item_id=r.order_item_id
WHERE r.return_quantity > oi.quantity;

-- V05: Aggregate non-rejected returns must not exceed quantity purchased
SELECT oi.order_item_id, oi.quantity,
       SUM(r.return_quantity) AS total_requested_return_qty
FROM order_items oi JOIN returns r ON r.order_item_id=oi.order_item_id
WHERE r.return_status <> 'REJECTED'
GROUP BY oi.order_item_id, oi.quantity
HAVING SUM(r.return_quantity) > oi.quantity;

-- V06: Refund must reference a payment on the same original order
SELECT rf.refund_id, oi.order_id AS return_order_id,
       p.order_id AS payment_order_id
FROM refunds rf JOIN returns r ON r.return_id=rf.return_id
JOIN order_items oi ON oi.order_item_id=r.order_item_id
JOIN payments p ON p.payment_id=rf.payment_id
WHERE oi.order_id <> p.order_id;

-- V07: Refund must not exceed associated payment (per refund)
SELECT rf.refund_id, rf.refund_amount, p.payment_amount
FROM refunds rf JOIN payments p ON p.payment_id=rf.payment_id
WHERE rf.refund_amount > p.payment_amount;

-- V08: Order cannot remain PLACED with an advanced shipment state
SELECT o.order_id, o.order_status, s.shipment_id, s.shipment_status
FROM orders o JOIN shipments s ON s.order_id=o.order_id
WHERE o.order_status='PLACED'
 AND s.shipment_status IN ('SHIPPED','IN_TRANSIT','OUT_FOR_DELIVERY','DELIVERED');

-- V09: Compare latest tracking event against current shipment status
-- If event history is behind the shipment summary, investigate the discrepancy.
SELECT s.shipment_id, s.shipment_status,
       t.event_status AS last_event_status, t.event_time
FROM shipments s
JOIN LATERAL (
 SELECT event_status, event_time FROM tracking_events
 WHERE shipment_id=s.shipment_id
 ORDER BY event_time DESC, tracking_event_id DESC LIMIT 1
) t ON TRUE
WHERE s.shipment_status <> t.event_status;

-- V10: Repeat of a demo tracking status for the same shipment (review, not always error)
SELECT shipment_id, event_status, COUNT(*) AS repeat_count
FROM tracking_events GROUP BY shipment_id, event_status
HAVING COUNT(*) > 1;
