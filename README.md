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

## Governance with Unity Catalog

**Unity Catalog** was used to provide enterprise-grade data governance across the pipeline:

- Secure access between **Azure Databricks** and **Azure Data Lake Storage (ADLS)**
- Centralized credential and permission management
- Fine-grained access control at the catalog, schema, and table levels
- Production-ready governance for scalable data platforms

This setup ensures **secure, auditable, and consistent data access** across all environments.

---

## Orchestration with Azure Data Factory

> **Insert Azure Data Factory Pipeline Screenshot Here**

**Azure Data Factory (ADF)** is responsible for orchestrating the entire ETL workflow.

### ADF Pipeline Responsibilities

- Execute Databricks notebooks for data cleaning and transformation
- Copy processed data from **ADLS → Azure SQL staging tables**
- Load data from **staging tables → EDW tables** using SQL logic

### Key ADF Components

- **Linked Services**
  - Azure Data Lake Storage
  - Azure SQL Database
- **Datasets**
  - CSV files in ADLS
  - Tables in Azure SQL
- **Copy Activities**
- **Pipeline sequencing and dependency management**

---

## Data Warehouse (Azure SQL)

The **Enterprise Data Warehouse (EDW)** is implemented using **Azure SQL Database**.

- Hosts both **staging** and **EDW** layers
- Schemas created using structured SQL scripts
- Data loaded via **ADF copy activities**
- Optimized for analytical querying and reporting

---

## How to Run the Pipeline

1. Upload raw CSV files to the ADLS `/raw` folder
2. Configure the Azure Databricks workspace and compute cluster
3. Set up **Unity Catalog** and grant ADLS access
4. Run the Databricks notebook to generate processed datasets
5. Trigger the Azure Data Factory pipeline
6. Validate loaded data in Azure SQL EDW tables

---

## Resources

- **Databricks Notebook**: Attached in the repository
- **SQL Scripts**: Included in the `/data_modelling` folder
- **Architecture Diagram**: Included in the `/architecture` folder

---

## Author

**Muhammed Sulaimon**  
_Data Engineer | Azure | Spark | SQL_

If you found this project helpful, feel free to ⭐ the repository!
