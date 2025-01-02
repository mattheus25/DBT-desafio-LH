with 
    state_province as (
        select *
        from {{ source('person_source', 'stateprovince') }} 
)

    , new_state_province as (
        select 
            stateprovinceid as stateprovince_id
            , stateprovincecode as state_province_code
            , countryregioncode as conutry_region_code 
            , isonlystateprovinceflag as province_flag  
            , name as state_or_province_name
            , territoryid as territory_id
        from state_province
)

select * from new_state_province 