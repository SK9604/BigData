-- �ּ�
/*
���ּ�(������ �ּ�)
*/
/*
���̺�: customer
�÷�: id: varchar2(10)
     name: nvarchar2(10)
     age: number(3) �����������
     gender: char(1) ����: F, ����: M
     join_date: Date
*/
create table customer(
    id varchar(10),
    name nvarchar2(10),
    age number(3),
    gender char(1),
    join_date date
);
--����: ctrl+enter

/*
���̺� �� ���� ������ �߰�
insert into ���̺��̸� (�÷���, �÷���,...) values (��, ��,...);
��� �÷��� ���� ���� ��� �÷� ������ ��������
*/
insert into customer (id, name, age, gender, join_date) values ('my-id','�輱��',24,'F','2019-07-03');
insert into customer (id, name, age) values('my-id2','������',22);
--gender, join_date => null
--��ȸ
select * from customer;
--���̺� ���� : drop table ���̺� �̸�
drop table customer;

create table customer(
    id varchar(10) primary key,--�⺻Ű �÷�(not null�� �ǹ̸� ������)
    name nvarchar2(10) not null,--�ݵ�� �����ϴ� ��. null�� ���� �� ���� �÷�
    age number(3) not null,
    gender char(1),
    join_date date
);

insert into customer values ('my-id','�輱��',24,'F','2019-07-03');
insert into customer (id) values ('my-id2');--not null���� �߻�
insert into customer(id,name, age) values ('my-id3','������',22);


