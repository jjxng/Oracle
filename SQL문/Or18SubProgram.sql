/***************
���ϸ� : Or18SubProgram.sql
���� ���α׷�
���� : ���� ���ν���, �Լ� �׸��� ���ν����� ������ Ʈ���Ÿ� �н�
****************/
-- hr�������� �����մϴ�.

/*
���� ���α׷�(Sub Program)
    - PL/SQL������ ���ν����� �Լ���� ���ڸ� ������ �������α׷��� �ִ�.
    - Select�� �����ؼ� �ٸ� DML���� �̿��Ͽ� ���α׷������� ��Ҹ� ����
    ��� �����ϴ�.
    - Ʈ���Ŵ� ���ν����� �������� Ư�� ���̺��� ���ڵ��� ��ȭ�� ���� ���
    �ڵ����� ����ȴ�.
    - �Լ��� �������� �Ϻκ����� ����ϱ� ���� �����Ѵ�. ��, �ܺ� ���α׷�����
    ȣ���ϴ� ���� ���� ����.
    - ���ν����� �ܺ� ���α׷����� ȣ���ϱ� ���� �����Ѵ�. ���� Java, JSP
    ��� ������ ȣ��� ������ ������ ������ �� �ִ�.
*/

/*
1. ���� ���ν���(Stored Procedure)
    - ���ν����� return���� ���� ��� out �Ķ���͸� ���� ���� ��ȯ�Ѵ�.
    - ���ȼ��� ���� �� �ְ�, ��Ʈ��ũ�� ���ϸ� ���� �� �մ�.
    ����] create [or replace] procedure �a�ν�����
        [(�Ű����� in �ڷ���, �Ű����� out �ڷ���)]
        is [���� ����]
        begin
            ���๮��;
        end;
    * �Ķ���� ���� �� �ڷ����� ����ϰ�, ũ��� ������� �ʴ´�.
*/

-- ����1] 100�� ����� �޿��� �����ͼ� select�Ͽ� ����ϴ� ���ν��� ����
-- ���� ù �����̶�� ���ʷ� �� �� �����ؾ߸� ����� ȭ�鼭 ����� �� �ִ�.
create procedure pcd_emp_salary
is
    -- PL/SQL�� declare���� ������ ���������� ���ν����� �Լ��� is������
    -- ������ �����Ѵ�. ���� ������ �ʿ���ٸ� ������ �� �ִ�.
    -- ������̺��� �޿� �÷��� �����ϴ� ���������� �����Ѵ�.
    v_salary employees.salary%type;
begin
    -- 100�� ����� �޿��� into�� �̿��Ͽ� ������ �Ҵ��Ѵ�.
    select salary into v_salary
    from employees
    where employee_id = 100;
    
    dbms_output.put_line('�����ȣ100�� �޿���:'|| v_salary ||'�Դϴ�');
end;
/
-- ������ �������� Ȯ���Ѵ�. ����� �����ڷ� ��ȯ�ǹǷ� ��ȯ�Լ��� ���°� ����.
select * from user_source where name like upper('%pcd_emp_salary%');

-- ���ν����� ������ ȣ��Ʈ ȯ�濡�� execute����� �̿��Ѵ�.
execute pcd_emp_salary;

--����2] IN�Ķ���� ����Ͽ� ���ν��� ����
/*
�ó�����] ����� �̸��� �Ű������� �޾Ƽ� ������̺��� ���ڵ带 ��ȸ����
�ش����� �޿��� ����ϴ� ���ν����� ���� �� �����Ͻÿ�.
�ش� ������ in�Ķ���͸� ������ ó���Ѵ�.
����̸�(first_name) : Bruce, Neena
*/
-- ���ν��� ������ in�Ķ���͸� �����Ѵ�. ������̺��� ����� �÷��� �����ϴ�
-- ���������� �����Ѵ�.
create procedure pcd_in_param_salary
    (param_name in employees.first_name%type)
is
    /*
    ������ is ���� �����ϰ�, �ʿ���� ��� �������� ���� ���� �ִ�.
    */
    valSalary number(10);
begin
    /*
    ���Ķ���ͷ� ���޵� ������� �������� �޿��� ���� �� ������ �Ҵ��Ѵ�.
    �ϳ��� ����� ��µǹǷ� into�� select������ ����� �� �ִ�.
    */
    select salary into valSalary
    from employees where first_name = param_name;
    
    -- �̸��� ���� �޿��� ����Ѵ�.
    dbms_output.put_line(param_name||'�� �޿��� '|| valSalary ||' �Դϴ�');
