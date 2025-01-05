with
    order_detail as (
        select *
        from {{ source('sales_source', 'salesorderdetail') }}
)

    , new_order_detail as (
        select 
            salesorderid as order_id
            , salesorderdetailid as order_detail_id
            , orderqty as order_qty
            , productid as product_id 
            , specialofferid as special_offer_id
            , unitprice as unit_price
            , unitpricediscount as unit_price_discount
        from order_detail
)

select * from new_order_detail