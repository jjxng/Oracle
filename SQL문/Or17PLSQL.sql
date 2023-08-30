/***************
���ϸ� :  Or17PLSQL.sql
PL/SQL
���� : ����Ŭ���� �����ϴ� ���α׷��� ��� 
****************/
-- hr�������� �����մϴ�.
/*
PL/SQL(procedural language)
    : �Ϲ� ���α׷��� ���� ������ �ִ� ��Ҹ� ��� ������ ������ DB������
    ó���ϱ� ���� ����ȭ�� ����̴�.
*/

set serveroutput on;

declare
    cnt number;
begin
    cnt := 10;
    cnt := cnt + 1;
    dbms_output.put_line(cnt);
end;
/
/*
    PL/SQL ������ ������ /�� �ٿ��� �ϴµ�, ���� ������
    ȣ��Ʈ ȯ������ ���������� ���Ѵ�. ��, PL/SQL ������ ����
    �ʿ��ϴ�.
    ȣ��Ʈȯ���̶� �������� �Է��ϱ� ���� SQL> ���¸� ���Ѵ�.
*/

-- ����2] �Ϲݺ��� �� info
/*
�ó�����] ��� ���̺��� �����ȣ�� 120�� ����� �̸��� ����ó�� ����ϴ�
    PL/SQL ���� �ۼ��Ͻÿ�.
*/
select * from employees where employee_id=120;

select concat(first_name||' ', last_name), phone_number
from employees where employee_id=120;

declare
    /*
    ����ο��� ������ ������ ���� ���̺� �����ÿ� �����ϰ� �����Ѵ�.
    => ������ �ڷ���(Ū;)
    ��, ������ ������ �÷��� Ÿ�԰� ũ�⸦ �����Ͽ� �������ִ� ���� ����.
    �Ʒ� '�̸�'�� ��� �ΰ��� �÷��� ������ �����̹Ƿ� ���� �� �˳���
    ũ��� ������ �ִ� ���� ����.
    */
    empName varchar2(60);
    empPhone varchar2(30);
begin
    /*
    ����� : select������ ������ ���������ο��� ������ ������
        1:1�� �����Ͽ� ���� �����Ѵ�. �̶� into�� ����Ѵ�.
    */
    select
        concat(concat(first_name,' '), last_name),
        phone_number
    into
        empName, empPhone
    from employees
    where employee_id=120;
 dbms_output.put_line(empName ||' '|| empPhone);
end;
/   
    

-- ����3] ��������1 (�ϳ��� �÷� ����)
/*
    �������� : Ư�� ���̺��� �÷��� �����ϴ� �����ν� ������ �ڷ�����
        ũ��� �����ϰ� ������ ����Ѵ�.
        ����] ���̺��.�÷���%type
        => ���̺��� '�ϳ�'�� �÷��� �����Ѵ�.
*/
/*
�ó�����] �μ���ȣ 10�� ����� �����ȣ, �޿�, �μ���ȣ�� �����ͼ�
    �Ʒ� ������ ���� �� ȭ��� ����ϴ� PL/SQL���� �ۼ��Ͻÿ�.
    ��, ������ ���� ���̺��� �ڷ����� �����ϴ� '��������'�� �����Ͻÿ�.
*/
-- �ó������� ���ǿ� �´� select���� �ۼ��Ͻÿ�,
select employee_id, salary, department_id 
 from employees where department_id=10;
    
declare
    -- ��� ���̺��� Ư�� �÷��� Ÿ�԰� ũ�⸦ �״�� �����ϴ� ������ �����Ѵ�.
    empNo employees.employee_id%type;       -- NUMBER(6,0)
    empSal employees.salary%type;           -- NUMVER(8,2)
    deptId employees.department_id%type;    -- NUMBER(4,0)�� �����ϰ� �����
begin
    -- select�� ����� into�� ���� ������ ������ �Ҵ��Ѵ�.
    select employee_id, salary, department_id
        into empNo, empSal, deptId
    from employees where department_id=10;
    
    dbms_output.put_line(empNo ||' '|| empSal ||' '|| deptId);
end;
/

-- ����4] ��������2 (��ü�÷��� ����)
/*
�ó�����] �����ȣ�� 100�� ����� ���ڵ带 �����ͼ� emp_row ������ ��ü �÷���
    ������ �� ȭ�鿡 ���� ������ ����Ͻÿ�.
    ��, emp_row�� ��� ���̺��� ��ü�÷��� ������ �� �ִ� ���������� �����ؾ��Ѵ�.
    ������� : �����ȣ, �̸�, �̸���, �޿�
*/
declare
    /*
    ������̺� ��ü �÷��� �����ϴ� ���������� �����Ѵ�. �̶� ���̺��
    �ڿ� %rowtype�� �ٿ� �����Ѵ�.
    */
    emp_row employees%rowtype;        
