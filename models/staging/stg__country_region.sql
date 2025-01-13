with

    country as (
        select *
        from {{ source('person_source', 'countryregion') }}
    )

    , new_country as (
        select
            countryregioncode as country_code
            , name as country_name
        from country
)

select * from new_country