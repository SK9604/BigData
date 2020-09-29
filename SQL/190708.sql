select salary from emp;

--������
select round(salary/comm_pct,1) from emp
where comm_pct is not null;

--������(����)
select sum(salary) from emp;
select round(avg(salary),2) from emp;

/* *************************************
�Լ� - ���ڿ����� �Լ�
 UPPER()/ LOWER() : �빮��/�ҹ��� �� ��ȯ
 INITCAP(): �ܾ� ù���ڸ� �빮�� ������ �ҹ��ڷ� ��ȯ
 LENGTH() : ���ڼ� ��ȸ
 LPAD(��, ũ��, ä�ﰪ) : "��"�� ������ "ũ��"�� �������� ���ڿ��� ����� ���ڶ�� ���� ���ʺ��� "ä�ﰪ"���� ä���.
 RPAD(��, ũ��, ä�ﰪ) : "��"�� ������ "ũ��"�� �������� ���ڿ��� ����� ���ڶ�� ���� �����ʺ��� "ä�ﰪ"���� ä���.
 SUBSTR(��, ����index, ���ڼ�) - "��"���� "����index"��° ���ں��� ������ "���ڼ�" ��ŭ�� ���ڿ��� ����. ���ڼ� ������ ������. 
 REPLACE(��, ã�����ڿ�, �����ҹ��ڿ�) - "��"���� "ã�����ڿ�"�� "�����ҹ��ڿ�"�� �ٲ۴�.
 LTRIM(��): �ް��� ����
 RTRIM(��): �������� ����
 TRIM(��): ���� ���� ����
 ************************************* */

select upper('abc'),lower('ABC'),initcap('abc def_ghi') from dual;
select length('alala'), length('������') from dual;
select * from emp where length(emp_name)>7;
select lpad('test',10,'-') from dual; --'-'������ �������� ä��
select rpad('test',10,'-') from dual;
select rpad('testtest',5,'-') from dual; --���ºκ� �������� �ڸ�
select lpad('testtest',5,'-') from dual;
select substr('123456789',5,2) from dual; --5��° ���ں��� �α��ڸ� �ڸ�
select replace('A--B--C','-','#') from dual; -- '-'�� '#'���� �ٲ�
select '   hello   ' o,trim('  hello  ') b,ltrim('  hello  ') l, rtrim('  hello  ') r from dual; --������ ����
select length(trim('   aaa   ')) a from dual; --�Լ��ȿ��� �Լ��� ȣ���ϴ� ���: ���� �Լ��� ���� �����ϰ� �� ����� �־� �ٱ��� �Լ� ����.



--EMP ���̺��� ������ �̸�(emp_name)�� ��� �빮��, �ҹ���, ù���� �빮��, �̸� ���ڼ��� ��ȸ
select upper(emp_name) �빮���̸�, lower(emp_name)�ҹ����̸�, initcap(emp_name)ù���ڴ빮��, length(emp_name)���ڼ� from emp;

-- TODO: EMP ���̺��� ������ ID(emp_id), �̸�(emp_name), �޿�(salary), �μ�(dept_name)�� ��ȸ. �� �����̸�(emp_name)�� ��� �빮��, �μ�(dept_name)�� ��� �ҹ��ڷ� ���.
-- UPPER/LOWER
select emp_id, upper(emp_name), salary, lower(dept_name) from emp;

--(�Ʒ� 2���� �񱳰��� ��ҹ��ڸ� Ȯ���� �𸣴� ����)
--TODO: EMP ���̺��� ������ �̸�(emp_name)�� PETER�� ������ ��� ������ ��ȸ�Ͻÿ�.
select * from emp
where upper(emp_name)='PETER';

--TODO: EMP ���̺��� ����(job)�� 'Sh_Clerk' �� ��������  ID(emp_id), �̸�(emp_name), ����(job), �޿�(salary)�� ��ȸ
select emp_id, emp_name, job, salary from emp
where initcap(job)='Sh_Clerk';