begin
    /*
    ���ϵ�ī�� *�� ���� ���� ��ü�÷��� ���� emp_row�� �Ѳ�����
    �����Ѵ�.
    */
     select *
        into emp_row
    from employees where employee_id=100;
    /*
    emp_row���� ��ü�÷��� ������ ����ǹǷ� ��½� ������.�÷���
    ���·� ����ؾ� �Ѵ�.
    */
    dbms_output.put_line(emp_row.employee_id ||' '||
                    emp_row.first_name || ' '||
                    emp_row.email ||' '||
                    emp_row.salary);
end;
/    

-- ����5] ���պ���
/*
���պ���
    : class�� �����ϵ� �������� �ڷ����� ���� �ϳ��� �ڷ����� ���� ��
    �����ϴ� ������ ���Ѵ�.
    ����]
        type ���պ����ڷ��� is record(
            �÷���1 �ڷ���(ũ��),
            �÷���2 ���̺��.�÷���%type
        );
    �տ��� ������ �ڷ����� ������� ������ �����Ѵ�.
    ���պ��� �ڷ����� ���� ���� �Ϲݺ���ȭ �������� 2������ �����ؼ�
    ����� �� �ִ�.
*/
/*
�ó�����] �����ȣ, �̸�(first_name+last_name), ���������� ������ �� �ִ� 
���պ����� ������ ��, 100�� ����� ������ ����ϴ� PL/SQL�� �ۼ��Ͻÿ�.
*/
select employee_id, first_name||' '||last_name, job_id
 from employees where employee_id=100;
 
declare
    type emp_3type is record(
        emp_id employees.employee_id%type,
        emp_name varchar2(60),
        emp_job employees.job_id%type
    );
    record3 emp_3type;
begin  
    select employee_id, first_name||' '||last_name, job_id
        into record3
    from employees where employee_id=100;
 
    dbms_output.put_line(record3.emp_id ||' '||
                        record3.emp_name || ' '||
                        record3.emp_job);
end;
/  
/*
����] �Ʒ� ������ ���� PL/SQL���� �ۼ��Ͻÿ�.
1.���պ�������
- �������̺� : employees
- ���պ����ڷ����� �̸� : empTypes
        ���1 : emp_id -> �����ȣ
        ���2 : emp_name -> �������ü�̸�(�̸�+��)
        ���3 : emp_salary -> �޿�
        ���4 : emp_percent -> ���ʽ���
������ ������ �ڷ����� �̿��Ͽ� ���պ��� rec2�� ������ �����ȣ 100����
������ �Ҵ��Ѵ�.
2.1�� ������ ����Ѵ�.
3.�� ������ �Ϸ����� ġȯ�����ڸ� ����Ͽ� �����ȣ�� ����ڷκ��� �Է¹��� ��
�ش� ����� ������ ����Ҽ��ֵ��� �����Ͻÿ�.[����]
*/
select 
    employee_id, first_name||' '||last_name, salary, nvl(commission_pct,0)
 from employees where employee_id=145;
 
declare
    type empTypes is record(
        emp_id employees.employee_id%type,
        emp_name varchar2(60),
        emp_salary employees.salary%type,
        emp_percent employees.commission_pct%type
    );
    rec2 empTypes;
begin  
    select employee_id, first_name||' '||last_name, salary, 
    nvl(commission_pct,0) into rec2
    from employees where employee_id=145;

    dbms_output.put_line('�����ȣ / ����� / �޿� / ���ʽ���');
    dbms_output.put_line(rec2.emp_id ||' '||rec2.emp_name ||' '
            ||rec2.emp_salary||' '||rec2.emp_percent);
end;
/  

/*
ġȯ������ : PL/SQL���� ����ڷκ��� �����͸� �Է¹��� �� ����ϴ� �����ڷ�
    ���� �տ� &�� �ٿ��ָ� �ȴ�. ���� �� �Է�â�� ���.
*/
-- �տ��� �ۼ��� PL.SQL
select 
    employee_id, first_name||' '||last_name, salary, nvl(commission_pct,0)
 from employees where employee_id=145;
 
declare
    type empTypes is record(
        emp_id employees.employee_id%type,
        emp_name varchar2(60),
        emp_salary employees.salary%type,
        emp_percent employees.commission_pct%type
    );
    rec2 empTypes;
    -- ġȯ�����ڸ� ���� �Է¹��� ���� �Ҵ��Ͽ� ������ �����Ѵ�.
    inputNum number(3);
