with 

    address as (
        select *
        from {{ source('person_source', 'address') }}

)

, new_address as (
        select
        addressid as address_id
        , stateprovinceid as stateprovince_id
        , coalesce(addressline1, '') || ' ' || coalesce(addressline2, '') AS full_address
        , city
        , postalcode
        , spatiallocation
        from address 
)

select * from new_address