
/* ************************************************************************************************
���ڵ�(Record)
    - ������ ������(���δٸ�) ������ Ÿ��. �ϳ��� ��(Row) ���� ǥ���ϴµ� ���ȴ�.
    - �ʵ�(Field) 
		- ���ڵ带 ���� ��ҷ� ���� value�� ������ �ִ�. 
		- ���ڵ��.�ʵ�� ���� �����Ѵ�.
    - ���� ���̺��� �̿��� ���ڵ�
    - ����� ���� ���ڵ�
************************************************************************************************ */


/* ************************************************************************************************
  - ���� ���̺��� �̿��� ���ڵ�
    -  %ROWTYPE �Ӽ�
    -  ���̺��̸�%ROWTYPE : ���� ���̺��̳� View�� �÷��� �ʵ�� ������ ���ڵ带 ����
        - �ش� ���̺��̳� VIEW�� ��� �÷��� �ʵ�� ������.
	- ����
		��������:  ������  ���̺��%rowtype;
	- ��ȸ�� �������� ���ڵ��� �ʵ���� ���̴�.
		���ڵ��� �ʵ� ��� : ������.�ʵ��
************************************************************************************************ */
declare
    rec_emp emp%rowtype; --���ڵ�Ÿ�� ���� : rec
                        --�ʵ��� ������ ���̺� ���鶧 ������ �÷�����
begin
    select  *
    into    rec_emp
    from    emp
    where   emp_id = 100;
    --���ڵ庯����.�ʵ��
    dbms_output.put_line(rec_emp.emp_id||' - '||rec_emp.emp_name||' - '||rec_emp.salary);
end;
/


-- ROWTYPE�� �̿��� DML
drop table emp_copy;
create table emp_copy as select * from emp where dept_id =100 ;
declare
    rec_emp emp%rowtype;
begin
    select  *
    into    rec_emp
    from    emp
    where   emp_id = 140;
    insert into emp_copy values rec_emp;    --�ʵ��-�÷����� ��ġ�ϴ� �÷��� ���� insert
    --���ڵ� �ʵ��� ���� ����
    rec_emp.salary := 30000;
    rec_emp.comm_pct := 0.3;
    rec_emp.hire_date := '2019-07-22';
    update  emp_copy
    set     row = rec_emp --��ü �÷��� ���� ���ڵ尡 ���� ������ ����.
    where   emp_id = rec_emp.emp_id;
end;
/
select * from emp_copy;


declare
    rec_emp     emp%rowtype;
begin
    select  emp_id, emp_name, salary
    into    rec_emp.emp_id, rec_emp.emp_name, rec_emp.salary
    from    emp
    where   emp_id = 110;
    
    dbms_output.put_line(rec_emp.emp_id||' - '||rec_emp.emp_name||' - '||rec_emp.salary);
end;
/






--�Ʒ� TODO�� ��ȸ ����� ���� ������ %ROWTYPE ���ڵ�� ����.
-- TODO : JOB ���̺��� JOB_ID�� 'AD_PRES' �� ���� ��ȸ�� ���.
declare
    rec_job job%rowtype;
begin
    select *
    into rec_job
    from job
    where job_id = 'AD_PRES';
    dbms_output.put_line(rec_job.job_id||' - '||rec_job.job_title);
end;
/
select * from job;

-- TODO : CUSTOMERS ���̺��� ��_ID(cust_id), �̸�(cust_name), �ּ�(address), 
--�̸����ּ�(cust_email)�� ��ȸ�Ͽ� ����ϴ� �ڵ� �ۼ�.  
declare
    rec_cust customers%rowtype;
begin
    select cust_id, cust_name, address, cust_email
    into rec_cust.cust_id, rec_cust.cust_name, rec_cust.address, rec_cust.cust_email
    from customers
    where cust_id = 100;
    dbms_output.put_line(rec_cust.cust_id||' - '||rec_cust.cust_name||' - '||rec_cust.address||' - '||rec_cust.cust_email);
end;
/
select * from customers;


-- DEPT_COPY ���̺��� ���� (��� ������ ī��)
-- TODO : DEPT_COPY���� DEPT_ID�� 100�� �μ� ������ ����ϴ� �ڵ� �ۼ�.
drop table dept_copy;
create table dept_copy
as select * from dept;
declare
    rec_dept dept%rowtype;