begin  
    -- �Է� ���� �����ȣ�� ������ �����Ѵ�.
    select employee_id, first_name||' '||last_name, salary, 
    nvl(commission_pct,0) into rec2
    from employees where employee_id=&inputNum;

    dbms_output.put_line('�����ȣ / ����� / �޿� / ���ʽ���');
    dbms_output.put_line(rec2.emp_id ||' '||rec2.emp_name ||' '
            ||rec2.emp_salary||' '||rec2.emp_percent);
end;
/  

/*
���ε� ����
    : ȣ��Ʈ ȯ�� ����� �����ν� �� PL/SQL �����̴�.
    ȣ��Ʈ ȯ���̶� PL/SQL�� ���� ������ ������ �κ��� ���Ѵ�.
    �ܼ�(CMD)������ SQL>��� ������Ʈ�� �ִ� ���¸� ���Ѵ�.
    
    ����]
        var ������ �ڷ���;
        Ȥ��
        variable ������ �ڷ���;
*/
set serveroutput on;
-- ȣ��Ʈ ȯ�濡�� ���ε庯�� ����
var return_var number;
-- PL/SQL �ۼ�
declare
    -- ����ο��� �̿Ͱ��� �ƹ����� ���� ���� �ִ�.
begin
    -- ���̵� ������ �Ϲݺ������� ������ ���� :(�ݷ�)�� �߰��ؾ� �Ѵ�.
    :return_var := 999;
    dbms_output.put_line(:return_var);
end;
/
-- ȣ��Ʈ ȯ�濡�� ��½ÿ��� print�� ����Ѵ�.
-- ���� ����� �ȵȴٸ� CMD���� Ȯ���غ��� ���������� ��µȴ�.
print return_var;

-- ����7] ���(���ǹ� : if)
--�ó�����] ������ ����� ���ڰ� Ȧ�� or ¦������ �Ǵ��ϴ� PL/SQL�� �ۼ��Ͻÿ�.
-- if�� : Ȧ���� ¦���� �Ǵ��ϴ� if�� �ۼ�
declare
    -- ����ο��� ����Ÿ���� ������ ����
    num number;
begin
    -- 10�� �Ҵ��� �� ¦������ �Ǵ��Ѵ�.
    num := 10;
    -- mod(����, ����) : ������ ������ ���� �������� ��ȯ�ϴ� �Լ�
    if mod(num,2) = 0 then
        dbms_output.put_line(num ||'�� ¦��');
    else
        dbms_output.put_line(num ||'�� Ȧ��');
    end if;
end;
/

-- ����] �� ������ ġȯ�����ڸ� ���� ���ڸ� �Է� ���� �� �ֵ��� �����Ͻÿ�.
declare
    -- ����ο��� ����Ÿ���� ������ ����
    num number;
begin
    /*
    ġȯ�����ڴ� �����, ����� ���� ����� �� �ִ�. ���� ����ο���
    ����ߴٸ� �Ʒ��� �Ҵ繮�� �ʿ����.
    */
    num := &num;
    -- mod(����, ����) : ������ ������ ���� �������� ��ȯ�ϴ� �Լ�
    if mod(num,2) = 0 then
        dbms_output.put_line(num ||'�� ¦��');
    else
        dbms_output.put_line(num ||'�� Ȧ��');
    end if;
end;
/

-- ����8] ���(���ǹ� : if-elsif)
/*
�ó�����] �����ȣ�� ����ڷκ��� �Է¹��� �� �ش� ����� ��μ�����
�ٹ��ϴ����� ����ϴ� PL/SQL���� �ۼ��Ͻÿ�. ��, if~elsif���� ����Ͽ�
�����Ͻÿ�.
*/
declare
    -- ġȯ�����ڸ� ���� �����ȣ�� �Է¹���
    emp_id employees.employee_id%type := &emp_id;
    emp_name varchar2(50);
    emp_dept employees.department_id%type;
    -- �μ����� ����� ���ÿ� �ʱ�ȭ�Ѵ�. ��ġ�ϴ� ������ ���� ���
    -- �ʱⰪ���� ��µȴ�.
    dept_name varchar2(30) := '�μ���������';
begin
    select employee_id, last_name, department_id
        into emp_id, emp_name, emp_dept
    from employees
    where employee_id = emp_id; -- �Է¹��� �����ȣ�� ������ �����Ѵ�.
    
    /*
    �������� ������ ����� ��� java�� ���� else if�� ������� �ʰ�
    elsif�� ����ؾ� �Ѵ�. ����, �߰�ȣ ��� then�� end if;�� ���Ⱥ��.
    */
    if emp_dept = 50 then
        dept_name := 'Shipping';
    elsif emp_dept = 60 then
        dept_name := 'IT';
    elsif emp_dept = 70 then
        dept_name := 'Public Relations';
    elsif emp_dept = 80 then
        dept_name := 'Sales';
    elsif emp_dept = 90 then
        dept_name := 'Executive';
    elsif emp_dept = 100 then
        dept_name := 'Finance';
    end if;
    
    dbms_output.put_line('�����ȣ'|| emp_id ||'�� ����');
    dbms_output.put_line('�̸�:'|| emp_name
            ||', �μ���ȣ:'|| emp_dept
            ||', �μ���:'|| dept_name );
