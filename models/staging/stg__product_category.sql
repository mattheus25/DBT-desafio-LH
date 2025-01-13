with 
    product_category as (
        select *
        from {{ source('production_source', 'productcategory') }}
)
    , new_product_category as (
        select 
            productcategoryid as product_category_id
            , name as product_category_name
        from product_category 
)

select * from new_product_category