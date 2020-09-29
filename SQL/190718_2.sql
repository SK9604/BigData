
/* ***********************************************************************************************
���� ���
- ���� ����
  - DECLARE ������ �Ѵ�.
  - ����: ������ [CONSTANT] ������Ÿ�� [NOT NULL] [ := �⺻��] 
     - CONSTANT : ���� ������ �� ���� ����. ����� �ݵ�� �ʱ�ȭ �ؾ� �Ѵ�.
	 - ������Ÿ��: ����Ŭ ������Ÿ��+PL/SQL ������Ÿ�� �����Ѵ�.
	 - NOT NULL: ������ NULL�� ������ �ȵ��� ������������ ����. ����� �ݵ�� �ʱ�ȭ �Ǿ���.
	 - ����� [DEFAULT ��] ���� �ʱⰪ ���� ����
  - ���Կ�����
     -  ���� := ��
*********************************************************************************************** */

declare
--������(identifier) datatype
    v_message1  varchar2(100); --null�� �ʱ�ȭ
    v_message2  varchar2(100) not null := '�⺻�޽���'; --not null�� �ݵ�� �ʱ�ȭ�� ���־���Ѵ�.
    c_num       constant pls_integer := 20; --������ ���
    --c_num       constant pls_integer default 20;
    --not null������ constant(���)�� ����� �ʱ�ȭ �ؾ� �Ѵ�.
begin
    v_message1 := 'hello world';
    v_message2 := '&msg'; --ġȯ������
    --c_num := 5000;  --������� ���� ���Ҵ� �� �� ����.
    dbms_output.put_line(v_message1);
    dbms_output.put_line(v_message2);
    dbms_output.put_line(c_num);
end;
/

-- TODO: DECLARE ���� ���� ������ ������ ������(�̸�, ����, �ּ� ���)�� �����ϰ� ���� ���(BEGIN)���� ���� ������ �� ����ϴ� �ڵ� �ۼ�.
declare
    v_name  nvarchar2(50);
    v_age   pls_integer;        --number
    v_address nvarchar2(100);
begin
    v_name := '�輱��';
    v_age := 24;
    v_address := '��⵵ ���ν� ������';
    dbms_output.put_line('�̸�: '||v_name);
    dbms_output.put_line('����: '||v_age);
    dbms_output.put_line('�ּ�: '||v_address);
end;
/


-- TODO: emp ���̺��� �̸�(emp_name), �޿�(salary), Ŀ�̼Ǻ���(comm_pct), �Ի���(hire_date) �� ���� ������ �� �ִ� ������ �����ϰ�
-- &������ �̿��� ���� �Է� �޾� ����ϴ� �ڵ带 �ۼ�.
declare
    v_emp_name  varchar2(50);
    v_salary    number(7,2);
    v_comm_pct  number(2,2);
    v_hire_date date;
begin
    v_emp_name := '&name';
    v_salary := &salary;
    v_comm_pct := &comm_pct;
    v_hire_date := '&hire_date';
    dbms_output.put_line('�̸�: '||v_emp_name);
    dbms_output.put_line('�޿�: '||v_salary);
    dbms_output.put_line('comm_pct: '||v_comm_pct);
    dbms_output.put_line('�Ի���: '||v_hire_date);
end;
/


/* **********************************************************
- %TYPE �Ӽ�
  - �÷��� ������Ÿ���� �̿��� ������ Ÿ�� �����
  - ����:   ���̺��.�÷�%TYPE
    ex) v_emp_id emp.emp_id%TYPE
*********************************************************** */
-- dept ���̺��� �÷����� ������ Ÿ���� �̿��� ���� ����

declare
    v_dept_id dept.dept_id%type; 
    v_dept_name dept.dept_name%type :='����';
    v_loc dept.loc%type;
begin
    v_dept_id := 2000;
    v_loc := '����';
    dbms_output.put_line(v_dept_id||','||v_dept_name||','||v_loc);
end;
/

