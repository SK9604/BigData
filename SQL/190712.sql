/* **************************************************************************
��������(Sub Query)
- �����ȿ��� select ������ ����ϴ� ��.
- ���� ���� �� ��������
- �ݵ�� �Ұ�ȣ ( ) �� ������Ѵ�.

���������� ���Ǵ� ��
 - select��, from��, where��, having��
 
���������� ����
- ��� ������ ���Ǿ������� ���� ����
    - ��Į�� �������� - select ���� ���. �ݵ�� �������� ����� 1�� 1��(�� �ϳ�-��Į��) 0���� ��ȸ�Ǹ� null�� ��ȯ
    - �ζ��� �� - from ���� ���Ǿ� ���̺��� ������ �Ѵ�.
- �������� ��ȸ��� ����� ���� ����
    - ������ �������� - ���������� ��ȸ��� ���� ������ ��.
    - ������ �������� - ���������� ��ȸ��� ���� �������� ��.
- ���� ��Ŀ� ���� ����
    - ����(�񿬰�) �������� - ���������� ���������� �÷��� ������ �ʴ´�. ���������� ����� ���� ���������� �����ϴ� ������ �Ѵ�.
    - ���(����) �������� - ������������ ���������� �÷��� ����Ѵ�. 
                            ���������� ���� ����Ǿ� ������ �����͸� ������������ ������ �´��� Ȯ���ϰ��� �Ҷ� �ַ� ����Ѵ�.
************************************************************************** */

-- ����_ID(emp.emp_id)�� 120���� ������ ���� ����(emp.job_id)���� 
-- ������ id(emp_id),�̸�(emp.emp_name), ����(emp.job_id), �޿�(emp.salary) ��ȸ
select emp_id, emp_name, job_id, salary 
from emp
where job_id = (select job_id from emp where emp_id = 120);
--subquery�� ( )�� ������� �Ѵ�.

-- ����_id(emp.emp_id)�� 115���� ������ ���� ����(emp.job_id)�� �ϰ� ���� �μ�(emp.dept_id)�� ���� �������� ��ȸ�Ͻÿ�.
select  * from emp
where   job_id = (select job_id from emp where emp_id = 115)
and     dept_id = (select dept_id from emp where emp_id = 115);
--�� ����� �ſ� ��ȿ���� �Ʒ� ��� ��� ( Pair ��� ��������)
select * from emp
where (job_id, dept_id) = (select job_id, dept_id from emp where emp_id = 115);

select * from emp
where (job_id, dept_id) = ('PU_MAN', 30); --pair����� �������������� �۵�

-- ������ �� �޿�(emp.salary)�� ��ü ������ ��� �޿����� ���� 
-- �������� id(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary)�� ��ȸ. �޿�(emp.salary) �������� ����.
select emp_id, emp_name, salary
from emp
where salary < (select avg(salary) from emp) --avg=6517.xxxx
order by salary;

-- ��ü ������ ��� �޿�(emp.salary) �̻��� �޴� �μ���  �̸�(dept.dept_name), �Ҽ��������� ��� �޿�(emp.salary) ���. 
-- ��ձ޿��� �Ҽ��� 2�ڸ����� ������ ��ȭǥ��($)�� ���� ������ ���
select d.dept_name, to_char(avg(e.salary),'$999,999.99') ��ձ޿� 
from emp e left join dept d on e.dept_id = d.dept_id
group by d.dept_name
having avg(e.salary) >= (select avg(salary) from emp);

-- TODO: ������ ID(emp.emp_id)�� 145�� �������� ���� ������ �޴� �������� �̸�(emp.emp_name)�� �޿�(emp.salary) ��ȸ.
-- �޿��� ū ������� ��ȸ
select emp_name, salary from emp
where salary>(select salary from emp where emp_id=145)
order by salary desc;

-- TODO: ������ ID(emp.emp_id)�� 150�� ������ ���� ����(emp.job_id)�� �ϰ� ���� ���(emp.mgr_id)�� ���� �������� 
-- id(emp.emp_id), �̸�(emp.emp_name), ����(emp.job_id), ���(emp.mgr_id) �� ��ȸ
select emp_id, emp_name, job_id, mgr_id from emp
where (mgr_id,job_id) = (select mgr_id, job_id from emp where emp_id = 150);

