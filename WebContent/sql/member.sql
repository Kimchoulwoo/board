-- member.sql
CREATE TABLE member (
    id       VARCHAR(10)  NOT NULL, -- 아이디, 중복 안됨, 레코드를 구분하는 컬럼 
    passwd   VARCHAR(10)  NOT NULL, -- 패스워드
    mname    VARCHAR(20)  NOT NULL, -- 성명
    tel      VARCHAR(14)  NULL,     -- 전화번호
    email    VARCHAR(50)  NOT NULL  UNIQUE, -- 전자우편 주소, 중복 안됨
    zipcode  VARCHAR(7)   NULL,     -- 우편번호, 101-101
    address1 VARCHAR(255) NULL,     -- 주소 1
    address2 VARCHAR(255) NULL,     -- 주소 2(나머지주소)
    job      VARCHAR(20)  NOT NULL, -- 직업
    mlevel   CHAR(2)      NOT NULL, -- 회원 등급, A1, B1, C1, D1, E1, F1
    mdate    DATE         NOT NULL, -- 가입일    
    PRIMARY KEY (id)
);

--회원가입
insert into member(id, passwd, mname, tel, email, zipcode, address1, address2, job, mlevel, mdate )
values('ssssssss','ssssssss','김철우','010-9999-8888','ss@naver.com','12345','서울시 종로구 관철동','코아빌딩 5층','A01','A1',sysdate)

--회원목록
select * from member order by mdate desc

--아이디 중복확인
select count(id) as cnt
from member
where id='soldesk'

--로그인
select mlevel
from member
where id=? and passwd=?
AND mlevel IN ('A1', 'B1', 'C1', 'D1')

--회원정보 수정
--1)비밀번호가 일치가 되면 
--2)수정하고자 하는 레코드를 DB에서 가져와
--3)수정폼에 출력
select passwd, mname, email, zipcode, address1, address2, job
from member
where id=? and passwd=?  --아이디는 세션에서 가져와야 한다
--4)다시 입력한 내용으로 레코드 수정(비밀번호 수정가능)
update member
set passwd=?, mname=?, email=?, zipcode=?, address1=?, address2=?, job=?
where id = ?         --아이디는 세션에서 가져와야 한다

--회원 탈퇴
--1)아이디와 비밀번호가 일치되면
--2)회원 삭제 또는 등급을 수정
--3)수정 후 자동으로 로그아웃 해야함.(세션정보 전부 remove할것)
delete from member 
where id=? and passwd=?
--또는
update member
set mlevel='F1'
where id=? and passwd=?

--A1 등급 회원 추가
insert into member(id, passwd, mname, tel, email, zipcode, address1, address2, job, mlevel, mdate )
values('soldesk','12341234','홍길동','010-9999-8888','s@naver.com','12345','서울시 종로구 관철동','코아빌딩 5층','A01','A1',sysdate)
insert into member(id, passwd, mname, tel, email, zipcode, address1, address2, job, mlevel, mdate )
values('soldesk2','12341234','홍길동','010-9999-8888','s2@naver.com','12345','서울시 종로구 관철동','코아빌딩 5층','A01','B1',sysdate)
insert into member(id, passwd, mname, tel, email, zipcode, address1, address2, job, mlevel, mdate )
values('soldesk3','12341234','홍길동','010-9999-8888','s3@naver.com','12345','서울시 종로구 관철동','코아빌딩 5층','A01','C1',sysdate)
insert into member(id, passwd, mname, tel, email, zipcode, address1, address2, job, mlevel, mdate )
values('soldesk4','12341234','홍길동','010-9999-8888','s4@naver.com','12345','서울시 종로구 관철동','코아빌딩 5층','A01','D1',sysdate)
insert into member(id, passwd, mname, tel, email, zipcode, address1, address2, job, mlevel, mdate )
values('soldesk5','12341234','홍길동','010-9999-8888','s5@naver.com','12345','서울시 종로구 관철동','코아빌딩 5층','A01','F1',sysdate)

delete from member where id='soldesk5'

--전체 회원수
select count(id)
from member
where mlevel IN ('A1', 'B1', 'C1', 'D1')

update member set mlevel='A1' where id='1' AND mlevel='A!';

--아이디 / 비번찾기
--이름, 이메일을 입력받아서 일치하면
--아이디와 비밀번호를 메일 발송
--1) 이름과 이메일을 입력받는 폼을 작성
--2) 사용자가 입력요청한 이름과 이메일이 일치되면
select id, passwd, mname, email from member
where mname=? and email=?
--    아이디와 비밀번호를 메일로 발송한다.
--    단, 비밀번호 : 대문자, 소문자, 숫자가 포함된 
--    랜덤한 10글자 조합한 후 DB에서 수정하고
--    그 값을 메일로 발송한다.


