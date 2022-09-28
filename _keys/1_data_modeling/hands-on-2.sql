1. This can be done in 2 locations: dbt_project.yml file or in the model itself. We 
recommend you manage materializations in the dbt_project.yml file. Open the file, scroll
to the bottom and identify the "materialized:" statement. Update the materialization to table

2. dbt run

3. This can be done by clicking on the run overview, and then opening up the summary
of each model built. Look for "created table model"

4. Located in snowflake under your target schema in Snowflake