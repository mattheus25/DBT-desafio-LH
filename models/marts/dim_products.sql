with
    product as (
        select *
        from {{ ref('stg__product') }}
)

    , new_product as (
        select
            product_id
            , product_name
            , product_number  
            , make_flag 
            , finished_goods_flag
            , color
            , safety_stock_level
            , reoder_point
            , standart_cost
            , list_price 
            , size
            , size_unit_measure_code
            , weight_unit_measure_code
            , weight
            , days_to_manufactore
            , product_line
            , class
            , style
            , product_subcategory_id
            , product_model_id 
            , sell_start_date
        from product
)

select * from new_product