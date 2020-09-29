create user scott_join identified by tiger;
grant all privileges to scott_join;


/* ****************************************
조인(JOIN) 이란
- 2개 이상의 테이블에 있는 컬럼들을 합쳐서 가상의 테이블을 만들어 조회하는 방식을 말한다.
 	- 소스테이블 : 내가 먼저 읽어야 한다고 생각하는 테이블 (emp)
	- 타겟테이블 : 소스를 읽은 후 소스에 조인할 대상이 되는 테이블 (dept)
 
- 각 테이블을 어떻게 합칠지를 표현하는 것을 조인 연산이라고 한다.
    - 조인 연산에 따른 조인종류
        - Equi join(PK=FK) , non-equi join(FK>=PK 와 같은 연산)
        
- 조인의 종류
    - Inner Join (소스테이블에서 FK가 되는 컬럼이 null이 아닌 행만 조인)
        - 양쪽 테이블에서 조인 조건을 만족하는 행들만 합친다. 
    - Outer Join (소스테이블에서 FK가 되는 컬럼이 null이어도 없는 컬럼의 값을 빈 상태로 조인)
        - 한쪽 테이블의 행들을 모두 사용하고 다른 쪽 테이블은 조인 조건을 만족하는 행만 합친다. 조인조건을 만족하는 행이 없는 경우 NULL을 합친다.
        - 종류 : Left Outer Join(왼쪽 소스테이블 오른쪽 타겟테이블),  Right Outer Join(오른쪽 소스테이블 왼쪽 타겟테이블), Full Outer Join
    - Cross Join (어떤 행을 합칠 것인지 명시하지 않음(ex. dept.dept_id=emp.dept_id 이런 과정X)
        - 두 테이블의 곱집합을 반환한다.
        - 카티션 곱: 하나의 행에 여러 다른 행이 붙는 경우
        - 총 emp의 행 수 * dept의 행 수의 결과가 나온다.
        
- 조인 문법
    - ANSI 조인 문법
        - 표준 SQL 문법
        - 오라클은 9i 부터 지원.
    - 오라클 조인 문법
        - 오라클 전용 문법이며 다른 DBMS는 지원하지 않는다.
**************************************** */        
        

/* ****************************************
-- inner join : ANSI 조인 구문
FROM  테이블a INNER JOIN 테이블b ON 조인조건 

- inner는 생략 할 수 있다.
**************************************** */
-- 직원의 ID(emp.emp_id), 이름(emp.emp_name), 입사년도(emp.hire_date), 소속부서이름(dept.dept_name)을 조회
select emp.emp_id, emp.emp_name, emp.hire_date, dept.dept_name
--select *
from emp join dept on emp.dept_id=dept.dept_id;

--emp e : e 테이블이름의 별칭(alias), dept d : d 테이블이름의 별칭
select e.emp_id, e.emp_name, e.hire_date, d.dept_name from emp e inner join dept d on e.dept_id=d.dept_id;

-- 직원의 ID(emp.emp_id)가 100인 직원의 직원_ID(emp.emp_id), 이름(emp.emp_name), 입사년도(emp.hire_date), 소속부서이름(dept.dept_name)을 조회.
select e.emp_id, e.emp_name, e.hire_date, d.dept_name
from emp e join dept d on e.dept_id = d.dept_id
where e.emp_id=100;

-- 직원_ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 담당업무명(job.job_title), 소속부서이름(dept.dept_name)을 조회
select e.emp_id, e.emp_name, e.salary, j.job_title, d.dept_name
from emp e  join job j on e.job_id=j.job_id
            join dept d on e.dept_id=d.dept_id;

-- 부서_ID(dept.dept_id)가 30인 부서의 이름(dept.dept_name), 위치(dept.loc), 그 부서에 소속된 직원의 이름(emp.emp_name)을 조회.
select d.dept_name, d.loc, e.emp_name
from dept d join emp e on d.dept_id=e.dept_id
where d.dept_id = 30;

-- 직원의 ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 급여등급(salary_grade.grade) 를 조회. 급여 등급 오름차순으로 정렬
select e.emp_id, e.emp_name, e.salary, s.grade||'등급'
from emp e join salary_grade s on e.salary between s.low_sal and s.high_sal;


