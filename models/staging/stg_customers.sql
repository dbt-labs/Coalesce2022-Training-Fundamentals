with customers as (

    select
        id as customer_id,
        first_name,
        last_name

    from raw.jaffle_shop_original.customers

)

select * from customers