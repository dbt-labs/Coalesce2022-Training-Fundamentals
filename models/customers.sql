with customers as (

    select
        id as customer_id,
        name as customer_name

    from raw.jaffle_shop.customers

),

orders as (

    select
        id as order_id,
        customer_id,
        ordered_at

    from raw.jaffle_shop.orders

),

products as (

    select
        name as product_name,
        type as product_type,
        price,
        sku as product_sku

    from raw.jaffle_shop.products
),

order_items as (

    select
        id as order_item_id,
        order_id,
        sku as product_sku

    from raw.jaffle_shop.order_items

),

final as (

    select
        customers.customer_id,
        customers.customer_name,

        min(orders.ordered_at) as first_order_date,
        max(orders.ordered_at) as most_recent_order_date,
        count(distinct orders.order_id) as number_of_orders,
        sum(case when products.product_type = 'beverage' then 1 else 0 end) as beverage_count,
        sum(case when products.product_type = 'jaffle' then 1 else 0 end) as jaffle_count

    from customers
    left join orders on customers.customer_id = orders.customer_id
    left join order_items on orders.order_id = order_items.order_id
    left join products on order_items.product_sku = products.product_sku

    group by 1, 2

)

select * from final
