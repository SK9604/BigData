

/* ***************************************************************************************************************
����ó��
 - ���๮���� �߻��� ����(����)�� ó���Ͽ� ���ν����� ���������� �����ϵ��� �ϴ� ����.
 - ���� ����
	- ����Ŭ ����
		- �ڵ尡 Ʋ���� �߻��ϴ� ����
	- ����� ���� 
		- ����� �ڵ忡�� �߻���Ų ����.
		- ���� ��Ģ�� ��� ��� �߻���Ų��.
-System ���� = application ����
- EXCEPTION ���� ó�� ������ �ۼ�
	- ���� �� ������ �ۼ��Ѵ�.
 - ����
  EXCEPTION
    WHEN �����̸�1 THEN
        ó������
    WHEN �����̸�2 THEN
        ó������
	[WHEN OTHERS THEN
		ó������ ]
 -����: �����ڵ带 ������ �� ���� ����
*************************************************************************************************************** */

--����Ŭ �����ڵ� ��ȸ: https://docs.oracle.com/pls/db92/db92.error_search?remark=homepage&prefill=ORA

declare
    v_emp_name  emp.emp_name%type;
    v_cnt       binary_integer;
begin
    v_cnt := 10/0;  --����(����) �߻�! �ٷ� exception�������� �Ѿ
    select  emp_name        
    into    v_emp_name
    from    emp;
    dbms_output.put_line(v_emp_name);
exception          --����ó��
--    when    too_many_rows then
--            dbms_output.put_line('�ʹ� ���� ���� ��ȸ�Ǿ���');
--    when    zero_divide then
--            dbms_output.put_line('0���� ������');
    when    others then
            dbms_output.put_line('������ ���� ���� ó��');
end;
/


/* ***************************************************************************************************************
- ����Ŭ ������ ���ܸ� ����

- ���ܸ��� ���ǵ��� ���� ����Ŭ ����
    - �����ڵ�� ������ �����̸��� ���� ����Ŭ ���� ����

 - ����
 1. �����̸� ����
    �����̸� EXCEPTION;
 2. �����̸��� ����Ŭ�����ڵ� ����
    PRAGMA EXCEPTION_INIT (�����̸�, �����ڵ�)
    - �����ڵ�� ������ ���δ�. (-01400)
*************************************************************************************************************** */
-- �̸� ���ǵ��� ���� ���� �̸� ���̱� (null �� INSERT �߻� ������ �̸� ���̱�)
insert into dept values(850, null, null);
--ORA-01400: cannot insert NULL into ("SCOTT_JOIN"."DEPT"."DEPT_NAME")
declare
    --1. ����(exception)�̸� ����
    ex_null exception;
    --2. 1���� ������ �����̸��� ����Ŭ �����ڵ带 ����
    pragma exception_init(ex_null, -01400);
    --ORA-01400 ������ �߻��ϸ� ex_null�̶� �̸����� ���� ó���Ѵ�.
begin
    insert into dept values(850, null, null);
exception
    when ex_null then
        dbms_output.put_line('NULL�� ���� �� �����ϴ�.');        
end;
/


--TODO: �μ����̺���(DEPT) �μ�_ID�� 100�� �μ��� �����ϴ� �ڵ� �ۼ�.
--      100�� �μ��� EMP���� �����ϹǷ� 'ORA-02292: integrity constraint (SCOTT.FK_EMP_DEPT) violated - child record found' ����Ŭ ���� �߻��Ѵ�.
--      �߻��ϴ� ������ �����̸��� ����� EXCEPTION ��Ͽ��� ó���ϴ� �ڵ带 �ۼ��Ͻÿ�.
--declare
create or replace procedure del_dept_sp(p_dept_id dept.dept_id%type)
is
    ex_integrity exception;
    pragma exception_init(ex_integrity, -02292);
begin
    delete from dept where dept_id  = p_dept_id;
    dbms_output.put_line('�����Ǿ����ϴ�. �����۾� ����');
    commit;    
exception
    when ex_integrity then
        dbms_output.put_line('������ �� ���� �Ұ�');
end;
/

exec del_dept_sp(100);


/* ***************************************************************************************************************
���� �߻���Ű��(application exception)
 - ���� �̸� ����
 - RAISE �����̸�
*************************************************************************************************************** */
--������ �μ� ID�� ������ ���� �߻���Ű��
declare
    v_id binary_integer := 843;
    v_cnt binary_integer;
    ex_not_found exception;
begin
    select count(*) into v_cnt from dept where dept_id = v_id;
    if v_cnt = 0 then --������ �μ��� ����. >>���ܹ߻�
        raise ex_not_found;
        --dbms_output.put_line('������ �μ��� �����ϴ�. �α� ���̺� insert');
        --�ּ��� ��� �Ʒ��κб��� �� �����Ѵ�. ���ܹ߻��� �Ʒ��κ� �������� �ʰ� exception���� �Ѿ
    end if;
    delete from dept where dept_id = v_id;
    dbms_output.put_line('���� �Ϸ�');