-- TODO : EMP ���̺��� ���� �̸���(emp.emp_name)��  'John'�� ������ �߿��� �޿�(emp.salary)�� ���� ���� ������ salary(emp.salary)���� ���� �޴� 
-- �������� id(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary)�� ���� ID(emp.emp_id) ������������ ��ȸ.
select emp_id, emp_name, salary from emp
where salary > (select max(salary) from emp where emp_name ='John')
order by 1;

-- TODO: �޿�(emp.salary)�� ���� ���� ������ ���� �μ��� �̸�(dept.dept_name), ��ġ(dept.loc)�� ��ȸ.
select d.dept_name, d.loc from emp e left join dept d on e.dept_id = d.dept_id
where salary = (select max(salary) from emp);

-- TODO: 30�� �μ�(emp.dept_id) �� ��� �޿�(emp.salary)���� �޿��� ���� �������� ��� ������ ��ȸ.
select * from emp
where salary>(select avg(salary) from emp where dept_id = 30);

-- TODO: ��� ����ID(emp.job_id) �� 'ST_CLERK'�� �������� ��� �޿����� ���� �޿��� ������ �޴� �������� ��� ������ ��ȸ. �� ���� ID�� 'ST_CLERK'�� �ƴ� �����鸸 ��ȸ. 
select * from emp
where salary < (select avg(salary) from emp where job_id = 'ST_CLERK')
and   Job_id <> 'ST_CLERK';

-- TODO: �޿�(emp.salary)�� ���� ���� �޴� �������� �̸�(emp.emp_name), �μ���(dept.dept_name), �޿�(emp.salary) ��ȸ. 
--       �޿��� �տ� $�� ���̰� ���������� , �� ���
select e.emp_name, d.dept_name, to_char(e.salary, '$999,999') �޿� from emp e left join dept d on e.dept_id = d.dept_id --�μ��� ���� ������ ��쵵 �ִ�
where e.salary = (select max(salary) from emp);

-- TODO: EMP ���̺��� ����(emp.job_id)�� 'IT_PROG' �� �������� ��� �޿� �̻��� �޴� 
-- �������� id(emp.emp_id), �̸�(emp.emp_name), �޿�(emp.salary)�� �޿� ������������ ��ȸ.
select emp_id, emp_name, salary from emp
where salary >= (select avg(salary) from emp where job_id = 'IT_PROG')
order by salary desc;

-- TODO: 'IT' �μ�(dept.dept_name)�� �ִ� �޿����� ���� �޴� ������ ID(emp.emp_id), �̸�(emp.emp_name), �Ի���(emp.hire_date), �μ� ID(emp.dept_id), �޿�(emp.salary) ��ȸ
-- �Ի����� "yyyy�� mm�� dd��" �������� ���
-- �޿��� �տ� $�� ���̰� ���������� , �� ���
select emp_id, emp_name, to_char(hire_date,'yyyy"��" mm"��" dd"��"')hire_date, dept_id, to_char(salary,'$999,999')salary from emp
where salary > (select max(e.salary) from emp e join dept d on e.dept_id=d.dept_id where dept_name = 'IT');

/* ----------------------------------------------
 ������ ��������
 - ���������� ��ȸ ����� �������� ���
 - where�� ������ ������
	- in
	- �񱳿����� any : ��ȸ�� ���� �� �ϳ��� ���̸� �� (where �÷� > any(��������) ) ������ min���� ũ��
	- �񱳿����� all : ��ȸ�� ���� ��ο� ���̸� �� (where �÷� > all(��������) ) ������ max���� ũ��
------------------------------------------------*/

--'Alexander' �� �̸�(emp.emp_name)�� ���� ������(emp.mgr_id)�� 
-- ���� �������� ID(emp_id), �̸�(emp_name), ����(job_id), �Ի�⵵(hire_date-�⵵�����), �޿�(salary)�� ��ȸ
-- �޿��� �տ� $�� ���̰� ���������� , �� ���
select emp_id, emp_name, job_id, to_char(hire_date,'yyyy')hire_date, salary from emp
where mgr_id in (select emp_id from emp where emp_name = 'Alexander');

-- ���� ID(emp.emp_id)�� 101, 102, 103 �� ������ ���� �޿�(emp.salary)�� ���� �޴� ������ ��� ������ ��ȸ.
select * from emp
where salary > all (select salary from emp where emp_id in (101,102,103));
--����(all = max�� �ϸƻ�����)
select * from emp
where salary > (select max(salary) from emp where emp_id in (101,102,103));

