/* **********************************************************
조건문
 - 조건에 따라 실행하는 구문이 다를 경우 사용.
 - IF 문과 CASE문 이 있다.

- IF 문 구문
    - [조건이 1개인 경우] 
    IF 조건 THEN 처리구문 END IF;
    
    - [참인경우 거짓인 경우의 두 조건]
    IF 조건 THEN 처리구문_1
    ELSE 처리구문_2
    END IF
    
    - [조건이 여러개인 겨우]
    IF 조건_1 THEN 처리구문_1
    ELSIF 조건_2 THEN 처리구문_2
    ELSIF 조건_3 THEN 처리구문_3
    ...
    ELSE 처리구문_N
    END IF
********************************************************** */    
declare
    v_num1 binary_integer := 10;
    v_num2 binary_integer := 0;
begin
    if v_num1 > v_num2 then
        dbms_output.put_line('num1이 크다');
    elsif v_num1 = v_num2 then
        dbms_output.put_line('num1과 num2는 같다.');
    else
        dbms_output.put_line('num2가 크다');
    end if;
end;
/

-- TODO : 직원 ID가 110 인 직원의 급여(salary)를 조회한 뒤 5000 미만이면 'LOW', 5000이상 10000이하면 'MIDDLE', 1000 초과이면 'HIGH'를 출력한다.
declare
    v_salary emp.salary%type;
    v_grade varchar(6);
begin
    select salary
    into v_salary
    from emp
    where emp_id = 110;
    if v_salary < 5000 then
        v_grade := 'LOW';
    elsif v_salary <10000 then
        v_grade := 'MIDDLE';
    else
        v_grade := 'HIGH';
    end if;
    dbms_output.put_line(v_salary);
    dbms_output.put_line(v_grade);
end;
/


-- TODO: 직원 ID가 100 인 직원의 SALARY와 COMM_PCT를 조회한다. COMM_PCT가 NULL이 아니면 SALARY + SALARY * COMM_PCT의 값을 출력하고 
--NULL 이면 COMM_PCT가 없음과 SALARY만 출력한다.
--직원ID 100과 145 두명을 해본다.
declare
    v_salary emp.salary%type;
    v_comm_pct emp.comm_pct%type;
begin
    select salary, comm_pct
    into v_salary, v_comm_pct
    from emp
    where emp_id = 145;
    if v_comm_pct is not null then
        dbms_output.put_line(v_salary+v_salary*v_comm_pct);
    else
        dbms_output.put_line(v_salary);
    end if;    
end;
/



-- TODO: emp_id를 bind변수로 받아서 그 직원이 커미션이 있는지 조회후(emp.comm_pct) 커미션이 있는 직원이면 commission 테이블에 emp_id와 
--실행시점 일시와 커미션(salary * comm_pct)을 저장한다.
--커미션 저장 테이블
create table commission(
    emp_id number(6),
    curr_date date,
    commission number
);

declare
    v_emp_id emp.emp_id%type := :id;
    v_comm_pct emp.comm_pct%type;
    v_salary emp.salary%type;
begin
    select comm_pct, salary
    into v_comm_pct, v_salary
    from emp
    where emp_id = v_emp_id;
    if v_comm_pct is not null then
        insert into commission values(v_emp_id, sysdate, v_salary*v_comm_pct);
        dbms_output.put_line('커미션 등록');
    else
        dbms_output.put_line('comm_pct가 null임');
    end if;
end;
/

select * from commission;
select emp_id, comm_pct, salary from emp;





/* ************************************************************** 
CASE 문 : SQL의 CASE 문과 (거의)동일

 [유형 1]
    CASE 표현식
        WHEN 결과1 THEN 처리구문_1;
        WHEN 결과2 THEN 처리구문_2;
        ...
        ELSE 기타 처리구문;
    END CASE;
     
    [유형 2]
    CASE WHEN 표현식1 THEN 처리구문_1;
         WHEN 표현식2 THEN 처리구문_2;
         ...
         ELSE 기타 처리구문;
    END CASE;
************************************************************** */    
declare
    v_num binary_integer := &num;
    v_result varchar2(20);
begin
    case v_num
        when 10 then
            v_result := '십';
        when 20 then
            v_result := '이십';
        else
            v_result := '기타';
    end case;
    dbms_output.put_line(v_result);
end;
/

-- TODO : 직원 ID가 110 인 직원의 급여(salary)를 조회한 뒤 5000 미만이면 'LOW', 5000이상 10000이하면 'MIDDLE', 1000 초과이면 'HIGH'를 출력한다.
-- CASE 문을 이용해 작성
declare
    v_salary emp.salary%type;
    v_emp_id emp.emp_id%type := &emp_id;
begin
    select salary
    into v_salary
    from emp
    where emp_id = v_emp_id;
    case    when v_salary<5000 then dbms_output.put_line('LOW');
            when v_salary<10000 then dbms_output.put_line('MIDDLE');
            else dbms_output.put_line('HIGH');
    end case;
    dbms_output.put_line(v_salary);
end;
/



