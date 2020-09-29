/* *****************************************
�� (View)
- �ϳ� �Ǵ� ���� ���̺�� ���� �������� �κ� ������ �������� ǥ���ϴ� ��.
- ���� �����͸� ������ �ִ� ���� �ƴ϶� �ش� �������� ��ȸ SELECT ������ ������ �ִ� ��.
- �並 �̿��� ��ȸ�Ӹ� �ƴ϶� ������ ����(insert/update/delete)�� �����ϴ�. �������̺��� ���� �ٲ�
- ���̺�ó�� ��밡��

- ����
  - ������ select���� �����ϰ� ó�� ����
  - ������� ������ ������ ���� (������, ��� �� �� �� �� �ִ� �����͸� �޸��� �� �ִ�.)

- ���� ����
  - �ܼ��� 
	- �ϳ��� ���̺��� �����͸� ��ȸ�ϸ� �Լ��� ������� �ʴ´�.  

  - ���պ�
	- ���� ���̺��� �����͸� ��ȸ�Ѵ�.
	- �Լ��� group by�� �̿��� ��ȸ�Ѵ�.
    - �並 ���� ������ �ȵ� �� �ִ�.
	
- �並 �̿��� DML(INSERT/DELETE/UPDATE) �۾��� �ȵǴ� ���
	- ���� �׸��� ���Ե� �ִ� ��� insert/delete/update �� �� ����.
		- �׷��Լ�
		- group by ��
		- distinct 
		- rownum 
		- SELECT ���� ǥ������ �ִ� ���
		- View�� ����� �࿡ NOT NULL ���� �ִ� ���
		

- ����
CREATE [OR REPLACE] VIEW ���̸�
AS
SELECT ��
[WITH CHECK OPTION]
[WITH READ ONLY]


- OR REPLACE
	- ���� �̸��� �䰡 ���� ��� �����ϰ� ���� �����Ѵ�.
	
- WITH CHECK OPTION
	- View���� ��ȸ�� �� �ִ� ���� insert�Ǵ� update�� �� �ִ�.

- WITH READ ONLY
	- �б� ���� View�� ����. INSERT/DELETE/UPDATE�� �� �� ����. select�� ����
	
View ����
DROP VIEW VIEW�̸�;	
**************************************** */

create view emp_view 
as
select * from emp where dept_id = 60;

select * from emp_view;
select * from emp;

select *
from (select * from emp where dept_id = 60); --inline view, view���� ���̴� inline view�� ��ȸ�� view�� ������ ��밡��

select e.emp_name, d.dept_name
from emp_view e, dept d
where e.dept_id = d.dept_id;

update  emp_view
set     comm_pct = 0.5
where   emp_id = 104;       --�� �� emp���̺��� 104���� comm_pct�� �ٲ��. (���� ���̺��� ���� �ٲ�)
-- =
update  emp
set     comm_pct = 0.5
where   emp_id = 104;

create or replace view emp_view --�Ȱ��� �̸��� view�� ���� �� �������(����� ����)
as
select  emp_id, emp_name, dept_id
from    emp;         

insert into emp_view values (5000, '���̸�', 60); --emp ���̺��� hire_date�� not null�̱� ������ insert �Ұ�

create view dept_view
as
select * from dept where loc = 'New York';

insert into dept_view values(300,'���μ�','����');
insert into dept_view values(301, '����μ�', 'New York');
select * from dept_view;        --dept_view�� loc�� New York�� �͸� ���� ������ ������ '����'�� ���� ���� �並 ��ȸ�ص� ������ �ʴ´�.
select * from dept;             --dept ���̺��� ��ȸ ����

create view dept_view2
as
select * from dept where loc = 'New York' 
with check option;      --View���� ��ȸ�� �� �ִ� ���� insert�Ǵ� update�� �� �ִ�. view�� where���� ������ �����ϴ� ��(��)�鸸 ���� ����.

insert into dept_view2 values(303, '����μ�', '����');   --view���� loc�� New York���� ���߱� ������ insert�� �Ұ����ϴ�.
insert into dept_view2 values(303, '����μ�', 'New York'); --���� ����
update dept_view2 set dept_name = 'aaa' where dept_id = 10; --view�� ���� �����͹Ƿ� update�� �ȵ�(0�� ����)

