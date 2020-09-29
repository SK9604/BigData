/* *********************************************************************
INSERT �� - �� �߰�
����
 - �����߰� :
   - INSERT INTO ���̺�� (�÷� [, �÷�]) VALUES (�� [, ��[])
   - ��� �÷��� ���� ���� ��� �÷� ���������� ���� �� �� �ִ�.

 - ��ȸ����� INSERT �ϱ� (subquery �̿�)
   - INSERT INTO ���̺�� (�÷� [, �÷�])  SELECT ����
	- INSERT�� �÷��� ��ȸ��(subquery) �÷��� ������ Ÿ���� �¾ƾ� �Ѵ�.
	- ��� �÷��� �� ���� ��� �÷� ������ ������ �� �ִ�.
  
************************************************************************ */

insert into emp (emp_id, emp_name, job_id, mgr_id, hire_date, salary, comm_pct, dept_id)
            values (1000, 'ȫ�浿', 'IT_PROG', 120, '2019-07-15', 5000, 0.1, 60);
            
--��� �÷��� ���� ���� ��� �÷������� ���� ����, ���� ����: ���̺� ������ ������ �÷���            
--Null : null��
--DATE : '��/��/��' �̿��� ������ to_date() ��ȯ, sysdate : ��������� �Ͻø� ��ȯ�ϴ� �Լ�.
insert into emp values (1100, '��ö��', null, 120, to_date('2015/03','yyyy/mm'), 5000, 0.1, null);
insert into emp values (1200, '��ö��', null, 120, sysdate, 5000, 0.1, null);

select * from emp order by emp_id desc;

--salary : NOT NULL �������� => �ݵ�� ���� ���� �Ѵ�.
insert into emp (emp_id, emp_name, hire_date) values(1300,'�̼���','2010/10/05');

--salary ������: 5�ڸ� => 7�ڸ�(������ ũ�Ⱑ �÷��� ũ�⺸�� ũ�� ����)
insert into emp (emp_id, emp_name, hire_date, salary) values(1300,'�̼���','2010/10/05', 1000000);

--��������: primary key(�⺻Ű) �÷��� ���� ���� insert ����.
--         foreign key(�ܷ�Ű) �÷����� �ݵ�� �θ����̺��� primary key �÷��� �ִ� ���鸸 ���� �� �ִ�.
insert into emp (emp_id, emp_name, hire_date, salary, dept_id) values(1400,'�̼����̼���','2010/10/05', 10000, 500);


create table emp2( emp_id number(6), emp_name varchar2(20), salary number(7,2));

--emp���� ��ȸ�� ���� emp2�� insert
insert into emp2 (emp_id, emp_name, salary)
select emp_id, emp_name, salary
from emp
where dept_id = 10;

select * from emp2;

--TODO: �μ��� ������ �޿��� ���� ��� ���̺� ����. 
--      ��ȸ����� insert. ����: �հ�, ���, �ִ�, �ּ�, �л�, ǥ������
drop table salary_stat;
create table salary_stat(
    dept_id number(6),
    salary_sum number(15,2),
    salary_avg number(10,2),
    salary_max number(7,2),
    salary_min number(7,2),
    salary_var number(20,2),
    salary_stddev number(7,2)
);

insert into salary_stat
select dept_id, sum(salary), round(avg(salary), 2), max(salary), min(salary), round(variance(salary),2), round(stddev(salary),2)
from emp
group by dept_id
order by 1;

select * from salary_stat;

/* *********************************************************************
UPDATE : ���̺��� �÷��� ���� ����
UPDATE ���̺��
SET    ������ �÷� = ������ ��  [, ������ �÷� = ������ ��]
[WHERE ��������]

 - UPDATE: ������ ���̺� ����
 - SET: ������ �÷��� ���� ����
 - WHERE: ������ ���� ����. 
************************************************************************ */

-- ���� ID�� 200�� ������ �޿��� 5000���� ����
select emp_id, salary from emp where emp_id = 200;
update  emp
set     salary = 5000
where   emp_id = 200;
--rollback; (���󺹱�)
--commit;(���� ���� ���� ����(Ŀ�Խ� �ѹ��� �ȵ�))

-- ���� ID�� 200�� ������ �޿��� 10% �λ��� ������ ����.
update  emp
set     salary = salary * 1.1
where   emp_id = 200;

-- �μ� ID�� 100�� ������ Ŀ�̼� ������ 0.2�� salary�� 3000�� ���� ������ ����.
select * from emp where dept_id = 100;
update  emp
set     comm_pct = 0.2, salary = salary + 3000
where   dept_id = 100;

-- TODO: �μ� ID�� 100�� �������� �޿��� 100% �λ�
update  emp
set     salary = salary * 2
where   dept_id = 100;

-- TODO: IT �μ��� �������� �޿��� 3�� �λ�
select * from emp e, dept d where e.dept_id = d.dept_id and d.dept_name = 'IT';
update  emp
set     salary = salary * 3
where   dept_id  = (select dept_id from dept where dept_name = 'IT');

-- TODO: EMP ���̺��� ��� �����͸� MGR_ID�� NULL�� HIRE_DATE �� �����Ͻ÷� COMM_PCT�� 0.5�� ����.
update  emp
set mgr_id = null, hire_date = sysdate, comm_pct = 0.5;
rollback;
select * from emp;
/* *********************************************************************
DELETE : ���̺��� ���� ����
���� 
 - DELETE FROM ���̺�� [WHERE ��������]
   - WHERE: ������ ���� ����
************************************************************************ */

select * from dept where dept_id = 100;
delete from dept where dept_id = 200;
delete from dept where dept_id = 100; --emp���̺�(�ڽ����̺�)���� 100�� �μ��� �����ϰ������Ƿ� ������ �Ұ����ϴ�.
--�ڽ����̺��� ���� ���� �����ϰų� �� ���� ���� �� �� ó���Ѵ�.
delete from emp where dept_id = 100;
rollback;
delete from emp;
select * from emp;

-- TODO: �μ� ID�� ���� �������� ����
delete from emp where dept_id is null;

-- TODO: ��� ����(emp.job_id)�� 'SA_MAN'�̰� �޿�(emp.salary) �� 12000 �̸��� �������� ����.
update emp
set mgr_id = null
where emp_id in (select emp_id from emp where mgr_id in (148,149));
delete from emp where job_id = 'SA_MAN' and salary <12000;

-- TODO: comm_pct �� null�̰� job_id �� IT_PROG�� �������� ����
delete from emp where comm_pct is null and job_id = 'IT_PROG';

create table emp2
as
select * from emp;

select * from emp2;
delete from emp2;
rollback;
/*
truncate table ���̺��; =>DDL��. �ڵ� Ŀ��
->��ü �����͸� ���� (delete from ���̺��)
->rollback�� �̿��� ������ �ȵȴ�.
*/

/*rollback�� �߰����� savepoint �̸�
    =>rollback �̸�
ddl�� commit�� �ٷ� ��
client tool�� ����� �ٷ� commit��
*/
