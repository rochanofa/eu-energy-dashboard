#Batch Data Pipeline for Energy Data Analysis

📌 Problem Statement

Understanding energy consumption trends in EU, UK, EEA, and Switzerland is crucial for policymakers and researchers. This project builds a batch data pipeline to analyze:

Total energy consumption per country (2019-2023).

Renewable vs. fossil energy in EU countries.

CO₂ emissions vs. energy consumption.

Top 10 countries with the highest renewable energy generation.

The dataset used is sourced from OWID Energy Data.

⚡ Technologies Used

Docker: Containerization.

Terraform: Infrastructure as Code (IaC) to set up GCS & BigQuery.

Kestra: Orchestration for data ingestion & transformation.

Google Cloud Storage (GCS): Raw data storage.

BigQuery: Data warehouse for analysis.

dbt (Data Build Tool): Data transformation & filtering.

Looker Studio: Dashboard visualization.

📌 Pipeline Architecture

Terraform provisions GCS & BigQuery.

Kestra downloads & uploads energy data to GCS.

Kestra loads data from GCS to BigQuery.

dbt filters & aggregates EU, UK, EEA, and Switzerland (2019-2023).

Looker Studio visualizes insights.

Docker manages containerized services.

🛠 Setup Instructions

1️⃣ Clone the Repository

git clone https://github.com/your-username/energy-data-pipeline.git
cd energy-data-pipeline

2️⃣ Configure Google Cloud

Create a Google Cloud Project.

Enable BigQuery, GCS, and IAM APIs.

Create a service account and download service-account.json.

Copy it into the project root folder.

3️⃣ Setup Terraform for GCS & BigQuery

cd terraform
terraform init
terraform apply -auto-approve

4️⃣ Start Docker Containers

docker-compose up -d

5️⃣ Execute Kestra Flow

kestra deployment up
kestra flow execute --id ingest_energy

6️⃣ Run dbt for Data Transformation

cd dbt
dbt run

7️⃣ Connect Looker Studio to BigQuery

Open Looker Studio.

Select BigQuery as the data source.

Choose the owid_energy.energy_summary table.

Build visualizations.

📊 Dashboard Insights : https://lookerstudio.google.com/reporting/316bd9e7-9e60-423d-8215-0ab4acbbdb8f

✔ Avg Yearly Energy Consumption per Country (Mapped)
✔ Renewable vs. Fossil Energy per Country (Stacked Chart)
✔ Trend of Fossil Fuel , Renewables Electricity Generation and GHG Emissions over the year (Scoreboard)
✔ Top 5 Countries with Highest Energy per capita (Leaderboard)

📌 Folder Structure

energy-data-pipeline/
│── kestra-flows/          # Kestra YAML workflows
│── dbt/                   # dbt models & transformations
│── terraform/             # Terraform setup for GCS & BigQuery
│── docker-compose.yml     # Docker services for Kestra, dbt, Terraform
│── README.md              # Project documentation
│── service-account.json   # Google Cloud credentials (DO NOT COMMIT)

🚀 Future Enhancements

✅ Automate pipeline execution using Cloud Scheduler✅ Integrate PySpark for large-scale transformations✅ Extend analysis to global energy trends
 