end;
/
-- ����� �̸��� �Ķ���ͷ� �����Ͽ� ���ν����� ȣ���Ѵ�.
execute pcd_in_param_salary('Bruce');
execute pcd_in_param_salary('Neena');

-- ����3] OUT�Ķ���� ����Ͽ� ���ν��� ����
/*
�ó�����] �� ������ �����ϰ� ������� �Ű������� ���޹޾Ƽ� �޿��� ��ȸ�ϴ�
���ν����� �����Ͻÿ�. ��, �޿��� out�Ķ���͸� ����Ͽ� ��ȯ�� ����Ͻÿ�
*/
/*
�ΰ��� ������ �Ķ���͸� �����Ѵ�. �Ϲݺ���, �������� ���� ����ߴ�.
�Ķ������ �뵵�� ���� in out�� ���� ����Ѵ�. �Ķ���͸� ������ ����
ũ��� ������� �ʴ´�.
*/
create or replace procedure pcd_out_param_salary
    (
        param_name in varchar2,
        param_salary out employees.salary%type
    )
is

    /*
    select�� ����� out �Ķ���͸� ������ ���̹Ƿ� ������ ������ �ʿ�����
    �ʾ� is���� ����д�. �̿Ͱ��� ���� ������ ������ �� �ִ�.
    */
begin
    /*
    in�Ķ���ʹ� where���� �������� ����ϰ�
    select�� ����� into������ out�Ķ���Ϳ� �����Ѵ�.
    */
    select salary into param_salary
    from employees where first_name = param_name;
end;
/
-- ȣ��Ʈ ȯ�濡�� ���ε� ������ �����Ѵ�. var �Ǵ� variable �� �� ��� ����
var v_salary varchar2(30);
/*
���ν��� ȣ�� �� ������ �Ķ���͸� �����Ѵ�. Ư�� ���ε� ������ :�� �ٿ��� �Ѵ�.
Out �Ķ������ param_salary�� ����� ���� v_salary�� ���޵ȴ�.
*/
execute pcd_out_param_salary('Matthew', :v_salary);
-- ���ν��� ���� �� out�Ķ���͸� ���� ���޵� ���� ����Ѵ�.
print v_salary;

/*
�ó�����] 
�����ȣ�� �޿��� �Ű������� ���޹޾� �ش����� �޿��� �����ϰ�, 
���� ������ ���� ������ ��ȯ�޾Ƽ� ����ϴ� ���ν����� �ۼ��Ͻÿ�
*/
-- �ǽ��� ���� employees ���̺��� ���ڵ���� �����Ѵ�.
create table zcopy_employees
    as
    select * from employees;
-- ����Ǿ����� Ȯ���Ѵ�.
select * from zcopy_employees;
-- in �Ķ���ʹ� �����ȣ�� �޿��� �����Ѵ�. out �Ķ���ʹ� ����� ���� ������
-- ��ȯ�޴´�.
create or replace procedure pcd_update_salary
    (
        p_empid in number,
        p_salary in number,
        rCount out number
    )
is
    -- �߰����� ���� ������ �ʿ�����Ƿ� �����Ѵ�.
begin
    -- ���� ������Ʈ�� ó���ϴ� ���������� in �Ķ���͸� ���� ���� �����Ѵ�.
    update zcopy_employees
        set salary = p_salary
        where employee_id = p_empid;
    /*
    SQL%notfound : ���� ���� �� ����� ���� ���� ��� true�� ��ȯ�Ѵ�.
        Found�� �ݴ��� ��츦 ��ȯ�Ѵ�.
    SQL%rowCount : ���� ���� �� ���� ����� ���� ������ ��ȯ�Ѵ�.
    */        
    if SQL%notfound then
        dbms_output.put_line(p_empid ||'��(��) ���� ����Դϴ�');
    else
        dbms_output.put_line(SQL%rowcount ||'���� �ڷᰡ �����Ǿ����ϴ�');
        
        -- ���� ����� ���� ������ ��ȯ�Ͽ� out �Ķ���Ϳ� �����Ѵ�.
        rCount := sql%rowcount;
    end if;
    
    /*
    ���� ��ȭ�� �ִ� ������ ������ ��� �ݵ�� commit�ؾ� ���� ���̺� ����Ǿ�
    oracle �ܺο��� Ȯ���� �� �ִ�.
    */
    commit;
