/*
1. ��ǰ ���̺��� ��ǰ_ID �÷��� ___�⺻Ű(Primary Key)___ �÷����� �� ���� �ٸ� ��� �ĺ��� �� ���ȴ�.
2. ��ǰ ���̺��� ������ �÷��� Not Null(NN) �� ������ ���� ___Null___ �� ������ ���� ����.
3. �� ���̺��� �ٸ���� �ĺ��� �� ����ϴ� �÷��� ___��_ID(cust_id)____ �̴�. 
4. �� ���̺��� ��ȭ��ȣ �÷��� ������ Ÿ���� _____VARCHAR2___ ���� ____���ڿ�___������ �� ___15____����Ʈ ������ �� ������ NULL ���� ___���� �� �ִ�___.
5. �� ���̺��� ������ �÷��� ���� 4�� ó�� ������ ���ÿ�.
   ������ �÷��� ������ Ÿ���� Date���� ��¥ ������ ���� ������ �� ������ NULL�� ���� �� ����.
6. �ֹ� ���̺��� �� 5�� �÷��� �ִ�. ���� Ÿ���� __3__���̰� ���ڿ� Ÿ���� __1__�� �̰� ��¥ Ÿ���� __1__���̴�.
7. �� ���̺�� �ֹ����̺��� ���� ���谡 �ִ� ���̺��Դϴ�.
    �θ����̺��� __�����̺�___ �̰� �ڽ� ���̺��� ____�ֹ����̺�____�̴�.
    �θ����̺��� __��_ID___�÷��� �ڽ����̺��� ___��_ID____�÷��� �����ϰ� �ִ�.
    �����̺��� ������ �����ʹ� �ֹ����̺��� ___0~n___ ��� ���谡 ���� �� �ִ�.
    �ֹ����̺��� ������ �����̺��� ____1_____��� ���谡 ���� �� �ִ�.
8. �ֹ� ���̺�� �ֹ�_��ǰ ���̺��� ���� ���谡 �ִ� ���̺��Դϴ�.
    �θ� ���̺��� ___�ֹ����̺�_____ �̰� �ڽ� ���̺��� ___�ֹ�_��ǰ ���̺�____�̴�.
    �θ� ���̺��� ____�ֹ�_ID____�÷��� �ڽ� ���̺��� _____�ֹ�_ID______�÷��� �����ϰ� �ִ�.
    �ֹ� ���̺��� ������ �����ʹ� �ֹ�_��ǰ ���̺��� ____0~n____ ��� ���谡 ���� �� �ִ�.
    �ֹ�_��ǰ ���̺��� ������ �ֹ� ���̺��� _____1_____��� ���谡 ���� �� �ִ�.
9. ��ǰ�� �ֹ�_��ǰ�� ���� ���谡 �ִ� ���̺��Դϴ�. 
    �θ� ���̺��� ____��ǰ���̺�_______ �̰� �ڽ� ���̺��� ___�ֹ�_��ǰ ���̺�____�̴�.
    �θ� ���̺��� ____��ǰ_ID___�÷��� �ڽ� ���̺��� __��ǰ_ID_______�÷��� �����ϰ� �ִ�.
    ��ǰ ���̺��� ������ �����ʹ� �ֹ�_��ǰ ���̺��� ___0~n_____ ��� ���谡 ���� �� �ִ�.
    �ֹ�_��ǰ ���̺��� ������ ��ǰ ���̺��� ___1____��� ���谡 ���� �� �ִ�.
*/

-- TODO: 4���� ���̺� � ������ �ִ��� Ȯ��.
select * from products;
select * from order_items;
select * from orders;
select * from customers;

-- TODO: �ֹ� ��ȣ�� 1�� �ֹ��� �ֹ��� �̸�, �ּ�, �����ȣ, ��ȭ��ȣ ��ȸ
select c.cust_name, c.address, c.postal_code, c.phone_number
from customers c join orders o on c.cust_id=o.cust_id
where o.order_id=1;

-- TODO : �ֹ� ��ȣ�� 2�� �ֹ��� �ֹ���, �ֹ�����, �ѱݾ�, �ֹ��� �̸�, �ֹ��� �̸��� �ּ� ��ȸ
select o.order_date, o.order_status, o.order_total, c.cust_name, c.cust_email
from customers c join orders o on c.cust_id=o.cust_id
where o.order_id = 2;

