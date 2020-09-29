
/* ***********************************************************************************************
변수 사용
- 변수 선언
  - DECLARE 절에서 한다.
  - 구문: 변수명 [CONSTANT] 데이터타입 [NOT NULL] [ := 기본값] 
     - CONSTANT : 값을 변경할 수 없는 변수. 선언시 반드시 초기화 해야 한다.
	 - 데이터타입: 오라클 데이터타입+PL/SQL 데이터타입 지정한다.
	 - NOT NULL: 변수가 NULL을 가져선 안됨을 제약조건으로 지정. 선언시 반드시 초기화 되야함.
	 - 선언시 [DEFAULT 값] 으로 초기값 선언 가능
  - 대입연산자
     -  변수 := 값
*********************************************************************************************** */

declare
--변수명(identifier) datatype
    v_message1  varchar2(100); --null로 초기화
    v_message2  varchar2(100) not null := '기본메시지'; --not null은 반드시 초기화를 해주어야한다.
    c_num       constant pls_integer := 20; --정수형 상수
    --c_num       constant pls_integer default 20;
    --not null변수와 constant(상수)는 선언시 초기화 해야 한다.
begin
    v_message1 := 'hello world';
    v_message2 := '&msg'; --치환연산자
    --c_num := 5000;  --상수에는 값을 재할당 할 수 없다.
    dbms_output.put_line(v_message1);
    dbms_output.put_line(v_message2);
    dbms_output.put_line(c_num);
end;
/

-- TODO: DECLARE 에서 본인 정보를 저장할 변수들(이름, 나이, 주소 등등)을 선언하고 실행 블록(BEGIN)에서 값을 대입한 뒤 출력하는 코드 작성.
declare
    v_name  nvarchar2(50);
    v_age   pls_integer;        --number
    v_address nvarchar2(100);
begin
    v_name := '김선경';
    v_age := 24;
    v_address := '경기도 용인시 수지구';
    dbms_output.put_line('이름: '||v_name);
    dbms_output.put_line('나이: '||v_age);
    dbms_output.put_line('주소: '||v_address);
end;
/


-- TODO: emp 테이블의 이름(emp_name), 급여(salary), 커미션비율(comm_pct), 입사일(hire_date) 를 값을 저장할 수 있는 변수를 선언하고
-- &변수를 이용해 값을 입력 받아 출력하는 코드를 작성.
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
    dbms_output.put_line('이름: '||v_emp_name);
    dbms_output.put_line('급여: '||v_salary);
    dbms_output.put_line('comm_pct: '||v_comm_pct);
    dbms_output.put_line('입사일: '||v_hire_date);
end;
/


/* **********************************************************
- %TYPE 속성
  - 컬럼의 데이터타입을 이용해 변수의 타입 선언된
  - 구문:   테이블명.컬럼%TYPE
    ex) v_emp_id emp.emp_id%TYPE
*********************************************************** */
-- dept 테이블의 컬럼들의 데이터 타입을 이용해 변수 선언

declare
    v_dept_id dept.dept_id%type; 
    v_dept_name dept.dept_name%type :='없음';
    v_loc dept.loc%type;
begin
    v_dept_id := 2000;
    v_loc := '서울';
    dbms_output.put_line(v_dept_id||','||v_dept_name||','||v_loc);
end;
/

-- TODO: job 테이블의 컬럼들의 타입을 이용해 v_job_id, v_job_title, v_max_salary, v_min_salary 를 생성하고 & 변수를 이용해 값을 입력 받아 출력하는 코드 작성
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
바인드 변수, 호스트 변수
※ 치환변수 &연산자와 다른 점은 db의 입장에서 &name은 입력한 값을 대체하여 받지만
    바인드 변수는 :name 그대로 보낸다. 변수를 초기화하는 과정을 툴이 해준다.
보통 쿼리문에서 사용
-선언
    variable 변수명 타입;
    var 변수명 타입;
    var name varchar2(100);
-사용
    :변수명
    :name

****************************************************************** */
var e_id number;
exec :e_id :=200;

select * from emp 
where emp_id = :e_id
and     emp_name = :e_name;

