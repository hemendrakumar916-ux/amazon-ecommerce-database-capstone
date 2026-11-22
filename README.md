# Amazon-Inspired Marketplace Database — AlmaBetter Capstone Project 3

**Database:** `amazon_capstone_project_3`  
**DBMS:** PostgreSQL 17 / pgAdmin 4  
**Project type:** Relational data modeling and SQL reporting  
**Data:** Synthetic/demo dataset — **not** Amazon's actual database or transactional data.

## Project objective
Design a relational e-commerce system that tracks customers, products, category hierarchy, sellers, seller offers, inventory, carts, orders, payments, shipping events, reviews, returns and refunds. Demonstrate constraints, relationships and practical SQL queries.

## Snapshot audit (22 November 2026, 13:51 IST)

| Metric | Count |
| --- | ---: |
| Tables | 17 |
| Primary keys | 17 |
| Foreign keys | 22 |
| UNIQUE constraints | 13 |
| CHECK constraints | 20 |
| Demo data rows, all tables combined | 57 |

The uploaded final PostgreSQL plain-text dump includes DDL, data, identity sequences, and constraints. Order **1** has status **SHIPPED**, addressing the previously identified `PLACED` vs shipment-stage mismatch.

## Contents

- `amazon_capstone_project_3_final.sql` — snapshot export with schema and example data
- `relationship_diagram.svg` / `.png` — relationship visualization derived from dump
- `relationship_diagram.dot` — editable Graphviz source
- `validation_queries.sql` — ten read-only data-integrity and consistency checks
- `business_reports.sql` — seven illustrative reporting queries
- `PROJECT_REPORT.md` — objective, relationships, normalization notes, results, limitations
- `SUBMISSION_CHECKLIST.md` — what remains before AlmaBetter submission

## Database modules

1. Catalog: `categories`, `products`, `sellers`, `seller_listings`, `inventory`
2. Customer/cart: `customers`, `addresses`, `carts`, `cart_items`
3. Orders: `orders`, `order_items`, `payments`
4. Logistics: `shipments`, `tracking_events`
5. Post-sale: `reviews`, `returns`, `refunds`

## Key data model choices

- A product may have offers from multiple sellers; `seller_listings` implements that many-to-many bridge.
- Category hierarchy uses a self-referencing foreign key (`categories.parent_category_id`).
- `order_items` stores unit price at sale time to preserve the original price even if a listing price later changes.
- An order can have multiple shipments and a shipment has an event history.
- Return and refund have separate lifecycles.

## Run and test

1. Create a **new empty test database** using PostgreSQL 17+.
2. Import `amazon_capstone_project_3_final.sql` using **psql** (it contains pg_dump `COPY` commands; do not paste into pgAdmin Query Tool as a single SQL query).
3. Run `validation_queries.sql` and inspect each result.
4. Run `business_reports.sql` to demonstrate reporting.
5. Open the vector-based `.svg` ERD and inspect at full zoom.

**Example restore command (from a terminal, adjust path):**

```bash
psql -U postgres -d amazon_project3_test -f amazon_capstone_project_3_final.sql
```

**Caution:** Restore only into a fresh database; this dump has `CREATE TABLE` statements and may conflict with existing objects. A restore into a separate `amazon_project_3_test` database was **user-verified in pgAdmin screenshots** on 22 November 2026: 17 tables, 3 customers, 1 order with status SHIPPED, and 17 PK / 22 FK / 13 UNIQUE / 20 CHECK constraints. Execution of the full validation and reporting scripts remains pending.

## Important limitations

- Only **1 order** is available, so sales trends and business conclusions cannot be generalized.
- FKs, CHECK and UNIQUE constraints don't enforce every **cross-table** business rule. See the findings in `PROJECT_REPORT.md`.
- The row-level tests passed on this snapshot, but future bad writes are not necessarily blocked by the database.
- For a public GitHub repository, inspect/sanitize sample contacts and addresses; publish demo-only data.

## Submission links to add

- **Repository URL:** https://github.com/hemendrakumar916-ux/amazon-ecommerce-database-capstone (repository exists; project files must still be uploaded)
- **Project video URL:** _Add if AlmaBetter rubric requires a video_
- **Student / team:** _Add_
