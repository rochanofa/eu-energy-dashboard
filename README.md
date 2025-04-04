# Europe and UK Energy Dashboard - Data Pipeline

## 📌 Problem Statement
The transition to sustainable energy is one of the most pressing challenges of our time. Governments, industries, and researchers need reliable data to track energy consumption patterns, the share of renewable versus fossil energy, and the impact of energy use on CO₂ emissions. However, raw energy data is often large, unstructured, and requires significant preprocessing before it can be used for analysis.

This project aims to solve these challenges by building a data pipeline for the collection, processing, and visualization of energy data from 2000-2023 for European Union (EU), United Kingdom (UK), European Economic Area (EEA), and Switzerland.

Key Questions Answered:
1. How much energy is consumed by each country in the EU, UK, EEA, and Switzerland?
2. What is the proportion of renewable vs. fossil energy usage over the years in these countries?
3. How are the Trends of yearly electricity generated from Fossil fuel and Renewable energy sources?
4. Which countries have the highest energy per capita?

## 📋 Data source
The data is derived from *Our World in Data (OWID)* Energy Data. Github download link [here](https://github.com/owid/energy-data)

## ⚡ Technologies Used
✔️ Docker: Containerization. <br>
✔️ Terraform: Infrastructure as Code (IaC) to set up GCS & BigQuery.<br>
✔️ Kestra: Orchestration for data ingestion & transformation.<br>
✔️ Google Cloud Storage (GCS): Data lake<br>
✔️ BigQuery: Data warehouse for analysis.<br>
✔️ dbt (Data Build Tool): Data transformation & filtering.<br>
✔️ Looker Studio: Dashboard visualization.<br>

## ❇️ Pipeline Architecture
<img src="https://github.com/rochanofa/eu-energy-dashboard/blob/main/data-pipeline.png" alt="Alt Text" width="600" height="300">

1. Terraform provisions GCS & BigQuery.
2. Kestra downloads & uploads energy data to GCS.
3. Kestra loads data from GCS to BigQuery.
4. dbt filters & aggregates EU, UK, EEA, and Switzerland (2000-2023) also runs through Kestra workflow.
5. Looker Studio visualizes insights.

## 🛠 Setup Instructions

1️⃣ Clone the Repository
```
git clone https://github.com/rochanofa/eu-energy-dashboard.git
cd eu-energy-dashboard
```

2️⃣ Configure Google Cloud 
1. Create a Google Cloud Project.
2. Enable BigQuery, GCS, and IAM APIs.
3. Create a service account and download the key service-account.json.
Tutorial to configure Google Cloud [here](https://github.com/DataTalksClub/data-engineering-zoomcamp/tree/main/01-docker-terraform/1_terraform_gcp)

3️⃣ Setup Terraform for GCS & BigQuery <p>
You need to configure Terraform using `main.tf` file, in this project [here is my confguration.](https://github.com/rochanofa/eu-energy-dashboard/blob/main/terraform/main.tf). Then run this Bash command to run Terraform:
```
cd terraform
terraform init
terraform apply -auto-approve
```
4️⃣ Start Docker Containers to Run Kestra <p>
To set up Kestra follow this [tutorial](https://kestra.io/docs/installation/docker-compose?clid=eyJpIjoiaVctMDdocmc2WldJdWJGOHdGcTU0IiwiaCI6IiIsInAiOiIvZGUtem9vbWNhbXAvZG9ja2VyLWNvbXBvc2UiLCJ0IjoxNzQzNzQ2NzU3fQ.ETZZO0g3OZVhETLcxK3VUAq_xuKYe3QqTT_SdwcHCZw) <br>
Run docker compose:
```
docker-compose up -d
```
Kestra will run in [http://localhost:8080/](http://localhost:8080/) <p>
5️⃣ Execute Kestra Flow <p>
Run these following flows using Kestra in this specific order
- [01_gcp_kv.yaml](https://github.com/rochanofa/eu-energy-dashboard/blob/main/kestra-flows/01_gcp_kv.yaml) to provide key values for the next flows
- [02_gcp_setup.yaml](https://github.com/rochanofa/eu-energy-dashboard/blob/main/kestra-flows/02_gcp_setup.yaml) to setup GCS bucket and dataset (optional- can be skipped if already set through Terraform)
- [03_ingest_energy.yaml](https://github.com/rochanofa/eu-energy-dashboard/blob/main/kestra-flows/03_ingest_energy.yaml) to perform data ingestion to Data Lake and load to Data Warehouse
- [04_run_dbt.yml](https://github.com/rochanofa/eu-energy-dashboard/blob/main/kestra-flows/04_run_dbt.yml) to perform data transformation in **dbt** <br>
Tutorial to Run Kestra Flows [here](https://www.youtube.com/watch?v=nKqjjLJ7YXs&feature=youtu.be)

6️⃣ Optional - If Run dbt separately for Data Transformation
Commands:
```
cd dbt
dbt run
```
SQL queries for this project to run dbt model [`energy_data_model.aql`](https://github.com/rochanofa/eu-energy-dashboard/blob/main/dbt/models/energy_data_model.sql)<p>

7️⃣ Connect Looker Studio to BigQuery
1. Open Looker Studio.
2. Select BigQuery as the data source.
3. Choose the data table.
4. Build visualizations.

## 📊 Interactive Dashboard Insights : https://lookerstudio.google.com/reporting/316bd9e7-9e60-423d-8215-0ab4acbbdb8f
<img src="https://github.com/rochanofa/eu-energy-dashboard/blob/main/dashboard.png" alt="Alt Text" width="600" height="400">
✔ Avg Yearly Energy Consumption per Country (Mapped)  <br>
✔ Renewable vs. Fossil Energy per Country (Stacked Chart) <br>
✔ Trend of Fossil Fuel , Renewables Electricity Generation and GHG Emissions over the year (Scoreboard) <br>
✔ Top 5 Countries with Highest Energy per capita (Leaderboard) <br>
✔ Filtering based on year and country <br>

## 🚀 Future Enhancements

✅ Automate pipeline execution using Cloud Scheduler<br>
✅ Integrate PySpark for large-scale transformations<br>
✅ Add real-time dataset e.g. Intraday electricity price from Entso-E data <br>
✅ Extend analysis to global energy trends
 
## 💫 Acknowledgement
Special thanks to the whole Data Engineering Zoomcamp Team for their efforts to create such a comprehensive bootcamp. Link to the bootcamp [here](https://github.com/DataTalksClub/data-engineering-zoomcamp)
