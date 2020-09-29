/* ***************************************************************************************
�Լ� (FUNCTION)
- �̸� �����ϵǾ� ���� ������ ��ü�� SQL�� �Ǵ� PL/SQL�� ������ ȣ��Ǿ� ���Ǵ� �������α׷�.
- ȣ���ڷ� ���� �Ķ���� ���� �Է� �޾� ó���ѵ� �� ����� ȣ���ڿ��� ��ȯ�Ѵ�. 
	- �Ķ���ʹ� �� ���� �� �� �ִ�.
- ��Ʈ�� �Լ�
	- ����Ŭ���� �����ϴ� �����Լ�
- ����� ���� �Լ��̸�	
	- ����� �����Լ�
	
- ����� ���� �Լ� ����
	CREATE [OR REPLACE] FUNCTION �Լ��̸� [(�Ķ����1, �Ķ����2, ..)]
		RETURN datatype --�ϳ��� ���� ��ȯ�Ѵ�.
	IS
		-- �����: ����, ����� ����
	BEGIN
		-- ���� �� : ó������
		RETURN value;
	[EXCETPION]
		-- ����ó�� ��
	END;
	
	
	- RETURN ��ȯ������Ÿ��
		- ȣ���ڿ��� ������ ��ȯ���� Ÿ�� ����
		- char/varchar2 �� number�� ��� size�� �������� �ʴ´�.
		- ���� �ο��� `return ��` ������ �̿��� ó������� ��ȯ�Ѵ�.
	- �Ķ���� 
		- ���� : 0 ~ N��
		- IN ��常 ����. 
		- ����
			������ ������Ÿ�� [:=�⺻��]
		- �⺻���� ���� �Ű��������� ȣ���ڿ��� �ݵ�� ���� �����ؾ� �Ѵ�.
		
	
�Լ� ����
DROP FUNCTION �Լ���;
-����(ALTER�� ���� replace�� ���� ����)
*************************************************************************************** */
-- �Ű����� ���� �Լ� ���� �� ȣ��
create or replace function ex_08_01_fn
    return varchar2
is
begin
    return '�ȳ��ϼ���!';
end;
/
select ex_08_01_fn() from dual; --�Ű������� ���� �� ��ȣ( ) ���� ����
select ex_08_01_fn from dual;
select emp_name , ex_08_01_fn �޽���
from emp;

--�Ű������� 1�� �ִ� �Լ�
create or replace function ex_08_02_fn(p_num binary_integer)
    return varchar2
is
begin
    return p_num||'��';
end;
/

select ex_08_02_fn(10000) from dual;
select ex_08_02_fn from dual; --����
select ex_08_02_fn(salary) from emp;

--�⺻���� �ִ� �Ű������� ���� �Լ�
create or replace function ex_08_02_fn(p_num binary_integer :=0)
 --���� �Ű������� ���� ���� ���� �� 0�� default��
    return varchar2
is
begin
    return p_num||'��';
end;
/

select ex_08_02_fn(10000) from dual;
select ex_08_02_fn from dual; --default���

--�Ű������� �������� �Լ�
create or replace function ex_8_3_fn(p_num1 binary_double:=0, 
                                     p_num2 binary_double:=0, 
                                     p_num3 binary_double:=0,
                                     p_cur varchar2:='��')
    return varchar2
is
    v_result varchar2(100);
begin
    v_result := (p_num1 + p_num2 + p_num3)||p_cur;
    return v_result;
end;
/

select ex_8_3_fn from dual;
select ex_8_3_fn(10,20,30) from dual;
select ex_8_3_fn(10.5,20.5,30.5,'�޷�') from dual;
select ex_8_3_fn(10.5,20.5,'�޷�') from dual;--����: �Ű������� �ݵ�� ������� ��
  

