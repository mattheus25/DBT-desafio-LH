-- tests/test_fact_orderline_gross_revenue_2011.sql

with 
    orderline as (
        select *
    from {{ ref('fact_orderline') }}
    
)

, query_test as (
    select 
        round(count(distinct(order_id))) as num_orders
    from orderline
)

, test as (
    select 
        *
    from query_test  
    where num_orders != 31465
)

select * from test 