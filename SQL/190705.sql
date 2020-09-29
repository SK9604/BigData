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
���Ĺ��� 
���� : 0, 9, . , ',', 'L', '$'
�Ͻ� : yyyy, mm, dd, hh24, mi, ss, day(����), am �Ǵ� pm )
************************************* */





-- EMP ���̺��� ����(job)�� "CLERK"�� ���� �������� ID(emp_id), �̸�(name), ����(job), �޿�(salary)�� ��ȸ
--(�޿��� ���� ������ , �� ����ϰ� �տ� $�� �ٿ��� ���.)


-- ���ڿ� '20030503' �� 2003�� 05�� 03�� �� ���.



-- TODO: �μ���(dept_name)�� 'Finance'�� �������� ID(emp_id), �̸�(emp_name)�� �Ի�⵵(hire_date) 4�ڸ��� ����Ͻÿ�. (ex: 2004);
--to_char()


--TODO: �������� 11���� �Ի��� �������� ����ID(emp_id), �̸�(emp_name), �Ի���(hire_date)�� ��ȸ
--to_char()


--TODO: 2006�⿡ �Ի��� ��� ������ �̸�(emp_name)�� �Ի���(yyyy-mm-dd ����)�� �Ի���(hire_date)�� ������������ ��ȸ
--to_char()


--TODO: 2004�� 01�� ���� �Ի��� ���� ��ȸ�� �̸�(emp_name)�� �Ի���(hire_date) ��ȸ



-- ���ڿ� '20100107232215' �� 2010�� 01�� 07�� 23�� 22�� 15�� �� ���. (dual ���Ժ� ���)



/* *************************************
�Լ� - null ���� �Լ� 
NVL()
NVL2(expr, nn, null) - expr�� null�� �ƴϸ� nn, ���̸� ����°
nullif(ex1, ex2) ���� ������ null, �ٸ��� ex1

************************************* */

-- EMP ���̺��� ���� ID(emp_id), �̸�(emp_name), �޿�(salary), Ŀ�̼Ǻ���(comm_pct)�� ��ȸ. �� Ŀ�̼Ǻ����� NULL�� ������ 0�� ��µǵ��� �Ѵ�..


--TODO: EMP ���̺��� ������ ID(emp_id), �̸�(emp_name), ����(job), �μ�(dept_name)�� ��ȸ. �μ��� ���� ��� '�μ��̹�ġ'�� ���.


--TODO: EMP ���̺��� ������ ID(emp_id), �̸�(emp_name), �޿�(salary), Ŀ�̼� (salary * comm_pct)�� ��ȸ. Ŀ�̼��� ���� ������ 0�� ��ȸ�Ƿ� �Ѵ�.



/* *************************************
DECODE�Լ��� CASE ��
decode(�÷�, [�񱳰�, ��°�, ...] , else���) 

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
--EMP���̺��� �޿��� �޿��� ����� ��ȸ�ϴµ� �޿� ����� 10000�̻��̸� '1���', 10000�̸��̸� '2���' ���� �������� ��ȸ



--TODO: EMP ���̺��� ����(job)�� 'AD_PRES'�ų� 'FI_ACCOUNT'�ų� 'PU_CLERK'�� �������� ID(emp_id), �̸�(emp_name), ����(job)�� ��ȸ. 
-- ����(job)�� 'AD_PRES'�� '��ǥ', 'FI_ACCOUNT'�� 'ȸ��', 'PU_CLERK'�� ��� '����'�� ��µǵ��� ��ȸ


--TODO: EMP ���̺��� �μ��̸�(dept_name)�� �޿� �λ���� ��ȸ. �޿� �λ���� �μ��̸��� 'IT' �̸� �޿�(salary)�� 10%�� 'Shipping' �̸� �޿�(salary)�� 20%�� 'Finance'�̸� 30%�� �������� 0�� ���
-- decode �� case���� �̿��� ��ȸ


--TODO: EMP ���̺��� ������ ID(emp_id), �̸�(emp_name), �޿�(salary), �λ�� �޿��� ��ȸ�Ѵ�. 
--�� �޿� �λ����� �޿��� 5000 �̸��� 30%, 5000�̻� 10000 �̸��� 20% 10000 �̻��� 10% �� �Ѵ�.



--decode()/case �� �̿��� ����
-- �������� ��� ������ ��ȸ�Ѵ�. �� ������ ����(job)�� 'ST_CLERK', 'IT_PROG', 'PU_CLERK', 'SA_MAN' ������� ������������ �Ѵ�. (������ JOB�� �������)