--  emp_id�� �޾Ƽ� �� ������ Ŀ�̼�(salary * comm_pct)�� ���� ��ȯ�ϴ� �Լ� 
select salary*comm_pct from emp;
create or replace function ex_8_5(p_emp_id emp.emp_id%type)
    return binary_double
is
    v_result    binary_double;
begin
    select  salary * comm_pct
    into    v_result
    from    emp
    where   emp_id = p_emp_id;
    return v_result;
end;
/
select ex_8_5(145) from dual;
select emp_id, ex_8_5(emp_id) ��갪, comm_pct, salary from emp;
select * from emp;

-- TODO: �Ű������� ���� �ΰ��� �޾� ���� ����� �Ҽ��� ���� �κи� ��ȯ�ϴ� �Լ� ���� (ex: 10/4 -> 0.5 ��ȯ)
create or replace function int_divide(p_num1 binary_integer, p_num2 binary_integer)
    return binary_double
is
    v_result binary_double;
begin
    v_result := p_num1/p_num2 - trunc(p_num1/p_num2);
    return v_result;
end;
/
select int_divide(12,5) from dual;





-- TODO: �Ű������� ���� �ΰ��� �޾Ƽ� ������ ������ ó���ϴ� �Լ� ����.  (10/4 -> 2�� ��ȯ)
-- ���������: --������ - (��� ������ * ����)
-- ex) 10/4�� ������ : 10 - (10/4������� * 4)
create or replace function mod_prac(p_num1 binary_integer, p_num2 binary_integer)
    return binary_integer
is
    v_result binary_integer;
begin
    v_result := p_num1 - (trunc(p_num1/p_num2) * p_num2);
    return v_result;
end;
/

select mod_prac(10,4) from dual;
select mod(10,4) from dual;



-- TODO: 1. �Ű������� ��� ID�� �޾Ƽ� �ڽ��� �޿��� �ڽ��� ���� �μ��� ��ձ޿� �̻��̸� TRUE�� �̸��̸� FALSE�� ��ȯ�ϴ� �Լ� �ۼ�. ��ȸ�� ����� ���� ��� NULL�� ��ȯ
--       2. ���� �Լ��� ȣ���ϴ� �͸� ���ν������� �ۼ�.
--			�Լ��� ȣ���Ͽ� ��ȯ�Ǵ� boolean ����
--				TRUE�̸� '������ �޿��� �μ���� �̻�' �� FALSE�̸� '������ �޿��� �μ���� �̸�' �� NULL�̸� '���� ����' �� ����Ѵ�.


CREATE OR REPLACE FUNCTION todo_03_fn(p_emp_id emp.emp_id%TYPE)
    RETURN boolean
IS
    v_cnt binary_integer;
    v_salary emp.salary%type;   --���� �޿�
    v_dept_id dept.dept_id%type;--��ȸ�� �μ� id
	v_sal_avg binary_double;    --�μ� �޿� ���
    ex_found_null exception;    --����ó��(null �϶�)
BEGIN
    -- ��ȸ ������ ������ null�� ��ȯ
    select count(*) into v_cnt from emp where emp_id = p_emp_id;
    if v_cnt = 0 then
        return null;
    end if;
	-- salary �� �μ� id�� ��ȸ
	select salary, dept_id into v_salary, v_dept_id from emp where emp_id = p_emp_id;
	-- �μ��� ��� �޿��� ��ȸ
	select avg(salary) into v_sal_avg from emp 
    where dept_id = v_dept_id;
	-- ������ salary�� �μ� ��ձ޿��� ���ؼ� boolean ���� ��ȯ
    /*
    if v_salary >= v_sal_avg then
        return TRUE;
    else
        return FALSE;
    end if;	
    */
    RETURN v_salary >= v_sal_avg;
END;
/
SELECT todo_03_fn(emp_id) FROM emp; --SQL������ booleanŸ���� �������� �ʱ� ������ ��� �Ұ�
-- 170(�̻�) 180(����) 
-- ------���� �Լ� ����ϴ� ���ν���. ---------
-- TRUE�̸� '������ �޿��� �μ���� �̻�' �� FALSE�̸� '������ �޿��� �μ���� �̸�' �� NULL�̸� '���� ����' �� ����Ѵ�.
DECLARE
    v_result boolean;