--TODO 200번대(200 ~ 299) 직원 ID(emp.emp_id)를 가진 직원들의 직원_ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 
--     소속부서이름(dept.dept_name), 부서위치(dept.loc)를 조회. 직원_ID의 오름차순으로 정렬.
select e.emp_id, e.emp_name, e.salary, d.dept_name, d.loc
from emp e join dept d on e.dept_id=d.dept_id
where e.emp_id between 200 and 299
order by e.emp_id;

--TODO 업무(emp.job_id)가 'FI_ACCOUNT'인 직원의 ID(emp.emp_id), 이름(emp.emp_name), 업무(emp.job_id), 
--     소속부서이름(dept.dept_name), 부서위치(dept.loc)를 조회.  직원_ID의 오름차순으로 정렬.
select e.emp_id, e.emp_name, e.job_id, d.dept_name, d.loc
from emp e  join dept d on e.dept_id=d.dept_id
where e.job_id='FI_ACCOUNT'
order by e.emp_id;

--TODO 커미션비율(emp.comm_pct)이 있는 직원들의 직원_ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 커미션비율(emp.comm_pct), 
--     소속부서이름(dept.dept_name), 부서위치(dept.loc)를 조회. 직원_ID의 오름차순으로 정렬.
select e.emp_id, e.emp_name, e.salary, e.comm_pct, d.dept_name, d.loc
from emp e join dept d on e.dept_id=d.dept_id
where e.comm_pct is not null
order by e.emp_id;

--TODO 'New York'에 위치한(dept.loc) 부서의 부서_ID(dept.dept_id), 부서이름(dept.dept_name), 위치(dept.loc), 
--     그 부서에 소속된 직원_ID(emp.emp_id), 직원 이름(emp.emp_name), 업무(emp.job_id)를 조회. 부서_ID 의 오름차순으로 정렬.
select d.dept_id, d.dept_name, d.loc, e.emp_id, e.emp_name, e.job_id
from dept d join emp e on d.dept_id=e.dept_id
where d.loc='New York'
order by d.dept_id;

--TODO 직원_ID(emp.emp_id), 이름(emp.emp_name), 업무_ID(emp.job_id), 업무명(job.job_title) 를 조회.
select e.emp_id, e.emp_name, e.job_id, j.job_title
from emp e join job j on e.job_id=j.job_id;
              
-- TODO: 직원 ID 가 200 인 직원의 직원_ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 
--       담당업무명(job.job_title), 소속부서이름(dept.dept_name)을 조회              
select e.emp_id, e.emp_name, e.salary, j.job_title, d.dept_name
from emp e  join job j on e.job_id=j.job_id
            join dept d on e.dept_id=d.dept_id
where e.emp_id=200;

-- TODO: 'Shipping' 부서의 부서명(dept.dept_name), 위치(dept.loc), 소속 직원의 이름(emp.emp_name), 업무명(job.job_title)을 조회. 
--       직원이름 내림차순으로 정렬
select d.dept_name, d.loc, e.emp_name, j.job_title
from dept d join emp e on d.dept_id=e.dept_id
            join job j on e.job_id=j.job_id
where d.dept_name = 'Shipping'
order by e.emp_name desc;

-- TODO:  'San Francisco' 에 근무(dept.loc)하는 직원의 id(emp.emp_id), 이름(emp.emp_name), 입사일(emp.hire_date)를 조회
--         입사일은 'yyyy-mm-dd' 형식으로 출력
select e.emp_id, e.emp_name, to_char(e.hire_date,'yyyy-mm-dd') hire_date
from emp e join dept d on d.dept_id=e.dept_id
where d.loc= 'San Francisco';