begin
    select *
    into rec_dept
    from dept
    where dept_id = 100;
    dbms_output.put_line(rec_dept.dept_id||'-'||rec_dept.dept_name||'-'||rec_dept.loc);
end;
/
create or replace procedure ex_dept_copy_sp(p_dept_id dept_copy.dept_id%type)
is
    rec_dept_copy dept_copy%rowtype;
begin
    select *
    into rec_dept_copy
    from dept_copy
    where dept_id = p_dept_id;
    dbms_output.put_line(rec_dept_copy.dept_id||'-'||rec_dept_copy.dept_name||'-'||rec_dept_copy.loc);
end;
/
exec ex_dept_copy_sp(&id);
-- TODO : DEPT_COPY �� ROWTYPE ���ڵ� ������ ���� �ϰ� �� ������ �ʵ忡 ������ ���� ������ �� 
--INSERT �ϴ� �ڵ带 �ۼ�.
declare
    rec_dept_copy dept_copy%rowtype;
begin
    rec_dept_copy.dept_id := 4701;
    rec_dept_copy.dept_name := '�μ���';
    rec_dept_copy.loc := '����';
    insert into dept_copy values rec_dept_copy;
    
    ex_dept_copy_sp(rec_dept_copy.dept_id);
    
    rec_dept_copy.loc := '����';
    update  dept_copy
    set     row = rec_dept_copy
    where   dept_id = rec_dept_copy.dept_id;
    
    ex_dept_copy_sp(rec_dept_copy.dept_id); --���� ��� ��ȸ
end;
/
select * from dept_copy;


/* ************************************************************************************************
����� ���� ���ڵ�
 - ���ڵ� Ÿ���� ���� ����
 - ���� ����� ������ Ÿ������ ����Ѵ�.
 - ����

 TYPE ���ڵ��̸� IS RECORD (
    �ʵ��  �ʵ�Ÿ�� [NOT NULL] [ := ����Ʈ��] , 
    ...
 );      
    -�ʵ�Ÿ��(������ Ÿ��)
        -PL/SQL ������Ÿ��
        -%type
        -%rowtype
    -���
     ������ ���ڵ��̸�;

type �̸� is ����
 ************************************************************************************************ */
declare
    --�μ�id�� �μ��̸��� ������ �� �ִ� record
    type dept_type is record(    --���ڵ�Ÿ�� �̸�: �̸�_type
--        id number(4),
--        name varchar2(100)
        id dept.dept_id%type,
        name dept.dept_name%type
    );
    rec_dept dept_type;     --ID/NAME�� �ʵ�� ������ ���ڵ�
begin
    select dept_id, dept_name
    into rec_dept
    from dept
    where dept_id = 10;
    
    dbms_output.put_line(rec_dept.id||' - '||rec_dept.name);
    rec_dept.id := 20;
    rec_dept.name := '������ȹ��';
    update  dept
    set     dept_name = rec_dept.name
    where   dept_id = rec_dept.id;
end;
/
select *from dept;

--TODO: �Ʒ� select �� �������� ������ ����� ���� ���ڵ带 ����� SQL�������� �� Ÿ���� ������ �����ѵ� ����ϴ� ���ν����� �ۼ�.
/*
select e.emp_id, e.emp_name, d.dept_id, d.dept_name, j.job_title
from emp e, dept d, job j
where e.dept_id = d.dept_id(+)
and   e.job_id = j.job_id(+)
and   e.emp_id = 100;
*/
declare
    type todo_type is record(
        emp_id emp.emp_id%type,
        emp_name emp.emp_name%type,
        dept_id  dept.dept_id%type,
        dept_name dept.dept_name%type,
        job_title job.job_title%type
    );
    rec_todo todo_type;
begin
    select e.emp_id, e.emp_name, d.dept_id, d.dept_name, j.job_title
    into rec_todo
    from emp e, dept d, job j
    where e.dept_id = d.dept_id(+)
    and   e.job_id = j.job_id(+)
    and   e.emp_id = 100;
    
    dbms_output.put_line(rec_todo.emp_id||' - '||rec_todo.emp_name||' - '||rec_todo.dept_id
        ||' - '||rec_todo.dept_name||' - '||rec_todo.job_title);
end;
/

declare
    type join_type is record(
        rec_emp emp%rowtype,
        rec_dept dept%rowtype,
        rec_job job%rowtype
    );
    
    rec_join join_type;
