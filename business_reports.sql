-- AlmaBetter Project 3 | Business reports on synthetic demonstration data
-- No real Amazon business records or meaningful market-level trends.

-- R01: Order totals by status
SELECT order_status, COUNT(*) AS order_count, SUM(total_amount) AS total_value
FROM orders GROUP BY order_status ORDER BY total_value DESC;

-- R02: Sales value per seller based on order lines (gross, before refunds)
SELECT s.seller_id, s.seller_name,
       COALESCE(SUM(oi.quantity * oi.unit_price),0) AS gross_sales
FROM sellers s LEFT JOIN seller_listings sl ON sl.seller_id=s.seller_id
LEFT JOIN order_items oi ON oi.listing_id=sl.listing_id
GROUP BY s.seller_id,s.seller_name ORDER BY gross_sales DESC;

-- R03: Low stock listings (sample threshold: 20)
SELECT p.product_name, s.seller_name, sl.price, i.stock_quantity
FROM inventory i JOIN seller_listings sl ON sl.listing_id=i.listing_id
JOIN products p ON p.product_id=sl.product_id
JOIN sellers s ON s.seller_id=sl.seller_id
WHERE i.stock_quantity <= 20 ORDER BY i.stock_quantity ASC;

-- R04: Products and customer ratings
SELECT p.product_name, COUNT(r.review_id) AS rating_count,
       ROUND(AVG(r.rating),2) AS avg_rating
FROM products p LEFT JOIN reviews r ON r.product_id=p.product_id
GROUP BY p.product_id,p.product_name ORDER BY rating_count DESC;

-- R05: Current shipment summary with most recent tracking event
SELECT s.shipment_id, s.tracking_number, s.shipment_status,
       te.event_status AS last_event_status, te.location, te.event_time
FROM shipments s LEFT JOIN LATERAL (
 SELECT event_status,location,event_time FROM tracking_events
 WHERE shipment_id=s.shipment_id
 ORDER BY event_time DESC, tracking_event_id DESC LIMIT 1
) te ON TRUE ORDER BY s.shipment_id;

-- R06: Return and refund reporting
SELECT r.return_id, r.return_status, r.return_reason, oi.order_id,
       rf.refund_amount, rf.refund_status
FROM returns r JOIN order_items oi ON oi.order_item_id=r.order_item_id
LEFT JOIN refunds rf ON rf.return_id=r.return_id
ORDER BY r.return_id;

-- R07: Items purchased by category
SELECT c.category_name, SUM(oi.quantity) AS units,
       SUM(oi.quantity*oi.unit_price) AS gross_sales
FROM order_items oi JOIN seller_listings sl ON sl.listing_id=oi.listing_id
JOIN products p ON p.product_id=sl.product_id
JOIN categories c ON c.category_id=p.category_id
GROUP BY c.category_id,c.category_name ORDER BY gross_sales DESC;
