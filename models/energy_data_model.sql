WITH euenergy AS (
    SELECT 
        CONCAT(country, '-', year) AS energy_id, -- Unique identifier
        country, 
        year, 
        primary_energy_consumption, 
        fossil_fuel_consumption,
        renewables_consumption,
        fossil_electricity, 
        renewables_electricity,
        energy_per_capita,
        greenhouse_gas_emissions
    FROM `eu-energy-proj.euenergy.energy_data`
    WHERE year BETWEEN 2000 AND 2023
    AND country IN (
        -- European Union (EU) countries
        'Austria', 'Belgium', 'Bulgaria', 'Croatia', 'Cyprus', 'Czechia', 
        'Denmark', 'Estonia', 'Finland', 'France', 'Germany', 'Greece', 'Hungary', 
        'Ireland', 'Italy', 'Latvia', 'Lithuania', 'Luxembourg', 'Malta', 'Netherlands', 
        'Poland', 'Portugal', 'Romania', 'Slovakia', 'Slovenia', 'Spain', 'Sweden',
        
        -- European Economic Area (EEA) countries and Switzerland (non-EU)
        'Iceland', 'Liechtenstein', 'Norway', 'Switzerland',
        
        -- United Kingdom (UK)
        'United Kingdom'
    )
)

SELECT * FROM euenergy