-- ���� ID(emp.emp_id)�� 101, 102, 103 �� ������ �� �޿��� ���� ���� �������� �޿��� ���� �޴� ������ ��� ������ ��ȸ.
select * from emp
where salary > any (select salary from emp where emp_id in (101,102,103));
--����(any = min�� �ϸƻ���)
select * from emp
where salary > (select min(salary) from emp where emp_id in (101,102,103));

-- TODO : �μ� ��ġ(dept.loc) �� 'New York'�� �μ��� �Ҽӵ� ������ ID(emp.emp_id), �̸�(emp.emp_name), �μ�_id(emp.dept_id) �� sub query�� �̿��� ��ȸ.
select emp_id, emp_name, dept_id
from emp
where dept_id in (select dept_id from dept where loc = 'New York');

-- TODO : �ִ� �޿�(job.max_salary)�� 6000������ ������ ����ϴ� ����(emp)�� ��� ������ sub query�� �̿��� ��ȸ.
select * from emp
where job_id in (select job_id from job where max_salary <=6000);

-- TODO: �μ�_ID(emp.dept_id)�� 20�� �μ��� ������ ���� �޿�(emp.salary)�� ���� �޴� �������� ������  sub query�� �̿��� ��ȸ.
select * from emp
where salary > all(select salary from emp where dept_id = 20);
--max���
select * from emp
where salary > (select max(salary) from emp where dept_id = 20);

-- TODO: �μ��� �޿��� ����� ���� ���� �μ��� ��� �޿����� ���� ���� �޴� ������� �̸�, �޿�, ������ ���������� �̿��� ��ȸ
select emp_name, salary, job_id from emp
where salary > any (select avg(salary) from emp group by dept_id);
--min���
select emp_name, salary, job_id from emp
where salary > (select min(avg(salary)) from emp group by dept_id);

-- TODO: ���� id(job_id)�� 'SA_REP' �� �������� ���� ���� �޿��� �޴� �������� ���� �޿��� �޴� �������� �̸�(emp_name), �޿�(salary), ����(job_id) �� subquery�� �̿��� ��ȸ.
select emp_name, salary, job_id from emp
where salary > all (select salary from emp where job_id = 'SA_REP');
--max���
select emp_name, salary, job_id from emp
where salary > (select max(salary) from emp where job_id = 'SA_REP');

/* ****************************************************************
���(����) ����
������������ ��ȸ���� ���������� ���ǿ��� ����ϴ� ����.
���������� �����ϰ� �� ����� �������� ���������� �������� ���Ѵ�.
* ****************************************************************/

-- �μ���(DEPT) �޿�(emp.salary)�� ���� ���� �޴� �������� id(emp.emp_id), �̸�(emp.emp_name), ����(emp.salary), �ҼӺμ�ID(dept.dept_id) ��ȸ
select  emp_id, emp_name, salary, dept_id
from    emp e
where   salary = (select max(salary) from emp where dept_id = e.dept_id);

/* ******************************************************************************************************************
EXISTS, NOT EXISTS ������ (���(����)������ ���� ���ȴ�)
-- ���������� ����� �����ϴ� ���� �����ϴ��� ���θ� Ȯ���ϴ� ����. ������ �����ϴ� ���� �������� ���ุ ������ ���̻� �˻����� �ʴ´�.
**********************************************************************************************************************/

-- ������ �Ѹ��̻� �ִ� �μ��� �μ�ID(dept.dept_id)�� �̸�(dept.dept_name), ��ġ(dept.loc)�� ��ȸ
select dept_id, dept_name, loc
from dept d
where exists(select emp_id from emp where emp.dept_id = d.dept_id);

-- ������ �Ѹ� ���� �μ��� �μ�ID(dept.dept_id)�� �̸�(dept.dept_name), ��ġ(dept.loc)�� ��ȸ
select dept_id, dept_name, loc
from dept d
where not exists(select 1 from emp where dept_id = d.dept_id);--select�� ���� ������ �߿����� �ʰ� ���翩�θ� ����ȴ�.

-- �μ�(dept)���� ����(emp.salary)�� 13000�̻��� �Ѹ��̶� �ִ� �μ��� �μ�ID(dept.dept_id)�� �̸�(dept.dept_name), ��ġ(dept.loc)�� ��ȸ
select dept_id, dept_name, loc
from dept d
where exists(select 1 from emp where d.dept_id = dept_id and salary>=13000); 

/* ******************************
�ֹ� ���� ���̺�� �̿�.
******************************* */

