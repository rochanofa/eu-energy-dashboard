WITH energy_data AS (
    SELECT 
        CONCAT(country, '-', year) AS energy_id, -- Unique identifier
        country, 
        year, 
        primary_energy_consumption, 
        renewables_consumption, 
        coal_consumption, 
        oil_consumption, 
        gas_consumption, 
        co2_emissions
    FROM `eu-energy-proj.energy_data.energy_consumption`
    WHERE year BETWEEN 2019 AND 2023
    AND country IN (
        -- European Union (EU) countries
        'Austria', 'Belgium', 'Bulgaria', 'Croatia', 'Cyprus', 'Czech Republic', 
        'Denmark', 'Estonia', 'Finland', 'France', 'Germany', 'Greece', 'Hungary', 
        'Ireland', 'Italy', 'Latvia', 'Lithuania', 'Luxembourg', 'Malta', 'Netherlands', 
        'Poland', 'Portugal', 'Romania', 'Slovakia', 'Slovenia', 'Spain', 'Sweden',
        
        -- European Economic Area (EEA) countries (non-EU)
        'Iceland', 'Liechtenstein', 'Norway',
        
        -- United Kingdom (UK)
        'United Kingdom'
    )
)

SELECT * FROM energy_data;