create view dept_view3
as
select * from dept where loc = 'New York' 
with read only;

select * from dept_view3;
insert into dept_view3 values(400, 'a', 'b'); --read only view�̱� ������ insert�� update, delete(DML)�� �Ұ����ϴ�.
delete from dept_view3; --���� �Ұ���

create view emp_name_view
as
select  emp_name, length(emp_name) name_length --�Լ��� �����Ƿ� insert���� �Ұ����ϴ�.
from    emp;

select * from emp_name_view;

create view emp_view2
as
select dept_id, max(salary) �ִ�޿�, min(salary) �ּұ޿�
from emp
group by dept_id;

select * from emp_view2;
update emp set salary = 30000 where emp_id =108; --emp���̺��� ���� �ٲ� ���� emp_view2�� �ٷ� ����Ǿ� �״�� ������

create view emp_dept_view
as
select e.emp_id, e.emp_name, e.salary, e.job_id, e.hire_date, e.comm_pct, d.dept_id, d.dept_name, d.loc from emp e left join dept d on e.dept_id = d.dept_id;

select * from emp_dept_view --join���� �ʾƵ� join�� ����� �� �� ����
where loc = 'Seattle';

--TODO: �޿�(salary)�� 10000 �̻��� �������� ��� �÷����� ��ȸ�ϴ� View ����
create or replace view emp_salary
as
select * from emp where salary>=10000 order by salary;
select * from emp_salary;

--TODO: �μ���ġ(dept.loc) �� 'Seattle'�� �μ��� ��� �÷����� ��ȸ�ϴ� View ����
create view dept_loc_view
as
select * from dept where loc = 'Seattle';
select * from dept_loc_view;

--TODO: JOB_ID�� 'FI_ACCOUNT', 'FI_MGR' �� �������� ����_ID(emp.emp_id), �����̸�(emp.emp_name), ����_ID(emp.job_id), 
-- ������(job.job_title), �����ִ�޿�(job.max_salary), �ּұ޿�(job.min_salary)�� ��ȸ�ϴ� View�� ����
create view job_emp_view
as
select e.emp_id, e.emp_name, e.job_id, j.job_title, j.max_salary, j.min_salary
from emp e left join job j on e.job_id = j.job_id where e.job_id in( 'FI_ACCOUNT','FI_MGR' );
select * from job_emp_view;

--TODO: �������� ������ ������ �޿� ���(salary_grade.grade)�� ��ȸ�ϴ� View�� ����
create or replace view emp_grade_view
as
select e.*, s.* from emp e join salary_grade s on e.salary between s.low_sal and s.high_sal;
select * from emp_grade_view;

