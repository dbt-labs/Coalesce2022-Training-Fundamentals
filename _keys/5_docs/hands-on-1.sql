1. Add a "description: " field directly below each model and column identified in your
"_schema.yml" file

--------
-- file: models/staging/_schema.yml
--------
version: 2

models:
  - name: stg_customers
    description: 
    columns:
      - name: customer_id
        description: 
        tests:
          - unique
          - not_null
  - name: stg_orders
    description: 
    columns:
      - name: order_id
        description: 
        tests:
          - unique
          - not_null
      - name: status
        description: 
        tests:
          - accepted_values:
              values: ['placed', 'shipped', 'completed', 'returned', return_pending]
      - name: customer_id
        description: 
        tests:
          - relationships:
              to: ref('stg_customers')
              field: customer_id

2. Create a markdown file called blocks.md in the staging directory. Use this
file to document the status field in the stg_orders.sql models

--------
-- file: models/staging/blocks.md
--------
{% docs order_status %}

One of the following values:

| status         | definition                                                 |
|----------------|------------------------------------------------------------|
| placed         | Order placed but not yet shipped                           |
| shipped        | Order has been shipped but has not yet been delivered      |
| completed      | Order has been received by customers                       |
| return_pending | Customer has indicated they would like to return this item |
| returned       | Item has been returned                                     |

{% enddocs %}

3. Replace the longform description in the "_schema.yml" file with the docs block function

--------
-- file: models/staging/_schema.yml
--------
- name: status
  description: "{{ doc('doc_name') }}"

4. dbt docs generate

