1. Click on the "..." next to the models folder and select "New Folder". 
Click on the "..." next to the customers.sql file and select "rename".
    ***tip - when renaming "customers", add the new "marts" subdirectory
    to the name (e.g. "models/marts/dim_customers.sql")


2. Create 2 new files under the "staging" folder: stg_customers.sql & 
stg_orders.sql.

-------
-- file: stg_customers.sql
-------
with

source as (

    select * from raw.jaffle_shop_original.customers

),

staged as (

    select
        id as customer_id,
        name
    from source

)

select * from staged

---------
--file: stg_orders.sql
---------
with

source as (

    select * from raw.jaffle_shop_original.orders

),

staged as (

    select
        id as order_id,
        customer_id,
        ordered_at

    from source

)

select * from staged

3. Navigate to the "dbt_project.yml" file and scroll to the bottom. You will need
to add a new layer under "models" for each of the new subfolders that were built.
Under "staging", you will add a "materialized: " tag and ensure it materializes
as a view

--------
-- file: dbt_project.yml
--------
models:
  my_new_project:
    marts:
      +materialized: table
    staging:
      +materialized: view


4. Remove the CTEs that were moved from "dim_customers.sql" to the new staging
layer models and replace them with references to the staging models.
    ***tip - this code snippet is just representative of the changes made in 
    the "dim_customers.sql" file, not of the entire file.

--------
-- file: dim_customers.sql
--------
with customers as (
    select * from {{ ref('stg_customers')}}
),
orders as (
    select * from {{ ref('stg_orders')}}
),