end;
/
-- ���ν��� ������ ���� ���ε� ���� ����
variable r_count number;
-- 100�� ����� �̸��� �޿��� Ȯ���Ѵ�. : Steven 24000
select first_name, salary from zcopy_employees where employee_id=100;
-- ���ν��� ����. ���ε� �������� �ݵ�� :�� �ٿ��� �Ѵ�.
execute pcd_update_salary(100, 30000, :r_count);
-- update�� ����� ���� ���� Ȯ��
print r_count;
-- ������Ʈ �� ������ Ȯ���Ѵ�. : Steven 30000
select first_name, salary from zcopy_employees where employee_id=100;

-----------------------------------------------------------------------------
/*
2. �Լ�
    - ����ڰ� PL/SQL���� ����Ͽ� ����Ŭ���� �����ϴ� �����Լ��� ���� �����
    ������ ���̴�.
    - �Լ��� In�Ķ���͸� ����� �� �ְ�, �ݵ�� ��ȯ�� ���� �ڷ����� ����ؾ�
    �Ѵ�.
    - ���ν����� �������� ������� ���� �� ������, �Լ��� �ݵ�� �ϳ���
    ���� ��ȯ�ؾ� �Ѵ�.
    - �Լ��� �������� �Ϻκ����� ���ȴ�.
    * �Ķ���� ��ȯŸ���� ����� �� ũ��� ������� �ʴ´�.
*/
/*
�ó�����] 
2���� ������ ���޹޾Ƽ� �� ���������� ������ ���ؼ� ����� ��ȯ�ϴ� �Լ��� �����Ͻÿ�.
���࿹) 2, 7 -> 2+3+4+5+6+7 = ??
*/
-- �Լ��� in�Ķ���͸� �����Ƿ� in�� �ַ� �����Ѵ�.
create or replace function calSumBetween (
    num1 in number,
    num2 number
)
return
    -- �Լ��� �ݵ�� ��ȯ���� �����Ƿ� ��ȯŸ���� ����ؾ� �ȴ�.
    number
is
    -- ��ȯ������ ����� ���� ����(����: �ʿ���ٸ� ���� �����ϴ�.)
    sumNum number;
begin
    sumNum := 0;
    
    -- for ���������� ���� ������ ���� ����� �� ��ȯ�Ѵ�.
    for i in num1 .. num2 loop
        -- �����ϴ� ���� i�� sumNum�� �����ؼ� �����ش�.
        sumNum := sumNum + i;
    end loop;
    
    -- ������� ��ȯ�Ѵ�.
    return sumNum;
end;
/
-- ������1 : �������� �Ϻη� ����Ѵ�.
select calSumBetween(1,10) from dual;

-- ������2 : ���ε� ������ ���� ���� ������� �ַ� ���������� ����Ѵ�.
var hapText varchar2(30);

execute :hapText := calSumBetween(1,100);
print hapText;

-- ������ �������� Ȯ���ϱ�
select * from user_source where name=upper('calSumBetween');

/*
��������] 
����] �ֹι�ȣ�� ���޹޾Ƽ� ������ �Ǵ��ϴ� �Լ��� �����Ͻÿ�.
990909-1000000 -> '����' ��ȯ
990919-2000000 -> '����' ��ȯ
��, 2000�� ���� ����ڴ� 3�� ����, 4�� ������.
�Լ��� : findGender()
*/
select substr('990909-1000000', 8, 1) from dual;
select substr('990919-2000000', 8, 1) from dual;

-- �ش� �Լ��� �ֹι�ȣ�� �������·� �޾Ƽ� ������ �Ǵ��Ѵ�.
-- �Լ�(funtion)�� in�Ķ���͸� �����Ƿ� in�� �����ϴ� ���� ����.
create or replace function findGender(juminNum varchar2)
-- ����� �ݵ�� ��ȯŸ���� ����ؾ� �Ѵ�. ���� �Ǵ� �� '����' Ȥ�� '����'��
-- ��ȯ�ϹǷ� ���������� �����Ѵ�.
return varchar2
is
    -- �ֹι�ȣ���� ������ �ش��ϴ� ���ڸ� ������ ����
    genderTxt varchar2(1);
    -- ������ ������ �� ��ȯ�� ����
    returnVal varchar2(10);
