with customers as (

    select
        id as customer_id,
        name

    from raw.jaffle_shop.customers

),

orders as (

    select
        id as order_id,
        customer_id,
        ordered_at

    from raw.jaffle_shop.orders

),

customer_orders as (

    select
        customer_id,

        min(ordered_at) as first_order_date,
        max(ordered_at) as most_recent_order_date,
        count(order_id) as number_of_orders

    from orders

    group by 1

),


final as (

    select
        customers.customer_id,
        customers.name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders

    from customers

    left join customer_orders using (customer_id)

)

select * from final