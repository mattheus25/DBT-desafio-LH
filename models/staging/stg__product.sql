with
    product as (
        select *
        from {{ source('production_source', 'product') }}
)

    , new_product as (
        select
            productid as product_id
            , name as product_name
            , productnumber as product_number  
            , makeflag as make_flag 
            , finishedgoodsflag as finished_goods_flag
            , color
            , safetystocklevel as safety_stock_level
            , reorderpoint as reoder_point
            , standardcost as standart_cost
            , listprice as list_price 
            , size
            , sizeunitmeasurecode as size_unit_measure_code
            , weightunitmeasurecode as weight_unit_measure_code
            , weight
            , daystomanufacture as days_to_manufactore
            , productline as product_line
            , class
            , style
            , productsubcategoryid as product_subcategory_id
            , productmodelid as product_model_id 
            , sellstartdate as sell_start_date
        from product
)

select * from new_product