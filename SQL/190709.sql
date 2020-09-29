/* **************************************************************************
����(Aggregation) �Լ��� GROUP BY, HAVING
************************************************************************** */

/* ************************************************************
�����Լ�, �׷��Լ�, ������ �Լ�
- �μ�(argument)�� �÷�.
  - sum(): ��ü�հ�
  - avg(): ���
  - min(): �ּҰ�
  - max(): �ִ밪
  - stddev(): ǥ������
  - variance(): �л�
  - count(): ����
        - �μ�: 
            - �÷���: null�� ������ ����
            -  *: �� ���(null�� ����)
            - count(*)�� ������ ��� �����Լ����� null�� �����ϰ� �����Ѵ�. (avg, stddev, variance�� ����)
            - ������/DATE: max(), min(), count()
************************************************************* */

--�޿�(salary)�� ���հ�, ���, �ּҰ�, �ִ밪, ǥ������, �л�, ���������� ��ȸ 
select  sum(salary) ���հ� ,round(avg(salary),2) ���, min(salary) �ּҰ�, max(salary) �ִ밪, 
        round(stddev(salary),2) ǥ������, round(variance(salary),2) �л�,count(*)
from emp;

select  to_char(sum(salary),'$9,999,999') ���հ� ,round(avg(salary),2) ���, min(salary) �ּҰ�, max(salary) �ִ밪, 
        round(stddev(salary),2) ǥ������, round(variance(salary),2) �л�,count(*)
from emp;

-- ���� �ֱ� �Ի��ϰ� ���� ������ �Ի����� ��ȸ
select max(hire_date) "�ֱ� �Ի���", min(hire_date) "������ �Ի���" from emp;
select max(emp_name), min(emp_name) from emp; -- (MIN)����<�빮��<�ҹ���<�ѱ�(MAX)

-- emp ���̺��� job ������ ���� ��ȸ
select count(distinct job) "job�� ����"from emp;

--TODO:  Ŀ�̼� ����(comm_pct)�� �ִ� ������ ���� ��ȸ
select count(comm_pct) from emp;

--TODO: Ŀ�̼� ����(comm_pct)�� ���� ������ ���� ��ȸ
select count(*)-count(comm_pct) from emp;

select count(*) from emp where comm_pct is null;

--TODO: ���� ū Ŀ�̼Ǻ���(comm_pct)�� �� ���� ���� Ŀ�̼Ǻ����� ��ȸ
select max(comm_pct) "ūĿ�̼Ǻ���" , min(comm_pct)"���� Ŀ�̼Ǻ���" from emp;

--TODO:  Ŀ�̼� ����(comm_pct)�� ����� ��ȸ. 
--�Ҽ��� ���� 2�ڸ����� ���
select  round(avg(comm_pct),2)"Ŀ�̼����" , --comm_pct�� �ִ� ������ ���
        round(avg(nvl(comm_pct,0)),2) "���(0����)"--��ü ������ ���
from emp;

--TODO: ���� �̸�(emp_name) �� ���������� �����Ҷ� ���� ���߿� ��ġ�� �̸��� ��ȸ.
select max(emp_name) from emp;

--TODO: �޿�(salary)���� �ְ� �޿��װ� ���� �޿����� ������ ���
select max(salary)-min(salary) from emp;

--TODO: ���� �� �̸�(emp_name)�� ����� ���� ��ȸ.
select max(length(emp_name)) from emp;

--TODO: EMP ���̺��� ����(job) ������ � �ִ� ��ȸ. 
--���������� ����
select count(distinct job) from emp;

--TODO: EMP ���̺��� �μ�(dept_name)�� �������� �ִ��� ��ȸ. 
-- ���������� ����
select count(distinct dept_name) from emp;


