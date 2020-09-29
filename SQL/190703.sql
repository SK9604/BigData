-- 주석
/*
블럭주석(여러줄 주석)
*/
/*
테이블: customer
컬럼: id: varchar2(10)
     name: nvarchar2(10)
     age: number(3) 백단위까지만
     gender: char(1) 여성: F, 남성: M
     join_date: Date
*/
create table customer(
    id varchar(10),
    name nvarchar2(10),
    age number(3),
    gender char(1),
    join_date date
);
--실행: ctrl+enter

/*
테이블에 한 행의 데이터 추가
insert into 테이블이름 (컬럼명, 컬럼명,...) values (값, 값,...);
모든 컬럼에 값을 넣을 경우 컬럼 지정은 생략가능
*/
insert into customer (id, name, age, gender, join_date) values ('my-id','김선경',24,'F','2019-07-03');
insert into customer (id, name, age) values('my-id2','김진희',22);
--gender, join_date => null
--조회
select * from customer;
--테이블 제거 : drop table 테이블 이름
drop table customer;

create table customer(
    id varchar(10) primary key,--기본키 컬럼(not null의 의미를 포함함)
    name nvarchar2(10) not null,--반드시 들어가야하는 값. null을 가질 수 없는 컬럼
    age number(3) not null,
    gender char(1),
    join_date date
);

insert into customer values ('my-id','김선경',24,'F','2019-07-03');
insert into customer (id) values ('my-id2');--not null문제 발생
insert into customer(id,name, age) values ('my-id3','김진희',22);


