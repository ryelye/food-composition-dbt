{{
    config(
        materialized='table'
    )
}}

with everything as (
    
    select fn.id as food_nutrient_id, * 
    from {{ source('stage_food_composition', 'food_nutrient') }} fn
    inner join {{ source('stage_food_composition', 'food') }} f using (fdc_id)
    inner join {{ source('stage_food_composition', 'nutrient') }} n on fn.nutrient_id = n.id


) 

select {{ dbt_utils.surrogate_key(['fdc_id', 'nutrient_id']) }} as food_nutrient_key, food_nutrient_id, fdc_id, nutrient_id, amount, description, food_category_id, name as nutrient_name, unit_name, nutrient_nbr, rank 

from everything