-- TODO : �� ID�� 120�� ���� �̸�, ����, �����ϰ� ���ݱ��� �ֹ��� �ֹ������� �ֹ�_ID, �ֹ���,
--�ѱݾ��� ��ȸ
select c.cust_name, c.gender, c.join_date, o.order_id, o.order_date, o.order_total
from customers c join orders o on c.cust_id = o.cust_id
where c.cust_id = 120;

-- TODO : �� ID�� 110�� ���� �̸�, �ּ�, ��ȭ��ȣ, �װ� ���ݱ��� �ֹ��� �ֹ������� �ֹ�_ID, 
--�ֹ���, �ֹ����� ��ȸ
select c.cust_name, c.address, c.phone_number, o.order_id, o.order_date, o.order_status
from customers c join orders o on c.cust_id = o.cust_id
where c.cust_id = 110;

-- TODO : �� ID�� 120�� ���� ������ ���ݱ��� �ֹ��� �ֹ������� ��� ��ȸ.
select c.*, o.*
from customers c join orders o on c.cust_id = o.cust_id
where c.cust_id = 120;

-- TODO : '2017/11/13'(�ֹ���¥) �� �ֹ��� �ֹ��� �ֹ����� ��_ID, �̸�, �ֹ�����, �ѱݾ��� ��ȸ
select  c.cust_id, c.cust_name, o.order_status, o.order_total
from    customers c join orders o on c.cust_id = o.cust_id
where   o.order_date = '2017/11/13';

-- TODO : �ֹ��� ID�� xxxx�� �ֹ���ǰ�� ��ǰ�̸�, �ǸŰ���, ��ǰ������ ��ȸ.
select p.product_name, o.sell_price, p.price
from order_items o join products p on o.product_id=p.product_id
where o.ordere_item_id= 1;

-- TODO : �ֹ� ID�� 4�� �ֹ��� �ֹ� ���� �̸�, �ּ�, �����ȣ, �ֹ���, �ֹ�����, �ѱݾ�, 
--�ֹ� ��ǰ�̸�, ������, ��ǰ����, �ǸŰ���, ��ǰ������ ��ȸ.
select c.cust_name, c.address, c.postal_code, o.order_date, o.order_status, o.order_total,
        p.product_name, p.maker, p.price, oi.sell_price, oi.quantity
from order_items oi join orders o on oi.order_id = o.order_id
                    join products p on oi.product_id = p.product_id
                    join customers c on o.cust_id = c.cust_id
where o.order_id = 4;

-- TODO : ��ǰ ID�� 200�� ��ǰ�� 2017�⿡ � �ֹ��Ǿ����� ��ȸ.
select  count(*) "2017�� �Ǹż���"
from    order_items oi join orders o on oi.order_id = o.order_id
where   oi.product_id = 200
and     to_char(o.order_date ,'yyyy')=2017;
--ORACLE����
select count(*)
from order_items oi, orders o
where oi.order_id = o.order_id
and     oi.product_id = 200
and     to_char(o.order_date,'yyyy')=2017;

-- TODO : ��ǰ�з��� �� �ֹ����� ��ȸ
select p.category , count(*) �ֹ���
from products p join order_items oi on p.product_id = oi.product_id
group by p.category;
--outer join�ϱ�
select p.category , nvl(sum(oi.quantity),0) �ֹ���
from products p left join order_items oi on p.product_id = oi.product_id
group by p.category;
--ORACLE����
select decode(grouping_id(p.category),1,'���ֹ���',p.category)category , nvl(sum(oi.quantity),0) �ֹ���
from products p, order_items oi 
where p.product_id = oi.product_id(+)
group by rollup(p.category);

insert into products values(600,'����ǰ','���̽�ũ��','����Ŀ1',3000);
insert into products values(610,'����ǰ','���̽�ũ��','����Ŀ1',3000);
commit;

select *
from customers natural join orders;

select *
from customers join orders using(cust_id);

select * from customers cross join orders;
select * from customers, orders;