BEGIN
    for idx in 170..180
    loop
        v_result := todo_03_fn(idx);
        if v_result is null then    --�� �� null�� false�� ����ϱ� ������ ���ǹ����� ���� ���� ����.
            dbms_output.put_line(idx||'���� ����');
        elsif v_result then --v_result ��ü�� true�̱� ������ v_result = true��� ���� �ʿ� ����.
            dbms_output.put_line(idx||'������ �޿��� �μ���� �̻�');
        else
            dbms_output.put_line(idx||'������ �޿��� �μ���� �̸�');            
        end if;
    end loop;   
END;
/
--Ȯ�� sql��
select emp_id,salary, dept_id from emp where emp_id = 175;
select avg(salary) from emp where dept_id = (select dept_id from emp where emp_id = 175);






--TODO �Ű������� 5���� 'y' �Ǵ� 'n'�� �޾Ƽ� ���° �Ű������� y������ �ϳ��� ���ڿ��� ��� ��ȯ�ϴ� �Լ� ����.
-- select todo_03_fn('y','n', 'n', 'y', 'y') from dual;  => 1, 4, 5

create or replace function todo_04_fn ( p_yn1 varchar2,
                                        p_yn2 varchar2,
                                        p_yn3 varchar2,
                                        p_yn4 varchar2,
                                        p_yn5 varchar2) 
    return varchar2
is  
    v_return varchar2(100); -- ������� ���ڿ��� ������ ����.

begin  
    --p_yn1 ó��: y �̸� v_return ���ڿ��� ����.
    if(p_yn1 = 'y') then
        if nvl(length(v_return),0) = 0 then
            v_return := '1';
        else
            v_return := v_return||', 1';
        end if;
        
    end if;
    
    --p_yn2 ó��
    if(p_yn2 = 'y') then
        if nvl(length(v_return),0) = 0 then
            v_return := '2';
        else
            v_return := v_return||', 2';
        end if;
    end if;
    
     --p_yn3 ó��
    if(p_yn3 = 'y') then
        if nvl(length(v_return),0) = 0 then
            v_return := '3';
        else
            v_return := v_return||', 3';
        end if;
    end if;
	
     --p_yn4 ó��
	 if(p_yn4 = 'y') then
        if nvl(length(v_return),0) = 0 then
            v_return := '4';
        else
            v_return := v_return||', 4';
        end if;
    end if;	 
	 
     --p_yn5 ó��
	 if(p_yn5 = 'y') then
        if nvl(length(v_return),0) = 0 then
            v_return := '5';
        else
            v_return := v_return||', 5';
        end if;
    end if;	 
    
    -- ����� ��ȯ
    return v_return;
end;
/
select todo_04_fn('y','y', 'n', 'y', 'n') from dual;
select todo_04_fn('n','n', 'n', 'y', 'y') from dual;

create table choice_tb(
    ch1 char check(ch1 in ('y', 'n')),
    ch2 char check(ch2 in ('y', 'n')),
    ch3 char check(ch3 in ('y', 'n')),
    ch4 char check(ch4 in ('y', 'n')),
    ch5 char check(ch5 in ('y', 'n'))
);

insert into choice_tb values ('n' ,'y', 'n', 'y', 'y');
insert into choice_tb values ('y' ,'y', 'y', 'y', 'y');
insert into choice_tb values ('y' ,'y', 'n', 'n', 'y');
insert into choice_tb values ('y' ,'y', 'n', 'n', 'n');
insert into choice_tb values ('n' ,'y', 'n', 'y', 'n');
commit;

select todo_04_fn(ch1, ch2, ch3,ch4,ch5) ���û��� from choice_tb;
