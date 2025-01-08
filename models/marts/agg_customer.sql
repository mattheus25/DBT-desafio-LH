with
    customer as (
        select *
        from {{ ref('stg__customers') }}
)
    , person as (
        select *
        from {{ ref('stg__person') }}
)
    , store as ( 
        select *
        from {{ ref('stg__store') }}
    
)
    , address as (
        select *
        from {{ ref('stg__address') }}
)   
    , state_province as (
        select *
        from {{ ref('stg__state_province') }}
)
    , country_region as (
        select *
        from {{ ref('stg__country_region') }}
)
    , order_ as (
        select *
        from {{ ref('stg__sales_order') }}
)   
    , order_itens as (
        select *
        from {{ ref('stg__sales_order_detail') }}
)
    , products as (
        select *
        from {{ ref('stg__product') }}
)
    , customers as (
        select
            {{ dbt_utils.generate_surrogate_key(['customer.customer_id', 'customer.person_id']) }} as sk_customer 
            , customer.customer_id
            , customer.person_id
            , person.full_name
            , customer.store_id
            , store.store_name
        from customer 
        left join person on customer.customer_id = person.business_entity_id
        left join store on customer.customer_id = store.business_entity_id
)   
    , new_customers as (
        select
            customers.customer_id 
            , customers.full_name
            , order_.order_id
            , order_itens.order_detail_id
            , order_itens.order_qty
            , order_itens.unit_price
            , order_.order_date
            , order_itens.unit_price_discount
            , products.product_name 
            , order_.bill_to_address_id
            , state_province.state_province_code
            , state_province.state_or_province_name as state
            , country_region.country_name
            , country_region.country_code
            , address.full_address
        from customers 
        left join order_ on customers.customer_id = order_.customer_id
        left join order_itens on order_itens.order_id = order_.order_id
        left join products on order_itens.product_id = products.product_id
        left join address on order_.bill_to_address_id = address.address_id
        left join state_province on address.stateprovince_id = state_province.stateprovince_id
        left join country_region on state_province.country_region_code = country_region.country_code 
)
    , agg_customers as (
        select 
            customer_id
            , full_name
            , country_name 
            , full_address
            , state
            , sum ((order_qty*unit_price) * (1-unit_price_discount)) as cltv
            , min (order_date) as first_purchase
            , max (order_date) as last_purchase 
        from new_customers
        group by 
            customer_id
            , full_name
            , country_name
            , full_address
            , state  
)
    , agg_customers_final as (
        select 
            customer_id
            , full_name
            , country_name
            , full_address
            , state
            , round(cltv,2) as cltv
            , first_purchase
            , last_purchase
            , round(datediff('day', first_purchase, last_purchase) / 30.44, 1) as customer_lifetime_months
        from agg_customers
        where cltv is not null 
)

select * from agg_customers_final 