--TODO: ������ id(emp.emp_id), �̸�(emp.emp_name), ������(job.job_title), �޿�(emp.salary), �Ի���(emp.hire_date),
--   ����̸�(emp.emp_name), ������Ի���(emp.hire_date), �ҼӺμ��̸�(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ�ϴ� View�� ����
-- ��簡 ���� ������ ��� ����̸�, ������Ի����� null�� ���.
-- �μ��� ���� ������ ��� '�̹�ġ'�� ���
-- ������ ���� ������ ��� '��������' ���� ���
create view e_d_view
as
select  e.emp_id, e.emp_name, nvl(j.job_title,'��������') job_title, e.salary, e.hire_date, m.emp_name ���id, 
        m.hire_date ����Ի���, nvl(d.dept_name,'�̹�ġ') dept_name, nvl(d.loc,'�̹�ġ') loc
from    emp e left join emp m on e.mgr_id = m.emp_id
              left join job j on e.job_id = j.job_id
              left join dept d on e.dept_id = d.dept_id;

select * from e_d_view;

--TODO: ������ �޿��� ��谪�� ��ȸ�ϴ� View ����. ��� �÷� ������, �޿��� �հ�, ���, �ִ�, �ּҰ��� ��ȸ�ϴ� View�� ���� 
create or replace view j_s
as
select j.job_title, sum(salary) �޿��հ�, round(avg(salary)) ��ձ޿�, max(salary) �ִ�޿�, min(salary) �ּұ޿� 
from emp e left join job j on e.job_id = j.job_id
group by j.job_title;

select * from j_s;

--TODO: ������, �μ�����, ������ ������  ��ȸ�ϴ� View�� ����
create view e_d_j
as
select count(distinct e.emp_id) ������, count(distinct d.dept_id) �μ���, count(distinct j.job_id) ������
from emp e, dept d, job j;
--union�̿�
create view ex
as
select '������' label , count(*) cnt from emp
union all
select '�μ���' , count(*) from dept
union all
select '������' , count(*) from job;

select * from e_d_j;
select * from ex;




/* **************************************************************************************************************
������ : SEQUENCE
- �ڵ������ϴ� ���ڸ� �����ϴ� ����Ŭ ��ü
- ���̺� �÷��� �ڵ������ϴ� ������ȣ�� ������ ����Ѵ�.
	- �ϳ��� �������� ���� ���̺��� �����ϸ� �߰��� �� ������ �� �� �ִ�.

���� ����
CREATE SEQUENCE sequence�̸�
	[INCREMENT BY n]	n:����
	[START WITH n]                		  
	[MAXVALUE n | NOMAXVALUE]   
	[MINVALUE n | NOMINVALUE]	
	[CYCLE | NOCYCLE(�⺻)]		
	[CACHE n | NOCACHE]		  

- INCREMENT BY n: ����ġ ����. ������ 1
- START WITH n: ���� �� ����. ������ 0
	- ���۰� ������
	 - ����: MINVALUE ���� ũĿ�� ���� ���̾�� �Ѵ�.
	 - ����: MAXVALUE ���� �۰ų� ���� ���̾�� �Ѵ�.
- MAXVALUE n: �������� ������ �� �ִ� �ִ밪�� ����
- NOMAXVALUE : �������� ������ �� �ִ� �ִ밪�� ���������� ��� 10^27 �� ��. ���������� ��� -1�� �ڵ����� ����. 
- MINVALUE n :�ּ� ������ ���� ����
- NOMINVALUE :�������� �����ϴ� �ּҰ��� ���������� ��� 1, ���������� ��� -(10^26)���� ����
- CYCLE �Ǵ� NOCYCLE : �ִ�/�ּҰ����� ������ ��ȯ�� �� ����. NOCYCLE�� �⺻��(��ȯ�ݺ����� �ʴ´�.)
- CACHE|NOCACHE : ĳ�� ��뿩�� ����.(����Ŭ ������ �������� ������ ���� �̸� ��ȸ�� �޸𸮿� ����) NOCACHE�� �⺻��(CACHE�� ������� �ʴ´�.)


������ �ڵ������� ��ȸ
 - sequence�̸�.nextval  : ���� ����ġ ��ȸ
 - sequence�̸�.currval  : ���� �������� ��ȸ


������ ���� (start with�� ���� �ǹ̰� ����)
ALTER SEQUENCE ������ �������̸�
	[INCREMENT BY n]	               		  
	[MAXVALUE n | NOMAXVALUE]   
	[MINVALUE n | NOMINVALUE]	
	[CYCLE | NOCYCLE(�⺻)]		
	[CACHE n | NOCACHE]	

������ �����Ǵ� ������ ������ �޴´�. (�׷��� start with ���� ��������� �ƴϴ�.)	  


������ ����
DROP SEQUENCE sequence�̸�
	
************************************************************************************************************** */

-- 1���� 1�� �ڵ������ϴ� ������
create sequence ex01_seq;
select * from user_sequences; --���� �������� ���� ���� ��ȸ

select ex01_seq.nextval from dual;

-- 1���� 50���� 10�� �ڵ����� �ϴ� ������
create sequence ex02_seq
    increment by 10
    maxvalue 50;
    
alter sequence ex02_seq
    cycle
    nocache;

select ex02_seq.nextval from dual; --1,11,21,31,41 max�� �ٴٸ��� �����߻�
--cycle������ max�� �ٴٸ��� �ٽ� ó������ ���ư�



-- 100 ���� 150���� 10�� �ڵ������ϴ� ������
create sequence ex03_seq
    increment by 10
    start with 100
    maxvalue 150;

select ex03_seq.nextval from dual; --������
select ex03_seq.currval from dual; --���簪


-- 100 ���� 150���� 2�� �ڵ������ϵ� �ִ밪�� �ٴٸ��� ��ȯ�ϴ� ������
create sequence ex04_seq
    increment by 2
    start with 100
    maxvalue 150
    cycle;  --cycle�� �������� �����ϴ� ������ ������ cache size���� Ŀ���Ѵ�.
    --cycle�� minvalue������ ���ư���.(�� ��� 1)
    
select ex04_seq.nextval from dual;

create sequence ex05_seq
    increment by 10
    start with 100
    maxvalue 150
    minvalue 100
    cycle
    cache 3;
select ex05_seq.nextval from dual;


-- -1���� �ڵ� �����ϴ� ������
create sequence ex06_seq
    increment by -1;
    
select ex06_seq.nextval from dual;
select * from user_sequences;


-- -1���� -50���� -10�� �ڵ� �����ϴ� ������
create sequence ex07_seq
    increment by -10
    minvalue -50;
select ex07_seq.nextval from dual;
select ex07_seq.currval from dual;

-- -10���� -100���� -10�� �����ϴ� ������
create sequence ex08_seq
    increment by -10
    start with -10
    minvalue -100
    cycle --����: ��ȯ�� maxvalue���� ����
    nocache;
alter sequence ex08_seq
    maxvalue -10; --���� ������ ū���̾�� �Ѵ�.
    
select ex08_seq.nextval from dual;

-- 100 ���� -100���� -100�� �ڵ� �����ϴ� ������
-- ����: �������� ����� ���� ���� maxvalue���� Ŭ �� ����.
create sequence ex09_seq
    increment by -100
    start with 100
    minvalue -100; --����

create sequence ex09_seq
    increment by -100
    start with 100
    minvalue -100
    maxvalue 100;
select ex09_seq.nextval from dual;
    


-- 15���� -15���� 1�� �����ϴ� ������ �ۼ�
create sequence ex10_seq
    increment by -1
    start with 15
    minvalue -15
    maxvalue 15;
select ex10_seq.nextval from dual;


-- -10 ���� 1�� �����ϴ� ������ �ۼ�
create sequence ex11_seq
    start with -10
    minvalue -10;   --start with���� ������ ����
select ex11_seq.nextval from dual;

--����
drop sequence ex10_seq;
select * from user_sequences;

-- Sequence�� �̿��� �� insert
create table items(
    no number primary key, --1�� �ڵ� ����
    name varchar2(100) not null
);
drop sequence items_no_seq;
create sequence items_no_seq;
insert into items values(items_no_seq.nextval, 'item�̸�'||ex01_seq.nextval);
select * from items;

rollback; --sequence�� rollback����� �ƴϴ�. rollback�� �ϴ��� �̹� ������ �� ���� �����ȴ�.

drop table dept_copy;
create table dept_copy
as
select * from dept where 1=0;


-- TODO: �μ�ID(dept.dept_id)�� ���� �ڵ����� ��Ű�� sequence�� ����. 10 ���� 10�� �����ϴ� sequence
-- ������ ������ sequence�� ����ؼ�  dept_copy�� 5���� ���� insert.
drop table dept_copy;
create table dept_copy
as
select * from dept where 1=0;

drop sequence dept_id_seq;
create sequence dept_id_seq
    increment by 10
    start with 10;
    
insert into dept_copy values(dept_id_seq.nextval,'�μ��̸�'||dept_id_seq.nextval, '����');

select * from dept_copy;

-- TODO: ����ID(emp.emp_id)�� ���� �ڵ����� ��Ű�� sequence�� ����. 10 ���� 1�� �����ϴ� sequence
-- ������ ������ sequence�� ����� emp_copy�� ���� 5�� insert
drop table emp_copy;
create table emp_copy
as
select * from emp where 1=0;

drop sequence emp_id_seq;
create sequence emp_id_seq
    start with 10;
    
insert into emp_copy values(emp_id_seq.nextval, '�̸�'||emp_id_seq.nextval, emp_id_seq.nextval, emp_id_seq.nextval, sysdate, 10000, null, 100);

select * from emp_copy;