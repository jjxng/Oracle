/***************
���ϸ� :  Or12SubQuery.sql
���� ����
���� : ������ �ȿ� �� �ٸ� �������� ���� ������ select��
    where���� selsct���� ����ϸ� ����������� �Ѵ�.
****************/
-- hr�������� �����մϴ�.

/*
������ ��������
    �� �ϳ��� �ุ ��ȯ�ϴ� ���������� �񱳿�����(=,<,<=,>,>=,<>)��
    ����Ѵ�.
    ����]
        select * from ���̺�� where �÷�=(
            select �÷� from ���̺�� where ����
        );
    * ��ȣ ���� ���������� �ݵ�� �ϳ��� ����� �����ؾ� �Ѵ�.
*/
/*
�ó�����] ������̺��� ��ü����� ��ձ޿����� ���� �޿��� �޴� �������
    �����Ͽ� ����Ͻÿ�.
    ����׸� : �����ȣ, �̸�, �̸���, ����ó, �޿�
*/
-- 1. ��ձ޿� ���ϱ� : 6462
select avg(salary) from employees;
-- 2. �ش� �������� ���ƻ� �´� �� ������ �׷��Լ��� �����࿡ ������
-- �߸��� �������̴�. ���� �߻�
select * from employees where salary<avg(salary);
-- 3. �տ��� ���� ��� �޿��� �������� select���� �ۼ��Ͻÿ�.
select * from employees where salary<6462;
-- 4. 2���� �������� �ϳ��� �������������� ���ļ� ����� Ȯ���Ѵ�.
select employee_id, first_name, email, phone_number, salary
 from employees where salary<(
    select avg(salary) from employees) 
 order by salary;
/*
����] ��ü ��� �� �޿��� ���� ���� ����� �̸��� �޿��� ����ϴ� 
    ������������ �ۼ��Ͻÿ�.
    ����׸� : �̸�1, �̸�2, �̸���, �޿�
*/
-- 1�ܰ� : �ּұ޿��� Ȯ���Ѵ�.
select min(salary) from employees;
-- 2�ܰ� : 2100�� �޴� ������ ������ �����Ѵ�.
select * from employees where salary=2100;
-- 3�ܰ� : 2���� ������ ���ļ� ���������� �����.
select * from employees where salary=(
    select min(salary) from employees);

/*
�ó�����] ��ձ޿��� ���� �޿��� �޴� ������� ����� ��ȸ�� �� �ִ�
    ������������ �ۼ��Ͻÿ�.
    ��� ���� : �̸�1, �̸�2, ��������, �޿�
    * ���������� jobs ���̺� �����Ƿ� join�ؾ� �Ѵ�.
*/
-- 1�ܰ� : ��ձ޿� ȯ���ϱ�
select round(avg(salary)) from employees;
-- 2�ܰ� : ���̺� ����
select
    first_name, last_name, job_title, salary
 from employees inner join jobs using(job_id)
 where salary>6462;
-- 3�ܰ� : �������������� ����
select
    first_name, last_name, job_title, salary
 from employees inner join jobs using(job_id)
 where salary>(select round(avg(salary)) from employees);
/*
������ �������� : ������ ����������� �ϰ� �������� ���� ��ȯ
    �ϴ� ������ in, any, all, exists�� ����ؾ� �Ѵ�.
    ����] select * from ���̺�� where �÷� in (
                select �÷� from ���̺�� where ����
            );
    * ��ȣ���� ���� ������ 2�� �̻��� ����� �����ؾ� �Ѵ�.
*/
/*
�ó�����] ���������� ���� ���� �޿��� �޴� ����� ����� ��ȸ�Ͻÿ�.
    ��¸�� : ������̵�, �̸�, ���������̵�, �޿�
*/
-- 1�ܰ� : �������� ���� ���� �޿��� Ȯ���Ѵ�.
select job_id, max(salary) from employees group by job_id;
-- 2�ܰ� : ���� ����� �ܼ��� or �������� �����.
-- 19���� ����� ��������� 4�������� ����غ���.
select * from employees 
    where
        (job_id='SH_CLERK' and salary=4200) or
        (job_id='AD_ASST' and salary=4400) or
        (job_id='MK_MAN' and salary=1300) or
        (job_id='MK_REP' and salary=6000);
