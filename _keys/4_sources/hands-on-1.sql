1. Click on the "..." next to the "staging" and select "New File". Be sure
to include the ".yml" extension. Feel free to copy & paste

--------
-- file: models/staging/_sources.yml
--------
version: 2

sources:
  - name: jaffle_shop
    database: raw
    schema: jaffle_shop_original
    tables:
      - name: orders
      - name: customers

2. Replace the hard-coded database references with the source function.

--------
-- file: models/staging/stg_customers.sql
--------

from {{ source('jaffle_shop', 'customers') }}


--------
-- file: models/staging/stg_orders.sql
--------

from {{ source('jaffle_shop', 'orders') }}

3. After saving, click on the "Lineage" tab to view the green source nodes that
have been added to your project. If you do not see the sources linked be sure that:
    * you are viewing one of your staging models currently
    * you have saved
    * if you still are not seeing the lineage, try refreshing the browser

4. In the "_souces.yml" file, add column & testing identifiers below the tables
that house the columns to be tested

--------
-- file: models/staging/_sources.yml
--------
version: 2

sources:
  - name: jaffle_shop
    database: raw
    schema: jaffle_shop_original
    tables:
      - name: orders
        freshness:
          warn_after: {count: 12, period: hour}
          error_after: {count: 24, period: hour}
        loaded_at_field: _etl_loaded_at
        columns:
          - name: order_id
            tests:
              - unique
              - not_null
      - name: customers
        columns:
          - name: customer_id
            tests:
              - unique
              - not_null
      
5. dbt source freshness