--TODO: ���� �̸�(emp_name) �� �ڸ����� 15�ڸ��� ���߰� ���ڼ��� ���ڶ� ��� ������ �տ� �ٿ� ��ȸ. ���� �µ��� ��ȸ
select lpad(emp_name,15, ' ') a from emp;-- lpad(emp_name,15) ������� ����
    
--TODO: EMP ���̺��� ��� ������ �̸�(emp_name)�� �޿�(salary)�� ��ȸ.
--(��, "�޿�(salary)" ���� ���̰� 7�� ���ڿ��� �����, ���̰� 7�� �ȵ� ��� ���ʺ��� �� ĭ�� '_'�� ä��ÿ�. EX) ______5000) -LPAD() �̿�
select emp_name, lpad(salary,7,'_') salary from emp;

-- TODO: EMP ���̺��� �̸�(emp_name)�� 10���� �̻��� �������� �̸�(emp_name)�� �̸��� ���ڼ� ��ȸ
select emp_name, length(emp_name) from emp
where length(emp_name)>=10;

/* *************************************
�Լ� - ���ڰ��� �Լ�
 round(��, �ڸ���) : �ڸ������� �ݿø� (��� - �Ǽ���, ���� - ������)
 trunc(��, �ڸ���) : �ڸ������� ����(��� - �Ǽ���, ���� - ������)
 ceil(��) : �ø�, ����
 floor(��) : ����, ����
 mod(�����¼�, �����¼�) : �������� ������ ����
************************************* */

select 50.123, round(50.128,2)�ݿø�, ceil(50.128) �ø�, floor(50.128)����, trunc(50.128,2)���� from dual;
select  round(12345,-1), --10���� ���Ͽ��� �ݿø�
        round(12378, -2) from dual; --100���� ���Ͽ��� �ݿø�
-- �ڸ��� : 0(�ܴ���-�⺻��), ���� > �Ǽ���, ���>������
select  trunc(1234.56,-2),
        trunc(1234.56,-1),
        trunc(1234.56,0),
        trunc(1234.56,1),
        trunc(1234.56,2)
from dual;
select mod(10,3) from dual; --10/3�� ������

--TODO: EMP ���̺��� �� ������ ���� ����ID(emp_id), �̸�(emp_name), �޿�(salary) �׸��� 15% �λ�� �޿�(salary)�� ��ȸ�ϴ� ���Ǹ� �ۼ��Ͻÿ�.
--(��, 15% �λ�� �޿��� �ø��ؼ� ������ ǥ���ϰ�, ��Ī�� "SAL_RAISE"�� ����.)
select emp_id, emp_name, salary, ceil(salary*1.15) SAL_RAISE from emp;

--TODO: ���� SQL������ �λ� �޿�(sal_raise)�� �޿�(salary) ���� ������ �߰��� ��ȸ (����ID(emp_id), �̸�(emp_name), 15% �λ�޿�, �λ�� �޿��� ���� �޿�(salary)�� ����)
select emp_id, emp_name, salary, ceil(salary*1.15) SAL_RAISE, ceil(salary*1.15)-salary from emp;

-- TODO: EMP ���̺��� Ŀ�̼��� �ִ� �������� ����_ID(emp_id), �̸�(emp_name), Ŀ�̼Ǻ���(comm_pct), Ŀ�̼Ǻ���(comm_pct)�� 8% �λ��� ����� ��ȸ.
--(�� Ŀ�̼��� 8% �λ��� ����� �Ҽ��� ���� 2�ڸ����� �ݿø��ϰ� ��Ī�� comm_raise�� ����)
select emp_id, emp_name, comm_pct, round(comm_pct*1.08,2) comm_raise from emp where comm_pct is not null;

/* *************************************
�Լ� - ��¥���� ��� �� �Լ�
Date +- ���� : ��¥ ���.
sysdate : ���� �ý��� �ð��� �ҷ���(��������� �Ͻ�) dateŸ������ ����
systimestamp: ��������� �Ͻ�. timestampŸ������ ����(�и��ʱ���)
months_between(d1, d2) -����� ������(d1�� �ֱ�, d2�� ����)
add_months(d1, ����) - �������� ���� ��¥. ������ ��¥�� 1���� �Ĵ� ���� ������ ���� �ȴ�. 
next_day(d1, '�ݿ���') - d1���� ù��° �ݿ����� ��¥. ������ �ѱ�(locale)�� �����Ѵ�.
last_day(d) - d ���� ��������.
extract(year|month|day from date) - date���� year/month/day�� ����
************************************* */

