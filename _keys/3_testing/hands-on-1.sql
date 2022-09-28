1. Click on the "..." next to the folder and select "New File". Be sure
to include the ".yml" extension. Feel free to copy & paste

2. Your YAML file should mirror the below. If you are receiving compilation errors,
be sure to check the indentation. Also, be sure that your transformed column names from the
staging layer are the same in your "_schema.yml" file. Copy & paste is encouraged with YAML.

--------
-- file: models/staging/_schema.yml
--------
version: 2

models:
  - name: stg_customers
    columns:
      - name: customer_id
        tests:
          - unique
          - not_null
  - name: stg_orders
    columns:
      - name: order_id
        tests:
          - unique
          - not_null
      - name: status
        tests:
          - accepted_values:
              values: ['placed', 'shipped', 'completed', 'returned', return_pending]
      - name: customer_id
        tests:
          - relationships:
              to: ref('stg_customers')
              field: customer_id

3. dbt test