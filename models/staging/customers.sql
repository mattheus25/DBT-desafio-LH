select * from {{ source('sales_source', 'customer') }}

