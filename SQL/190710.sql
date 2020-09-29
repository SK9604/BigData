create user scott_join identified by tiger;
grant all privileges to scott_join;


/* ****************************************
����(JOIN) �̶�
- 2�� �̻��� ���̺� �ִ� �÷����� ���ļ� ������ ���̺��� ����� ��ȸ�ϴ� ����� ���Ѵ�.
 	- �ҽ����̺� : ���� ���� �о�� �Ѵٰ� �����ϴ� ���̺� (emp)
	- Ÿ�����̺� : �ҽ��� ���� �� �ҽ��� ������ ����� �Ǵ� ���̺� (dept)
 
- �� ���̺��� ��� ��ĥ���� ǥ���ϴ� ���� ���� �����̶�� �Ѵ�.
    - ���� ���꿡 ���� ��������
        - Equi join(PK=FK) , non-equi join(FK>=PK �� ���� ����)
        
- ������ ����
    - Inner Join (�ҽ����̺��� FK�� �Ǵ� �÷��� null�� �ƴ� �ุ ����)
        - ���� ���̺��� ���� ������ �����ϴ� ��鸸 ��ģ��. 
    - Outer Join (�ҽ����̺��� FK�� �Ǵ� �÷��� null�̾ ���� �÷��� ���� �� ���·� ����)
        - ���� ���̺��� ����� ��� ����ϰ� �ٸ� �� ���̺��� ���� ������ �����ϴ� �ุ ��ģ��. ���������� �����ϴ� ���� ���� ��� NULL�� ��ģ��.
        - ���� : Left Outer Join(���� �ҽ����̺� ������ Ÿ�����̺�),  Right Outer Join(������ �ҽ����̺� ���� Ÿ�����̺�), Full Outer Join
    - Cross Join (� ���� ��ĥ ������ ������� ����(ex. dept.dept_id=emp.dept_id �̷� ����X)
        - �� ���̺��� �������� ��ȯ�Ѵ�.
        - īƼ�� ��: �ϳ��� �࿡ ���� �ٸ� ���� �ٴ� ���
        - �� emp�� �� �� * dept�� �� ���� ����� ���´�.
        
- ���� ����
    - ANSI ���� ����
        - ǥ�� SQL ����
        - ����Ŭ�� 9i ���� ����.
    - ����Ŭ ���� ����
        - ����Ŭ ���� �����̸� �ٸ� DBMS�� �������� �ʴ´�.
**************************************** */        
        

/* ****************************************
-- inner join : ANSI ���� ����
FROM  ���̺�a INNER JOIN ���̺�b ON �������� 

- inner�� ���� �� �� �ִ�.
**************************************** */
-- ������ ID(emp.emp_id), �̸�(emp.emp_name), �Ի�⵵(emp.hire_date), �ҼӺμ��̸�(dept.dept_name)�� ��ȸ
select emp.emp_id, emp.emp_name, emp.hire_date, dept.dept_name
--select *
from emp join dept on emp.dept_id=dept.dept_id;

--emp e : e ���̺��̸��� ��Ī(alias), dept d : d ���̺��̸��� ��Ī
select e.emp_id, e.emp_name, e.hire_date, d.dept_name from emp e inner join dept d on e.dept_id=d.dept_id;

-- ������ ID(emp.emp_id)�� 100�� ������ ����_ID(emp.emp_id), �̸�(emp.emp_name), �Ի�⵵(emp.hire_date), �ҼӺμ��̸�(dept.dept_name)�� ��ȸ.
select e.emp_id, e.emp_name, e.hire_date, d.dept_name
from emp e join dept d on e.dept_id = d.dept_id
where e.emp_id=100;

-- ����_ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), ��������(job.job_title), �ҼӺμ��̸�(dept.dept_name)�� ��ȸ
select e.emp_id, e.emp_name, e.salary, j.job_title, d.dept_name
from emp e  join job j on e.job_id=j.job_id
            join dept d on e.dept_id=d.dept_id;

-- �μ�_ID(dept.dept_id)�� 30�� �μ��� �̸�(dept.dept_name), ��ġ(dept.loc), �� �μ��� �Ҽӵ� ������ �̸�(emp.emp_name)�� ��ȸ.
select d.dept_name, d.loc, e.emp_name
from dept d join emp e on d.dept_id=e.dept_id
where d.dept_id = 30;

-- ������ ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), �޿����(salary_grade.grade) �� ��ȸ. �޿� ��� ������������ ����
select e.emp_id, e.emp_name, e.salary, s.grade||'���'
from emp e join salary_grade s on e.salary between s.low_sal and s.high_sal;


--TODO 200����(200 ~ 299) ���� ID(emp.emp_id)�� ���� �������� ����_ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), 
--     �ҼӺμ��̸�(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ. ����_ID�� ������������ ����.
select e.emp_id, e.emp_name, e.salary, d.dept_name, d.loc
from emp e join dept d on e.dept_id=d.dept_id
where e.emp_id between 200 and 299
order by e.emp_id;

--TODO ����(emp.job_id)�� 'FI_ACCOUNT'�� ������ ID(emp.emp_id), �̸�(emp.emp_name), ����(emp.job_id), 
--     �ҼӺμ��̸�(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ.  ����_ID�� ������������ ����.
select e.emp_id, e.emp_name, e.job_id, d.dept_name, d.loc
from emp e  join dept d on e.dept_id=d.dept_id
where e.job_id='FI_ACCOUNT'
order by e.emp_id;

--TODO Ŀ�̼Ǻ���(emp.comm_pct)�� �ִ� �������� ����_ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), Ŀ�̼Ǻ���(emp.comm_pct), 
--     �ҼӺμ��̸�(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ. ����_ID�� ������������ ����.
select e.emp_id, e.emp_name, e.salary, e.comm_pct, d.dept_name, d.loc
from emp e join dept d on e.dept_id=d.dept_id
where e.comm_pct is not null
order by e.emp_id;

--TODO 'New York'�� ��ġ��(dept.loc) �μ��� �μ�_ID(dept.dept_id), �μ��̸�(dept.dept_name), ��ġ(dept.loc), 
--     �� �μ��� �Ҽӵ� ����_ID(emp.emp_id), ���� �̸�(emp.emp_name), ����(emp.job_id)�� ��ȸ. �μ�_ID �� ������������ ����.
select d.dept_id, d.dept_name, d.loc, e.emp_id, e.emp_name, e.job_id
from dept d join emp e on d.dept_id=e.dept_id
where d.loc='New York'
order by d.dept_id;

--TODO ����_ID(emp.emp_id), �̸�(emp.emp_name), ����_ID(emp.job_id), ������(job.job_title) �� ��ȸ.
select e.emp_id, e.emp_name, e.job_id, j.job_title
from emp e join job j on e.job_id=j.job_id;
              
-- TODO: ���� ID �� 200 �� ������ ����_ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), 
--       ��������(job.job_title), �ҼӺμ��̸�(dept.dept_name)�� ��ȸ              
select e.emp_id, e.emp_name, e.salary, j.job_title, d.dept_name
from emp e  join job j on e.job_id=j.job_id
            join dept d on e.dept_id=d.dept_id
where e.emp_id=200;

-- TODO: 'Shipping' �μ��� �μ���(dept.dept_name), ��ġ(dept.loc), �Ҽ� ������ �̸�(emp.emp_name), ������(job.job_title)�� ��ȸ. 
--       �����̸� ������������ ����
select d.dept_name, d.loc, e.emp_name, j.job_title
from dept d join emp e on d.dept_id=e.dept_id
            join job j on e.job_id=j.job_id
where d.dept_name = 'Shipping'
order by e.emp_name desc;

-- TODO:  'San Francisco' �� �ٹ�(dept.loc)�ϴ� ������ id(emp.emp_id), �̸�(emp.emp_name), �Ի���(emp.hire_date)�� ��ȸ
--         �Ի����� 'yyyy-mm-dd' �������� ���
select e.emp_id, e.emp_name, to_char(e.hire_date,'yyyy-mm-dd') hire_date
from emp e join dept d on d.dept_id=e.dept_id
where d.loc= 'San Francisco';

-- TODO �μ��� �޿�(salary)�� ����� ��ȸ. �μ��̸�(dept.dept_name)�� �޿������ ���. �޿� ����� ���� ������ ����.
-- �޿��� , ���������ڿ� $ �� �ٿ� ���.
select d.dept_name, to_char(avg(e.salary),'$9,999,999')"��ձ޿�"
from dept d join emp e on d.dept_id=e.dept_id
group by d.dept_name
order by avg(e.salary) desc;            
--order by 2 desc; --�� �� ��ձ޿��� ���ڿ��� ���ϱ� ������ fm�� �ٿ� ������ ���� ��� ������ ����� ���� �ʴ� ������ �����.

--TODO ������ ID(emp.emp_id), �̸�(emp.emp_name), ������(job.job_title), �޿�(emp.salary), 
--     �޿����(salary_grade.grade), �ҼӺμ���(dept.dept_name)�� ��ȸ. ��� ������������ ����
select e.emp_id, e.emp_name, j.job_title, e.salary, s.grade, d.dept_name
from emp e  join job j on e.job_id=j.job_id
            join salary_grade s on e.salary between s.low_sal and s.high_sal
            join dept d on e.dept_id=d.dept_id
order by 5 desc;

--TODO �޿������(salary_grade.grade) 1�� ������ �Ҽӵ� �μ���(dept.dept_name)�� ���1�� ������ ���� ��ȸ. �������� ���� �μ� ������� ����.
/*select d.dept_name, count(*) ������
from dept d join emp e on d.dept_id=e.dept_id
            join salary_grade s on e.salary between s.low_sal and s.high_sal
group by d.dept_name, s.grade
having s.grade=1
order by 2 desc;*/
---------------------------------------------------------------------------------
select d.dept_name, count(*) ������
from dept d join emp e on d.dept_id=e.dept_id
            join salary_grade s on e.salary between s.low_sal and s.high_sal
where s.grade=1
group by d.dept_name
--group by rollup(dept_name) : �� 1����� ������ ��
--having count(*)>=4         : 1����� ������ ���� 4�� �̻��� �μ���
order by 2 desc;

/* ###################################################################################### 
����Ŭ ���� 
- Join�� ���̺���� from���� �����Ѵ�.
- Join ������ where���� ����Ѵ�. 

###################################################################################### */
-- ������ ID(emp.emp_id), �̸�(emp.emp_name), �Ի�⵵(emp.hire_date), �ҼӺμ��̸�(dept.dept_name)�� ��ȸ
-- �Ի�⵵�� �⵵�� ���


-- ������ ID(emp.emp_id)�� 100�� ������ ����_ID(emp.emp_id), �̸�(emp.emp_name), �Ի�⵵(emp.hire_date), �ҼӺμ��̸�(dept.dept_name)�� ��ȸ
-- �Ի�⵵�� �⵵�� ���


-- ����_ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), ��������(job.job_title), �ҼӺμ��̸�(dept.dept_name)�� ��ȸ



