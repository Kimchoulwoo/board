-- 게시판 생성
create table tb_bbs(
  bbsno    number(5)       not null -- 일련번호 -99999~99999
 ,wname    varchar2(20)    not null -- 작성자
 ,subject  varchar2(100)   not null -- 글제목
 ,content  varchar2(2000)  not null -- 글내용
 ,passwd   varchar2(10)    not null -- 글비밀번호
 ,readcnt  number(5)       default 0 not null -- 글조회수
 ,regdt    date            default  sysdate -- 글작성일
 ,grpno    number(5)       not null  -- 글 그룹번호
 ,indent   number(5)       default 0 -- 들여쓰기
 ,ansnum   number(5)       default 0 -- 글순서
 ,ip       varchar2(15)    not null -- 글 IP
 ,primary key(bbsno)                --bbsno 기본키 
);

--시퀀스 생성
create sequence bbsno_seq;

--테이블 삭제
drop table tb_bbs;
--시퀀스 삭제
drop sequence bbsno_seq;

--행추가
insert into tb_bbs(bbsno, wname, subject, content, passwd, ip, grpno)
values(bbsno_seq.nextval, '홍길동', '1빠', '안녕하세요홍길동입니다.', '1234', '172.16.4.27', (select nvl(max(bbsno),0)+1 from tb_bbs));

-- 목록
select * from tb_bbs order by grpno desc, ansnum asc;

--목록
select bbsno, subject, wname, regdt, readcnt from tb_bbs order by grpno desc, ansnum asc;

--삭제
delete from tb_bbs where bbsno=3;

--상세보기
select wname, subject, content, readcnt, grpno, ip, regdt
from tb_bbs
where bbsno=21;

--조회수 증가
update tb_bbs set readcnt=readcen+1
where bbsno=21;

--글순서 재조정
update tb_bbs set ansnum=ansnum+1 
where grpno=1 and ansnum>=4

--답변쓰기
insert into tb bbs(bbsno, wname, subject, content, passwd, ip, grpno, indent, ansnum)
values(bbsno_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?)

--삭제
delete from tb_bbs
where bbsno=4 and passwd=1234

--답글 갯수 목록
--1)
select subject, grpno, indent, ansnum from tb_bbs AA
order by grpno desc, ansnum asc

--2)그룹번호가 동일한 레코드 그룹
select grpno, count(grpno) as 답글
		 from tb_bbs
		 where indent>0
		 group by grpno

--3)댓글형 게시판 목록 만들기(조인)
select BB.subject, AA.답글 
from (select grpno, count(grpno) as 답글
		 from tb_bbs
		 where indent>0
		 group by grpno) AA join tb_bbs BB
on AA.grpno = BB.grpno
where BB.ansnum=0
order by AA.grpno desc

--수정 : 비밀번호가 일치되면 수정하고자 하는 글을 가져와서 수정
--1) bbsUpdate.jsp : 비밀번호 입력 받는 폼 작성
--2) bbsUpdateForm.jsp : 비밀번호와 글번호가 일치하는 레코드를 
--    DB에서 가져와서 수정폼에 출력(SELECT문)
select wname, subject, content, from tb_bbs
where bbsno=? and passwd=?
--3) bbsUpdateProc.jsp : 다시 입력된 내용을 DB에서 수정(UPDATE)
update tb_bbs set wname='수정',subject='수정',content='수정', passwd='수정', ip='127.0.0.1'
where bbsno=27;

-- 게시판 검색(Keyword 검색어, Keyfield 검색컬럼)
-- 1) 이름
select * from tb_bbs
where wname like '%happy%'
-- 2) 제목
select * from tb_bbs
where subject like '%happy%'
-- 3) 내용
select * from tb_bbs
where content like '%happy%'
-- 4) 제목+내용
select * from tb_bbs
where subject like '%happy%' or content like '%happy%'


--글갯수
select count(bbsno) from tb_bbs
where indent=0

--한페이지에 글갯수 5개씩 출력
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

--제목에 'soldesk'가 있는 레코드를 검색
select grpno,ansnum, subject, wname, regdt, readcnt, ip
from (select rownum as rnum, grpno, ansnum, subject, wname, regdt, readcnt, ip
		 from (select grpno, ansnum, subject, wname, regdt, readcnt, ip 
				  from tb_bbs
				  where subject like '%11%'
				  order by grpno desc, ansnum asc) AA
		) BB
where BB.rnum >=1 and rnum<=5