end;
/
/*
case�� : 

�ó�����] �տ��� if~elsif�� �ۼ��� PL/SQL���� case~when������ �����Ͻÿ�.
*/    
declare
    emp_id employees.employee_id%type := &emp_id;
    emp_name varchar2(50);
    emp_dept employees.department_id%type;
    dept_name varchar2(30) := '�μ���������';
begin
    select employee_id, last_name, department_id
        into emp_id, emp_name, emp_dept
    from employees
    where employee_id = emp_id;
    
    /*
    case~when���� if���� �ٸ����� �Ҵ��� ������ ���� ������ �� ���� ������
    ������ �Ǵ��Ͽ� �ϳ��� ���� �Ҵ��ϴ� ����̴�. ���� ������
    �ߺ����� ������� �ʾƵ� �ȴ�.
    */
    dept_name :=
        case emp_dept
            when 50 then 'Shipping'
            when 60 then 'IT'
            when 70 then 'Public Relations'
            when 80 then 'Sales'
            when 90 then 'Executive'
            when 100 then 'Finance'
    end;

    dbms_output.put_line('�����ȣ'|| emp_id ||'�� ����');
    dbms_output.put_line('�̸�:'|| emp_name
            ||', �μ���ȣ:'|| emp_dept
            ||', �μ���:'|| dept_name );
end;
/
-------------------------------------------------------------------------------
-- ���(�ݺ���)
/*
�ݺ���1 : Basic loop
    Java�� do~while���� ���� ����üũ ���� loop������ �� Ż�� ������ 
    �ɶ����� �ݺ��Ѵ�. Ż�� �ÿ��� exit�� ����Ѵ�.
*/

-- ����10] ���(�ݺ��� : basic loop)
declare
    num number := 0;
begin
    -- ���� üũ���� ������ �����Ѵ�.
    loop 
        -- 0~10���� ����Ѵ�.
        dbms_output.put_line(num);
        -- ���������� ���մ��Կ����ڰ� �����Ƿ� �Ϲ����� �������
        -- ������ �������Ѿ� �Ѵ�.
        num := num +1;
        -- num�� 10�� �ʰ��ϸ� loop���� Ż���Ѵ�.
        -- exit�� Java�� break;�� ������ ������ �Ѵ�.
        exit when (num>10);
    end loop;
end;
/
  
-- ����11] ��� �ݺ��� : basic loop) 
/*
�ó�����] Basic loop������ 1���� 10������ ������ ���� ���ϴ� ���α׷��� 
�ۼ��Ͻÿ�.
*/
declare
    -- �ݺ������� ������ų ����
    i number := 1;
    -- �������� ������ ����
    sumNum number := 0;
    -- ���������� sum�� ����� �� ����. �����(�׷��Լ�)�̹Ƿ� ������ �߻��Ѵ�.
begin
    loop
        -- �����ϴ� ���� i�� �����ؼ� ���Ѵ�.
        sumNum := sumNum + i;
        -- ���� i�� 1�� �����Ѵ�.
        i := i + 1;
        -- 10�� �ʰ��ϸ� Ż���Ѵ�.
        exit when (i > 10);
    end loop;
    dbms_output.put_line('1~10������ ����:'|| sumNum);
end;
/

/*
�ݺ���1 : while��
    Basic loop�ʹ� �ٸ��� ������ ���� ������ �� �����Ѵ�.
    ��, ���ǿ� ���� �ʴ´ٸ� �ѹ��� ������� ���� �� �ִ�.
    �ݺ��� ������ �����Ƿ� Ư���� ��찡 �ƴ϶�� exit�� ������� �ʾƵ� �ȴ�.
*/
--����12] ���(�ݺ��� : while)
declare
    num1 number := 0;
begin
    -- while�� ������ ������ Ȯ���Ѵ�.
    while num1<11 loop
    -- 0~10���� ����Ѵ�.
         dbms_output.put_line('�̹����ڴ�:'|| num1);
         num1 := num1 + 1;
    end loop;
end;
/
--����13] ���(�ݺ��� : while)
/*
�ó�����] while loop������ ������ ���� ����� ����Ͻÿ�.
*
**
***
****
*****
*/
declare
    -- *�� �����ؼ� ������ ������ ���� ����
    starStr varchar2(100);
    -- �ݺ��� ���ؼ� ���� ��� �� �ʱ�ȭ
    i number := 1;
    j number := 1;