select sysdate from dual;
select to_char(sysdate, 'yyyy/mm/dd hh24:mi:ss') from dual;
select sysdate -10, sysdate+10 from dual;
select add_months(sysdate, 10), add_months(sysdate,-10), add_months(sysdate, 12*3) from dual;
select months_between(sysdate, '2015-07-05') , months_between(sysdate, '2015-07-01') from dual;
select next_day('&year-&month-01', '�ݿ���') from dual;
select last_day(sysdate) from dual;
select extract(year from hire_date), extract(month from hire_date), extract(day from hire_date) from emp;

select *from emp where extract(year from hire_date)=2004;

--TODO: EMP ���̺��� �μ��̸�(dept_name)�� 'IT'�� �������� '�Ի���(hire_date)�� ���� 10����', �Ի��ϰ� '�Ի��Ϸ� ���� 10����',  �� ��¥�� ��ȸ. 
select hire_date-10,hire_date,hire_date+10 from emp where dept_name='IT';

--TODO: �μ��� 'Purchasing' �� ������ �̸�(emp_name), �Ի� 6�������� �Ի���(hire_date), 6������ ��¥�� ��ȸ.
select emp_name, add_months(hire_date,-6), hire_date, add_months(hire_date, 6) from emp where dept_name='Purchasing';     

--TODO: EMP ���̺��� �Ի��ϰ� �Ի��� 2�� ��, �Ի��� 2�� �� ��¥�� ��ȸ.
select hire_date, add_months(hire_date,2), add_months(hire_date,-2) from emp;

-- TODO: �� ������ �̸�(emp_name), �ٹ� ������ (�Ի��Ͽ��� ��������� �� ��)�� ����Ͽ� ��ȸ.
--(�� �ٹ� �������� �Ǽ� �� ��� ������ �ݿø�. �ٹ������� ������������ ����.)
select emp_name, round(months_between(sysdate, hire_date))||'����' from emp order by 2 desc;

--TODO: ���� ID(emp_id)�� 100 �� ������ �Ի��� ���� ù��° �ݿ����� ��¥�� ���Ͻÿ�.
select next_day(hire_date, '�ݿ���') from emp where emp_id=100;

/* *************************************
�Լ� - ��ȯ �Լ�
to_char() : ������, ��¥���� ���������� ��ȯ
to_number() : �������� ���������� ��ȯ 
to_date() : �������� ��¥������ ��ȯ

-����: �Լ�(��ȯ���, ����)
-to_char()�� ����: ��ȯ ó�� ����� ����(�������)
-to_number()/to_date(): ��ȯ�� ����� ����

����(format)����
���� : 0(���� �ڸ� 0ó��), 9(���� �ڸ� ����ó��) ex) 533> 0000> 0533, 546>9999>546
      fm���� �����ϸ� 9�ϰ�� ������ ����,
      '.'(����/�Ǽ��� ������) , ','(������ ����������), 
      'L'(������ȭ��ȣ), '$'(��ȭǥ��)
�Ͻ� : yyyy(���� 4�ڸ�, yy:���� 2�ڸ�(2000���)), 
      rr(���� 2�ڸ�(50�̻�:90���, 50�̸�:2000���)),
      mm(�� 2�ڸ�), ex) 04,11
      dd(�� 2�ڸ�), 
      hh24(�ð� 00~23 2�ڸ�), hh(01~12)
      mi, (�� 2�ڸ�)
      ss, (�� 2�ڸ�)
      day(����), 
      am �Ǵ� pm (����/����)
************************************* */

