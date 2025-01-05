with 
    salesorderheadereason as (
        select *
        from {{ source('sales_source', 'salesorderheadersalesreason') }}
)

    , new_sales_order_header as (
        select
            salesorderid as sales_order_id
            , salesreasonid as sales_reason_id
        from salesorderheadereason
)

select * from new_sales_order_header