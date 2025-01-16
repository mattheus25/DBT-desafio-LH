with 
    order_ as (
        select *
        from {{ ref('stg__sales_order') }}
)
    , order_itens as (
        select *
        from {{ ref('stg__sales_order_detail') }}
)     
    , card as (
        select * 
        from {{ ref('stg__creditcard') }}
)

    , orderline as (
        select
            {{ dbt_utils.generate_surrogate_key(['order_.order_id', 'order_itens.order_detail_id']) }} as sk_orderline
            , to_varchar(date(order_.order_date), 'YYYYMMDD') AS date_sk
            , order_.order_date
            , order_.order_id
            , order_.sales_person_id  
            , order_itens.order_detail_id 
            , order_.customer_id 
            , order_.bill_to_address_id 
            , card.card_type  
            , order_itens.order_qty 
            , order_itens.product_id 
            , order_itens.unit_price 
            , order_itens.unit_price_discount
            , order_itens.unit_price * (1 - order_itens.unit_price_discount) * order_itens.order_qty as net_amount
            , order_.subtotal
            , order_.taxamt
            , order_.freight
            , order_.total_due
        from order_
        left join order_itens on order_.order_id = order_itens.order_id
        left join card on order_.creditcard_id = card.creditcard_id
)

select * from orderline