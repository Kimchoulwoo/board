--pds.sql
--테이블명 : tb_pds
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
    
--시퀀스 생성
create sequence pdsno_seq;

--행추가
insert into tb_pds(pdsno, wname, subject, passwd, filename, filesize, regdate, readcnt)
values(pdsno_seq.nextval, ?, ?, ?, ?, ?, sysdate, 0);

--목록
select pdsno, wname, subject, filename, readcnt, regdate, passwd
FROM tb_pds
ORDER BY regdate DESC

--삭제
--1) 테이블에서 레코드 삭제
DELETE FROM tb_pds WHERE pdsno=? AND passwd=?
--2) upload폴더에 첨부한 파일도 삭제
--    경로명과 파일명이 필요하다


select *
FROM tb_pds ORDER BY pdsno DESC