-- TODO: job ���̺��� �÷����� Ÿ���� �̿��� v_job_id, v_job_title, v_max_salary, v_min_salary �� �����ϰ� & ������ �̿��� ���� �Է� �޾� ����ϴ� �ڵ� �ۼ�
desc job;
declare
    v_job_id job.job_id%type;
    v_job_title job.job_title%type;
    v_max_salary job.max_salary%type;
    v_min_salary job.min_salary%type;
begin
    v_job_id := '&job_id';
    v_job_title := '&job_title';
    v_max_salary := &max_salary;
    v_min_salary := &min_salary;
    dbms_output.put_line(v_job_id||','||v_job_title||','||v_max_salary||','||v_min_salary);
end;
/
/* ******************************************************************
���ε� ����, ȣ��Ʈ ����
�� ġȯ���� &�����ڿ� �ٸ� ���� db�� ���忡�� &name�� �Է��� ���� ��ü�Ͽ� ������
    ���ε� ������ :name �״�� ������. ������ �ʱ�ȭ�ϴ� ������ ���� ���ش�.
���� ���������� ���
-����
    variable ������ Ÿ��;
    var ������ Ÿ��;
    var name varchar2(100);
-���
    :������
    :name

****************************************************************** */
var e_id number;
exec :e_id :=200;

select * from emp 
where emp_id = :e_id
and     emp_name = :e_name;

/* ******************************************************************
 PL/SQL���� ������(Sequence) ���
 - select �������� sequence�̸�.nextval �� �ٷ�ȣ�� ����.
********************************************************************* */
create sequence t_seq;
declare
    v_num number;
begin
    v_num := t_seq.nextval;   
    dbms_output.put_line(v_num);
    dbms_output.put_line(t_seq.currval);
end;
/




/* ****************************************************************
���ν������� �Լ� ���
 - ����/����/��¥/��ȯ �Լ��� ó������� 1���� �� ���� �������� �ܵ����� ����� �� �ִ�.
 - �����Լ�(max, min��)�� DECODE() �Լ��� SQL�������� ����� �� �ִ�. 
******************************************************************* */
begin
    dbms_output.put_line(length('aaaaa')); --������ select�� ���� �ٷ� �Լ��� ��� �� �� �ִ�.
    dbms_output.put_line(round(4.232323,2));
end;
/



-- TODO: ������ ������� ����ϴ� �ڵ带 �ۼ�
/*
"����� ������ ���ﵿ" ���ڿ��� ���̸� ���
"Hello World" �� �빮�ڷ� ���
100.23456 �� �Ҽ��� ù��° ���Ͽ��� �ݿø� �ؼ� ���
SYSDATE���� ��:��:�� �� ���*/
begin
    dbms_output.put_line(length('����� ������ ���ﵿ'));
    dbms_output.put_line(upper('Hello World'));
    dbms_output.put_line(round(100.23456,1));
    dbms_output.put_line(to_char(sysdate,'hh24:mi:ss'));
end;
/
/* *************************************************************
��ø ����
- PL/SQL �����ϳ��� PL/SQL ������ ��ø�ؼ� �ۼ��� �� �ִ�.
- ���� �����Ͽ����� �ٱ��� ���౸������ ������ ������ ����� �� ������ �ݴ�� �ȵȴ�.
- ��
declare
begin
    declare
    begin
    end
end
*************************************************************** */
declare
    v_outer varchar2(100) := 'v_outer';
begin
    declare
        v_inner varchar2(100) := 'v_inner';
    begin
        dbms_output.put_line('INNER: '||v_outer);   --outer�� ������ inner���� ��밡��.
        dbms_output.put_line('INNER: '||v_inner);
    end;
    dbms_output.put_line('OUTER: '||v_outer);
    --dbms_output.put_line('OUTER: '||v_inner); --error: inner���� ����� ������ outer���� ������.
end;
/

begin <<outer_p>>
    declare
        v_outer varchar2(100) := 'v_outer';
    begin
        declare
            v_inner varchar2(100) := 'v_inner';
            v_outer number := 30;
        begin
            dbms_output.put_line('INNER: '||v_outer);  --inner�� v_outer�� ȣ���
            dbms_output.put_line('INNER: '||outer_p.v_outer); --outer�� v_outer�� ȣ���
            dbms_output.put_line('INNER: '||v_inner);
        end;
        dbms_output.put_line('OUTER: '||v_outer);
    end;
