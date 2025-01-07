with 
    sales_reason_id as (
        select *
        from {{ ref('stg__sales_order_header_reason') }}
    )

    , sales_reason as (
        select * 
        from {{ ref('stg__sales_reason') }}
    )

    , reason as (
        select 
            sales_reason_id.order_id 
            , sales_reason_id.sales_reason_id
            , sales_reason.reason_name
            , sales_reason.reason_type
        from sales_reason_id
        join sales_reason on sales_reason.sales_reason_id = sales_reason.sales_reason_id
    )

select * from reason 