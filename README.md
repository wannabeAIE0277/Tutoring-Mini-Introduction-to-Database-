# 🎓 Tutoring Management System Database (`tutoring_mini`)

> **Course Project:** Database Systems & Applied SQL  
> **Target Database Engine:** MySQL 8.0+ (InnoDB Engine)  
> **Schema Name:** `tutoring_mini`  
> **Repository:** [https://github.com/wannabeAIE0277/Tutoring-Mini-Introduction-to-Database-.git](https://github.com/wannabeAIE0277/Tutoring-Mini-Introduction-to-Database-.git)

---

## 📌 Project Overview

This repository delivers an end-to-end, production-grade relational database schema, database view abstraction layer, and business intelligence reporting suite for a private tutoring management platform (**`tutoring_mini`**). The system automates operational workflows across subject registries, tutor profiles, student bookings, lesson executions, post-session reports, and financial settlements.

The project emphasizes three foundational engineering pillars:

1. **Strict Data Integrity:** Enforcement of entity and referential integrity using primary keys, foreign key cascading policies, `1:1` mandatory report uniqueness, enumeration types for states, and explicit domain `CHECK` constraints on financial amounts and durations.
2. **Layered Database Architecture:** Separation of physical storage definitions (`schema.sql`), test fixtures (`seed.sql`), complex analytical business intelligence scripts (`queries.sql`), and virtual abstraction views (`views.sql`).
3. **Optimized Analytical Capability:** Production-grade SQL handling non-trivial reporting challenges, including half-open timestamp range filtering, null-safe aggregation (`COALESCE`), dynamic zero-division protection, and multi-table outer join compositions.

---

## 👥 Contributors & Workload Distribution

| Member Name | Student ID | Core Responsibilities & Outputs | Contribution |
| :--- | :---: | :--- | :---: |
| **Dương Minh Nguyên** *(Lead)* | `11256308` | Database relational modeling & DDL implementation (`schema.sql`), business logic view abstraction design (`views.sql`), Git repository administration & branch workflows, comprehensive technical documentation, and project file architecture. | **35%** |
| **Tống Thoại Khanh** | `11253781` | Complex financial & analytical queries design (Queries 6–10: payment reconciliations, cancellation rates, cohort frequency analysis), edge-case mock dataset engineering (`seed.sql`), and integrity constraint validation testing. | **35%** |
| **Nguyễn Thị Thảo Uyên** | `11258816` | Core operational and business reporting implementation (Queries 1–5: session scheduling, subject utilization, delinquent report tracking, tutor ranking), query optimization, edge-case debugging, and result verification. | **30%** |

---

## 🤖 Declaration on Generative AI Usage

In compliance with academic integrity guidelines, conversational AI assistants were utilized strictly as interactive code review and debugging partners.

Specifically, AI was engaged for syntax validation, edge-case hypothesis formulation, and query performance discussions. All relational entity definitions, business rules, synthetic dataset modeling, virtual view logic, and analytical query interpretations were designed, executed, verified, and finalized entirely by the human authors.

---

## 📁 Repository Directory Structure

```text
Database Project/
|-- SQL Query/
|   |-- schema.sql              # DDL: Schema creation, table definitions, and constraints
|   |-- seed.sql                # DML: Mock dataset for edge-case and integrity verification
|   |-- views.sql               # DDL: Virtual views abstracting complex business entities
|   |-- queries.sql             # DQL: 10 production-grade analytical and operational reports
|-- De_1.pdf                    # Official project specification & assignment guidelines
|-- Diagram.jpg                 # Full Entity-Relationship & Relational Schema Diagram
|-- Report.pdf                  # Comprehensive technical project report (Documentation & Analysis)
|-- README.MD                   # Project documentation and reproduction guide
|-- .gitignore                  # Environment & SQL query cache exclusions
```

---

## 🗄️ Relational Schema & Entity Overview

### Entity-Relationship Architecture

The conceptual diagram and foreign key mapping are illustrated in the project diagram file:  
👉 **`Diagram.jpg`** *(located in the repository root directory)*.

```text
       ┌───────────┐           ┌──────────────┐           ┌──────────────┐
       │ subjects  │───(1:N)──<│    tutors    │───(1:N)──<│   lessons    │>───(N:1)───┌──────────────┐
       └───────────┘           └──────────────┘           └──────┬───────┘            │   students   │
                                                                 │                    └──────────────┘
                                                 ┌───────────────┴───────────────┐
                                                 │                               │
                                       (1:1 Optional)                     (1:N Financial)
                                                 ▼                               ▼
                                      ┌─────────────────────┐         ┌─────────────────────┐
                                      │   lesson_reports    │         │      payments       │
                                      └─────────────────────┘         └─────────────────────┘
```

### Table Dictionary & Constraint Specifications

| Table Name | Primary Key | Foreign Key References | Core Integrity & Domain Constraints |
| :--- | :--- | :--- | :--- |
| **`subjects`** | `subject_id` | *None* | `name` is unique, non-null, and indexed. |
| **`tutors`** | `tutor_id` | `subject_id` $\rightarrow$ `subjects` | Contact channels (`email`, `phone`) enforce uniqueness. |
| **`students`** | `student_id` | *None* | Non-null `full_name`; strictly unique `email`. |
| **`lessons`** | `lesson_id` | `student_id`, `tutor_id` | `status` enum restricted to (`'Pending'`, `'Completed'`, `'Cancelled'`). |
| **`lesson_reports`** | `report_id` | `lesson_id` $\rightarrow$ `lessons` | `lesson_id` enforces `UNIQUE` ($1:1$ card.); `CHECK (duration_minutes > 0)` and `CHECK (fee >= 0)`. |
| **`payments`** | `payment_id` | `lesson_id` $\rightarrow$ `lessons` | Multi-tranche payments per lesson allowed; `CHECK (amount > 0)`; `method` enum (`'Cash'`, `'BankTransfer'`, `'Card'`). |

---

## 🚀 Quickstart & Execution Guide

### 1. Clone the Repository

Clone this repository to your local machine using standard Git CLI:

```bash
git clone https://github.com/wannabeAIE0277/Tutoring-Mini-Introduction-to-Database-.git
cd Tutoring-Mini-Introduction-to-Database-
```

### 2. Execution Workflows

Ensure you execute scripts in the strict relational dependency order:  
**`schema.sql`** $\rightarrow$ **`seed.sql`** $\rightarrow$ **`queries.sql`** $\rightarrow$ **`views.sql`**.

#### 🟢 OPTION 1: MySQL Workbench GUI Execution

1. Launch **MySQL Workbench** and connect to your local MySQL instance (default port `3306`).
2. Navigate to **File** $\rightarrow$ **Open SQL Script...** and load the scripts from the `SQL Query/` directory:
   * **Step 1:** Open `SQL Query/schema.sql` $\rightarrow$ Click the **Execute (Lightning Bolt)** icon to create database `tutoring_mini` and all 6 tables.
   * **Step 2:** Open `SQL Query/seed.sql` $\rightarrow$ Execute to ingest all mock records and verify constraints.
   * **Step 3:** Open `SQL Query/queries.sql` $\rightarrow$ Run queries individually or in batch to inspect reporting outputs in the Result Grid.
   * **Step 4:** Open `SQL Query/views.sql` $\rightarrow$ Execute to compile the virtual view abstraction layer.

#### 💻 OPTION 2: Visual Studio Code (VS Code)

1. Open the project folder in **VS Code** (**File** $\rightarrow$ **Open Folder...**).
2. Install the **MySQL** extension (by Weihan Chen) or **Database Client** extension from the VS Code Marketplace.
3. Connect the extension to your local MySQL server (`host: localhost`, `user: root`, `password: <your_password>`).
4. Execute scripts sequentially by right-clicking inside the editor or clicking **Run MySQL Query**:
   ```text
   SQL Query/schema.sql   ==> (Builds schema & tables)
   SQL Query/seed.sql     ==> (Populates test fixtures)
   SQL Query/queries.sql  ==> (Executes analytical reports)
   SQL Query/views.sql    ==> (Registers business views)
   ```
   *(Alternatively, run via the VS Code integrated terminal using `mysql -u root -p tutoring_mini < "SQL Query/schema.sql"`).*

---

## 📊 Analytical Query Suite (`queries.sql`)

The query suite addresses 10 critical operational and financial requirements:

* **Q1 (Monthly Completed Sessions):** Filters completed sessions in a specific billing month using half-open boundary intervals (`>= '2025-01-01' AND < '2025-02-01'`).
* **Q2 (Subject Utilization):** Uses defensive `LEFT JOIN` to tally total booked sessions across all subjects, ensuring zero-booking subjects are preserved.
* **Q3 (Delinquent Lesson Reports):** Identifies completed sessions missing tutor evaluation logs (`l.status = 'Completed' AND r.report_id IS NULL`) to enforce service-level agreements (SLAs).
* **Q4 (Average Subject Fees):** Computes mean lesson fees by subject from submitted reports, with precision formatting (`ROUND(..., 2)`).
* **Q5 (Top Performer Ranking):** Determines the top 3 tutors ranked by completed lessons in a target period with deterministic tie-breaking.
* **Q6 (Student Cash Collection):** Computes gross cash payments received per student across the fiscal year with null-safe zero-filling (`COALESCE`).
* **Q7 (Unpaid Session Auditing):** Employs an `INNER JOIN` $\rightarrow$ `LEFT JOIN` combination to isolate active students who have attended lessons but recorded zero payments (`HAVING COUNT(p.payment_id) = 0`).
* **Q8 (Confirmed Revenue by Student):** Aggregates confirmed session charges derived directly from official session report fees.
* **Q9 (Tutor Cancellation Rate):** Calculates individual tutor cancellation percentages featuring dynamic zero-division protection via conditional aggregation.
* **Q10 (High-Frequency Student Cohorts):** Identifies highly active students completing over 3 sessions in a single fiscal year for loyalty tier evaluation.

---

## 👁️ Database View Abstraction Layer (`views.sql`)

The `views.sql` script encapsulates multi-table join complexities, providing clean, reusable virtual tables for application developers and reporting services:

1. **`v_active_tutor_profiles`**: Merges tutor contact profiles with their respective subject specialties, abstracting the internal foreign key join for front-end booking interfaces.
2. **`v_completed_lesson_details`**: Consolidates lesson timestamps, participating student names, assigned tutors, session reports, duration, and assessed fees into a single flat operational view.
3. **`v_student_financial_summary`**: Aggregates confirmed session charges against total historical receipts per student, computing outstanding accounts receivable balances on the fly.