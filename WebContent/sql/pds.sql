--pds.sql
--���̺�� : tb_pds
CREATE TABLE tb_pds (
      pdsno       NUMBER         NOT NULL
      ,wname     VARCHAR2(100)  NOT NULL
      ,subject    VARCHAR2(250)  NOT NULL
      ,regdate    DATE           NOT NULL
      ,passwd    VARCHAR2(15)   NOT NULL
      ,readcnt    NUMBER         DEFAULT 0
      ,filename   VARCHAR2(250)  NOT NULL
      ,filesize     NUMBER         DEFAULT 0
      ,PRIMARY KEY(pdsno)
);
    
--������ ����
create sequence pdsno_seq;

--���߰�
insert into tb_pds(pdsno, wname, subject, passwd, filename, filesize, regdate, readcnt)
values(pdsno_seq.nextval, ?, ?, ?, ?, ?, sysdate, 0);

--���
select pdsno, wname, subject, filename, readcnt, regdate, passwd
FROM tb_pds
ORDER BY regdate DESC

--����
--1) ���̺��� ���ڵ� ����
DELETE FROM tb_pds WHERE pdsno=? AND passwd=?
--2) upload������ ÷���� ���ϵ� ����
--    ��θ�� ���ϸ��� �ʿ��ϴ�


select *
FROM tb_pds ORDER BY pdsno DESC


