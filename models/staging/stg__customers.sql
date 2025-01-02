With
    customer as (
        select *
        from {{ source('sales_source', 'customer') }}
)

    , new_customer as (
        select 
            customerid as customer_id 
            , personid as person_id
            , storeid as store_id
            , territoryid as territory_id
        from customer 

)

select * from new_customer