begin
    select e.emp_id, e.emp_name, d.dept_id, d.dept_name, j.job_title
    into rec_join.rec_emp.emp_id,
         rec_join.rec_emp.emp_name,
         rec_join.rec_dept.dept_id,
         rec_join.rec_dept.dept_name,
         rec_join.rec_job.job_title
    from emp e, dept d, job j
    where e.dept_id = d.dept_id(+)
    and   e.job_id = j.job_id(+)
    and   e.emp_id = 100;
    dbms_output.put_line(rec_join.rec_emp.emp_id);
end;
/


/* ************************************************************************************************************************************************************************************
�÷���

- ���� Ÿ���� ������ ������ �����ϴ� ����.(��)
    - ���ڵ�� �پ��� Ÿ���� �ʵ带 �������� ���̺� ó�� ���� ROW�� ���� �� ����.
    - �÷����� ���� row�� ������ ����
- ����
  1. �����迭: Ű�� ������ ������ �÷���
  2. VARRAY  : ũ�Ⱑ ������ �ִ� �迭����
  3. ��ø���̺� : ũ�⸦ �����Ӱ� ���� ���ִ� �迭����

************************************************************************************************************************************************************************************ */

/* *********************************************************************************************
- �����迭(Associative Array)
    - Ű-�� ������ ������ �÷���
    - Ű�� INDEX�� �θ��� ������ Index-by ���̺��̶�� �Ѵ�.
	- ������ Ÿ������ ���ȴ�.
- ����
    - Ÿ�� ����
        - TYPE �̸� IS TABLE OF ��Ÿ�� INDEX BY Ű(�ε���)Ÿ��
        - ��Ÿ�� : ��� Ÿ�� ����
        - Ű(�ε���) Ÿ�� : ������(VARCHAR2) �Ǵ� PLS_INTEGER/BINARY_INTEGER Ÿ�Ը� ����.
    - ����ο� �����Ѵ�.
	- Ÿ���� ���� �ѵ� ������ Ÿ������ ����� �� �ִ�.
	- �� ���� : �迭�̸�(INDEX):=��
    - �� ��ȸ : �迭�̸�(INDEX)
********************************************************************************************* */

declare
    -- key(index) Ÿ��: ����
    -- ��(value) Ÿ��: varchar2(100)
    -- �����迭 Ÿ���̸� : �̸�_table_type
    type my_table_type is table of varchar2(100)
        index by binary_integer;
        
    --���� ����
    my_table my_table_type;
begin
    --�����迭�� �� ����
    my_table(10) := 'text1';
    my_table(20) := 'text2';
    dbms_output.put_line(my_table(10));
    dbms_output.put_line(my_table(20));
end;
/

declare
    -- index(key) : dept_id, value: dept_name
    type dept_name_table_type is table of dept.dept_name%type
        index by binary_integer;    --index�� Ÿ�� ����! numberŸ���� �� �� ����.
        
    dept_name_table dept_name_table_type;
begin
    select dept_name
    into dept_name_table(10)    --select����� �����迭�� �߰�
    from dept
    where dept_id = 10;
    
    select dept_name
    into dept_name_table(20)    --select����� �����迭�� �߰�
    from dept
    where dept_id = 20;
    
    dbms_output.put_line(dept_name_table(10));
    dbms_output.put_line(dept_name_table(20));
end;
/

declare
    --index: ����(dept_id), value: �μ����ڵ�(�� ��)
    type dept_table_type is table  of dept%rowtype
        index by binary_integer;    
    dept_table dept_table_type;
begin
    select *
    into dept_table(10)
    from dept
    where dept_id = 10;
    
    select *
    into dept_table(20)
    from dept
    where dept_id = 20;
    
    dbms_output.put_line(dept_table(10).dept_name||'-'||dept_table(10).loc);
    dbms_output.put_line(dept_table(20).dept_name||'-'||dept_table(20).loc);
end;
/



--TODO
-- 1. index�� ũ�� 10�� ���ڿ��� ���� date�� ������ �����迭 ����
-- 2. index�� ����, ���� dept ���̺��� loc�� ���� Ÿ���� �����迭 ����
declare
    --1�� ����
    type var1_table_type is table of date
        index by varchar2(10);
    --2�� ����
    type var2_table_type is table of dept.loc%type
        index by binary_integer;
    
    var1_table var1_table_type;
    var2_table var2_table_type;
