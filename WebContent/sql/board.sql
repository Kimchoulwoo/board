--bbs2.sql
--1)���̺����
create table board(
  num          number         NOT NULL,
  writer       varchar2(20)   NOT NULL,
  email        varchar2(30),
  subject      varchar2(50)   NOT NULL,
  content      varchar2(2000) NOT NULL,
  passwd       varchar2(10)   NOT NULL,
  reg_date     date           NOT NULL,
  readcount    number         default 0,
  ref          number         NOT NULL,  -- �׷��ȣ
  re_step      number         NOT NULL,  -- �ۼ���
  re_level     number         NOT NULL,  -- �鿩����
  ip           varchar2(20)   NOT NULL,
  PRIMARY KEY(num)  
);

--������ ����
create sequence board_seq;

select * from board