select dept_name, sum(salary) from emp; --�� ��� sum�� ������ �̸��� �������̱� ������ ǥ�� ������ ���� �ʴ´�.
/* **************
group by ��
- select�� where�� ������ ����Ѵ�.
- Ư�� �÷�(��)�� ������ ���� ������ �� ������ �����÷��� �����ϴ� ����.
- ����: group by �÷��� [, �÷���]
- �÷�: �з���(������, �����) - �μ��� �޿� ���, ���� �޿� �հ�
- select������ group by���� ������ �÷��鸸 �����Լ��� ���� �� �� �ִ�.
****************/

-- ����(job)�� �޿��� ���հ�, ���, �ּҰ�, �ִ밪, ǥ������, �л�, �������� ��ȸ
select  job, sum(salary), round(avg(salary),2), min(salary), max(salary), 
        round(stddev(salary),2), round(variance(salary),2), count(*) from emp
group by job;

-- �Ի翬�� �� �������� �޿� ���.
select to_char(hire_date,'yyyy') "�Ի翬��",round(avg(salary),2)"���" from emp
group by to_char(hire_date,'yyyy')
order by 1;


-- �޿�(salary) ������ �������� ���. �޿� ������ 10000 �̸�,  10000�̻� �� ����.
select  case    when salary>=10000 then '1000�̻�'
                else '10000�̸�' end "���", count(*) ������ from emp
group by case   when salary>=10000 then '1000�̻�'
                else '10000�̸�' end;

select dept_name,job, sum(salary) from emp --�����з��� ���� �����ִ� ���� ���⿡ ���ϴ�
group by job, dept_name
order by 1;

--TODO: �μ���(dept_name) �������� ��ȸ
select dept_name, count(*)"������" from emp
group by dept_name;

--TODO: ������(job) �������� ��ȸ. �������� ���� �ͺ��� ����.
select job, count(*)"������" from emp
group by job
order by 2 desc;

--TODO: �μ���(dept_name), ����(job)�� ������, �ְ�޿�(salary)�� ��ȸ. �μ��̸����� �������� ����.
select dept_name, job, count(*) "������", max(salary)"�ְ� �޿�" from emp
group by dept_name, job
order by 1;

--TODO: EMP ���̺��� �Ի翬����(hire_date) �� �޿�(salary)�� �հ��� ��ȸ. 
--(�޿� �հ�� �ڸ������� , �� �����ÿ�. ex: 2,000,000)
select to_char(hire_date,'yyyy') �Ի翬��, to_char(sum(salary), '9,999,999') from emp
group by to_char(hire_date,'yyyy');

--TODO: ����(job)�� �Ի�⵵(hire_date)�� ��� �޿�(salary)�� ��ȸ
--to_char�̿�
select job, to_char(hire_date,'yyyy')"�Ի�⵵", ceil(avg(salary)) "��ձ޿�" from emp
group by job, to_char(hire_date,'yyyy');
--extract�̿�
select job, extract(year from hire_date) "�Ի�⵵", round(avg(salary),2) "��ձ޿�" from emp
group by job, extract(year from hire_date);

--TODO: �μ���(dept_name) ������ ��ȸ�ϴµ� �μ���(dept_name)�� null�� ���� �����ϰ� ��ȸ.
select dept_name, count(*) ������ from emp
where dept_name is not null
group by dept_name;

--TODO �޿� ������ �������� ���. �޿� ������ 5000 �̸�, 5000�̻� 10000 �̸�, 10000�̻� 20000�̸�, 20000�̻�. 
select case when salary<5000 then '5000�̸�'
            when salary<10000 then '5000�̻� 10000�̸�'
            when salary<20000 then '10000�̻� 20000�̸�'
            when salary>=20000 then '20000�̻�' end "�޿� ����" ,count(*)"������"
from emp
group by case when salary<5000 then '5000�̸�'
              when salary<10000 then '5000�̻� 10000�̸�'
              when salary<20000 then '10000�̻� 20000�̸�'
              when salary>=20000 then '20000�̻�' end