begin
    while i <= 5 loop
    -- *�� �����ؼ�  �����Ѵ�.
         while j <= 5 loop
            starStr := starStr || '*';
            -- ������ *�� ����Ѵ�.
            exit when (j<=i);
            j := j+1;
        end loop;
        dbms_output.put_line(starStr);
        i := i +1;
        j := 1;
    end loop;
end;
/

-- ����14] ���(�ݺ��� : while)
/*
�ó�����] while loop������ 1���� 10������ ������ ���� ���ϴ� ���α׷��� 
�ۼ��Ͻÿ�.
*/
declare
    i number := 1;
    sumNum number := 0;
begin
    -- i�� 10������ ���� �����ؼ� �����ش�.
    while i <= 10 loop
            sumNum := sumNum + i;
            i := i + 1;
        end loop;
        dbms_output.put_line('1~10������ ����:'|| sumNum);
end;
/
/*
����15] ���(�ݺ��� : for)
    : �ݺ��� Ƚ���� �����Ͽ� ����� �� �ִ� �ݺ�������, �ݺ��� ���� ������
    ������ �������� �ʾƵ� �ȴ�. �׷��Ƿ� Ư���� ������ ������
    �����(declare)�� ������� �ʾƵ� �ȴ�.
*/
declare
    -- ������ ������ ����,
begin
    -- �ݺ��� ���� ������ ������ ���� ���� for������ ����� �� �ִ�.
    for num2 in 0 .. 10 loop
        dbms_output.put_line('for��¯�ε�:'|| num2);
    end loop;
end;
/
-- �ʿ���� ����� declare���� ������ �� �ִ�.
begin
    for num3 in reverse 0 .. 10 loop
        dbms_output.put_line('�Ųٷ�for��¯�ε�:'|| num3);
    end loop;
end;
/

-- ����16] ���(�ݺ��� : for) 
/*
��������] for loop������ �������� ����ϴ� ���α׷��� �ۼ��Ͻÿ�.
*/
-- �ٹٲ� �Ǵ� ����
begin
    -- 2~9�ܱ��� �ݺ�
    for dan in 2 .. 9 loop
        -- �� ���
        dbms_output.put_line(dan||'��');
        -- 1~9���� �ݺ�
        for su in 1 .. 9 loop
            -- �������� ��� ����ϰ� �ٹٲ� ó��
            dbms_output.put_line(dan||'*'||su||'='||(dan*su));
        end loop;
    end loop;
end;
/
-- �ٹٲ� �ȵǴ� ����
declare
    -- �����ܿ��� �ϳ��� ���� �����ϱ� ���� ����
    guguStr varchar2(1000);
begin
    -- �ܿ� �ش��ϴ� ����
    for dan in 2 .. 9 loop
        -- ���� �ش��ϴ� ����
        for su in 1 .. 9 loop
            -- �ϳ��� ���� ������ ������ �����ؼ� �����Ѵ�.
            guguStr := guguStr || dan ||'*'|| su ||'='|| (dan*su) ||' ';
        end loop;
        -- �ϳ��� ���� ������ �Ϸ�Ǹ� ��� ����Ѵ�.
        dbms_output.put_line(guguStr);
        -- �� ���� ���� �����ϱ� ���� �ʱ�ȭ�Ѵ�.
        guguStr := '';
    end loop;
end;
/  
/* 
Ŀ��(Cursor)
    : select ���忡 ���� �������� ��ȯ�Ǵ� ��� �� �࿡ �����ϱ� ���� ��ü
    ������]
        Cursor Ŀ���� Is
            Select ������. �� into���� ���� ���·� ����Ѵ�.
            
        Open Cursor
            : ������ �����϶�� �ǹ�. �� Open �� �� Cursor ������� select ������
            ����Ǿ� ������� ��Եȴ�. Curesor�� �� ������� ô��° �࿡
            ��ġ�ϰ� �ȴ�.
        Fetch~Into~
            : ����¿� �ϳ��� ���� �о���̴� �۾����� ������� ����(Fetch)
            �Ŀ� Cursor�� ���������� �̵��Ѵ�.
        Close Cursor
            : Ŀ�� �ݱ�� ������� �ڿ����� �ݳ��Ѵ�. select ������ ��� ó����
            �� Cursor�� �ݾ��ش�.
            
        Cursor�� �Ӽ�
            %Found : ���� �ֱٿ� ����(Fetch)�� ���� Return�ϸ� True, �ƴϸ�
                False�� ��ȯ�Ѵ�.
            %NotFoung : %Found�� �ݴ��� ���� ��ȯ�Ѵ�.
            %RowCount : ���ݱ��� return�� ���� ������ ��ȯ�Ѵ�.
����17] Cursor

/*
�ó�����] �μ����̺��� ���ڵ带 Cursor�� ���� ����ϴ� PL/SQL���� �ۼ��Ͻÿ�.
*/
declare
    -- �μ����̺��� ��ü �÷��� �����ϴ� �������� ����
    v_dept departments%rowtype;
    /*
    Ŀ������ : �μ� ���̺��� ��� ���ڵ带 ��ȸ�ϴ� select������ into����
        ���� ���·� ����Ѵ�.
        ������ ������ cur1�� ������ ����ȴ�.
    */
    cursor cur1 is
        select
            department_id, department_name, location_id
        from departments;