select '10' + 10 from dual; --oracle���� ���� �� �� �˾Ƽ� ���ڿ��� ���ڷ� �ٲ� ('10'+10>>10+10)
select to_date('10','yy') - 10 from dual; --���� ��� ������ 10�⵵���� 10���� �� ���� ���� ���� �� 10�� �Ἥ�� ����� ó���� �ȵǱ� ������ ���� �˷�����Ѵ�.
select to_number('2,900','0,000') from dual;
select to_char(1234567,'9,999,999')c, 
       to_char(12345,'9,999,999')a,
       to_char(12345,'fm9,999,999')b ,
       to_char(1234567,'9,999') d ,--���Ĺ������� �ڸ����� ������ ũ�ų� ���ƾ��Ѵ�. ������ #���� ���´�.
       to_char(12345.6789,'99999.99') e ,--�ݿø�
       to_char(5000,'$9,999')f, --�޷�ǥ��
       to_char(5000,'L9,999')g, --������ȭ��ȣ
       to_char(5000,'9,999')||'��'h --��ȯ�Լ�����format���ڸ� ��� ����
       --���ڴ� ���Ĺ��ڿ����� ���Ĺ��ڸ� ������ ���� ��� ����.
from dual; --fm���� ���� ����
select to_number('4,000','9,999') +10 a,
       to_number('$5,000','$9,999')+50 b
from dual;

select sysdate, 
       to_char(sysdate) a,
       to_char(sysdate,'yyyy') b,
       to_char(sysdate,'yy') c,
       to_char(sysdate,'mm') d,
       to_char(sysdate, 'yyyy-mm-dd') e
from dual;

select to_char(sysdate,'hh24') a,
       to_char(sysdate,'hh')b,
       to_char(sysdate,'hh24:mi:ss') c,
       to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') d,
       to_char(sysdate, 'hh am pm') e, --am�̳� pm�̳� ���� �������� �������� Ȯ���Ѵ�.
       to_char(sysdate, 'mm-dd day') f
from dual;

--date ���� ���Ĺ��ڸ� ������ ���ڿ��� " " �� ���μ� �־��� �� �ִ�.
select to_char(sysdate,'yyyy"��"')a,
       to_char(sysdate,'yyyy"��" mm"��" dd"��" hh24"��" mi"��" ss"��"')b
from dual;

select to_char(sysdate, 'w') ���°��,
       to_char(sysdate,'ww') �ϳ��߸��°��,
       to_char(sysdate,'q') "4�б� �� ���°�б�", --1�б�:1~3, 2�б�:4~6, 3�б�:7~9, 4�б�:10~12
       to_char(sysdate,'d') "������ ���ڷ� ��ȯ" --��:1 ��:2 ȭ:3~ ��:7
from dual;

select to_date('20191010','yyyymmdd')-10,
       to_date('201905','yyyymm') --default�� ù��° ��(�Ͻú���01 00 00 00)
from dual;

-- EMP ���̺��� ����(job)�� "CLERK"�� ���� �������� ID(emp_id), �̸�(name), ����(job), �޿�(salary)�� ��ȸ
--(�޿��� ���� ������ , �� ����ϰ� �տ� $�� �ٿ��� ���.)
select emp_id, emp_name, job, to_char(salary,'fm$99,999.99') salary, salary
from emp
where job like '%CLERK%';

-- ���ڿ� '20030503' �� 2003�� 05�� 03�� �� ���.
-->char->char; char->date->char
select to_char(to_date('20030503','yyyymmdd'),'yyyy"��" mm"��" dd"��"') a
from dual;


-- TODO: �μ���(dept_name)�� 'Finance'�� �������� ID(emp_id), �̸�(emp_name)�� �Ի�⵵(hire_date) 4�ڸ��� ����Ͻÿ�. (ex: 2004);
--to_char()
select emp_id, emp_name, to_char(hire_date, 'yyyy')�Ի�⵵ from emp where dept_name='Finance';

--TODO: �������� 11���� �Ի��� �������� ����ID(emp_id), �̸�(emp_name), �Ի���(hire_date)�� ��ȸ
--to_char()
select emp_id, emp_name, hire_date
from emp
where to_char(hire_date,'mm')='11';
--where extract(month from hire_date)='11';

