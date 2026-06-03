# SECOP Big Data 2025

This project implements a batch-first big data architecture for SECOP 2025 analysis using Spark, Databricks, GitHub, and layered data processing.

## Objective
Build a scalable and reusable pipeline to ingest, clean, integrate, and analyze public procurement data for the 2025 period.

## Architecture

- Layer 0: Raw API landing
- Bronze: Raw Delta tables
- Silver: Cleaned and standardized data
- Gold: Analytical and business-ready tables

## Main Sources

- SECOP II contracts
- SECOP II additions
- SECOP II execution
- DIVIPOLA territorial data

## Analysis Window

Only 2025 records will be processed.

## Execution Order

1. 00_setup_databricks.py
2. 01_layer0_ingestion.py
3. 02_bronze_tables.py
4. 03_silver_cleaning.py
5. 04_gold_analysis.py
6. 05_mongodb_export.py
