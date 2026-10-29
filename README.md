# Healthcare Management & Billing SQL Project

## Project Overview

This project uses MySQL to explore and validate a healthcare dataset. It covers appointments, patients, doctors, treatments, and billing. The SQL script has data-quality checks, relationship checks, and summary queries.

## Tools

- MySQL and MySQL Workbench
- SQL: `SELECT`, `WHERE`, `GROUP BY`, `HAVING`, aggregate functions, `JOIN`, `LEFT JOIN`, subqueries, `REGEXP`, `TRIM`, `ALTER TABLE`

## Dataset

- **Source:** Kaggle – Hospital Management Dataset by Kanak Baghel.
- The data is made for practice, so the findings are illustrative, not real healthcare conclusions.
- The five raw CSV files are included in the main repository for reproducibility.

The five CSV files have 660 rows in total:

| Table | Rows | Purpose |
|---|---:|---|
| `appointments` | 200 | Appointment date, time, patient, doctor, reason, status |
| `patients` | 50 | Patient details and registration date |
| `doctors` | 10 | Doctor details, specialization, experience, branch |
| `treatments` | 200 | Treatments linked to appointments, with type, date, and cost |
| `billing` | 200 | Bill amount, payment method, payment status |

## Objectives

- Inspect table structures and data.
- Check for missing values and duplicate records.
- Check ID patterns, email and phone formats, dates, times, and numeric ranges.
- Find extra spaces and empty text values.
- Check that records match across tables.
- Compare billing amounts with treatment costs.
- Summarize appointment status, payment status, specializations, and treatment types.

## Main SQL Work

1. **Data profiling:** `DESCRIBE`, `COUNT`, `COUNT(DISTINCT ...)`.
2. **Data-quality checks:** `NULL` values, full-row duplicates, repeated IDs, ID patterns (`REGEXP`), spaces (`TRIM`), date and number ranges.
3. **Data types:** `ALTER TABLE` to set date and time columns to `DATE` / `TIME`, billing amount to `DECIMAL(10,2)`, and phone numbers to `VARCHAR`.
4. **Relationship checks:** `LEFT JOIN` queries to find records with no matching patient, doctor, appointment, or treatment.
5. **Summary analysis:** Grouped by appointment status, payment status, specialization, and treatment type.
6. **Consistency checks:** Billing amount vs treatment cost, treatment date vs appointment date, and appointment date vs patient registration date.

## Findings

**Data quality**

- No missing values, duplicate rows, repeated IDs, or extra spaces in any table.
- All appointments are in 2023, from 2023-01-01 to 2023-12-30.

**Relationships**

- 0 appointments without a matching patient or doctor.
- 0 treatments without a matching appointment.
- 0 bills without a matching treatment or patient.
- 0 bills where the amount differs from the treatment cost.

**Issues found**

- **28 appointments (10 patients)** are dated before the patient's registration date. These are flagged for review, not changed.
- **1 repeated patient slot:** patient P036 has two appointments on 2023-04-18 at 8:45, with two different doctors (D003 and D006). No doctor is booked twice at the same time.
- 20 patients share 9 email addresses, and all 50 patients live at only 4 addresses. This is a sign of synthetic data. Repeated emails or addresses do not always mean duplicate patients.
- **Cancelled and no-show appointments still have treatments and bills.** All 200 appointments have a treatment and a bill, whatever their status. For example, 51 cancelled appointments have bills, and 17 of them are marked Paid. This is a sign of synthetic data and should be reviewed in real data.

**Summary**

| Appointment status | Count |
|---|---:|
| No-show | 52 |
| Scheduled | 51 |
| Cancelled | 51 |
| Completed | 46 |

| Payment status | Count |
|---|---:|
| Pending | 69 |
| Failed | 67 |
| Paid | 64 |

## How to Run

1. Open MySQL Workbench and connect to your server.
2. Create the database: `CREATE DATABASE hospitals;`
3. Import the five CSV files from the repository into MySQL Workbench as tables named appointments, patients, doctors, treatments, and billing.
4. Open `hospitals_project.sql` and run it section by section.
5. The script has `ALTER TABLE` statements. Check the table structure before running it a second time.

## Repository Structure

├── hospitals_project.sql
├── appointments.csv
├── billing.csv
├── doctors.csv
├── patients.csv
├── treatments.csv
└── README.md

## Limitations

- This is a data exploration and validation project. The script finds possible problems and changes some column data types. It does not fix every issue it finds.
- The data is synthetic, so the results are for practice only.

## Skills Demonstrated

SQL querying, data validation, joins, aggregation, duplicate checks, pattern matching, date and time validation, and reading query results.
