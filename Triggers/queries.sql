Q1.

create or replace function update_updated_at()
returns trigger as $$
begin
NEW.updated_at = current_timestamp;
return NEW;
end;
$$ language plpgsql;
CREATE FUNCTION


create trigger trigger_update_updated_at
before update on products
for each row
execute function update_updated_at();
CREATE TRIGGER


INSERT INTO products (name, price) VALUES ('Product A', 10.00);
INSERT 0 1

select * from products;

 product_id |   name    | price |         updated_at
------------+-----------+-------+----------------------------
          1 | Product A | 10.00 | 2025-01-19 18:42:22.237753
(1 row)


UPDATE products SET price = 12.00 WHERE product_id = 1;
UPDATE 1

select * from products;

 product_id |   name    | price |         updated_at
------------+-----------+-------+----------------------------
          1 | Product A | 12.00 | 2025-01-19 18:42:43.424147
(1 row)


Q2.

create or replace function prevent_order_deletion()
returns trigger as $$
begin
if exists (select 1 from shipments where order_id = OLD.order_id) then
raise exception 'Cannot delete an order with associated shipments';
end if;
return old;
end;
$$ language plpgsql;

CREATE FUNCTION

create trigger trigger_prevent_order_deletion
before delete on orders
for each row
execute function prevent_order_deletion();

CREATE TRIGGER

INSERT INTO orders (customer_id, order_date) VALUES (1, '2024-01-01');
INSERT 0 1
INSERT INTO orders (customer_id, order_date) VALUES (2, '2024-01-02');
INSERT 0 1
INSERT INTO shipments (order_id, shipment_date) VALUES (1, '2024-01-05');


DELETE FROM orders WHERE order_id = 1;
ERROR:  Cannot delete an order with associated shipments
CONTEXT:  PL/pgSQL function prevent_order_deletion() line 4 at RAISE

DELETE FROM orders WHERE order_id = 2;
DELETE 1

select * from orders;
 order_id | customer_id | order_date
----------+-------------+------------
        1 |           1 | 2024-01-01
(1 row)

