/* *********************************************************************
���ν���
 - Ư�� ������ ó���ϴ� ���밡���� ���� ���α׷�
 - �ۼ��� ����Ǹ� ������ �Ǿ� ��ü�� ����Ŭ�� ����Ǹ� EXECUTE�� EXEC ��ɾ�� �ʿ�ø��� ���밡��
����
CREATE [OR REPLACE] PROCEDURE �̸� [(�Ķ���� ����,..)]
IS      --declare���, �����Ұ�
    [���� ����]
BEGIN
    ���౸��
[EXCEPTION
    ����ó������]
END;

- �Ķ���� ����
  - ���� ���� ����
  - ���� : ������ mode Ÿ�� [:=�ʱⰪ]
    - mode
      - IN : �⺻. ȣ���ϴ� ������ ���� ���� ���� �޾� ���ν��� ������ ���. �б� ���뺯��. 
      - OUT : ȣ�� �ϴ� ������ ������ ���� ������ ����. 
      - IN OUT : IN�� OUT�� ����� ��� �ϴ� ����
	- Ÿ�Կ� size�� �������� �ʴ´�. 
	- �ʱⰪ�� ���� �Ű������� ȣ��� �ݵ�� ���� ���޵Ǿ� �Ѵ�.


����
exec �̸�[(���ް�)]
execute �̸�[(���ް�)]

���ν��� ����
- DROP PROCEDURE ���ν����̸�

*********************************************************************** */
set serveroutput on;
create or replace procedure message_sp1
is
    --��������
    v_message varchar2(100);
begin
    --���౸��
    v_message := 'HelloWorld!';
    dbms_output.put_line(v_message);
end;
/
--ctrl+enter: ����Ŭ ������ ����

--����
execute message_sp1;
exec message_sp1;

create or replace procedure message_sp2(p_message in varchar2) --in�� ��������
is
begin
    dbms_output.put_line(p_message);
end;
/
exec message_sp2('�ȳ��ϼ���');
exec message_sp2('Hi');
exec message_sp2;--error(�Ű������� ����)

create or replace procedure message_sp2(p_message in varchar2 := '�⺻ �ȳ��ϼ���') --default����
is
begin
    dbms_output.put_line(p_message);
end;
/
exec message_sp2; --�� ��� default���� �⺻ �ȳ��ϼ��䰡 ��µ�

create or replace procedure message_sp3(p_message in varchar2, p_num pls_integer)
is
begin
    dbms_output.put_line(p_message||p_num);
end;
/
exec message_sp3('�ȳ��ϼ���',20);

create or replace procedure message_sp4(p_message in out varchar2)
is
begin
    dbms_output.put_line(p_message);
    p_message := 'message_sp4������ �޽���';
end;
/
create or replace procedure caller_sp
is
    v_msg varchar2(100);
begin
    --message_sp4 �� ȣ�� - �޽����� ��ȯ�ϴ� sp
    v_msg := '�⺻��'; 
    message_sp4(v_msg); --message_sp4���� in�Ͻ� ���� v_msg�� ���� ���� (out�Ͻ� null�� �ʱ�ȭ)
    dbms_output.put_line(v_msg);
end;
/

exec caller_sp;


--�Ű������� �μ�ID, �μ��̸�, ��ġ�� �޾� DEPT�� �μ��� �߰��ϴ� Stored Procedure �ۼ�
create or replace procedure add_dept(p_dept_id dept.dept_id%type, p_dept_name dept.dept_name%type
    ,p_loc dept.loc%type)
is
begin
    insert into dept values(p_dept_id, p_dept_name, p_loc);
end;
/
exec add_dept(&id, '&name', '&loc');


--�Ű������� �μ�ID�� �Ķ���ͷ�  �޾� ��ȸ�ϴ� Stored Procedure
create or replace procedure find_dept_sp(p_dept_id dept.dept_id%type)
is
    v_dept_id dept.dept_id%type;
    v_dept_name dept.dept_name%type;
    v_loc dept.loc%type;
begin
    select dept_id, dept_name, loc
    into v_dept_id, v_dept_name, v_loc
    from dept
    where dept_id = p_dept_id;
    dbms_output.put_line(v_dept_id||' - '||v_dept_name||' - '||v_loc);
    --��ȸ �μ��� loc�� new york�̸� seoul�� ����
    if v_loc = 'New York' then
        update dept
        set loc = 'Seoul'
        where dept_id = p_dept_id;
    end if;
end;
/

exec find_dept_sp(&id);

-- TODO ������ ID�� �Ķ���ͷ�  �޾Ƽ� ������ �̸�(emp.emp_name), �޿�(emp.salary), ����_ID (emp.job_id),
--�Ի���(emp.hire_date)�� ����ϴ� Stored Procedure �� ����
create or replace procedure TODO_01_sp(p_emp_id emp.emp_id%type) --�̸� ��ҹ��� ��� X
is
    v_emp_name  emp.emp_name%type;
    v_salary    emp.salary%type;
    v_job_id    emp.job_id%type;
    v_hire_date emp.hire_date%type;
begin
    select  emp_name, salary, job_id, hire_date
    into    v_emp_name, v_salary, v_job_id, v_hire_date
    from    emp
    where   emp_id = p_emp_id;
    dbms_output.put_line(v_emp_name||' - '||v_salary||' - '||v_job_id||' - '||v_hire_date);