begin
    --1�� Ÿ���� ������ �� ���� �� ���
    var1_table('ȫ�浿') := '2010-10-20';
    var1_table('�̼���') := to_date('2000-10','yyyy-mm');
    dbms_output.put_line(var1_table('ȫ�浿'));
    dbms_output.put_line(var1_table('�̼���'));
    --2�� Ÿ���� ������ �� ���� �� ���
    var2_table(10) := '����';
    var2_table(20) := '�λ�';
    dbms_output.put_line(var2_table(10));
    dbms_output.put_line(var2_table(20));
end;
/

--TODO �μ� ID�� Index�� �μ� ���ڵ�(%ROWTYPE)�� Value�� ������ �����迭�� �����ϰ�
-- dept_id�� 10�� �μ��� dept_id�� 20 �� �μ��� ����(dept_id, dept_name, loc)�� ��ȸ�Ͽ� �����迭 ������ �ִ� ���ν����� �ۼ�
declare
    type dept_table_type is table of dept%rowtype
        index by binary_integer;
        
    dept_type dept_table_type; --�μ� �������� ������ �÷���.
begin
    select *
    into dept_type(10)
    from dept
    where dept_id = 10;
    
    select *
    into dept_type(20)
    from dept
    where dept_id = 20;
    
    dbms_output.put_line(dept_type(10).dept_id||'-'||dept_type(10).dept_name||'-'||dept_type(10).loc);
    dbms_output.put_line(dept_type(20).dept_id||'-'||dept_type(20).dept_name||'-'||dept_type(20).loc);
end;
/



-- TODO: emp_id �� 100 ~ 120���� ������ �̸��� ��ȸ�� �����迭(index: emp_id, value: emp_name)�� �����ϴ� �ڵ带 �ۼ�.
declare
    type emp_table_type is table of emp.emp_name%type
        index by binary_integer;
    emp_type emp_table_type;
begin
	--�ݺ����� �̿��� 100 ~ 120 �� ������ �̸��� ��ȸ �� �����迭�� ���尡��
	for idx in 100..120
    loop
        select emp_name
        into emp_type(idx)
        from emp
        where emp_id = idx;
    end loop;
	
	--�����迭���� ��ȸ��� ���
    for idx in 100..120
    loop
        dbms_output.put_line(idx||emp_type(idx));
    end loop;
    
end;
/





/* *********************************************************************************************
- VARRAY(Variable-Size Array)
    - �������� �迭. 
		- ����� �迭�� ũ��(�ִ��Ұ���)�� �����ϸ� �� ũ�� ��ŭ�� ��Ҹ� ���尡��
        - ������ ���� �̻� ���� �� �� ������ ���� �����ϴ� ���� ����.
    - Index�� 1���� 1�� �����ϴ� ������ �ڵ����� �����ȴ�.
    - �����ڸ� ���� �ʱ�ȭ
		- �ݵ�� �����ڸ� �̿��� ������ ������ �ڿ������ �� �ִ�.
    - �Ϲ� ������ �������� ���� �����ؾ� �ϴ� ��� ���� ����(index�� ���� �����̹Ƿ�)
	- C �� Java�� �迭�� ����� �����̴�.
- ����    
    - Ÿ�� ����
        - TYPE �̸� IS VARRAY(�ִ�ũ��) OF ��Ұ�Ÿ��;
    - �ʱ�ȭ 
        - ���� := �̸�(�� [, ...]) 
        - �ʱ�ȭ �� ������ŭ�� ���� ���� 
    - �� ����(����) : �̸�(INDEX):=��
    - �� ��ȸ : �̸�(INDEX)
********************************************************************************************* */
declare
    type va_type is varray(5) of varchar2(100);
    va_arr va_type;
begin
    --�ʱ�ȭ
    va_arr := va_type('��', '��', '��', '��'); --������ �ִ�ũ�⸦ 5���� �����Ͽ�� ����ȭ�� 4���� �ϸ� ũ��� 4�� �����ȴ�.
    va_arr(1) := 'a';
    dbms_output.put_line(va_arr(1)||va_arr(2)||va_arr(3)||va_arr(4));
end;
/

