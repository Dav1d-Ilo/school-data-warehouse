/*

Create Database and Schemas

Script Purpose:
This script creates a new database named 'SchoolDataWarehouse'
after checking if it already exists. If the database exists,
it is dropped and recreated. Additionally, the script creates
three schemas within the database: 'Bronze', 'Silver', and 'Gold'.

*/

USE master;
GO
  IF EXISTS (
SELECT 1
FROM sys.databases
WHERE name = 'SchoolDataWarehouse'
)
BEGIN
ALTER DATABASE SchoolDataWarehouse
SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

DROP DATABASE SchoolDataWarehouse;

END;
GO
  
-- Create the 'SchoolDataWarehouse' Database 
CREATE DATABASE SchoolDataWarehouse;
GO

USE SchoolDataWarehouse;
GO
-- Craete Schema
CREATE SCHEMA Bronze;
GO
CREATE SCHEMA Silver;
GO
CREATE SCHEMA Gold;