order by decode("�޿� ����", '5000�̸�', 1, '5000�̻� 10000�̸�',2,'10000�̻� 20000�̸�',3,4) ;

/* **************************************************************
having ��
- �������� ���� �� ���� ����
- group by ���� order by ���� �´�.
- ����
    having �������� : �����ڴ� where���� �����ڸ� ����Ѵ�. �ǿ����ڴ� �����Լ��� ���
************************************************************** */
-- �������� 10 �̻��� �μ��� �μ���(dept_name)�� �������� ��ȸ
select dept_name, count(*) ������ from emp
group by dept_name
having count(*)>=10; 
--having ������ >= 10;

--TODO: 15�� �̻��� �Ի��� �⵵�� (�� �ؿ�) �Ի��� �������� ��ȸ.
select extract(year from hire_date) �Ի�⵵, count(*) from emp
group by extract(year from hire_date)
having count(*)>=15;

--TODO: �� ����(job)�� ����ϴ� ������ ���� 10�� �̻��� ����(job)��� ��� �������� ��ȸ
select job, count(*) from emp
group by job
having count(*)>=10;

--TODO: ��� �޿���(salary) $5000�̻��� �μ��� �̸�(dept_name)�� ��� �޿�(salary), �������� ��ȸ
select dept_name, round(avg(salary),2) ��ձ޿�, count(*) ������ from emp
group by dept_name
having avg(salary)>=5000;

--TODO: ��ձ޿��� $5,000 �̻��̰� �ѱ޿��� $50,000 �̻��� �μ��� �μ���(dept_name), ��ձ޿��� �ѱ޿��� ��ȸ
select dept_name, round(avg(salary),2) ��ձ޿�, sum(salary) �ѱ޿� from emp
group by dept_name
having avg(salary)>=5000 and sum(salary)>=50000;

-- TODO ������ 2�� �̻��� �μ����� �̸��� �޿��� ǥ�������� ��ȸ
select dept_name, round(stddev(salary),2) �޿�ǥ������ from emp
group by dept_name
having count(*)>=2;

/* **************************************************************
group by �� Ȯ�� : rollup �� cube
- rollup(): group by�� Ȯ��
    -�߰�����, �����踦 group �� �κ����迡 �߰��ؼ� ������ �� �� ���
    -���� : group by (�÷��� [, �÷���])
- cube(): rollup�� Ȯ��
    -group by ���� �÷��� ��� ������ ��� ����.
    -�׷����� ���� �÷��� �ΰ� �̻��� �� ���.
grouping(), grouping_id() �Լ�
-grouping(): group by���� rollup�̳� cube�� ���� �÷��� ����� ���� ������ 0,
                �������� �ʾ����� 1�� ��ȯ�Ѵ�.
    - select ������ ���
    - ����: grouping(group by���� ����� �÷��� 1��)
-grouping_id():
    - ����: grouping_id(group by���� ����� �÷��� [,�÷���,..])
************************************************************** */
/*
group by rollup(job)
    1. job�� ����
    2. job�� �����ϰ� ����
    
group by rollup(dept_name, job)     �Ʒ� ������ ����
    1. (dept_name,job) ����
    2. (dept_name) ����
    3. () ��ü����
*/
/*
group by cube(dept_name, job)       ��� ����� ���� ���� ����
    ( )
    (dept_name)
    (job)
    (dept_name, job)
*/
-- EMP ���̺��� ����(job) �� �޿�(salary)�� ��հ� ����� �Ѱ赵 ���̳������� ��ȸ.
select job,ceil(avg(salary)) ��ձ޿�
from emp
group by rollup(job);

select job,ceil(avg(salary)) ��ձ޿�
from emp
group by cube(job);

select  decode(grouping_id(dept_name),0,dept_name, 1, '�����'),--dept_name�� �׷����� ���� �� ���� ���ΰ�(T:0 F:1)
        ceil(avg(salary)) ��ձ޿�
from    emp
group by rollup(dept_name);

