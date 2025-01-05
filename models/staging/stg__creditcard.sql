with 
    creditcard as (
        select *
        from {{ source('sales_source', 'creditcard') }}
)

    , new_creditcard as (
        select
            creditcardid as creditcard_id
            , cardtype as card_type
        from creditcard

)

select * from new_creditcard