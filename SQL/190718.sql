/* *********************************************************************************************
PL/SQL ����
- PL/SQL �̶�
	- Oracle's Procedual Lanague extension to SQL
	- SQL�� Ȯ���Ͽ� SQL�۾��� ������ ���α׷����� �ۼ��� �� �ִ� ���α׷��� ���.
	- �ټ��� SQL���� �ѹ��� ó���� �� �־� �ϳ��� Ʈ���輱 �۾��� �ϳ��� ������� �ۼ��� ���ִ�.
	- ������ �����ϴ�.
	- ����ó���� �����Ѵ�.

********************************************************************************************* */
--�μ��� ���� �հ踦 �����ϴ� ���̺�
create table emp_sum
as
select dept_id, sum(salary) salary_sum from emp group by dept_id;

select * from emp_sum;

--emp_id�� xxx �� ������ ����
--emp_sum���� �޿� �հ踦 ����.
--emp_sum�� ��ȸ

--salary_sum�� ��ȸ(10 4400)
select * from emp_sum;
select * from emp where emp_id = 200;
--dept_id: 10 , salary: 4400
delete from emp where emp_id = 200;--����
--�հ� ���̺� ����
update  emp_sum
set     salary_sum = salary_sum - 4400
where   dept_id = 10;
rollback;

set serveroutput on; 
--DBMS ��� â�� �ƴ� ���� ���â���� �������� �� �� �ִ�.
declare --���� �ΰ� ����
    emp_rec emp%rowtype;
    sum_rec emp_sum%rowtype;
begin
    --1) 200�� ������ ���� ��ȸ
    select * 
    into emp_rec
    from emp where emp_id = 200;
    --2) 200�� ������ ����
    delete from emp where emp_id = 200;
    --3) �޿��հ� ���̺��� ����(update)
    update  emp_sum
    set     salary_sum = salary_sum - emp_rec.salary
    where   dept_id = emp_rec.dept_id;
    --4) �޿��հ����̺��� ���泻�� ��ȸ�ؼ� ���
    select * 
    into sum_rec
    from emp_sum where dept_id = emp_rec.dept_id;
    --5) ���: �μ�ID: 10, �޿��հ�: 0
    dbms_output.put_line('�μ�ID: '||sum_rec.dept_id);
    dbms_output.put_line('�޿��հ�: '||sum_rec.salary_sum);
    rollback; --commit;
end;
/       --�ٸ� sql�̳� plsql�� �����ϱ� ���� �Ʒ��� �������� ����� �ǹ�

rollback;
select * from emp_sum;

/* ***********************************************************************************************
PL/SQL �⺻ ���
- ����(DECLARE)
    -  ����, Ŀ��, ��������� ���� �� ����
    -  ���û���
- ���౸�����(BEGIN)
    - ȣ��Ǹ� ������ ���� �ۼ�
    - SQL��, PL/SQL ���� ���� ������ �°� ����
    - ���ǹ��̳� �ݺ��� ��밡��
    - �ʼ�
- ����ó��(EXCEPTION)
    - ���๮���� �߻��� ������ ó���ϴ� ���� �ۼ�
    - ���๮�� ���൵�� ������ �߻��ϸ� EXCEPTION ���� �̵�
    - ���û���
- ����(END;)
    -  PL/SQL ������ ���Ḧ ǥ��
    
- PL/SQL ����
    - �͸� ���ν���
		- �̸� ���� �ۼ��ϴ� PL/SQL ���
		- DATABASE�� ����Ǿ� ���� ���� �ʰ� �ʿ��� ������ �ݺ� �ۼ�, �����Ѵ�.
    - ���� ���ν���(Stored Procedure)
		- �̸��� ������ DATABASE�� ����Ǿ� �����ȴ�.
		- �̸����� ȣ���Ͽ� ������ �����ϴ�. 
		- ȣ��� ���� �޾� �� ���� ���ο��� ����� �� �ִ�.
    - �Լ�(Function)
		- ����� ���� �Լ��� ó���� ���� �ݵ�� ��ȯ�ؾ� �Ѵ�.
		- SQL������ ���� ó���ϱ� ���� ȣ���ؼ� ����Ѵ�.
		
*********************************************************************************************** */

 
-- Hellowordl ����ϴ� PL/SQL

begin
    dbms_output.put_line('Helloworld');
end;
/


-- TODO: ������ ����ϴ� ���� �ۼ��Ͻÿ�.
/*
�̸� : ȫ�浿
���� : 20��
�ּ� : ����� ������ ���ﵿ
*/

begin
    dbms_output.put_line('�̸� : �輱��' );
    dbms_output.put_line('���� : 24��');
    dbms_output.put_line('�ּ� : ��⵵ ���ν� ������');
end;
/

--ctrl+space: �����ڵ��ϼ�










