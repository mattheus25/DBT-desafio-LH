with 
    salesperson as ( 
        select * 
        from {{ ref('stg__salesperson') }}
)
    , person as(
        select *
        from {{ ref('stg__person') }}
)
    , address as (
        select * 
        from {{ ref('stg__address') }}
)
    , state_province as (
        select * 
        from {{ ref('stg__state_province') }}
)
    , country as(
        select * 
        from {{ ref('stg__country_region') }}
)
    , sales_order as (
        select * 
        from {{ ref('stg__sales_order') }}   
)
    , sales_per_seller as (
        select
            {{ dbt_utils.generate_surrogate_key(['sales_person_id', 'territoryid']) }} as sk_seller_per_region
            , sales_person_id
            , person.full_name
            , territoryid
            , country_name
            , count(order_id) as num_sales
        from sales_order
        left join person on sales_order.sales_person_id = person.business_entity_id
        left join state_province on sales_order.territoryid = state_province.territory_id
        left join country on state_province.country_region_code = country.country_code
        group by 
            sales_person_id
            , person.full_name
            , territoryid
            , country_name
)

select * from sales_per_seller

