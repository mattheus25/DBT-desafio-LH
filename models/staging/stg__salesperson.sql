with
    salesperson as (
        select *
        from {{ source('sales_source', 'salesperson') }}
)
    , new_salesperson as (
        select 
        businessentityid as sales_person_id
        , territoryid as territory_id
        from salesperson
)

select * from new_salesperson