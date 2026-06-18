# 🏠 Housing Data Cleaning with SQL

## Overview

This project demonstrates a complete data cleaning workflow using SQL Server. The objective was to transform raw housing transaction data into a cleaner and more analysis-ready dataset.

The project focuses on handling missing values, standardizing address information, removing duplicate records, and eliminating unnecessary columns.

---

## Dataset

The dataset contains housing transaction records with information such as:

* Parcel ID
* Property Address
* Owner Address
* Sale Date
* Sale Price
* Legal Reference
* Tax District

The original data contained:

* Missing property addresses
* Combined address fields
* Duplicate records
* Unnecessary columns

---

## Data Cleaning Steps

### 1. Populate Missing Property Addresses

Some records contained NULL values in the `PropertyAddress` column.

Using self-joins on `ParcelID`, missing addresses were populated from matching records that shared the same parcel identifier.

**Techniques Used**

* Self Join
* `ISNULL()`
* Conditional Updates

---

### 2. Split Property Address into Separate Columns

The original property address contained both street and city information in a single field.

Example:

```text
123 Main St, Nashville
```

Was transformed into:

| Street      | City      |
| ----------- | --------- |
| 123 Main St | Nashville |

**Techniques Used**

* `SUBSTRING()`
* `CHARINDEX()`
* `ALTER TABLE`
* `UPDATE`

---

### 3. Split Owner Address into Street, City, and State

The owner address was stored as a single string.

Example:

```text
456 Oak Ave, Atlanta, GA
```

Was transformed into:

| Street      | City    | State |
| ----------- | ------- | ----- |
| 456 Oak Ave | Atlanta | GA    |

**Techniques Used**

* `PARSENAME()`
* `REPLACE()`
* String Parsing Functions

---

### 4. Identify Duplicate Records

Potential duplicates were identified based on:

* ParcelID
* PropertyAddress
* SaleDate
* SalePrice
* LegalReference

A Common Table Expression (CTE) and window function were used to flag duplicate rows.

**Techniques Used**

* CTEs
* `ROW_NUMBER()`
* `PARTITION BY`
* Window Functions

---

### 5. Remove Unused Columns

After extracting useful information into new fields, redundant columns were removed to improve table structure.

Dropped columns:

* PropertyAddress
* OwnerAddress
* TaxDistrict

**Techniques Used**

* `ALTER TABLE`
* `DROP COLUMN`

---

## SQL Concepts Demonstrated

This project showcases practical use of:

* Data Cleaning
* Data Standardization
* NULL Handling
* Self Joins
* String Functions
* Common Table Expressions (CTEs)
* Window Functions
* Duplicate Detection
* Schema Modification

---

## Skills Practiced

* SQL Server
* Data Wrangling
* Data Preparation
* Data Quality Improvement
* Database Design Fundamentals

---

## Learning Outcome

Through this project, I explored common data-cleaning challenges encountered in real-world datasets and practiced transforming raw data into a structured format suitable for reporting, analytics, and business intelligence applications.

---

### Author

**Mahesh B**

Business Intelligence Analyst | SQL | Power BI | Data Analytics

Always exploring new ways to turn messy data into meaningful insights.
