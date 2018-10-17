 create table tb_notice(
     noticeno   number           not null  -- 일련번호
    ,subject    varchar2(255)    not null  -- 제목
    ,content    varchar2(4000)   not null  -- 내용
    ,regdt      date    default  sysdate   -- 작성일
    ,primary key(noticeno)                 -- noticeno 기본키 
   );

--시퀀스
create sequence noticeno_seq;

--입력
insert into tb_notice(noticeno, subject, content, regdt)
values(noticeno_seq.nextval,'공지사항','내~~~~용',sysdate)

--목록
select noticeno, subject, content, regdt from tb_notice

--상세보기
select subject, content, regdt from tb_notice

--페이징
SELECT noticeno,subject,content,regdt, r
FROM( SELECT noticeno,subject,content,regdt, rownum as r
FROM ( SELECT noticeno,subject,content,regdt 
		        FROM tb_notice
		        ORDER BY noticeno DESC
		        )
		        )
WHERE r>=1 AND r<=5 