--dept_id = 10, 50, 70�� �μ��� ������ ��ȸ =>�����迭�� 
declare
    --����� ���� �����迭Ÿ��
    type dept_table_type is table of dept%rowtype
        index by binary_integer;
    --��ȸ�� �μ� id���� ���� varray
    type dept_id_list is varray(3) of dept.dept_id%type;
    dept_table dept_table_type;
    dept_ids dept_id_list;
begin
    dept_ids := dept_id_list(10,50,70); --��ȸ�� �μ�id�� varray �ʱ�ȭ
    for idx in 1..3
    loop
        select *
        into dept_table(dept_ids(idx))
        from dept
        where dept_id = dept_ids(idx);
    end loop;
    for idx in 1..3
    loop
        dbms_output.put_line(dept_table(dept_ids(idx)).dept_name);
    end loop;
end;
/





/* *********************************************************************************************
- ��ø���̺�(Nested Table)
    - ����� ũ�⸦ �������� �ʰ� �����ڸ� �̿��� �ʱ�ȭ �Ҷ� ���Ե� ���� ���� ���� ũ�Ⱑ ��������.
    - �����ڸ� ����� �ʱ�ȭ �� ���
    - index �� 1���� 1�� �ڵ������ϴ� ������ ����.    
    - �Ϲ� ���̺��� �÷� Ÿ������ ���� �� �ִ�.
- ����
    - Ÿ�� ����
        - TYPE �̸� IS TABLE OF ��Ÿ��;
********************************************************************************************* */
declare
    type nt_table_type is table of number;
    nt_table nt_table_type;
    nt_table2 nt_table_type;
begin
    --�����ڸ� �̿��� �ʱ�ȭ
    nt_table := nt_table_type(10,20,30,40,50);
    nt_table2 := nt_table_type(1,2,3,4,5,6,7,8,9,10);
    nt_table(2):=2000; --����(����)   
    
--    for idx in 1..5
    for idx in 1..nt_table.count    
    loop
        dbms_output.put_line(nt_table(idx));
    end loop;
end;
/





/* *****************************************************************************************************************************
- �÷��� �޼ҵ�
 # DELETE : ��� ��� ����
 # DELETE(n) : index�� n�� ��� ���� (varray�� ��������)
 # DELETE(n, m) : index�� n ~ m �� ��� ���� (varray�� ��������)
 
 # EXISTS(index) : index�� �ִ� �� ���� boolean������ ��ȯ
 # FIRST : ù��° IDNEX ��ȯ
 # LAST : ������ INDEX ��ȯ
    - FOR idx IN �÷���.FIRST..�÷���.LAST  
 # PRIOR(index) : index ���� INDEX ��ȯ
 # NEXT(index) : index ���� INDEX ��ȯ

# COUNT: �÷��ǳ��� ��� ���� ��ȯ 

***************************************************************************************************************************** */

declare
    type varr_type is varray(5) of varchar2(10);
    
    varr varr_type;
begin
    varr := varr_type('a','b','c','d');
    
    dbms_output.put_line(varr.first);
    dbms_output.put_line(varr.last);
    dbms_output.put_line(varr.next(3));
    dbms_output.put_line(varr.prior(3));
    if varr.exists(3) then
        dbms_output.put_line('index ����');
    end if;
end;
/





-- TODO: emp���� emp_id�� 100 ~ 120�� �������� ������ ��ȸ�� �� �� ������ emp_copy�� �߰��ϴ� �ڵ带 �ۼ�.
DECLARE
    -- �����迭 Ÿ�� ����(��ȸ�� ���������� ����): key - emp_idŸ��, value:emp row
    type emp_table_type is table of emp%rowtype
        index by binary_integer;
    -- �����迭 Ÿ�� ���� ����
    emp_table emp_table_type;    
BEGIN
    -- �ݺ����� �̿��� emp_id�� 100 ~ 120 �� ���� ��ȸ�ؼ� �����迭�� ���� 
    for idx in 100..120
    loop
        select *
        into emp_table(idx)
        from emp
        where emp_id = idx;
    end loop;
	
	-- �ݺ����� �̿��� �����迭�� ����� ��ȸ������� emp_copy ���̺� insert (FIRST, LAST �޼ҵ� �̿�)
	for idx in emp_table.first..emp_table.last
    loop
        insert into emp_copy values emp_table(idx);
    end loop;
    commit;
END;
/
drop table emp_copy;
create table emp_copy as select * from emp where 1=0;

select * from emp_copy;