end;
/


/* *************************************************************************************	

DML ����
- insert/delete/update
- SQL�� ����
- ó���� commit

************************************************************************************* */
drop table dept_copy;
create table dept_copy
as
select * from dept;
select * from dept_copy order by dept_id desc;

--insert
declare
    v_dept_id dept.dept_id%type;
    v_dept_name dept.dept_name%type;
    v_loc dept.loc%type;
begin
    v_dept_id := :id;
    v_dept_name := :name;
    v_loc := :loc;
    
    --insert into dept_copy values(2000, '��ȹ��', '��õ');
    insert into dept_copy values(v_dept_id, v_dept_name, v_loc);
    v_dept_name := '������';   --���� �ٲ�
    v_loc := '�λ�';           --���� �ٲ�
    insert into dept_copy values(v_dept_id+1, v_dept_name, v_loc);
    insert into dept_copy values(v_dept_id+2, v_dept_name, v_loc);
    commit;
end;
/
rollback;

--delete
begin
    delete from dept_copy
    where loc = '����';
    commit;
end;
/
select * from dept_copy order by dept_id desc;

--update
declare
    v_dept_id dept.dept_id%type := :dept_id;
    v_loc dept.loc%type := :loc;    
begin
    update dept_copy
    set loc = v_loc
    where dept_id = v_dept_id;
    commit;
end;
/

select * from emp_copy;
drop table emp_copy;
create table emp_copy
as
select emp_id, emp_name, salary, comm_pct from emp;
desc emp_copy;
-- TODO : emp ���̺� ���ο� �������� �߰��ϴ� ������ �ۼ�.
declare
    v_emp_id emp.emp_id%type;
    v_emp_name emp.emp_name%type;
    v_emp_salary emp.salary%type;
    v_comm_pct emp.comm_pct%type;
begin
    v_emp_id := :id;
    v_emp_name := :name;
    v_emp_salary := :salary;
    v_comm_pct := :commpct;
    
    insert into emp_copy values(v_emp_id, v_emp_name, v_emp_salary, v_comm_pct);
    insert into emp_copy values(v_emp_id+1, v_emp_name, v_emp_salary, v_comm_pct);
    insert into emp_copy values(v_emp_id+2, v_emp_name, v_emp_salary, v_comm_pct);
    commit;
end;
/

-- TODO : ������ �߰��� ���� ���� salary�� comm_pct �� ���� ���� �ø��� ������ �ۼ�
select * from emp_copy;

begin    
    update emp_copy
    set salary = salary *3, comm_pct = comm_pct*3
    where emp_id in (2000,2001,2002);
end;
/
rollback;
-- TODO : ������ �߰��� ���� ���� �����ϴ� ������ �ۼ�
begin    
   delete from emp_copy where emp_id in (2000,2001,2002);
   commit;
end;
/

/* *************************************************************************************
��ȸ����
select into �� 

select ��ȸ�÷�
INTO   ��ȸ���� ������ ����
from ���̺�
where ��������
group by 
having
order by

************************************************************************************* */

-- �μ� ID(dept_id)�� 10�� �μ��� �̸�(dept_name), ��ġ(loc) �� ��ȸ�ϴ� ����



--���� id(emp.emp_id) �� 110 �� ������ �̸�(emp.emp_name), �޿�(emp.salary), �μ� ID(dept.dept_id) �μ��̸�(dept.dept_name) ����ϴ� �����ۼ�



-- TODO ������ ID�� 120�� ������ �̸�(emp.emp_name), �޿�(emp.salary), ����_ID (emp.job_id), �Ի���(emp.hire_date)�� ����ϴ� ���� �ۼ�



-- TODO �μ����̺� dept_id=9900, dept_name='�濵��ȹ', loc='����' �� insert �ϰ� dept_id�� ��ȸ�Ͽ� �Է°���� ����ϴ� ������ �ۼ�.



-- TODO ����_ID�� 110�� ������ �̸�(emp.emp_name), ���� ID(emp.job_id), ������(job.job_title) ����ϴ� ���� �ۼ�













