with 
    salesorder as (
        select *
        from {{ source('sales_source', 'salesorderheader') }}
)

    , new_sales_order as (
        select 
            salesorderid as order_id 
            , orderdate as order_date
            , onlineorderflag as online_flag
            , customerid as customer_id 
            , salespersonid as sales_person_id
            , territoryid as territoryid
            , billtoaddressid as bill_to_address_id
            , shiptoaddressid as ship_to_address_id
            , creditcardid as creditcard_id
            , subtotal
            , taxamt
            , freight
            , totaldue as total_due
        from salesorder
)

select * from new_sales_order