begin
    -- ���1
    -- �������� ����� ����� into�� ���� ������ �����Ѵ�.
     select substr(juminNum, 8, 1) into genderTxt from dual;
    
    -- ���2 : substr()�� ���� ���
    -- genderTxt := substr(juminNum, 8,1);
    
    if genderTxt = '1' then
        returnVal := '����';
    elsif genderTxt = '2' then
        returnVal := '����';
     elsif genderTxt = '3' then
        returnVal := '����';
     elsif genderTxt = '4' then
        returnVal := '����';
     else 
        returnVal := '����';
    end if;
    -- �Լ��� �ݵ�� ��ȯ���� ������.
    return returnVal;
end;
/

select findGender('990909-1000000') from dual;
select findGender('990919-2000000') from dual;
select findGender('990909-3000000') from dual;
select findGender('990919-4000000') from dual;
select findGender('990909-5000000') from dual;

/*
�ó�����] ����� �̸�(first_name)�� �Ű������� ���� �޾Ƽ�
    �μ���(department_name)�� ��ȯ�ϴ� �Լ��� �ۼ��Ͻÿ�.
    �Լ��� : func_departName
*/
-- 1�ܰ� : Namcy�� �μ����� ����ϱ� ���� inner join�� �ۼ�
select
    first_name, last_name, department_id, department_name
 from employees inner join departments using (department_id)
 where first_name = 'Nancy';

-- 2�ܰ� : �Լ� �ۼ�
create or replace function func_departName (
    -- ����� �̸��� �ޱ� ���� �Ķ���� ����
    param_name varchar2)
    return
        -- �μ����� ��ȯ�ϹǷ� ���������� �����Ѵ�.
        varchar2
    is
        -- �μ����̺��� �μ����� �����ϴ� ���������� ����
        return_deptname departments.department_name%type;
begin
    -- �������� ������ �� ������� ������ �����Ѵ�.
    select
        department_name into return_deptname
    from employees inner join departments using(department_id)
    where first_name = param_name;
    
    -- ��� ��ȯ
    return param_name;
end;
/
select func_departName('Nancy') from dual;  -- Finance ��ȯ
select func_departName('Diana') from dual;  -- IT ��ȯ

/*
3. Ʈ����(Trigger)
    : �ڵ����� ����Ǵ� ���ν����� ���� ������ �а��� �ϳ�.
    �ַ� ���̺� �Էµ� ���ڵ��� ��ȭ�� ���� �� �ڵ����� �����Ѵ�.
*/
-- Ʈ���� �ǽ��� ���� HR�������� �Ʒ� ���̺��� �����Ѵ�.
-- ���̺��� ���ڵ���� ��� �����Ѵ�.
create table trigger_dept_original
as
select * from departments;
-- ���̺��� ��Ű��(����)�� �����Ѵ�. where���� ������ ������ �ָ� ���ڵ��
-- select ���� �ʴ´�.
create table trigger_dept_backup
as
select * from departments where 1=0;
/*
����1] trig_dept_backup
�ó�����] ���̺� ���ο� �����Ͱ� �ԷµǸ� �ش� �����͸� ������̺� �����ϴ�
Ʈ���Ÿ� �ۼ��غ���.
*/
create or replace trigger trig_dept_backup
    after   -- Ÿ�̹� : after => �̺�Ʈ �߻� ��, before => �̺�Ʈ �߻� ��
    INSERT  -- �̺�Ʈ : insert/update/delete�� ���� ���� ���� �� �߻��ȴ�.
    on trigger_dept_original    -- Ʈ���Ÿ� ������ ���̺��
    for each row
    /*
        �� ���� Ʈ���� �����Ѵ�. �� �ϳ��� ���� ��ȭ�� ������ Ʈ���Ű�
        ����ȴ�. ���� ����(���̺�)���� Ʈ���ŷ� �����ϰ� �ʹٸ� �ش�
        ������ �����ϸ� �ȴ�. �� ���� ������ �� �� ������ �� Ʈ���ŵ� ��
        �� ���� ����ȴ�.
    */
    
begin
    -- insert �̺�Ʈ�� �߻��Ǹ� true�� ��ȯ�Ͽ� if���� ����ȴ�.
    if Inserting then
        dbms_output.put_line('insert Ʈ���� �߻���');
        
        /*
        ���ο� ���ڵ尡 �ԷµǾ����Ƿ� �ӽ����̺� : new�� ����ǰ�
        �ش� ���ڵ带 ���� backup���̺� �Է��� �� �ִ�.
        �̿� ���� �ӽ����̺��� ����� Ʈ���ſ����� ����� �� �ִ�. 
        */
        insert into trigger_dept_backup
        values (
            :new.department_id,
            :new.department_name,
            :new.manager_id,
            :new.location_id
        );
    end if;
