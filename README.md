# School Data Warehouse
An end-to-end SQL Server data warehouse for a secondary school. It turns 11 raw CSV exports from Finance, HR and Academics into a clean star schema, using the Bronze, Silver and Gold (medallion) layers.

# Project Overview
Schools keep their records in separate places: fees in one, staff in another, results in a another. This project brings them together so a question that crosses departments,becomes a simple query.

# Data Architecture
This project’s data architecture is built on the Medallion pattern, with three layers: Bronze, Silver and Gold
<img width="2800" height="1120" alt="school_dwh_architecture" src="https://github.com/user-attachments/assets/0a3cc06d-8a98-4631-800a-120f2e656553" />
1. **Bronze layer:** Holds the raw data exactly as it arrives from the source files. 
2. **Silver layer:** Cleans and standardizes the Bronze data.
3. **Gold layer:** Holds the ready data, modeled as a star schema.

# Data Model
<img width="1920" height="990" alt="school_dwh_data_model_v3" src="https://github.com/user-attachments/assets/be4221d3-2b6c-4399-99c0-32689b2227a6" />
