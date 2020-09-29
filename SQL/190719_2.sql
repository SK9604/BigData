/* *********************************************************************
프로시저
 - 특정 로직을 처리하는 재사용가능한 서브 프로그램
 - 작성후 실행되면 컴파일 되어 객체로 오라클에 저장되며 EXECUTE나 EXEC 명령어로 필요시마다 재사용가능
구문
CREATE [OR REPLACE] PROCEDURE 이름 [(파라미터 선언,..)]
IS      --declare대신, 생략불가
    [변수 선언]
BEGIN
    실행구문
[EXCEPTION
    예외처리구문]
END;

- 파라미터 선언
  - 개수 제한 없음
  - 구문 : 변수명 mode 타입 [:=초기값]
    - mode
      - IN : 기본. 호출하는 곳으로 부터 값을 전달 받아 프로시저 내에서 사용. 읽기 전용변수. 
      - OUT : 호출 하는 곳으로 전달할 값을 저장할 변수. 
      - IN OUT : IN과 OUT의 기능을 모두 하는 변수
	- 타입에 size는 지정하지 않는다. 
	- 초기값이 없는 매개변수는 호출시 반드시 값이 전달되야 한다.


실행
exec 이름[(전달값)]
execute 이름[(전달값)]

프로시저 제거
- DROP PROCEDURE 프로시저이름

*********************************************************************** */
set serveroutput on;
create or replace procedure message_sp1
is
    --변수선언
    v_message varchar2(100);
begin
    --실행구문
    v_message := 'HelloWorld!';
    dbms_output.put_line(v_message);
end;
/
--ctrl+enter: 오라클 서버에 저장

--실행
execute message_sp1;
exec message_sp1;

create or replace procedure message_sp2(p_message in varchar2) --in은 생략가능
is
begin
    dbms_output.put_line(p_message);
end;
/
exec message_sp2('안녕하세요');
exec message_sp2('Hi');
exec message_sp2;--error(매개변수가 없음)

create or replace procedure message_sp2(p_message in varchar2 := '기본 안녕하세요') --default지정
is
begin
    dbms_output.put_line(p_message);
end;
/
exec message_sp2; --이 경우 default값인 기본 안녕하세요가 출력됨

create or replace procedure message_sp3(p_message in varchar2, p_num pls_integer)
is
begin
    dbms_output.put_line(p_message||p_num);
end;
/
exec message_sp3('안녕하세요',20);

create or replace procedure message_sp4(p_message in out varchar2)
is
begin
    dbms_output.put_line(p_message);
    p_message := 'message_sp4에서의 메시지';
end;
/
create or replace procedure caller_sp
is
    v_msg varchar2(100);
begin
    --message_sp4 를 호출 - 메시지를 반환하는 sp
    v_msg := '기본값'; 
    message_sp4(v_msg); --message_sp4에서 in일시 받음 v_msg의 값을 받음 (out일시 null로 초기화)
    dbms_output.put_line(v_msg);
end;
/

exec caller_sp;


--매개변수로 부서ID, 부서이름, 위치를 받아 DEPT에 부서를 추가하는 Stored Procedure 작성
create or replace procedure add_dept(p_dept_id dept.dept_id%type, p_dept_name dept.dept_name%type
    ,p_loc dept.loc%type)
is
begin
    insert into dept values(p_dept_id, p_dept_name, p_loc);
end;
/
exec add_dept(&id, '&name', '&loc');


--매개변수로 부서ID를 파라미터로  받아 조회하는 Stored Procedure
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
    --조회 부서의 loc이 new york이면 seoul로 변경
    if v_loc = 'New York' then
        update dept
        set loc = 'Seoul'
        where dept_id = p_dept_id;
    end if;
end;
/

exec find_dept_sp(&id);

-- TODO 직원의 ID를 파라미터로  받아서 직원의 이름(emp.emp_name), 급여(emp.salary), 업무_ID (emp.job_id),
--입사일(emp.hire_date)를 출력하는 Stored Procedure 를 구현
create or replace procedure TODO_01_sp(p_emp_id emp.emp_id%type) --이름 대소문자 상관 X
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



-- TODO 업무_ID(job.job_id)를 파라미터로 받아서 업무명(job.job_title)과 
--업무최대/최소 급여(job.max_salary, min_salary)를 출력하는 Stored Procedure 를 구현
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


-- TODO: 직원_ID를 파라미터로 받아서 직원의 이름(emp.emp_name), 업무 ID(emp.job_id), 업무명(job.job_title) 출력하는 Stored Procedure 를 구현
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




-- TODO 직원의 ID를 파라미터로 받아서 직원의 이름(emp.emp_name), 급여(emp.salary), 
--소속부서이름(dept.dept_name), 부서위치(dept.loc)를 출력하는 Stored Procedure 를 구현
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




-- TODO 직원의 ID를 파라미터로 받아서 그 직원의 이름(emp.emp_name), 급여(emp.salary), 
--업무의 최대급여(job.max_salary), 업무의 최소급여(job.min_salary), 업무의 급여등급(salary_grade.grade)를 출력하는 store procedure를 구현
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



-- TODO: 직원의 ID(emp.emp_id)를 파라미터로 받아서 급여(salary)를 조회한 뒤 급여와 급여등급을 출력하는 Stored Procedure 를 구현.
-- 업무급여 등급 기준:  급여가 $5000 미만 이면 LOW, %5000 ~ $10000 이면 MIDDLE, $10000 초과면 HIGH를 출력
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

