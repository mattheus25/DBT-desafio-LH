with 
    store as (
        select *
        from {{ source('sales_source', 'store') }}

)
    , new_store as (
        select 
            businessentityid as business_entity_id
            , name as store_name
            , salespersonid as sales_person_id
        from store
)

select * from new_store