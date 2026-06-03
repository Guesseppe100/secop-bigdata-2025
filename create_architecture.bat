@echo off
echo Creating SECOP Big Data 2025 repository architecture...

REM ============================================================
REM Main folders
REM ============================================================

mkdir notebooks
mkdir src
mkdir config
mkdir docs
mkdir tests
mkdir data
mkdir data\layer0_raw
mkdir data\bronze
mkdir data\silver
mkdir data\gold
mkdir outputs
mkdir outputs\logs
mkdir outputs\reports

REM ============================================================
REM Databricks notebooks
REM ============================================================

type nul > notebooks\00_setup_databricks.py
type nul > notebooks\01_layer0_ingestion.py
type nul > notebooks\02_bronze_tables.py
type nul > notebooks\03_silver_cleaning.py
type nul > notebooks\04_gold_analysis.py
type nul > notebooks\05_mongodb_export.py

REM ============================================================
REM Source code modules
REM ============================================================

type nul > src\__init__.py
type nul > src\config.py
type nul > src\socrata_client.py
type nul > src\transformations.py
type nul > src\quality_checks.py
type nul > src\mongodb_client.py

REM ============================================================
REM Configuration files
REM ============================================================

type nul > config\sources_2025.json
type nul > config\project_settings.json

REM ============================================================
REM Documentation files
REM ============================================================

type nul > docs\architecture.md
type nul > docs\data_dictionary.md
type nul > docs\limitations.md
type nul > docs\execution_plan.md

REM ============================================================
REM Test files
REM ============================================================

type nul > tests\test_transformations.py
type nul > tests\test_quality_checks.py

REM ============================================================
REM Keep empty folders in Git
REM ============================================================

type nul > data\layer0_raw\.gitkeep
type nul > data\bronze\.gitkeep
type nul > data\silver\.gitkeep
type nul > data\gold\.gitkeep
type nul > outputs\logs\.gitkeep
type nul > outputs\reports\.gitkeep

REM ============================================================
REM README
REM ============================================================

(
echo # SECOP Big Data 2025
echo.
echo This project implements a batch-first big data architecture for SECOP 2025 analysis using Spark, Databricks, GitHub, and layered data processing.
echo.
echo ## Objective
echo Build a scalable and reusable pipeline to ingest, clean, integrate, and analyze public procurement data for the 2025 period.
echo.
echo ## Architecture
echo.
echo - Layer 0: Raw API landing
echo - Bronze: Raw Delta tables
echo - Silver: Cleaned and standardized data
echo - Gold: Analytical and business-ready tables
echo.
echo ## Main Sources
echo.
echo - SECOP II contracts
echo - SECOP II additions
echo - SECOP II execution
echo - DIVIPOLA territorial data
echo.
echo ## Analysis Window
echo.
echo Only 2025 records will be processed.
echo.
echo ## Execution Order
echo.
echo 1. 00_setup_databricks.py
echo 2. 01_layer0_ingestion.py
echo 3. 02_bronze_tables.py
echo 4. 03_silver_cleaning.py
echo 5. 04_gold_analysis.py
echo 6. 05_mongodb_export.py
) > README.md

REM ============================================================
REM .gitignore
REM ============================================================

(
echo # Python
echo __pycache__/
echo *.pyc
echo *.pyo
echo *.pyd
echo .Python
echo env/
echo venv/
echo .venv/
echo.
echo # Jupyter
echo .ipynb_checkpoints/
echo.
echo # Databricks / local data
echo data/layer0_raw/*
echo data/bronze/*
echo data/silver/*
echo data/gold/*
echo outputs/logs/*
echo outputs/reports/*
echo.
echo # Keep folder structure
echo !data/layer0_raw/.gitkeep
echo !data/bronze/.gitkeep
echo !data/silver/.gitkeep
echo !data/gold/.gitkeep
echo !outputs/logs/.gitkeep
echo !outputs/reports/.gitkeep
echo.
echo # Secrets
echo .env
echo *.key
echo *.pem
echo secrets.*
echo.
echo # OS files
echo .DS_Store
echo Thumbs.db
) > .gitignore

REM ============================================================
REM Requirements
REM ============================================================

(
echo requests
echo pandas
echo pymongo
echo python-dotenv
) > requirements.txt

REM ============================================================
REM Config JSON
REM ============================================================

(
echo {
echo   "analysis_year": 2025,
echo   "start_date": "2025-01-01T00:00:00",
echo   "end_date": "2026-01-01T00:00:00",
echo   "batch_size_dev": 1000,
echo   "batch_size_prod": 50000,
echo   "sources": {
echo     "contratos": {
echo       "description": "SECOP II contracts source",
echo       "type": "api",
echo       "layer": "layer0_raw"
echo     },
echo     "adiciones": {
echo       "description": "SECOP II contract additions source",
echo       "type": "api",
echo       "layer": "layer0_raw"
echo     },
echo     "ejecucion": {
echo       "description": "SECOP II contract execution source",
echo       "type": "api",
echo       "layer": "layer0_raw"
echo     },
echo     "divipola": {
echo       "description": "Territorial normalization source",
echo       "type": "api",
echo       "layer": "layer0_raw"
echo     }
echo   }
echo }
) > config\sources_2025.json

echo Architecture created successfully.
pause