{{ config(materialized='table') }}

select * from {{ source('stage_food_composition', 'food') }}