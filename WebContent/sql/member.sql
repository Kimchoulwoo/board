-- member.sql
CREATE TABLE member (
    id       VARCHAR(10)  NOT NULL, -- ���̵�, �ߺ� �ȵ�, ���ڵ带 �����ϴ� �÷� 
    passwd   VARCHAR(10)  NOT NULL, -- �н�����
    mname    VARCHAR(20)  NOT NULL, -- ����
    tel      VARCHAR(14)  NULL,     -- ��ȭ��ȣ
    email    VARCHAR(50)  NOT NULL  UNIQUE, -- ���ڿ��� �ּ�, �ߺ� �ȵ�
    zipcode  VARCHAR(7)   NULL,     -- �����ȣ, 101-101
    address1 VARCHAR(255) NULL,     -- �ּ� 1
    address2 VARCHAR(255) NULL,     -- �ּ� 2(�������ּ�)
    job      VARCHAR(20)  NOT NULL, -- ����
    mlevel   CHAR(2)      NOT NULL, -- ȸ�� ���, A1, B1, C1, D1, E1, F1
    mdate    DATE         NOT NULL, -- ������    
    PRIMARY KEY (id)
);

--ȸ������
insert into member(id, passwd, mname, tel, email, zipcode, address1, address2, job, mlevel, mdate )
values('ssssssss','ssssssss','��ö��','010-9999-8888','ss@naver.com','12345','����� ���α� ��ö��','�ھƺ��� 5��','A01','A1',sysdate)

--ȸ�����
select * from member order by mdate desc

--���̵� �ߺ�Ȯ��
select count(id) as cnt
from member
where id='soldesk'

--�α���
select mlevel
from member
where id=? and passwd=?
AND mlevel IN ('A1', 'B1', 'C1', 'D1')

--ȸ������ ����
--1)��й�ȣ�� ��ġ�� �Ǹ� 
--2)�����ϰ��� �ϴ� ���ڵ带 DB���� ������
--3)�������� ���
select passwd, mname, email, zipcode, address1, address2, job
from member
where id=? and passwd=?  --���̵�� ���ǿ��� �����;� �Ѵ�
--4)�ٽ� �Է��� �������� ���ڵ� ����(��й�ȣ ��������)
update member
set passwd=?, mname=?, email=?, zipcode=?, address1=?, address2=?, job=?
where id = ?         --���̵�� ���ǿ��� �����;� �Ѵ�

--ȸ�� Ż��
--1)���̵�� ��й�ȣ�� ��ġ�Ǹ�
--2)ȸ�� ���� �Ǵ� ����� ����
--3)���� �� �ڵ����� �α׾ƿ� �ؾ���.(�������� ���� remove�Ұ�)
delete from member 
where id=? and passwd=?
--�Ǵ�
update member
set mlevel='F1'
where id=? and passwd=?

--A1 ��� ȸ�� �߰�
insert into member(id, passwd, mname, tel, email, zipcode, address1, address2, job, mlevel, mdate )
values('soldesk','12341234','ȫ�浿','010-9999-8888','s@naver.com','12345','����� ���α� ��ö��','�ھƺ��� 5��','A01','A1',sysdate)
insert into member(id, passwd, mname, tel, email, zipcode, address1, address2, job, mlevel, mdate )
values('soldesk2','12341234','ȫ�浿','010-9999-8888','s2@naver.com','12345','����� ���α� ��ö��','�ھƺ��� 5��','A01','B1',sysdate)
insert into member(id, passwd, mname, tel, email, zipcode, address1, address2, job, mlevel, mdate )
values('soldesk3','12341234','ȫ�浿','010-9999-8888','s3@naver.com','12345','����� ���α� ��ö��','�ھƺ��� 5��','A01','C1',sysdate)
insert into member(id, passwd, mname, tel, email, zipcode, address1, address2, job, mlevel, mdate )
values('soldesk4','12341234','ȫ�浿','010-9999-8888','s4@naver.com','12345','����� ���α� ��ö��','�ھƺ��� 5��','A01','D1',sysdate)
insert into member(id, passwd, mname, tel, email, zipcode, address1, address2, job, mlevel, mdate )
values('soldesk5','12341234','ȫ�浿','010-9999-8888','s5@naver.com','12345','����� ���α� ��ö��','�ھƺ��� 5��','A01','F1',sysdate)

delete from member where id='soldesk5'

--��ü ȸ����
select count(id)
from member
where mlevel IN ('A1', 'B1', 'C1', 'D1')

update member set mlevel='A1' where id='1' AND mlevel='A!';

--���̵� / ���ã��
--�̸�, �̸����� �Է¹޾Ƽ� ��ġ�ϸ�
--���̵�� ��й�ȣ�� ���� �߼�
--1) �̸��� �̸����� �Է¹޴� ���� �ۼ�
--2) ����ڰ� �Է¿�û�� �̸��� �̸����� ��ġ�Ǹ�
select id, passwd, mname, email from member
where mname=? and email=?
--    ���̵�� ��й�ȣ�� ���Ϸ� �߼��Ѵ�.
--    ��, ��й�ȣ : �빮��, �ҹ���, ���ڰ� ���Ե� 
--    ������ 10���� ������ �� DB���� �����ϰ�
--    �� ���� ���Ϸ� �߼��Ѵ�.