-- TODO 부서별 급여(salary)의 평균을 조회. 부서이름(dept.dept_name)과 급여평균을 출력. 급여 평균이 높은 순서로 정렬.
-- 급여는 , 단위구분자와 $ 를 붙여 출력.
select d.dept_name, to_char(avg(e.salary),'$9,999,999')"평균급여"
from dept d join emp e on d.dept_id=e.dept_id
group by d.dept_name
order by avg(e.salary) desc;            
--order by 2 desc; --이 때 평균급여를 문자열로 비교하기 때문에 fm을 붙여 공백을 없앨 경우 정렬이 제대로 되지 않는 문제가 생긴다.

--TODO 직원의 ID(emp.emp_id), 이름(emp.emp_name), 업무명(job.job_title), 급여(emp.salary), 
--     급여등급(salary_grade.grade), 소속부서명(dept.dept_name)을 조회. 등급 내림차순으로 정렬
select e.emp_id, e.emp_name, j.job_title, e.salary, s.grade, d.dept_name
from emp e  join job j on e.job_id=j.job_id
            join salary_grade s on e.salary between s.low_sal and s.high_sal
            join dept d on e.dept_id=d.dept_id
order by 5 desc;

--TODO 급여등급이(salary_grade.grade) 1인 직원이 소속된 부서명(dept.dept_name)과 등급1인 직원의 수를 조회. 직원수가 많은 부서 순서대로 정렬.
/*select d.dept_name, count(*) 직원수
from dept d join emp e on d.dept_id=e.dept_id
            join salary_grade s on e.salary between s.low_sal and s.high_sal
group by d.dept_name, s.grade
having s.grade=1
order by 2 desc;*/
---------------------------------------------------------------------------------
select d.dept_name, count(*) 직원수
from dept d join emp e on d.dept_id=e.dept_id
            join salary_grade s on e.salary between s.low_sal and s.high_sal
where s.grade=1
group by d.dept_name
--group by rollup(dept_name) : 총 1등급인 직원의 수
--having count(*)>=4         : 1등급인 직원의 수가 4명 이상인 부서명
order by 2 desc;

/* ###################################################################################### 
오라클 조인 
- Join할 테이블들을 from절에 나열한다.
- Join 연산은 where절에 기술한다. 

###################################################################################### */
-- 직원의 ID(emp.emp_id), 이름(emp.emp_name), 입사년도(emp.hire_date), 소속부서이름(dept.dept_name)을 조회
-- 입사년도는 년도만 출력
select e.emp_id, e.emp_name, to_char(e.hire_date,'yyyy') 입사년도, d.dept_name
from emp e, dept d          --조인할 테이블들을 나열
where e.dept_id=d.dept_id;  --조인 연산(행을 어떻게 붙일지에 대한 제약조건)

-- 직원의 ID(emp.emp_id)가 100인 직원의 직원_ID(emp.emp_id), 이름(emp.emp_name), 입사년도(emp.hire_date), 소속부서이름(dept.dept_name)을 조회
-- 입사년도는 년도만 출력
select e.emp_id, e.emp_name, to_char(e.hire_date, 'yyyy') 입사년도, d.dept_name
from emp e, dept d
where   e.dept_id=d.dept_id and --조인연산
        e.emp_id=100;           --행 선택

-- 직원_ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 담당업무명(job.job_title), 소속부서이름(dept.dept_name)을 조회
select e.emp_id, e.emp_name, e.salary, j.job_title, d.dept_name
from emp e, job j, dept d
where e.job_id= j.job_id and e.dept_id=d.dept_id;

--TODO 200번대(200 ~ 299) 직원 ID(emp.emp_id)를 가진 직원들의 직원_ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 
--     소속부서이름(dept.dept_name), 부서위치(dept.loc)를 조회. 직원_ID의 오름차순으로 정렬.
select e.emp_id, e.emp_name, e.salary, d.dept_name, d.loc
from emp e,  dept d
where   e.dept_id=d.dept_id
and     e.emp_id between 200 and 299
order by e.emp_id;


--TODO 업무(emp.job_id)가 'FI_ACCOUNT'인 직원의 ID(emp.emp_id), 이름(emp.emp_name), 업무(emp.job_id), 
--     소속부서이름(dept.dept_name), 부서위치(dept.loc)를 조회.  직원_ID의 오름차순으로 정렬.
select e.emp_id, e.emp_name, e.job_id, d.dept_name, d.loc
from emp e, dept d
where e.dept_id=d.dept_id
and e.job_id= 'FI_ACCOUNT'
order by e.emp_id;

