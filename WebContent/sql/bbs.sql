-- �Խ��� ����
create table tb_bbs(
  bbsno    number(5)       not null -- �Ϸù�ȣ -99999~99999
 ,wname    varchar2(20)    not null -- �ۼ���
 ,subject  varchar2(100)   not null -- ������
 ,content  varchar2(2000)  not null -- �۳���
 ,passwd   varchar2(10)    not null -- �ۺ�й�ȣ
 ,readcnt  number(5)       default 0 not null -- ����ȸ��
 ,regdt    date            default  sysdate -- ���ۼ���
 ,grpno    number(5)       not null  -- �� �׷��ȣ
 ,indent   number(5)       default 0 -- �鿩����
 ,ansnum   number(5)       default 0 -- �ۼ���
 ,ip       varchar2(15)    not null -- �� IP
 ,primary key(bbsno)                --bbsno �⺻Ű 
);

--������ ����
create sequence bbsno_seq;

--���̺� ����
drop table tb_bbs;
--������ ����
drop sequence bbsno_seq;

--���߰�
insert into tb_bbs(bbsno, wname, subject, content, passwd, ip, grpno)
values(bbsno_seq.nextval, 'ȫ�浿', '1��', '�ȳ��ϼ���ȫ�浿�Դϴ�.', '1234', '172.16.4.27', (select nvl(max(bbsno),0)+1 from tb_bbs));

-- ���
select * from tb_bbs order by grpno desc, ansnum asc;

--���
select bbsno, subject, wname, regdt, readcnt from tb_bbs order by grpno desc, ansnum asc;

--����
delete from tb_bbs where bbsno=3;

--�󼼺���
select wname, subject, content, readcnt, grpno, ip, regdt
from tb_bbs
where bbsno=21;

--��ȸ�� ����
update tb_bbs set readcnt=readcen+1
where bbsno=21;

--�ۼ��� ������
update tb_bbs set ansnum=ansnum+1 
where grpno=1 and ansnum>=4

--�亯����
insert into tb bbs(bbsno, wname, subject, content, passwd, ip, grpno, indent, ansnum)
values(bbsno_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?)

--����
delete from tb_bbs
where bbsno=4 and passwd=1234

--��� ���� ���
--1)
select subject, grpno, indent, ansnum from tb_bbs AA
order by grpno desc, ansnum asc

--2)�׷��ȣ�� ������ ���ڵ� �׷�
select grpno, count(grpno) as ���
		 from tb_bbs
		 where indent>0
		 group by grpno

--3)����� �Խ��� ��� �����(����)
select BB.subject, AA.��� 
from (select grpno, count(grpno) as ���
		 from tb_bbs
		 where indent>0
		 group by grpno) AA join tb_bbs BB
on AA.grpno = BB.grpno
where BB.ansnum=0
order by AA.grpno desc

--���� : ��й�ȣ�� ��ġ�Ǹ� �����ϰ��� �ϴ� ���� �����ͼ� ����
--1) bbsUpdate.jsp : ��й�ȣ �Է� �޴� �� �ۼ�
--2) bbsUpdateForm.jsp : ��й�ȣ�� �۹�ȣ�� ��ġ�ϴ� ���ڵ带 
--    DB���� �����ͼ� �������� ���(SELECT��)
select wname, subject, content, from tb_bbs
where bbsno=? and passwd=?
--3) bbsUpdateProc.jsp : �ٽ� �Էµ� ������ DB���� ����(UPDATE)
update tb_bbs set wname='����',subject='����',content='����', passwd='����', ip='127.0.0.1'
where bbsno=27;

-- �Խ��� �˻�(Keyword �˻���, Keyfield �˻��÷�)
-- 1) �̸�
select * from tb_bbs
where wname like '%happy%'
-- 2) ����
select * from tb_bbs
where subject like '%happy%'
-- 3) ����
select * from tb_bbs
where content like '%happy%'
-- 4) ����+����
select * from tb_bbs
where subject like '%happy%' or content like '%happy%'


--�۰���
select count(bbsno) from tb_bbs
where indent=0

--���������� �۰��� 5���� ���
select BB.grpno,BB.rnum, BB.subject, BB.wname, BB.regdt, BB.readcnt, BB.ip
from (select rownum as rnum,AA.grpno, AA.subject, AA.wname, AA.regdt, AA.readcnt, AA.ip
		 from (select grpno,subject, wname, regdt, readcnt, ip 
				  from tb_bbs order by grpno desc, ansnum asc) AA
		) BB
where BB.rnum >=1 and rnum<=5;

select BB.grpno, BB.subject, BB.wname, BB.regdt, BB.readcnt, BB.ip
from (select rownum as rnum,AA.grpno, AA.subject, AA.wname, AA.regdt, AA.readcnt, AA.ip
		 from (select grpno, subject, wname, regdt, readcnt, ip 
				  from tb_bbs order by grpno desc, ansnum asc) AA
		) BB
where BB.rnum >=6 and rnum<=10;

--���� 'soldesk'�� �ִ� ���ڵ带 �˻�
select grpno,ansnum, subject, wname, regdt, readcnt, ip
from (select rownum as rnum, grpno, ansnum, subject, wname, regdt, readcnt, ip
		 from (select grpno, ansnum, subject, wname, regdt, readcnt, ip 
				  from tb_bbs
				  where subject like '%11%'
				  order by grpno desc, ansnum asc) AA
		) BB
where BB.rnum >=1 and rnum<=5
