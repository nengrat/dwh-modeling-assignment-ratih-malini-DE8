-- dim_sales_shipment
{{
  config(
    materialized='table'
  )
}}

With t_data AS (
SELECT DISTINCT 
  `ship-service-level` AS ship_service_level,
  `Courier Status` AS courier_status,
  `ship-city` AS ship_city,
  `ship-state` AS ship_state,
  `ship-postal-code` AS ship_postal_code,
  `ship-country` AS ship_country
FROM
    {{ source('bronze', 'amazon_sale_report') }}
)

SELECT {{ dbt_utils.generate_surrogate_key([
				'ship_service_level',
                'courier_status',
                'ship_city',
                'ship_state',
                'ship_postal_code',
                'ship_country'
			]) }} as sales_shipment_id, *
FROM t_data