--TODO 커미션비율(emp.comm_pct)이 있는 직원들의 직원_ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 커미션비율(emp.comm_pct), 
--     소속부서이름(dept.dept_name), 부서위치(dept.loc)를 조회. 직원_ID의 오름차순으로 정렬.
select e.emp_id, e.emp_name, e.salary, e.comm_pct, d.dept_name, d.loc
from emp e, dept d
where e.dept_id=d.dept_id
and e.comm_pct is not null
order by e.emp_id;

--TODO 'New York'에 위치한(dept.loc) 부서의 부서_ID(dept.dept_id), 부서이름(dept.dept_name), 위치(dept.loc), 
--     그 부서에 소속된 직원_ID(emp.emp_id), 직원 이름(emp.emp_name), 업무(emp.job_id)를 조회. 부서_ID 의 오름차순으로 정렬.
select d.dept_id, d.dept_name, d.loc, e.emp_id, e.emp_name, e.job_id
from emp e, dept d
where e.dept_id=d.dept_id
and d.loc = 'New York'
order by d.dept_id;

--TODO 직원_ID(emp.emp_id), 이름(emp.emp_name), 업무_ID(emp.job_id), 업무명(job.job_title) 를 조회.
select e.emp_id, e.emp_name, e.job_id, j.job_title
from emp e, job j
where e.job_id=j.job_id;
             
-- TODO: 직원 ID 가 200 인 직원의 직원_ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 
--       담당업무명(job.job_title), 소속부서이름(dept.dept_name)을 조회              
select e.emp_id, e.emp_name, e.salary, j.job_title, d.dept_name
from emp e, dept d, job j
where   e.dept_id=d.dept_id
and     e.job_id=j.job_id
and     e.emp_id=200;


-- TODO: 'Shipping' 부서의 부서명(dept.dept_name), 위치(dept.loc), 소속 직원의 이름(emp.emp_name), 업무명(job.job_title)을 조회. 
--       직원이름 내림차순으로 정렬
select d.dept_name, d.loc, e.emp_name, j.job_title
from emp e, dept d, job j
where e.dept_id=d.dept_id
and   e.job_id=j.job_id
and   d.dept_name='Shipping';

-- TODO:  'San Francisco' 에 근무(dept.loc)하는 직원의 id(emp.emp_id), 이름(emp.emp_name), 입사일(emp.hire_date)를 조회
--         입사일은 'yyyy-mm-dd' 형식으로 출력
select e.emp_id, e.emp_name, to_char(e.hire_date,'yyyy-mm-dd')
from emp e, dept d
where e.dept_id=d.dept_id
and   d.loc='San Francisco';

--TODO 부서별 급여(salary)의 평균을 조회. 부서이름(dept.dept_name)과 급여평균을 출력. 급여 평균이 높은 순서로 정렬.
-- 급여는 , 단위구분자와 $ 를 붙여 출력.
select d.dept_name, to_char(avg(e.salary),'$999,999') 평균급여
from emp e, dept d
where e.dept_id=d.dept_id
group by d.dept_name
order by avg(e.salary) desc;

