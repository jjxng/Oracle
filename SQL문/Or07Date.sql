/***************
���ϸ� :  Or07Date.sql
��¥�Լ�
���� : ��, ��, ��, ��, ��, ���� �������� ��¥������ �����ϰų�
    ��¥�� ����Ҷ� Ȱ���ϴ� �Լ���
****************/
-- hr ����

/*
months_between() : ���糯¥�� ���س�¥ ������ �������� ��ȯ�Ѵ�.
    ����] months_between(���糯¥, ���س�¥[���ų�¥]);
*/
-- 2020�� 1�� 1�Ϻ��� ���ݱ��� ���� ��������??
select
    months_between(sysdate, '2020-01-01') "�⺻��¥ ����",
    months_between(sysdate, 
        to_date('2020��01��10��', 'yyyy"��"mm"��"dd"��"')) "to_date���",
    ceil(months_between(sysdate, 
        to_date('2020��01��10��', 'yyyy"��"mm"��"dd"��"'))) "�Ҽ����ø�ó��",
    add_months(sysdate, 4)
 from dual;

/*
����] employees ���̺� �Էµ� �������� �ټӰ������� ����Ͽ� ����Ͻÿ�
    ��, �ټӰ������� ������������ �����Ͻÿ�.
*/
select
    first_name, hire_date,
    months_between(sysdate, hire_date) "�ټӰ�����1",
    trunc(months_between(sysdate, hire_date)) "�ټӰ�����2"
 from employees
  order by "�ټӰ�����2" asc;
-- order by trunc(months_between(sysdate, hire_date)) asc;
/*
select ����� �����ϱ� ���� order by�� ����Ҷ� �÷����� ���Ͱ���
2���� ���·� ����� �� �ִ�.
���1 : ������ ���Ե� �÷����״�� ����Ѵ�.
���2 : ��Ī�� ����Ѵ�.
*/

/*
next_day() : ���糯"¥�� �������� ���ڷ� �־��� ���Ͽ� �ش��ϴ�
    �̷��� ��¥�� ��ȯ�ϴ� �Լ�
    ����] next_day(���糯¥, '������')
        => ������ �������� �����ϱ��?
*/
select
    to_char(sysdate, 'yyyy-mm-dd') "���ó�¥",
    next_day(sysdate, '������') "����������",
    to_char(next_day(sysdate, '������'), 'yyyy-mm-dd') "��¥ ��������"
 from dual;

/*
last_day() : �ش���� ������ ��¥�� ��ȯ�Ѵ�.
*/
select last_day('22-04-03') from dual; -- 22�� 4���� �������� 30��
select last_day('22-02-03') from dual; -- 28�� ���
select last_day('20-02-03') from dual; -- 2020���� ����̹Ƿ� 29�� ��µ�

-- �÷��� dateŸ���� ��� ������ ���� ������ �����ϴ�.
select
    sysdate "����",
    sysdate+1 "����",
    sysdate-1 "����",
    sysdate+15 "������"
 from dual;

