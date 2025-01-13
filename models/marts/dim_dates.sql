with 
    raw_generate_date as (
        {{ dbt_date.get_date_dimension("2011-01-01", "2015-01-01") }}
)

, generate_date as (
    select
        raw_generate_date.date_day as date_day
        , raw_generate_date.month_start_date as date_start_month
        , raw_generate_date.month_name_short as month_name_short
        , (raw_generate_date.month_name_short||'/'|| raw_generate_date.year_number ) as month_year 
        , raw_generate_date.year_start_date as date_start_year
        , raw_generate_date.year_number as year_number 
    from raw_generate_date
)

, final_date as (
    select
        to_varchar(date(generate_date.date_day), 'YYYYMMDD') AS date_sk 
        , date_day
        , date_start_month
        , month_name_short
        , month_year 
        , date_start_year
        , year_number
    from generate_date
)

select * from final_date
