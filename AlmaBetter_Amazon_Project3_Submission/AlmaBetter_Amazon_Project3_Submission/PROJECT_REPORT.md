# Project Report — Amazon-Inspired E-Commerce Database

## 1. Problem statement & context
A multi-seller e-commerce marketplace must store and relate product offers, customers, order activity, payments, deliveries, reviews, and after-sales support. Storing everything in one flat table would duplicate facts, complicate updates, and increase the risk of inconsistent records. This capstone demonstrates a normalized relational structure with explicit relationships and validation constraints.

**Scope:** A modeled Amazon-style marketplace using synthetic records. This is **not** Amazon's real internal database, integration, or business performance report.

## 2. Objectives
- Design a relational schema covering the full order lifecycle.
- Model many-to-many product-seller relationships using seller listings.
- Add primary keys, foreign keys, CHECK rules and UNIQUE rules.
- Load demonstrative sample data and test joins, returns, refunds, shipment tracking and summaries.
- Use SQL to produce operational and commercial reports.

## 3. Tools & source data
PostgreSQL 17.11, pgAdmin 4, plain-text `pg_dump` export. All results below refer to the snapshot exported at **2026-11-22 13:51:06 IST**, containing 57 synthetic table rows. The original project screenshot and automated live restore were not part of the static audit. The user subsequently restored the SQL dump into a separate PostgreSQL test database and provided screenshots confirming table and constraint counts.

## 4. Tables by domain

| Domain | Tables | Purpose |
| --- | --- | --- |
| Product catalog | categories, products, sellers, seller_listings, inventory | Organize offers and current stock |
| Customer | customers, addresses, carts, cart_items | Customer accounts and shopping carts |
| Transactions | orders, order_items, payments | Orders, purchased items and payment status |
| Fulfilment | shipments, tracking_events | Seller shipments and chronological shipment activity |
| After-sales | reviews, returns, refunds | Feedback, item returns and money reversals |

## 5. Relational model and ERD
The project defines **17 tables** and **22 foreign keys**. Important examples:

- `customers (1) -> (M) addresses`
- `customers (1) -> (M) orders`
- `orders (1) -> (M) order_items`
- `orders (1) -> (M) shipments`
- `shipments (1) -> (M) tracking_events`
- `products (1) -> (M) seller_listings` and `sellers (1) -> (M) seller_listings`
- `order_items (1) -> (M) returns` (possible in design)
- `returns (1) -> (0..1) refunds` (UNIQUE return_id)
- `categories (1) -> (M) categories` self reference for category hierarchy

See `relationship_diagram.svg`. The diagram is rendered from **actual FK definitions** in the backup, not from an assumed schema.

## 6. Normalization discussion

**1NF:** Each defined record consists of atomic named columns rather than lists of repeated products in one field. Order items, tracking events and addresses use separate rows.

**2NF:** The tables use single-column primary keys. The many-to-many listing entity prevents seller-specific attributes such as selling price from being placed directly in `products`. Single-column keys mean there are no non-key attributes partially dependent on a composite primary key; composite UNIQUE rules support business uniqueness.

**3NF (design intent, not a formal proof):** Seller details live in `sellers`, product details in `products`, customer addresses in `addresses`, and shipment history in `tracking_events`, minimizing several common transitive dependencies. However, `orders.total_amount` is a stored summary of its `order_items`, and `shipments.shipment_status` duplicates the latest event state conceptually; these are deliberately useful derived/snapshot fields that require synchronization. A formal normalization audit should include all functional dependencies and business rules.

## 7. Structural findings from the SQL dump

- 17 primary keys, 22 foreign keys, 13 UNIQUE constraints and 20 CHECK constraints were defined.
- `inventory.stock_quantity >= 0`, item quantity > 0, listing price > 0, return quantity > 0, review rating 1 to 5, and status whitelists exist.
- `seller_listings` has UNIQUE(seller_id, product_id), avoiding duplicate offers for the same pair.
- `refunds.return_id` is UNIQUE, allowing at most one refund per return.

## 8. Sample transaction walkthrough

The demonstrative Order #1 contains two order items at ₹650 and ₹700 = ₹1,350, matching the stored `orders.total_amount`. The corresponding UPI payment is ₹1,350 and SUCCESS. The order is SHIPPED, with two seller shipments (SHIPPED and IN_TRANSIT). A single defective-keyboard return has quantity 1 and status REQUESTED, with a linked ₹650 refund marked PENDING. These are snapshot **examples**, not aggregate business outcomes.

## 9. Snapshot consistency checks

The following checks were computed from the exported COPY blocks; no violating sample records were found:

- Orders have matching owned shipping addresses
- Stored order total equals the sum of priced order items
- Shipment seller appears among that order's seller listings
- Per-return quantity does not exceed original purchased quantity
- Refund payment references the same underlying order as the returned item
- Per-refund amount does not exceed its linked payment amount
- No order remains PLACED with a shipment already SHIPPED/IN_TRANSIT/DELIVERED

**These are data-snapshot checks, not proof that future writes cannot violate the rules.** Ten SQL checks are in `validation_queries.sql`; V10 highlights recurring shipment event statuses for manual review, not necessarily an error.

## 10. Risks and improvement opportunities

1. **Cross-table consistency:** The FK on `orders.shipping_address_id` proves address existence, but not that the address belongs to that customer. Additional logic (trigger/application transaction or suitable composite keys) is required.
2. **Refund limits:** FK rules don't enforce cumulative refund totals, same-order matching, or item-specific refund maxima; extra validation is needed.
3. **Returns:** `return_quantity > 0` doesn't enforce the maximum eligible quantity, especially across multiple returns; extra validation is needed.
4. **Shipment lifecycle:** `order_status` and shipment status need synchronization. Shipment seller should correspond to an order line; avoid invalid state transitions.
5. **Tracking:** The demo has repeated CREATED/SHIPPED/IN_TRANSIT events across different dates for the same shipments; verify whether this represents intentional reprocessing or duplicate test data before production-style presentation.
6. **Analytics sample size:** One order cannot support conclusions on seasonality, revenue growth or broader customer behavior. Increase synthetic data for a meaningful demonstration.
7. **Database restore:** The user restored the dump into a separate `amazon_project_3_test` database and verified 17 tables, 3 customers, 1 order (SHIPPED), and matching PK/FK/UNIQUE/CHECK counts. A separate automated restore within this review environment and execution of the full validation script were not performed.

## 11. Proposed business questions and reports

Examples in `business_reports.sql`: order value by status; sales per seller; low-stock listings; product average ratings; latest shipment event; returns and refunds; units and sales by category. Results on the tiny sample are illustrative only.

## 12. Conclusion

The snapshot demonstrates a working foundational 17-table relational marketplace schema, strong declarative constraints, and interconnected sample workflows. After correcting the order-status mismatch, no checked cross-table inconsistency was found in the current sample. For a convincing final submission, retain screenshots of the successful clean database restore, execute the validation and reporting SQL, document schema design decisions, and attach a clear ERD and any institution-required presentation/video links.