--TODO: ��(customers) �� �ֹ�(orders)�� �ѹ� �̻� �� ������ ��ȸ.
select * from customers c
where exists(select order_id from orders where cust_id = c.cust_id);

--TODO: ��(customers) �� �ֹ�(orders)�� �ѹ��� ���� ���� ������ ��ȸ.
select * from customers c
where not exists(select order_id from orders where cust_id = c.cust_id);

--TODO: ��ǰ(products) �� �ѹ��̻� �ֹ��� ��ǰ ���� ��ȸ
select * from products p 
where exists(select ordere_item_id from order_items oi where oi.product_id=p.product_id);

--TODO: ��ǰ(products)�� �ֹ��� �ѹ��� �ȵ� ��ǰ ���� ��ȸ
select * from products p 
where not exists(select ordere_item_id from order_items oi where oi.product_id=p.product_id);

/*
Inline-view: subquery�� from ������ ���
- subquery�� ��ȸ����� ���̺�� �ؼ� main ������ ����ȴ�
- inline-view�� ������������ �÷� ��Ī(alias)�� �����ϸ� main���������� ��Ī�� ����ؾ� �Ѵ�.
*/

select emp_id, emp_name, job_id, dept_id from emp where dept_id = 60;

select e.e_id, e.e_name, d.dept_name --e.emp_id, e.emp_name�� ��Ī ���(inlineview���� ��Ī�� �� ��� ���̺��� �����ϹǷ�)
from (select emp_id e_id, emp_name e_name, job_id, dept_id from emp where dept_id = 60) e, dept d 
where e.dept_id = d.dept_id;

/*inline-view�� �̿��� n-top����(��ȸ)
 - ���� 5��, ���� 3���� ��ȸ
 - ROWNUM �÷�: ��ȸ��� ���ȣ�� ��ȯ
*/

select rownum, emp_id, emp_name
from emp
where rownum<=5;

select rownum, emp_id, emp_name, salary
from emp
--where rownum<=5;
order by salary desc; --������ ���� �������� �Ͼ�� ������ rownum�� ���׹����� �ȴ�.
--�ذ�: inline view�� �̿��Ͽ� �̸� ���ĵ� ���̺��� ����Ѵ�.
select rownum, emp_id, emp_name, salary
from (select * from emp order by salary desc)
where rownum<=5;

--salary ���� ���� 5 - 10�� �������� ��ȸ
select rank ����, emp_id, emp_name, salary               --4: ����� ������ Į��
from (select rownum rank, emp_id, emp_name, salary      --2: rank��� �̸����� rownum�� ���� ���̺�
      from (select * from emp order by salary desc))    --1: salary�������� ����
where rank between 5 and 10;                            --3: rank�� ������ ��
--����: ����: from������ ������ �ϸ� where������ �ϳ��� ���� �ҷ��� rownum�� 1���� ���̰� ������ Ȯ���ϴµ� 
--5���� ũ�� ������ pass ���� �൵ �ҷ��ͼ� rownum�� �� 1�� ���̰� �� pass ���� ����� �ƿ� ������ �ʰԵȴ�.
select rownum, emp_id, emp_name, salary
from (select * from emp order by salary desc)
where rownum between 5 and 10;

select rownum, emp_id, emp_name, salary
from (select * from emp order by salary desc)
where rownum between 5 and 10;

select rank ����, emp_id, emp_name, salary, e.dept_id, d.dept_name
from (select rownum rank, emp_id, emp_name, salary, dept_id
      from (select * from emp order by salary desc)) e, dept d
where e.dept_id = d.dept_id(+) and rank between 5 and 10;           --���ο���, dept�� ������ �ϸ鼭 ������ �ٲ��.=>�������� ó��

select rank ����, emp_id, emp_name, salary, dept_id, dept_name
from (  select rownum rank, emp_id, emp_name, salary, dept_id, dept_name
        from (  select e.emp_id, e.emp_name, e.salary, d.dept_id, d.dept_name
                from emp e left join dept d on e.dept_id = d.dept_id
                order by e. salary desc))
where rank between 5 and 10;
        
-- �Ի����� ���� ���� 10��
select rownum, emp_id, emp_name, hire_date
from (select * from emp order by hire_date)
where rownum <= 10;

-- �Ի����� ���� ���� 10��
select rownum, emp_id, emp_name, hire_date
from (select * from emp order by hire_date desc)
where rownum <= 10;