-- EMP ���̺��� ����(JOB) �� �޿�(salary)�� ��հ� ����� �Ѱ赵 ���̳������� ��ȸ.
-- ���� �÷���  �Ұ質 �Ѱ��̸� '�����'��  �Ϲ� �����̸� ����(job)�� ���
select decode(grouping_id(job),0,job,'�����'), ceil(avg(salary)) ��ձ޿� from emp
group by rollup(job);

-- EMP ���̺��� �μ�(dept_name), ����(job) �� salary�� �հ�� �������� �Ұ�� �Ѱ谡 �������� ��ȸ
select dept_name, job, sum(salary) �ѱ޿�, count(*) ������ from emp
group by rollup(dept_name, job);
--grouping����
select  decode(grouping_id(dept_name),0,dept_name,'������') dept_name, 
        decode(grouping_id(job),0,job,'�߰�����') job, sum(salary) �ѱ޿�, 
        count(*) ������ from emp
group by rollup(dept_name, job);

select dept_name, job, sum(salary) �ѱ޿�, count(*) ������ from emp
group by cube(dept_name, job);

--# �Ѱ�/�Ұ� ���� ��� :  �Ѱ�� '�Ѱ�', �߰������ '��' �� ���
--TODO: �μ���(dept_name) �� �ִ� salary�� �ּ� salary�� ��ȸ
select dept_name, max(salary), min(salary) from emp
group by dept_name;

--TODO: ���_id(mgr_id) �� ������ ���� �Ѱ踦 ��ȸ�Ͻÿ�.
select decode(grouping_id(mgr_id),0,to_char(mgr_id),'�Ѱ�')mgr_id ,count(*) ������ from emp  
--decode(grouping_id(mgr_id),1,'�Ѱ�',mgr_id) : ó�� ��ȯ������ �÷��� ���������� ��ȯ�ȴ�. ���� '�Ѱ�'�� ���ڿ� Ÿ������ �����Ǿ� ���ڵ� ���ڿ��� ��ȯ�Ǿ� ����ȴ�.
--decode(grouping_id(mgr_id),0,mgr_id,'�Ѱ�') : ���� �޸� ù ��ȯ���� mgr_id, �� �������̱� ������ ���߿� ���ڿ� Ÿ���� '�Ѱ�'�� �� �� ����.
--���� �ݵ�� ���ڿ��� ���� �������� �����ؾ��Ѵ�.
group by rollup(mgr_id);

--TODO: �Ի翬��(hire_date�� year)�� �������� ���� ���� �հ� �׸��� �Ѱ谡 ���� ��µǵ��� ��ȸ.
select decode(grouping_id(to_char(hire_date,'yyyy')),0,to_char(hire_date,'yyyy'),'�Ѱ�') hire_date, count(*) ������ , sum(salary) �����հ� from emp
group by rollup(to_char(hire_date,'yyyy'));

--TODO: �μ���(dept_name), �Ի�⵵�� ��� �޿�(salary) ��ȸ. �μ��� ����� �����谡 ���� �������� ��ȸ
select decode(grouping_id(dept_name),0,dept_name,'�Ѱ�')dept_name, decode(grouping_id(to_char(hire_date,'yyyy')),0,to_char(hire_date,'yyyy'),'��')to_char, ceil(avg(salary)) from emp
group by rollup(dept_name,to_char(hire_date,'yyyy'));

select  grouping_id(dept_name)a,                            --group by���� ���������� 0 �ƴϸ� 1��ȯ
        grouping_id(to_char(hire_date,'yyyy'))b,            --group by���� ���������� 0 �ƴϸ� 1��ȯ
        grouping_id(dept_name, to_char(hire_date,'yyyy'))c, --�ΰ����� 2������ �����Ͽ� 10������ ��ȯ(11:3, 01:1)
        round(avg(salary))
from    emp
group by rollup(dept_name, to_char(hire_date,'yyyy'));