--TODO: 2006�⿡ �Ի��� ��� ������ �̸�(emp_name)�� �Ի���(yyyy-mm-dd ����)�� �Ի���(hire_date)�� ������������ ��ȸ
--to_char()
select emp_name, to_char(hire_date, 'yyyy-mm-dd') hire_date from emp where to_char(hire_date,'yyyy')='2006' order by hire_date;

--TODO: 2004�� 01�� ���� �Ի��� ���� ��ȸ�� �̸�(emp_name)�� �Ի���(hire_date) ��ȸ
select emp_name, hire_date from emp 
where hire_date >= to_date('200401','yyyymm')
--where to_char(hire_date, 'yyyymm')>='200401')
order by 2;

--TODO: ���ڿ� '20100107232215' �� 2010�� 01�� 07�� 23�� 22�� 15�� �� ���. (dual ���Ժ� ���)
select to_char(to_date('20100107232215' ,'yyyymmddhh24miss'),'yyyy"��" mm"��" dd"��" hh24"��" mi"��" ss"��"')
from dual;

/* *************************************
�Լ� - null ���� �Լ� 
NVL(expr1, expr2) : expr1-���� �ƴϸ� expr1��ȯ ���̸� expr2��ȯ
NVL2(expr, nn, null) : expr�� null�� �ƴϸ� nn, ���̸� ����°
nullif(ex1, ex2) : ���� ������ null, �ٸ��� ex1
coalesce(ex1,ex2,ex3,...) ex1~exn �� null�� �ƴ� ù��° �� ��ȯ.
************************************* */

select nvl(10,0),nvl(null,70) from dual; --�տ��� null�� ��� �ڿ���
select nvl2(10,1,0), nvl2(null,1,0) from dual;
select nullif(10,10), nullif(10,20) from dual; --������ null �ƴϸ� ù��°��
select coalesce(null, null, 10, null,23) from dual;

select emp_id, comm_pct, mgr_id, dept_name ,
       coalesce(comm_pct, mgr_id) "notnull" --�� �÷��� ���� ������ Ÿ���� ���ƾ��Ѵ�. coalesce(comm_pct, mgr_id, dept_name)�� ����
from emp
where emp_id in(150, 100, 101);

-- EMP ���̺��� ���� ID(emp_id), �̸�(emp_name), �޿�(salary), Ŀ�̼Ǻ���(comm_pct)�� ��ȸ. �� Ŀ�̼Ǻ����� NULL�� ������ 0�� ��µǵ��� �Ѵ�..
select emp_id, emp_name, salary, nvl(comm_pct,0), nvl2(comm_pct*salary,'Ŀ�̼�����','Ŀ�̼Ǿ���')"Ŀ�̼�����"
from emp;

--TODO: EMP ���̺��� ������ ID(emp_id), �̸�(emp_name), ����(job), �μ�(dept_name)�� ��ȸ. �μ��� ���� ��� '�μ��̹�ġ'�� ���.
select emp_id, emp_name, job, nvl(dept_name,'�μ��̹�ġ') from emp;

--TODO: EMP ���̺��� ������ ID(emp_id), �̸�(emp_name), �޿�(salary), Ŀ�̼� (salary * comm_pct)�� ��ȸ. Ŀ�̼��� ���� ������ 0�� ��ȸ�Ƿ� �Ѵ�.
select emp_id, emp_name, salary, to_char(nvl(salary*comm_pct,0),'$9,999') commition from emp;
/*
nvl(10,0)
if 10 �� null�� �ƴϸ�
then 10
else 0

nvl2(10,1,0)
if 10 �� null�� �ƴϸ�
then 1
else 0
*/
/* *************************************
DECODE�Լ��� CASE ��
decode(�÷�, [�񱳰�, ��°�, ...] , else���) 
ex) decode(emp_id,100,'a',200,'b',300,'c','d') => emp_id�� 100�̸� a, 200�̸� b 300�̸� c �ƹ��͵� �ƴϸ� d (d�� ���� ������ null��ȯ)
case�� �����
case �÷� when �񱳰� then ��°�
              [when �񱳰� then ��°�]
              [else ��°�]
              end
              
case�� ���ǹ�
case when ���� then ��°�
       [when ���� then ��°�]
       [else ��°�]
       end

************************************* */