begin
    /*
    �ش� �������� �����ؼ� �����(ResultSet)�� �����´�. ������̶�
    ����(����)���� ������ �� ��ȯ�Ǵ� ���ڵ��� ����� ���Ѵ�.
    */
    open cur1;
    -- basic ���������� ���� ������� ������ŭ �ݺ��Ͽ� �����Ѵ�.
    loop
        -- fetch�� ����� ���������� ���� �����Ѵ�.
        fetch cur1 into
            v_dept.department_id,
            v_dept.department_name,
            v_dept.location_id;
            
        -- Ż�� �������� ���̻� ������ ���� ������ exit�� ����ȴ�.
        exit when cur1%notfound;
        
        dbms_output.put_line( v_dept.department_id||' '||
            v_dept.department_name||' '||
            v_dept.location_id);
    end loop;
    
    dbms_output.put_line('����� ���� ����:'|| cur1%rowcount);
    close cur1;
end;
/

/*
����18] Cursor
*/
/*
�ó�����] Cursor�� ����Ͽ� ������̺��� Ŀ�̼��� null�� �ƴ� ����� 
�����ȣ, �̸�, �޿��� ����Ͻÿ�. ��½ÿ��� �̸��� ������������ �����Ͻÿ�.
*/
-- ������ ���ǿ� �´� ������ �ۼ�
select * from employees where commission_pct is not nul;;

declare
    -- �ۼ��� ������ ���� Ŀ���� �����Ѵ�.
    cursor curEmp is
        select employee_id, last_name, salary
        from employees
        where commission_pct is not null
        order by last_name asc;
    -- ��� ���̺��� ��ü�÷��� �����ϴ� �������� ����
    varEmp employees%rowType;
begin
    -- Ŀ���� �����Ͽ� �������� �����Ѵ�.
    open curEmp;
    -- Basic loop���� ���� Ŀ���� ����� ������� �����Ѵ�.
    loop
        fetch curEmp
            into varEmp.employee_id, varEmp.last_name, varEmp.salary;
        -- ������ ������� ������ loop���� Ż���Ѵ�.
        exit when curEmp%notFound;
         dbms_output.put_line( varEmp.employee_id||' '||
                                 varEmp.last_name||' '||
                                 varEmp.salary);
    end loop;
    -- ���ϱ� ���� �� ��
    dbms_output.put_line('����� ���� ����:'|| curEmp%rowcount); 
    -- Ŀ���� �ݾ��ش�.
    close curEmp;
end;
/

/*
�÷���(�迭)
    : �Ϲ� ���α׷��� ���� ����ϴ� �迭Ÿ���� PL/SQL������ ���̺�Ÿ��
    �̶�� �Ѵ�. 1, 2���� �迭�� �����غ��� ���̺�(ǥ)�� ���� �����̱� �����̴�.
����
    - �����迭
    - Varray
    - ��ø���̺�
1. �����迭(Associative Array)
    : Key�� Value�� �� ������ ������ �÷������� Java�� �ؽ��ʰ� ���� �����̴�.
    Key : �ڷ����� �ַ� ���ڸ� ����Ѵ�. Binary_integer, pls_integer�� �ַ�
        ����ϴµ� numberŸ�Ժ��� ũ��� ������, ������꿡 ���� Ư¡��
        ������.
    Value : �������� �ַ� ����ϰ� varchar2�� ���� �ȴ�.
    ����] Type �����迭 �ڷ��� Is
            Table of ���� Ÿ��
            Index by Ű�� Ÿ��;
*/
/*
����19] �����迭(Associative Array)
*/
/*
�ó�����] ������ ���ǿ� �´� �����迭�� ������ �� ���� �Ҵ��Ͻÿ�.
    �����迭 �ڷ��� �� : avType, �����ڷ���:������, Ű���ڷ���:������
    key : girl, boy
    value : Ʈ���̽�, ��ź�ҳ��
    ������ : var_array
*/
-- ȭ��� ������ ����ϰ� ������ on���� �����Ѵ�. off�϶��� ��µ��� �ʴ´�.
set serveroutput on;
-- PL/SQL �ۼ�
declare
    -- �����迭 �ڷ��� �ۼ�
    Type avType Is
        Table Of varchar2(30)   -- value(��)�� �ڷ��� ����
        Index By varchar2(10);  -- key(Ű, �ε���)�� �ڷ��� ����
    -- �����迭 Ÿ���� ���� ����
    var_array avType;
