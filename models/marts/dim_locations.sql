with 
    address as (
        select *
        from {{ ref('stg__address') }}
)
    , state_province as (
        select *
        from {{ ref('stg__state_province') }}
)
    , country_region as (
        select *
        from {{ ref('stg__country_region') }}
)
    , dim_location as (
        select
            {{ dbt_utils.generate_surrogate_key(['address_id', 'postalcode']) }} as sk_address
            , address.address_id
            , address.full_address
            , address.city
            , address.postalcode
            , case 
                when state_province.province_flag = 'false' then 'true'
                else 'false' end as province_flag
            , state_province.state_or_province_name
            , state_province.territory_id
            , country_region.country_code
            , country_region.country_name 
        from address
        left join state_province on address.stateprovince_id = state_province.stateprovince_id
        left join country_region on state_province.country_region_code = country_region.country_code 
)

select * from dim_location 




