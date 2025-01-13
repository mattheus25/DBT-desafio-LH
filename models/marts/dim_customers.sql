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

select * from customers    