select decode(dept_name, null, '�μ�����') from emp where dept_name is null;
select  case dept_name when null then '�μ�����' end a,
        case when dept_name is null then '�μ�����' end b from emp where dept_name is null; 
        --null�� ��� �ݵ�� ����񱳰� �ƴ� �������� is null�� ����ؾ��Ѵ�.

--EMP���̺��� �޿��� �޿��� ����� ��ȸ�ϴµ� �޿� ����� 10000�̻��̸� '1���', 10000�̸��̸� '2���' ���� �������� ��ȸ
select salary, case when salary>=10000 then '1���'
                    else '2���'
                    end ���
from emp
order by 1;


--TODO: EMP ���̺��� ����(job)�� 'AD_PRES'�ų� 'FI_ACCOUNT'�ų� 'PU_CLERK'�� �������� ID(emp_id), �̸�(emp_name), ����(job)�� ��ȸ. 
-- ����(job)�� 'AD_PRES'�� '��ǥ', 'FI_ACCOUNT'�� 'ȸ��', 'PU_CLERK'�� ��� '����'�� ��µǵ��� ��ȸ
--decode��
select emp_id, emp_name, decode(job,'AD_PRES','��ǥ',
                                    'FI_ACCOUNT','ȸ��',
                                    'PU_CLERK','����','��Ÿ') job, job
from emp
where job in ('AD_PRES','FI_ACCOUNT','PU_CLERK','IT_PROG');
--case��
select emp_id, emp_name,    case job    when 'AD_PRES' then '��ǥ'
                                        when 'FI_ACCOUNT' then 'ȸ��'
                                        when 'PU_CLERK' then '����'
                                        else '��Ÿ' 
                            end job2, job
from emp
where job in ('AD_PRES','FI_ACCOUNT','PU_CLERK','IT_PROG');
--TODO: EMP ���̺��� �μ��̸�(dept_name)�� �޿� �λ���� ��ȸ. �޿� �λ���� �μ��̸��� 'IT' �̸� �޿�(salary)�� 10%�� 'Shipping' �̸� �޿�(salary)�� 20%�� 'Finance'�̸� 30%�� �������� 0�� ���
-- decode �� case���� �̿��� ��ȸ
--decode��
select dept_name, decode(dept_name, 'IT', salary*0.1, 'Shipping', salary*0.2, 'Finance', salary*0.3,0) "�޿� �λ��"
from emp;
--case��
select dept_name, case dept_name when 'IT' then salary*0.1
                                 when 'Shipping' then salary*0.2
                                 when 'Finance' then salary*0.3
                                 else 0 end "�޿� �λ��"
from emp;
--TODO: EMP ���̺��� ������ ID(emp_id), �̸�(emp_name), �޿�(salary), �λ�� �޿��� ��ȸ�Ѵ�. 
--�� �޿� �λ����� �޿��� 5000 �̸��� 30%, 5000�̻� 10000 �̸��� 20% 10000 �̻��� 10% �� �Ѵ�.
select  emp_id, emp_name, salary,
        case when salary<5000 then salary*0.3
             when salary<10000 then salary*0.2
             else salary*0.1 end "�λ�� �޿�"
from emp;

--decode()/case �� �̿��� ����
-- �������� ��� ������ ��ȸ�Ѵ�. �� ������ ����(job)�� 'ST_CLERK', 'IT_PROG', 'PU_CLERK', 'SA_MAN' ������� ������������ �Ѵ�. (������ JOB�� �������)

select * from emp
order by decode(job, 'ST_CLERK',1,
                     'IT_PROG',2,
                     'PU_CLERK', 3,
                     'SA_MAN',4,9999),salary desc;

select * from emp
order by case job when 'ST_CLERK' then 1
                  when 'IT_PROG' then 2
                  when 'PU_CLERK' then 3
                  when 'SA_MAN' then 4
                  else 9999 end;