end;
/

set serveroutput on;

insert into trigger_dept_original values (101, '������', 10, 100);
insert into trigger_dept_original values (102, '������', 20, 100);
insert into trigger_dept_original values (103, '������', 30, 100);
select * from trigger_dept_original;
select * from trigger_dept_backup;

--����2] trig_dept_delete
/*�ó�����] �������̺��� ���ڵ尡 �����Ǹ� ������̺��� ���ڵ嵵 ����
�����Ǵ� Ʈ���Ÿ� �ۼ��غ���.
*/
create or replace trigger tring_dept_delete
    /*
    trigger_dept_original���� ���ڵ带 ������ �� ������� �ش� Ʈ���Ÿ�
    �����Ѵ�.
    */
    after
    delete
    on trigger_dept_original
    for each row
begin
    dbms_output.put_line('delete Ʈ���� �߻���');
    /*
    ���ڵ尡 ������ ���Ŀ� �̺�Ʈ�� �߻��Ǿ� Ʈ���Ű� ȣ��ǹǷ�
    : old �ӽ����̺��� ����Ѵ�.
    */
    if deleting then
        delete from trigger_dept_backup
            where department_id = :old.department_id;
    end if;
end;
/
-- �Ʒ��� ���� ���ڵ带 �����ϸ� Ʈ���Ű� �ڵ�ȣ�� �ȴ�.
delete from trigger_dept_original where department_id=101;
delete from trigger_dept_original where department_id=102;
select * from trigger_dept_original;
select * from trigger_dept_backup;

-- ����3] trigger_update_test
/*
For each row �ɼǿ� ���� Ʈ���� ����Ƚ�� �׽�Ʈ

����1 : �������� ���̺� ������Ʈ ���� ������� �߻��Ǵ� Ʈ���� ����

*/
create or replace trigger trigger_update_test
    after update
    on trigger_dept_original
    for each row
begin
    /*
    ������Ʈ �̺�Ʈ�� �����Ǹ� backup���̺� ���ڵ带 �Է��Ѵ�.
    */
    if updating then
        insert into trigger_dept_backup
        values (
            :old.department_id,
            :old.department_name,
            :old.manager_id,
            :old.location_id
        );
    end if;
end;
/
-- 5���� ���ڵ尡 ����Ǵ� ���� Ȯ���Ѵ�.
select * from trigger_dept_original where
    department_id >= 10 and department_id<=50;
    
-- ������Ʈ ����(5���� ���ڵ尡 ������Ʈ �ȴ�.)
update trigger_dept_original set department_name='5��������Ʈ'
    where department_id>=10 and department_id<=50;
-- ���� ���̺��� 5���� ���ڵ尡 ������Ʈ �ǹǷ�, ������̺��� 5����
-- �Էµȴ�. ����� Ʈ���Ŵ� ����� ���� ������ŭ ����ȴ�.
select * from trigger_dept_original;
select * from trigger_dept_backup;

/*
����2 : �������� ���̺� ������Ʈ ���� ���̺�(����) ������ �߻��Ǵ� 
    Ʈ���� ����
*/
create or replace trigger trigger_update_test2
    after update
    on trigger_dept_original
   /* for each row*/
   /*
   �������� ���̺��� ���ڵ带 ������Ʈ �� ���� ���̺� ������ Ʈ���Ű�
   ����ǹǷ� ����� ������ ������� ������ �� ���� Ʈ���Ű� ����ȴ�.
   */
begin
    /*
    ������Ʈ �̺�Ʈ�� �����Ǹ� backup���̺� ���ڵ带 �Է��Ѵ�.
    */
    if updating then
        insert into trigger_dept_backup
        values (
        /*
        ���̺�(����) ���� Ʈ���ſ����� �ӽ����̺� ����� �� ����.
            :old.department_id,
            :old.department_name,
            :old.manager_id,
            :old.location_id*/
            999, to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'),99,99
        );
    end if;
end;
/
-- ������Ʈ ����(5���� ���ڵ尡 ������Ʈ �ȴ�.)
update trigger_dept_original set department_name='5��������Ʈ2'
    where department_id>=10 and department_id<=50;
-- 5���� ���ڵ带 ������Ʈ �������� ���̺���� Ʈ�����̹Ƿ� 1���� �Էµȴ�.
select * from trigger_dept_original;
select * from trigger_dept_backup;

-- Ʈ���� �����ϱ�
drop trigger trigger_update_test;
drop trigger trigger_update_test2;