/* *********************************************************************************
반복문
 - 특정 구문을 반복해서 실행하는 구문
 - LOOP, WHILE, FOR 세가지 구문이 있다.
 - EXIT WHEN 조건
	- 반복문을 멈추고 빠져나온다.
-  CONTINUE WHEN 조건
	- 반복문의 이하부분을 실행하지 않고 처리구문 처음으로 가서 실행한다.
 ********************************************************************************* */
 
 /* ************************************************************
    LOOP 문 : 단순 반복처리 > 무한반복(exit조건을 명시해야함)
    구문
        LOOP
            반복처리할 구문
            EXIT WHEN 멈출조건
        END LOOP
 ************************************************************ */
-- LOOP 문을 이용해 0 ~ 10까지 누적합계 구하기
declare
    v_num binary_integer := 1;
    v_result binary_integer :=0;
begin
    loop
        v_result := v_result + v_num;
        dbms_output.put_line(v_num||' 더한 결과 : '||v_result);
        v_num := v_num+1;
        exit when v_num = 11;
    end loop;
end;
/

 
 /* ************************************************************
 WHILE 문: 조건이 참(TRUE)일 동안 반복
 구문
    WHILE 반복조건
    LOOP
        처리구문
    END LOOP;

************************************************************  */
-- WHILE 문을 이용한 0 ~ 10까지 누적합계
declare
    v_num binary_integer := 1;
    v_result binary_integer :=0;
begin
    while v_num != 11 --반복구문을 실행할 조건.
    loop
        v_result := v_result + v_num;
        dbms_output.put_line(v_num||' 더한 결과 : '||v_result);
        v_num := v_num+1;
    end loop;
end;
/

-- TODO: hello1, hello2, hello3 ... hello10을 출력하는 코드를 작성 (LOOP와 WHILE문으로 작성)
--loop
declare
    v_num binary_integer := 1;
begin
    loop
        dbms_output.put_line('hello'||v_num);
        v_num := v_num + 1;
        exit when v_num = 11;
    end loop;
end;
/
--while
declare
    v_num binary_integer := 1;
begin
    while v_num < 11
    loop
        dbms_output.put_line('hello'||v_num);
        v_num := v_num + 1;
    end loop;
end;
/

-- TODO: sequence t_seq 의 값이 20이 될때 까지 조회해 출력하는 코드를 작성. (LOOP 와 WHILE문으로 작성)
drop sequence t_seq;
create sequence t_seq;
--loop
begin
    loop
        dbms_output.put_line(t_seq.nextval);
        exit when t_seq.currval = 20;
    end loop;
end;
/
--while
declare
    v_num binary_integer := 1;
begin
    while v_num<20
    loop
        dbms_output.put_line(t_seq.nextval);
        v_num := t_seq.currval;
    end loop;
end;
/

 /* ************************************************************
 FOR 문: 일정 횟수를 반복할 때 사용
 
 FOR 인덱스 IN [REVERSE] 초깃값..최종값
 LOOP
    반복 처리 구문
 END LOOP;

-- 인덱스: 반복 시마다 1씩 증가하는 값. 참조는 가능하나 변경은 안된다.
-- REVERSE : 최종값->초깃값

************************************************************ */

-- FOR 문을  이용한 0 ~ 10까지 누적합계
declare
    v_result binary_integer := 0;
begin
    for i in reverse 1..10
    loop
        v_result := v_result +i;
        dbms_output.put_line(i);
    end loop;
    dbms_output.put_line('합계: '||v_result);
end;
/

begin
    for e_row in (select * from emp where dept_id = 60)
    loop
        dbms_output.put_line(e_row.emp_id||e_row.emp_name);
    end loop;
end;
/


-- TODO: hello1, hello2, hello3 ... hello10을 출력하는 코드를 작성 (FOR문으로 작성)
begin
    for i in 1..10
    loop
        dbms_output.put_line('hello'||i);
    end loop;
end;
/


-- TODO: sequence t_seq 의 값이 20이 될때 까지 조회해 출력하는 코드를 작성. (FOR문으로 작성)
drop sequence t_seq;
create sequence t_seq;
declare
    v_num binary_integer;
begin
    for i in 1..20
    loop
        exit when v_num>20;
        dbms_output.put_line(t_seq.nextval);
        v_num := t_seq.currval;
    end loop;
end;
/


--TODO 구구단 5단을 출력하는 코드를 작성 (loop, for, while으로 작성)
--for
declare
    v_dan pls_integer:=&dan;
begin
    for i in 1..9
    loop
        dbms_output.put_line(v_dan||' * '|| i || ' = ' || v_dan*i);
    end loop;
end;
/
--loop
declare
    v_num binary_integer := 1;
begin
    loop
        exit when v_num >=10;
        dbms_output.put_line('5 * '|| v_num || ' = ' || 5*v_num);
        v_num := v_num + 1;
    end loop;
end;
/
--while
declare
    v_num binary_integer := 1;
begin
    while v_num < 10
    loop
        dbms_output.put_line('5 * '|| v_num || ' = ' || 5*v_num);
        v_num := v_num + 1;
    end loop;
end;
/


--TODO 1 ~ 100 사이의 숫자 중에 5의 배수만 출력하도록 작성. (MOD(A, B): A를 B로 나눈 나머지 반환 함수)
begin
    for i in 1..100
    loop
        if mod(i,5)=0 then
            dbms_output.put_line(i);
        end if;
    end loop;
end;
/