exception
    when ex_not_found then
        dbms_output.put_line('������ �μ��� �����ϴ�. �α� ���̺� insert');
end;
/
select * from dept order by 1 desc;


--TODO: EMP_ID�� 832���� ������ �̸��� UPDATE�ϴµ� 832���� ������ ���� ��� ����� ���� ���ܸ� ����� �߻� ��Ű�ÿ�.
declare
    v_emp_id emp.emp_id%type := 832;
    v_cnt binary_integer;
    ex_not_found exception;
begin
    select count(*) into v_cnt from emp where emp_id = v_emp_id;
    if v_cnt = 0 then 
        raise ex_not_found;
    end if;
    update emp set emp_name = emp_name where emp_id = v_emp_id;
    dbms_output.put_line('������Ʈ �Ϸ�');
exception
    when ex_not_found then
        dbms_output.put_line('������Ʈ�� ������ �����ϴ�. �α� ���̺� insert');
end;
/
declare
    v_emp_id emp.emp_id%type := 832;
    ex_not_found exception;
begin
   --insert/delete/update ������ ���� ����� ���
    update emp set emp_name = emp_name where emp_id = v_emp_id;
     if sql%notfound then
        raise ex_not_found;
     end if;
     dbms_output.put_line('������Ʈ �Ϸ�');
exception
    when ex_not_found then
        dbms_output.put_line('������Ʈ�� ������ �����ϴ�. �α� ���̺� insert');
        rollback; --����ο��� ���� �߻������� ó���� ������ ������Ŵ
end;
/

--TODO: �μ� ID�� �޾� �μ��� �����ϴ� ���ν��� �ۼ�
--      EMP ���̺��� �����Ϸ��� �μ��� �����ϴ� ���� �ִ��� Ȯ�� �ѵ� ������ �����ϰ� ������ ��������� ���ܸ� �߻���Ų �� EXCEPTION ��Ͽ��� ó��
create or replace procedure del_dept_sp1(p_dept_id dept.dept_id%type)
is
    v_cnt binary_integer;
    ex_fk exception;
begin
    select count(*) into v_cnt from emp where dept_id = p_dept_id;
    if v_cnt != 0 then
        raise ex_fk;
    end if;
    delete from dept where dept_id = p_dept_id;
    dbms_output.put_line('�����Ϸ�');
exception
    when ex_fk then
        dbms_output.put_line('������ �μ��� ��������');
end;
/

exec del_dept_sp1(100);

/* ****************************************************************************************************************************************************
RAISE_APPLICATION_ERROR
���� ���� ���� ���� �ڵ�� ���ܸ޼����� �޾� ���ܸ� �߻���Ű�� ���ν���
 - RAISE_APPLICATION_ERROR(�����ڵ�, ���� �޼���)
    - �����ڵ�� -20000 ~ -20999 ������ ���ڸ� ����Ѵ�. 
**************************************************************************************************************************************************** */
declare
    v_dept_id dept.dept_id%type := &d_id;
    v_cnt binary_integer;
    ex_fk exception;
begin
    select count(*) into v_cnt from emp where dept_id = v_dept_id;
    if v_cnt != 0 then
        --raise ex_fk;
        raise_application_error(-20001, v_dept_id||'�� �����ǰ� �ִ� �μ��̹Ƿ� ���� �ȵ�');
    end if;
    delete from dept where dept_id = v_dept_id;
    dbms_output.put_line('�����Ϸ�');
exception
    when others then
        dbms_output.put_line(sqlcode);  --����Ŭ �����ڵ带 ��ȸ: sqlcode
        dbms_output.put_line(sqlerrm);  --���� �޼����� ��ȸ: sqlerrm
end;
/


--TODO: �μ� ID�� �޾� �μ��� �����ϴ� ���ν��� �ۼ�
--      EMP ���̺��� �����Ϸ��� �μ��� �����ϴ� ���� �ִ��� Ȯ�� �� �� ������ �����ϰ� ������ �����ڵ� 
---20100 ���� ������ �޼����� �־� ����� ���� ���ܸ� �߻���Ų�� EXCEPTION ������ ó��.
declare
    v_dept_id dept.dept_id%type := &d_id;
    v_cnt binary_integer;
begin
    select count(*) into v_cnt from emp where dept_id = v_dept_id;
    if v_cnt <> 0 then
        raise_application_error (-20100, '�����Ϸ��� �μ��� ��������');
    end if;
    delete from dept where dept_id = v_dept_id;
exception
    when others then
        dbms_output.put_line(sqlerrm);
end;
/