begin
    -- �����迭 �� �Ҵ�
    var_array('girl') := 'Ʈ���̽�';
    var_array('boy') := '��ź�ҳ��';
    -- ���
    dbms_output.put_line(var_array('girl'));
    dbms_output.put_line(var_array('boy'));
end;
/

/*
����20] �����迭(Associative Array)
*/
/*
�ó�����] 100�� �μ��� �ٹ��ϴ� ����� �̸��� �����ϴ� �����迭�� �����Ͻÿ�.    
key�� ����, value�� full_name ���� �����Ͻÿ�.
*/
-- 100�� �μ��� �ٹ��ϴ� ���� ��� : 6��
select * from employees where department_id=100;

-- Full name�� ����ϱ� ���� ������ �ۼ�
select first_name||' '||last_name
    from employees where department_id=100;
    
-- ������ ������ ���� �������� �ټ����� ����Ǿ����Ƿ�  Cursor�� ����Ѵ�.  
declare
    -- �������� ���� Ŀ���� �����Ѵ�.
    cursor emp_cur is
        select first_name||' '||last_name from employees
        where department_id=100;
    -- �����迭 �ڷ��� ����(Key : ������, Value : ������)
    Type nameAvType Is
        Table Of varchar2(30)
        Index By binary_integer;
    -- �ڷ����� ������� ������ �����Ѵ�.
    names_arr nameAvType;
    -- ����� �̸��� �ε����� ����� ���� ����
    fname varchar2(50);
    idx number := 1;
begin
    /*
    Ŀ���� �����Ͽ� �������� ������ �� ���� ������� ������ŭ �ݺ��Ͽ�
    ������� �����Ѵ�.
    */
    open emp_cur;
    loop
        fetch emp_cur into fname;
        -- ���̻� ������ ������ ���ٸ� loop�� Ż���Ѵ�.
        exit when emp_cur%NotFound;
        -- �����迭 ������ ����̸��� �Է��Ѵ�.
        names_arr(idx) := fname;
        -- Ű�� ���� �ε����� ������Ų��.
        idx := idx + 1;
    end loop;
    close emp_cur;
    
    -- �����迭.count : �����迭�� ����� ������ ������ ��ȯ�Ѵ�.
    for i in 1 .. names_arr.count loop
        dbms_output.put_line(names_arr(i));
    end loop;
end;
/

/*
--����21] VArray(Variable Array)
    : �������̸� ���� �迭�ν� �Ϲ� ���η��� ���� ����ϴ� �迭��
    �����ϴ�. ũ�⿡ ������ �־ ������ �� ũ��(������ ����)�� �����ϸ�
    �̺��� ū �迭�� ���� �� ����.
    ����] Type �迭Ÿ�Ը� Is
            Array(�迭ũŰ) Of ���� Ÿ��;
*/
declare
    -- VArray Ÿ�Լ��� : ũ��� 5, ������ �����ʹ� ���������� �����Ѵ�.
    type vaType is
        array(5) of varchar2(20);
    -- VAarrya�� �迭���� ����
    v_arr vaType;
    -- �ε����� ����� ���� ���� �� �ʱ�ȭ
    cnt number := 0;
begin
    -- �����ڸ� ���� ���� �ʱ�ȭ �� 5�� �� 3���� �Ҵ��Ѵ�.
    v_arr := vaType('First', 'Second', 'Third','','');
    
    -- Basic �������� ���� �迭�� ���Ҹ� ����Ѵ�.(* �ε����� 1���� �����Ѵ�)
    loop
        cnt := cnt + 1;
        -- Ż�������� where ��� if�� ����� ���� �ִ�.
        if cnt>5 then
            exit;
        end if;
        -- �迭ó�� �ε����� ���� ����Ѵ�.
        dbms_output.put_line(v_arr(cnt));
    end loop;
    
    -- �迭�� ���� ���Ҵ�
    v_arr(3) := '�츮��';
    v_arr(4) := 'JAVA';
    v_arr(5) := '�����ڴ�';
    
    -- for���������� ����Ѵ�.
    for i in 1 .. 5 loop
        dbms_output.put_line(v_arr(i));
    end loop;
end;
/

--����22]  VArray(Variable Array)
/*
�ó�����] 100�� �μ��� �ٹ��ϴ� ����� �����ȣ�� �����Ͽ� VArray�� ������ ��
    ����ϴ� PL/SQL�� �ۼ��Ͻÿ�.
*/
-- 6���� ���ڵ尡 ����ȴ�.
select * from employees where department_id=100;