-- 3�ܰ� :  ������ �����ڸ� ���� ���������� �����Ѵ�.
select employee_id, first_name, job_id, salary
 from employees where 
    (job_id, salary) in (
        select job_id, max(salary) from employees group by job_id)
    order by salary;

/*
������ ������: any(� ���̶�)�� ������ or�� ����ϴ�.
    ���������� �������� ���������� �˻������ �ϳ� �̻�
    ��ġ�ϸ� ���̵Ǵ� ������. ��, �� �� �ϳ��� �����ϸ� �ش� ���ڵ带
    �����Ѵ�.
*/
/*
�ó�����] ��ü ��� �߿��� �μ���ȣ�� 20�� ������� �޿����� ���� �޿���
    �޴� �������� �����ϴ� ������������ �ۼ��Ͻÿ�. ��, �� �� �ϳ���
    �����ϴ��� �����Ͻÿ�.
*/
-- 1�ܰ� : 20�μ����� �޿��� Ȯ���Ѵ�.
select first_name, salary from employees where department_id=20;
-- 2�ܰ� : 1���� ����� �ܼ��� or���� �ۼ��غ���.
select first_name, salary from employees
    where salary>13000 or salary>6000;
-- 3�ܰ� : �� �� �ϳ��� �����ϸ� �ǹǷ� ������ ������ any�� �̿��ؼ� ����������
-- ����� �ȴ�. ��, 6000���� ũ�� �Ǵ� 13000���� ū �������� �����ȴ�.
select first_name, salary from employees 
    where salary>any(
        select salary from employees where department_id=20);
/*
    ��������� 6000���� ũ�� ���ǿ� �����Ѵ�. ����� 55���� ���´�.
*/
/*
������ ������3 : all�� and�� ����� �����ϴ�.
    ���������� �������� ���������� �˻������ ��� ��ġ�ؾ�
    ���ڵ带 �����Ѵ�.
*/
/*
�ó�����] ��ü��� �߿��� �μ���ȣ�� 20�� ������� �޿����� ���� �޿���
    �޴� �������� �����ϴ� ������������ �ۼ��Ͻÿ�. ��, �� �� �����ϴ�
    ���ڵ常 �����Ͻÿ�.
*/
select first_name, salary from employees 
    where salary>all(
        select salary from employees where department_id=20);
/*
    6000�̻��̰� ���ÿ� 13000���� Ŀ���ϹǷ� ��������� 13000 �̻���
    ���ڵ常 �����ϰ� �ȴ�. ����� : 5��
*/

/*
rownum : ���̺��� ���ڵ带 ��ȸ�� ������� ������ �ο��Ǵ� ������
    �÷��� ���Ѵ�. �ش� �÷��� ��� ���̺� �������� �����Ѵ�.
*/
-- ��� ������ �������� �����ϴ� ���̺�
select * from dual;
-- ���ڵ��� ���ľ��� ��� ���ڵ带 �����ͼ� rownum�� �ο��Ѵ�.
-- �� ��� rownum�� ������� ��µȴ�.
select employee_id, first_name, rownum from employees;
-- �̸��� ������������ �����ϸ� rownum�� ������ �̻��ϰ� ���´�.
select employee_id, first_name, rownum from employees
    order by first_name asc;
    
/*
rownum�� �츮�� ������ ������� ��ο��ϱ� ���� ���������� ����Ѵ�.
from������ ���̺��� ���;� �ϴµ�, �Ʒ��� �������������� ������̺���
��ü ���ڵ带 ������� �ϵ� �̸��� ������������ ���ĵ� ���·� ���ڵ带
�����ͼ� ���̺�ó�� ����Ѵ�.
*/
select first_name, rownum 
 from (select * from employees order by first_name asc);