--TODO 200����(200 ~ 299) ���� ID(emp.emp_id)�� ���� �������� ����_ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), 
--     �ҼӺμ��̸�(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ. ����_ID�� ������������ ����.



--TODO ����(emp.job_id)�� 'FI_ACCOUNT'�� ������ ID(emp.emp_id), �̸�(emp.emp_name), ����(emp.job_id), 
--     �ҼӺμ��̸�(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ.  ����_ID�� ������������ ����.



--TODO Ŀ�̼Ǻ���(emp.comm_pct)�� �ִ� �������� ����_ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), Ŀ�̼Ǻ���(emp.comm_pct), 
--     �ҼӺμ��̸�(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ. ����_ID�� ������������ ����.




--TODO 'New York'�� ��ġ��(dept.loc) �μ��� �μ�_ID(dept.dept_id), �μ��̸�(dept.dept_name), ��ġ(dept.loc), 
--     �� �μ��� �Ҽӵ� ����_ID(emp.emp_id), ���� �̸�(emp.emp_name), ����(emp.job_id)�� ��ȸ. �μ�_ID �� ������������ ����.



--TODO ����_ID(emp.emp_id), �̸�(emp.emp_name), ����_ID(emp.job_id), ������(job.job_title) �� ��ȸ.



             
-- TODO: ���� ID �� 200 �� ������ ����_ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), 
--       ��������(job.job_title), �ҼӺμ��̸�(dept.dept_name)�� ��ȸ              



-- TODO: 'Shipping' �μ��� �μ���(dept.dept_name), ��ġ(dept.loc), �Ҽ� ������ �̸�(emp.emp_name), ������(job.job_title)�� ��ȸ. 
--       �����̸� ������������ ����



-- TODO:  'San Francisco' �� �ٹ�(dept.loc)�ϴ� ������ id(emp.emp_id), �̸�(emp.emp_name), �Ի���(emp.hire_date)�� ��ȸ
--         �Ի����� 'yyyy-mm-dd' �������� ���



--TODO �μ��� �޿�(salary)�� ����� ��ȸ. �μ��̸�(dept.dept_name)�� �޿������ ���. �޿� ����� ���� ������ ����.
-- �޿��� , ���������ڿ� $ �� �ٿ� ���.



--TODO ������ ID(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), �޿����(salary_grade.grade) �� ��ȸ. ���� id ������������ ����




--TODO ������ ID(emp.emp_id), �̸�(emp.emp_name), ������(job.job_title), �޿�(emp.salary), 
--     �޿����(salary_grade.grade), �ҼӺμ���(dept.dept_name)�� ��ȸ. ��� ������������ ����



--TODO �޿������(salary_grade.grade) 1�� ������ �Ҽӵ� �μ���(dept.dept_name)�� ���1�� ������ ���� ��ȸ. �������� ���� �μ� ������� ����.


/* ****************************************************
Self ����
- ���������� �ϳ��� ���̺��� �ΰ��� ���̺�ó�� �����ϴ� ��.
**************************************************** */
--������ ID(emp.emp_id), �̸�(emp.emp_name), ����̸�(emp.emp_name)�� ��ȸ



-- TODO : EMP ���̺��� ���� ID(emp.emp_id)�� 110�� ������ �޿�(salary)���� ���� �޴� �������� id(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary)�� ���� ID(emp.emp_id) ������������ ��ȸ.



/* ****************************************************
�ƿ��� ���� (Outer Join)
-ANSI ����
from ���̺�a [LEFT | RIGHT | FULL] OUTER JOIN ���̺�b ON ��������
- OUTER�� ���� ����.

-����Ŭ JOIN ����
- FROM ���� ������ ���̺��� ����
- WHERE ���� ���� ������ �ۼ�
    - Ÿ�� ���̺� (+) �� ���δ�.
    - FULL OUTER JOIN�� �������� �ʴ´�.
- OUTER�� ���� �� �� �ִ�.	
**************************************************** */
-- ������ id(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary), �μ���(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ. 
-- �μ��� ���� ������ ������ �������� ��ȸ. (�μ������� null). dept_name�� ������������ �����Ѵ�.




-- ��� ������ id(emp.emp_id), �̸�(emp.emp_name), �μ�_id(emp.dept_id)�� ��ȸ�ϴµ�
-- �μ�_id�� 80 �� �������� �μ���(dept.dept_name)�� �μ���ġ(dept.loc) �� ���� ����Ѵ�. (�μ� ID�� 80�� �ƴϸ� null�� ��������)




--TODO: ����_id(emp.emp_id)�� 100, 110, 120, 130, 140�� ������ ID(emp.emp_id), �̸�(emp.emp_name), ������(job.job_title) �� ��ȸ. 
--      �������� ���� ��� '�̹���' ���� ��ȸ



--TODO: �μ��� ID(dept.dept_id), �μ��̸�(dept.dept_name)�� �� �μ��� ���� �������� ���� ��ȸ. 
--      ������ ���� �μ��� 0�� �������� ��ȸ�ϰ� �������� ���� �μ� ������ ��ȸ.



-- TODO: EMP ���̺��� �μ�_ID(emp.dept_id)�� 90 �� �������� id(emp.emp_id), �̸�(emp.emp_name), ����̸�(emp.emp_name), �Ի���(emp.hire_date)�� ��ȸ. 
-- �Ի����� yyyy-mm-dd �������� ���
-- ��簡�� ���� ������ '��� ����' ���




--TODO 2003��~2005�� ���̿� �Ի��� ������ id(emp.emp_id), �̸�(emp.emp_name), ������(job.job_title), �޿�(emp.salary), �Ի���(emp.hire_date),
--     ����̸�(emp.emp_name), ������Ի���(emp.hire_date), �ҼӺμ��̸�(dept.dept_name), �μ���ġ(dept.loc)�� ��ȸ.
-- �� ��簡 ���� ������ ��� ����̸�, ������Ի����� null�� ���.
-- �μ��� ���� ������ ��� null�� ��ȸ