end;
/

EXEC TODO_01_sp(100);
EXEC TODO_01_sp(110);



-- TODO ����_ID(job.job_id)�� �Ķ���ͷ� �޾Ƽ� ������(job.job_title)�� 
--�����ִ�/�ּ� �޿�(job.max_salary, min_salary)�� ����ϴ� Stored Procedure �� ����
create or replace procedure TODO_02_sp(p_job_id job.job_id%type)
is
    v_job_title job.job_title%type;
    v_max_salary job.max_salary%type;
    v_min_salary job.min_salary%type;
begin
    select job_title, max_salary, min_salary
    into v_job_title,v_max_salary,v_min_salary
    from job
    where job_id = p_job_id;
    dbms_output.put_line(v_job_title||' - '||v_max_salary||' - '||v_min_salary);
end;
/
EXEC TODO_02_sp('FI_ACCOUNT');
EXEC TODO_02_sp('IT_PROG');


-- TODO: ����_ID�� �Ķ���ͷ� �޾Ƽ� ������ �̸�(emp.emp_name), ���� ID(emp.job_id), ������(job.job_title) ����ϴ� Stored Procedure �� ����
create or replace procedure todo_03_sp(p_emp_id emp.emp_id%type)
is
    v_emp_name  emp.emp_name%type;
    v_job_id    emp.job_id%type;
    v_job_title job.job_title%type;
begin
    select e.emp_name, e.job_id, j.job_title
    into v_emp_name, v_job_id, v_job_title
    from emp e left join job j on e.job_id = j.job_id
    where e.emp_id = p_emp_id;
    dbms_output.put_line(v_emp_name||' - '||v_job_id||' - '||v_job_title);
end;
/
EXEC TODO_03_sp(110);
EXEC TODO_03_sp(200);




-- TODO ������ ID�� �Ķ���ͷ� �޾Ƽ� ������ �̸�(emp.emp_name), �޿�(emp.salary), 
--�ҼӺμ��̸�(dept.dept_name), �μ���ġ(dept.loc)�� ����ϴ� Stored Procedure �� ����
create or replace procedure todo_04_sp(p_emp_id emp.emp_id%type)
is
    v_emp_name emp.emp_name%type;
    v_salary emp.salary%type;
    v_dept_name dept.dept_name%type;
    v_loc dept.loc%type;
begin
    select e.emp_name, e.salary, d.dept_name, d.loc
    into v_emp_name, v_salary, v_dept_name, v_loc
    from emp e left join dept d on e.dept_id = d.dept_id
    where e.emp_id = p_emp_id;
    dbms_output.put_line(v_emp_name||' - '||v_salary||' - '||v_dept_name||' - '||v_loc);
end;
/
EXEC TODO_04_sp(100);
EXEC TODO_04_sp(120);




-- TODO ������ ID�� �Ķ���ͷ� �޾Ƽ� �� ������ �̸�(emp.emp_name), �޿�(emp.salary), 
--������ �ִ�޿�(job.max_salary), ������ �ּұ޿�(job.min_salary), ������ �޿����(salary_grade.grade)�� ����ϴ� store procedure�� ����
create or replace procedure todo_05_sp(p_emp_id emp.emp_id%type)
is
    v_emp_name emp.emp_name%type;
    v_salary emp.salary%type;
    v_max_salary job.max_salary%type;
    v_min_salary job.min_salary%type;
    v_grade salary_grade.grade%type;
begin
    select e.emp_name, e.salary, j.max_salary, j.min_salary, s.grade
    into v_emp_name, v_salary, v_max_salary, v_min_salary, v_grade
    from emp e left join job j on e.job_id = j.job_id
               left join salary_grade s on e.salary between s.low_sal and s.high_sal
    where e.emp_id = p_emp_id;
    dbms_output.put_line(v_emp_name||' - '||v_salary||' - '||v_max_salary||' - '||v_min_salary||' - '||v_grade);
end;
/
EXEC TODO_05_sp(100);
EXEC TODO_05_sp(120);



-- TODO: ������ ID(emp.emp_id)�� �Ķ���ͷ� �޾Ƽ� �޿�(salary)�� ��ȸ�� �� �޿��� �޿������ ����ϴ� Stored Procedure �� ����.
-- �����޿� ��� ����:  �޿��� $5000 �̸� �̸� LOW, %5000 ~ $10000 �̸� MIDDLE, $10000 �ʰ��� HIGH�� ���
create or replace procedure todo_06_sp(p_emp_id emp.emp_id%type)
is
    v_salary emp.salary%type;
begin
    select salary
    into v_salary
    from emp 
    where emp_id = p_emp_id;
    case when v_salary < 5000 then
        dbms_output.put_line('LOW');
         when v_salary <10000 then
        dbms_output.put_line('MIDDLE');
        else
        dbms_output.put_line('HIGH');
    end case;
    /*
    if v_salary < 5000 then
        dbms_output.put_line('LOW');
    elsif v_salary <10000 then
        dbms_output.put_line('MIDDLE');
    else
        dbms_output.put_line('HIGH');
    end if;
    */
end;
/
exec TODO_06_sp(100);
exec TODO_06_sp(130);

