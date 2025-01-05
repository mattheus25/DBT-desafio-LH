with 
    salesreason as (
        select *
        from {{ source('sales_source', 'salesreason') }}
)


    , new_sales_reason as (
        select
            salesreasonid as sales_reason_id
            , name as reason_name
            , reasontype as reason_type
        from salesreason
)

select * from new_sales_reason 