/* ******************************************************************
 PL/SQL에서 시퀀스(Sequence) 사용
 - select 구문없이 sequence이름.nextval 로 바로호출 가능.
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
프로시저에서 함수 사용
 - 문자/숫자/날짜/변환 함수는 처리결과가 1개일 때 실행 구문에서 단독으로 사용할 수 있다.
 - 집계함수(max, min등)와 DECODE() 함수는 SQL문에서만 사용할 수 있다. 
******************************************************************* */
begin
    dbms_output.put_line(length('aaaaa')); --별도의 select문 없이 바로 함수를 사용 할 수 있다.
    dbms_output.put_line(round(4.232323,2));
end;
/



-- TODO: 다음을 순서대로 출력하는 코드를 작성
/*
"서울시 강남구 역삼동" 문자열의 길이를 출력
"Hello World" 를 대문자로 출력
100.23456 를 소숫점 첫번째 이하에서 반올림 해서 출력
SYSDATE에서 시:분:초 를 출력*/
begin
    dbms_output.put_line(length('서울시 강남구 역삼동'));
    dbms_output.put_line(upper('Hello World'));
    dbms_output.put_line(round(100.23456,1));
    dbms_output.put_line(to_char(sysdate,'hh24:mi:ss'));
end;
/
/* *************************************************************
중첩 구문
- PL/SQL 실행블록내에 PL/SQL 구문을 중첩해서 작성할 수 있다.
- 안쪽 실행블록에서는 바깥쪽 실행구문에서 선언한 변수를 사용할 수 있지만 반대는 안된다.
- 예
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
        dbms_output.put_line('INNER: '||v_outer);   --outer의 변수를 inner에서 사용가능.
        dbms_output.put_line('INNER: '||v_inner);
    end;
    dbms_output.put_line('OUTER: '||v_outer);
    --dbms_output.put_line('OUTER: '||v_inner); --error: inner에서 선언된 변수는 outer에서 사용못함.
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
            dbms_output.put_line('INNER: '||v_outer);  --inner의 v_outer가 호출됨
            dbms_output.put_line('INNER: '||outer_p.v_outer); --outer의 v_outer가 호출됨
            dbms_output.put_line('INNER: '||v_inner);
        end;
        dbms_output.put_line('OUTER: '||v_outer);
    end;
end;
/


/* *************************************************************************************	

DML 구문
- insert/delete/update
- SQL은 동일
- 처리후 commit

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
    
    --insert into dept_copy values(2000, '기획부', '인천');
    insert into dept_copy values(v_dept_id, v_dept_name, v_loc);
    v_dept_name := '연구소';   --값을 바꿈
    v_loc := '부산';           --값을 바꿈
    insert into dept_copy values(v_dept_id+1, v_dept_name, v_loc);
    insert into dept_copy values(v_dept_id+2, v_dept_name, v_loc);
    commit;
end;
/
rollback;

--delete
begin
    delete from dept_copy
    where loc = '서울';
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
-- TODO : emp 테이블에 새로운 세개행을 추가하는 구문을 작성.
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

-- TODO : 위에서 추가한 세개 행의 salary와 comm_pct 의 값을 세배 올리는 구문을 작성
select * from emp_copy;

begin    
    update emp_copy
    set salary = salary *3, comm_pct = comm_pct*3
    where emp_id in (2000,2001,2002);
end;
/
rollback;
-- TODO : 위에서 추가한 세개 행을 삭제하는 구문을 작성
begin    
   delete from emp_copy where emp_id in (2000,2001,2002);
   commit;
end;
/

/* *************************************************************************************
조회구문
select into 문 

select 조회컬럼
INTO   조회값을 저장할 변수
from 테이블
where 제약조건
group by 
having
order by

************************************************************************************* */

-- 부서 ID(dept_id)가 10인 부서의 이름(dept_name), 위치(loc) 를 조회하는 구문



--직원 id(emp.emp_id) 가 110 인 직원의 이름(emp.emp_name), 급여(emp.salary), 부서 ID(dept.dept_id) 부서이름(dept.dept_name) 출력하는 구문작성



-- TODO 직원의 ID가 120인 직원의 이름(emp.emp_name), 급여(emp.salary), 업무_ID (emp.job_id), 입사일(emp.hire_date)를 출력하는 구문 작성



-- TODO 부서테이블에 dept_id=9900, dept_name='경영기획', loc='서울' 을 insert 하고 dept_id로 조회하여 입력결과를 출력하는 구문을 작성.



-- TODO 직원_ID가 110인 직원의 이름(emp.emp_name), 업무 ID(emp.job_id), 업무명(job.job_title) 출력하는 구문 작성













