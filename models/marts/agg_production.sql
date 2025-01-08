with 
    customer as (
        select *
        from {{ ref('stg__customers') }}
)
    , store as (
        select *
        from {{ ref('stg__store') }} 
)   
    , order_ as (
        select *
        from {{ ref('stg__sales_order') }}
)
    , order_itens as (
        select *
        from {{ ref('stg__sales_order_detail') }}
)
    , product as (
        select *
        from {{ ref('stg__product') }}
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

    , production as (
        select
            {{ dbt_utils.generate_surrogate_key([ 'order_itens.order_detail_id']) }} as sk_production
            , customer.customer_id
            , store_id 
            , store_name
            , order_.order_id
            , order_itens.order_detail_id
            , order_itens.order_qty
            , order_itens.unit_price
            , order_.order_date
            , order_itens.unit_price_discount
            , product.product_name
            , state_province.state_province_code
            , state_province.state_or_province_name as state_or_province_name
            , case 
                when province_flag = 'false' then 1
                else 0 
              end as province_st_flag
            , country_region.country_name
            , country_region.country_code 
        from customer
        left join store on customer.customer_id = store.business_entity_id 
        left join order_ on customer.customer_id = order_.customer_id
        left join order_itens on order_itens.order_id = order_.order_id
        left join product on order_itens.product_id = product.product_id
        left join address on order_.bill_to_address_id = address.address_id
        left join state_province on address.stateprovince_id = state_province.stateprovince_id
        left join country_region on state_province.country_region_code = country_region.country_code
    )
select * from production 