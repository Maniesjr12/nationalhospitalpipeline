# Azure ETL Pipeline for Healthcare Analytics

An end-to-end, production-style **ETL (Extract, Transform, Load) data pipeline** built on Microsoft Azure for processing and analyzing healthcare datasets.  
This project demonstrates real-world **data engineering best practices** including data lake layering, Spark-based transformations, secure governance, and warehouse-ready data modeling.

---

## Project Overview

This pipeline ingests raw healthcare CSV data, cleans and transforms it using **Apache Spark on Azure Databricks**, orchestrates workflows with **Azure Data Factory**, and loads analytics-ready data into an **Enterprise Data Warehouse (EDW)** on **Azure SQL Database**.

The architecture follows a **Medallion-style pattern**:

- **Raw Layer** → Immutable source data
- **Processed Layer** → Cleaned and standardized datasets
- **Warehouse Layer** → Structured tables optimized for analytics

---

## Objectives

- Build a scalable and secure Azure-based ETL pipeline
- Apply real-world data engineering patterns
- Enable reliable analytics on healthcare data
- Demonstrate orchestration, governance, and data modeling concepts

---

## Dataset Description

The project uses healthcare-related datasets stored as CSV files:

| Dataset            | Description                            |
| ------------------ | -------------------------------------- |
| Patients           | Patient demographic data               |
| Medical Records    | Historical patient medical information |
| Lab Results        | Diagnostic test results                |
| Imaging Results    | Medical imaging outcomes               |
| Clinical Trials    | Clinical trial metadata                |
| Trial Participants | Patient participation in trials        |

### Use Cases

- Clinical analytics
- Operational reporting
- Research and insights generation

---

## Architecture Overview

> **Insert Pipeline Architecture Diagram Here**

### Core Azure Services Used

- **Azure Data Lake Storage Gen2 (ADLS)** – Raw & processed storage
- **Azure Databricks (Apache Spark)** – Data transformation
- **Unity Catalog** – Secure data access & governance
- **Azure Data Factory (ADF)** – Pipeline orchestration
- **Azure SQL Database** – Staging & Enterprise Data Warehouse
- **Azure Data Studio** – SQL development & management

---

## Pipeline Flow

1. Raw CSV files are uploaded to **ADLS (raw zone)**
2. **Databricks Spark notebooks** clean and transform the data
3. Cleaned datasets are written to **ADLS (processed zone)**
4. **Azure Data Factory** orchestrates:
   - Databricks notebook execution
   - Copying data from processed files to staging tables
   - Loading data from staging into EDW tables
5. Data is available for analytics and reporting

---

## Data Modeling Strategy

The warehouse layer follows a **Staging → EDW** approach:

- **Staging Tables**

  - Mirror processed CSV schemas
  - Used for validation and controlled loading

- **EDW Tables**
  - Cleaned and integrated
  - Designed for analytical queries
  - Enforce referential integrity where applicable

---

## Data Transformation (Databricks)

### Technologies

- Apache Spark (PySpark)
- Azure Databricks
- Unity Catalog

### Key Transformation Steps

- Remove duplicate records
- Drop rows with null values
- Add ingestion metadata (`loaded_date`)
- Write cleaned datasets to the processed zone

Example:

```python
from pyspark.sql.functions import current_date

processed_patients_df = patient_df.dropDuplicates() \
    .na.drop() \
    .withColumn("loaded_data", current_date())
```

Governance with Unity Catalog

Unity Catalog was used to:

Secure access between Databricks and ADLS

Manage credentials centrally

Enforce fine-grained data access control

Enable production-grade governance

This ensures scalable and secure data access across environments.

Orchestration with Azure Data Factory

Insert Azure Data Factory Pipeline Screenshot Here

ADF pipelines perform:

Databricks notebook execution

Copy activity from ADLS - Azure SQL (staging)

SQL-based loading from staging - EDW

Key ADF Components

Linked Services (ADLS, Azure SQL)

Datasets (CSV files, SQL tables)

Copy Activities

Pipeline sequencing & dependency management

Data Warehouse (Azure SQL)

Azure SQL Database hosts staging and EDW layers

Schemas created using SQL scripts

Data loaded via ADF copy activities

How to Run the Pipeline

Upload raw CSV files to ADLS /raw folder

Configure Databricks workspace and cluster

Set up Unity Catalog and ADLS access

Run Databricks notebook to generate processed data

Trigger Azure Data Factory pipeline

Validate data in Azure SQL EDW tables

Resources

Databricks Notebook: Attached in repository

SQL Scripts: Included in /data modelling folder

Architecture Diagram: Included in /Architecture folder

Author

Muhammed Sulaimon
Data Engineer | Azure | Spark | SQL

If you found this project helpful, feel free to ⭐ the repository!
