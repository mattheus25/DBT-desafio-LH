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
            salesperson.sales_person_id
            , person.full_name
            , country_name
            , count(*) as num_sales
        from salesperson 
        left join person on salesperson.sales_person_id = person.business_entity_id
        left join sales_order on salesperson.sales_person_id = sales_order.sales_person_id
        left join address on sales_order.bill_to_address_id = address.address_id
        left join state_province on address.stateprovince_id = state_province.stateprovince_id
        left join country s on state_province.country_region_code = state_province.country_region_code
        group by
            salesperson.sales_person_id
            , person.full_name
            , country_name
)

select * from sales_per_seller