--TODO 직원의 ID(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 급여등급(salary_grade.grade) 를 조회. 직원 id 오름차순으로 정렬
select e.emp_id, e.emp_name, e.salary, s.grade
from emp e, salary_grade s
where   e.salary between s.low_sal and s.high_sal
order by e.emp_id;

--TODO 직원의 ID(emp.emp_id), 이름(emp.emp_name), 업무명(job.job_title), 급여(emp.salary), 
--     급여등급(salary_grade.grade), 소속부서명(dept.dept_name)을 조회. 등급 내림차순으로 정렬
select e.emp_id, e.emp_name, j.job_title, e.salary, s.grade, d.dept_name
from emp e, dept d, job j, salary_grade s
where   e.dept_id=d.dept_id
and     e.job_id=j.job_id
and     e.salary between s.low_sal and s.high_sal
order by s.grade desc;

--TODO 급여등급이(salary_grade.grade) 1인 직원이 소속된 부서명(dept.dept_name)과 등급1인 직원의 수를 조회. 직원수가 많은 부서 순서대로 정렬.
select d.dept_name, count(*) 직원수
from emp e, dept d, salary_grade s
where   e.dept_id=d.dept_id
and     e.salary between s.low_sal and s.high_sal
and     s.grade=1
group by d.dept_name
order by 2 desc;

/* ****************************************************
Self 조인
- 물리적으로 하나의 테이블을 두개의 테이블처럼 조인하는 것.
**************************************************** */
--직원의 ID(emp.emp_id), 이름(emp.emp_name), 상사이름(emp.emp_name)을 조회
--ansi
select e.emp_id, e.emp_name 직원이름, m.emp_name 상사이름
from emp e join emp m on e.mgr_id=m.emp_id;
--oracle
select e.emp_id, e.emp_name 직원이름, m.emp_name 상사이름
from emp e, emp m
where e.mgr_id =m.emp_id;

-- TODO : EMP 테이블에서 직원 ID(emp.emp_id)가 110인 직원의 급여(salary)보다 많이 받는 직원들의 id(emp.emp_id), 이름(emp.emp_name), 
--급여(emp.salary)를 직원 ID(emp.emp_id) 오름차순으로 조회.
--ansi
select e.emp_id, e.emp_name, e.salary
from emp e join emp m on e.salary>=m.salary
where m.emp_id=110
order by e.emp_id;
--oracle
select e.emp_id, e.emp_name, e.salary
from emp e , emp m
where m.emp_id=110 --행조건
and e.salary>=m.salary--조인조건
order by e.emp_id;

/* ****************************************************
아우터 조인 (Outer Join)
- 불충분 조인
    - 조인 연산시 ㅅ스테이블의 행은 다 join하고 타겟테이블의 행은 조인 조건을 만족하면 붙이고 없으면 null처리
- 종류
    왼쪽(LEFT OUTER JOIN): 구문상 소스 테이블이 왼쪽
    오른쪽(RIGHT OUTER JOIN) : 구문상 소스 테이블이 오른쪽
    전체(FULL OUTER JOIN) : 둘다 소스 테이블(오라클 조인문법은 지원 안함)
    
-ANSI 문법
from 테이블a [LEFT | RIGHT | FULL] OUTER JOIN 테이블b ON 조인조건
- OUTER는 생략 가능.

-오라클 JOIN 문법
- FROM 절에 조인할 테이블을 나열
- WHERE 절에 조인 조건을 작성
    - 타겟 테이블에 (+) 를 붙인다.
    - FULL OUTER JOIN은 지원하지 않는다.
**************************************************** */

-- 직원의 id(emp.emp_id), 이름(emp.emp_name), 급여(emp.salary), 부서명(dept.dept_name), 부서위치(dept.loc)를 조회. 
-- 부서가 없는 직원의 정보도 나오도록 조회. (부서정보는 null). dept_name의 내림차순으로 정렬한다.
select e.emp_id, e.emp_name, e.salary, d.dept_name, d.loc
from emp e left outer join dept d on e.dept_id=d.dept_id
order by d.dept_name desc;
--ORACLE문법
select e.emp_id, e.emp_name, e.salary, d.dept_name, d.loc
from emp e, dept d
where e.dept_id = d.dept_id(+);     --타겟테이블쪽에 (+)를 붙임

select d.dept_id, d.dept_name, d.loc, e.emp_name, e.hire_date
from emp e right outer join dept d on e.dept_id = d.dept_id;  --내가 보고 싶은 테이블인 dept를 전부 보기 위해 right outer join
--ORACLE문법
select d.dept_id, d.dept_name, d.loc, e.emp_name, e.hire_date
from emp e, dept d
where e.dept_id(+)=d.dept_id;

select d.dept_id, d.loc, e.emp_name, e.salary
from dept d left outer join emp e on d.dept_id=e.dept_id
where e.emp_id in(100,175,178)
or    d.dept_id in(260,270,10,60);

-- 모든 직원의 id(emp.emp_id), 이름(emp.emp_name), 부서_id(emp.dept_id)를 조회하는데
-- 부서_id가 80 인 직원들은 부서명(dept.dept_name)과 부서위치(dept.loc) 도 같이 출력한다. (부서 ID가 80이 아니면 null이 나오도록)
select  e.emp_id, e.emp_name, e.dept_id, d.dept_name, d.loc
from    emp e left outer join dept d on e.dept_id=d.dept_id and d.dept_id = 80;
--ORACLE문법
select  e.emp_id, e.emp_name, e.dept_id, d.dept_name, d.loc
from    emp e, dept d
where   e.dept_id = d.dept_id(+)    --조인연산
and     d.dept_id(+) = 80;          --조인연산

--TODO: 직원_id(emp.emp_id)가 100, 110, 120, 130, 140인 직원의 ID(emp.emp_id), 이름(emp.emp_name), 업무명(job.job_title) 을 조회. 
--      업무명이 없을 경우 '미배정' 으로 조회
select  e.emp_id, e.emp_name, nvl(j.job_title,'미배정')
from    emp e left outer join job j on e.job_id = j.job_id
where   e.emp_id in (100,110,120,130,140);
--ORACLE문법
select  e.emp_id, e.emp_name, nvl(j.job_title,'미배정')
from    emp e, job j
where   e.job_id = j.job_id(+)
and     e.emp_id in (100,110,120,130,140);
--TODO: 부서의 ID(dept.dept_id), 부서이름(dept.dept_name)과 그 부서에 속한 직원들의 수를 조회. 
--      직원이 없는 부서는 0이 나오도록 조회하고 직원수가 많은 부서 순서로 조회.
--count(*): 행수
select  d.dept_id, d.dept_name, count(e.emp_id) 직원수         --count(*)를 하면 행의 수를 세므로 직원이 없더라도 1이 나온다
from    dept d left outer join emp e on d.dept_id = e.dept_id
group by d.dept_id, d.dept_name
order by 3 desc;

select  d.dept_id, d.dept_name, e.emp_id        --count(*)를 하면 행의 수를 세므로 직원이 없더라도 1이 나온다
from    dept d left outer join emp e on d.dept_id = e.dept_id;

-- TODO: EMP 테이블에서 부서_ID(emp.dept_id)가 90 인 직원들의 id(emp.emp_id), 이름(emp.emp_name), 상사이름(emp.emp_name), 입사일(emp.hire_date)을 조회. 
-- 입사일은 yyyy-mm-dd 형식으로 출력
-- 상사가가 없는 직원은 '상사 없음' 출력
select e.emp_id, e.emp_name, nvl(m.emp_name,'상사없음')상사, to_char(e.hire_date,'yyyy-mm-dd') 입사일
from emp e left outer join emp m on e.mgr_id = m.emp_id
where e.dept_id = 90;
--ORACLR문법
select e.emp_id, e.emp_name, nvl(m.emp_name,'상사없음')상사, to_char(e.hire_date,'yyyy-mm-dd') 입사일
from emp e, emp m
where e.mgr_id = m.emp_id(+)
and   e.dept_id = 90;

--TODO 2003년~2005년 사이에 입사한 직원의 id(emp.emp_id), 이름(emp.emp_name), 업무명(job.job_title), 급여(emp.salary), 입사일(emp.hire_date),
--     상사이름(emp.emp_name), 상사의입사일(emp.hire_date), 소속부서이름(dept.dept_name), 부서위치(dept.loc)를 조회.
-- 단 상사가 없는 직원의 경우 상사이름, 상사의입사일을 null로 출력.
-- 부서가 없는 직원의 경우 null로 조회
select e.emp_id, e.emp_name,  j.job_title, e.salary, e.hire_date, m.emp_name 상사, m.hire_date 상사의입사일, d.dept_name, d.loc
from emp e left join emp m on e.mgr_id = m.emp_id
           left join dept d on e.dept_id = d.dept_id
           left join job j on e.job_id = j.job_id           
where to_char(e.hire_date,'yyyy') between 2003 and 2005;