declare
    -- VAarry �ڷ��� ����. �迭�� ����� ���� ������̵� �÷��� �����Ͽ� ����
    type vaType1 is
        array(6) of employees.employee_id%Type;
    -- �迭 ���� ���� �� �����ڸ� ���� �ʱ�ȭ�� �����Ѵ�.
    va_one vaType1 := vaType1('','','','','','');
    cnt number := 1;
begin
    /*
    Java�� ������ for���� ����ϰ� ������ ����� ������ŭ �ڵ����� �ݺ��ϴ�
    ���·� ����Ѵ�. select���� employee_id�� ���� i�� �Ҵ�ǰ� �̸� ����
    ������ �� �ִ�.
    */
    for i in (select employee_id from employees
                        where department_id=100) loop
        va_one(cnt) := i.employee_id;
        cnt := cnt + 1;
    end loop;
    
    -- �迭�� ũ�⸸ŭ �ݺ��Ͽ� �� ���Ҹ� �����Ѵ�.
    for j in 1 .. va_one.count loop
        dbms_output.put_line(va_one(j));
    end loop;
end;
/

/*
3. ��ø ���̺�(Nested table)
    : Varry�� ����� ������ �迭�ν� �迭�� ũ�⸦ ������� �����Ƿ�
    �������� �迭�� ũ�Ⱑ �����ȴ�. ���⼭ ���ϴ� ���̺��� �ڷᰡ ����Ǵ�
    ���� ���̺��� �ƴ϶� �÷����� �� ������ �ǹ��Ѵ�.
    ����] Type ��ø���̺� Is
            Table Of ���� Ÿ��;
*/
--����23] ��ø���̺�(Nested Table)
declare
    -- ��ø���̺��� �ڷ����� ������ �� ���� ����
    type ntType is
        table of varchar2(30);
    nt_array ntType;
begin
    -- �����縦 ���� ���� �Ҵ��Ѵ�. �̴� ũ�� 4�� ��ø���̺��� �����ȴ�.
    nt_array := ntType('ù��°', '�ι�°', '����°','');
    
    dbms_output.put_line(nt_array(1));
    dbms_output.put_line(nt_array(2));
    dbms_output.put_line(nt_array(3));
    nt_array(4) := '�׹�° �Ҵ�';
    dbms_output.put_line(nt_array(4));
    
    -- �����߻�. ÷�ڰ� ������ �Ѿ����ϴ�.(�ڵ����� Ȯ����� �ʴ´�.)
--  nt_array(5) := '�ټ���°��??�Ҵ�??';

    -- ũ�⸦ Ȯ������ �� �����ڸ� ���� �迭�� ũ�⸦ �������� Ȯ���Ѵ�.
    -- ũ�Ⱑ 7�� ��ø���̺�� Ȯ��ȴ�.
    nt_array := ntType('1a', '2b', '3c', '4d', '5e', '6f', '7g');
    
    for i in 1 .. 7 loop
        dbms_output.put_line(nt_array(i));
    end loop;
end;
/

-- ����24] ��ø���̺�(Nested Table)
/*
�ó�����] ��ø���̺�� for���� ���� ������̺��� ��ü ���ڵ��� �����ȣ�� 
�̸��� ����Ͻÿ�.
*/
declare
    /*
    ��ø���̺� �ڷ��� ���� �� �������� : ������̺� ��ü �÷��� �����ϴ� 
        ���������� �����̹Ƿ� �ϳ��� ���ڵ�(Row)�� ������ �� �ִ� ����� ����
    */
    type ntType is
        table of employees%rowtype;
    nt_array ntType;
begin
    -- ũ�⸦ �������� ���� ���·� �����ڸ� ���� ��ø���̺��� �ʱ�ȭ �Ѵ�.
    nt_array := ntType();
    
    /*
    ��� ���̺��� ���ڵ� �� ��ŭ �ݺ��ϸ鼭 ���ڵ带 �ϳ��� ���� rec��
    �����Ѵ�. Ŀ��ó�� �����ϴ� for���� ���·� Java�� Ȯ�� for��ó��
    ����� �� �ִ�.
    */
    for rec in (select * from employees order by employee_id) loop
        -- ��ø ���̺��� ���κ��� Ȯ���ϸ鼭 null�� �����Ѵ�. 
        nt_array.extend;
        -- ������ �ε��� ���� ���� �� ������� ���ڵ带 �����Ѵ�.
        nt_array(nt_array.last) := rec;
    end loop;
    
    -- ��ø���̺��� ù��° �ε������� ������ �ε������� ����Ѵ�.
    for i in nt_array.first .. nt_array.last loop
        -- �����ȣ�� �̸��� ����Ѵ�.
        dbms_output.put_line(nt_array(i).employee_id||
            '>'||nt_array(i).first_name);
    end loop;
    
end;
/