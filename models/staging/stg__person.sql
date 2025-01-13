with 
    person as (
        select *
        from {{ source('person_source', 'person') }}
)
    , new_person as (
        select
            businessentityid as business_entity_id
            , persontype as person_type            
            , namestyle as name_style 
            , firstname ||' '||lastname as full_name 
        from person
)

select * from new_person 