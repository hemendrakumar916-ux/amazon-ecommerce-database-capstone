# Final AlmaBetter submission checklist

This list is a **project-specific recommendation**, not a claim about the official AlmaBetter grading rubric. Verify your exact assignment instructions before the final submission.

- [x] SQL dump exported at 2026-11-22 13:51:06 IST and readable
- [x] 17 tables and 22 foreign keys inspected from SQL dump
- [x] Previously incorrect Order #1 status changed to SHIPPED
- [x] Synthetic data consistency checks on exported snapshot
- [x] ERD reconstructed from actual foreign key constraints (SVG + PNG + editable DOT)
- [x] Draft README and project report prepared
- [x] Read-only validation and example reporting queries prepared
- [x] Restore SQL into the newly created `amazon_project_3_test` database; pgAdmin screenshot verifies 17 tables, 3 customers, 1 order (SHIPPED), and 17 PK / 22 FK / 13 UNIQUE / 20 CHECK constraints
- [ ] Run validation_queries.sql in pgAdmin on restored database and retain evidence
- [ ] Run business_reports.sql on restored database and retain screenshots
- [ ] Discuss repeated shipment tracking events as test data / improve seed data if needed
- [ ] Add author, team, course name, and date
- [ ] Check if official rubric requires specific video length, dataset size, or formatting
- [ ] Upload project files to the created public repository: https://github.com/hemendrakumar916-ux/amazon-ecommerce-database-capstone
- [ ] Record explanation video and include link if the official rubric requires one
- [ ] Confirm all published sample data is synthetic and acceptable to share

**Recommended ZIP:** `AlmaBetter_Amazon_Project3_Submission.zip`.
