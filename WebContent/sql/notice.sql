 create table tb_notice(
     noticeno   number           not null  -- �Ϸù�ȣ
    ,subject    varchar2(255)    not null  -- ����
    ,content    varchar2(4000)   not null  -- ����
    ,regdt      date    default  sysdate   -- �ۼ���
    ,primary key(noticeno)                 -- noticeno �⺻Ű 
   );

--������
create sequence noticeno_seq;

--�Է�
insert into tb_notice(noticeno, subject, content, regdt)
values(noticeno_seq.nextval,'��������','��~~~~��',sysdate)

--���
select noticeno, subject, content, regdt from tb_notice

--�󼼺���
select subject, content, regdt from tb_notice

--����¡
SELECT noticeno,subject,content,regdt, r
FROM( SELECT noticeno,subject,content,regdt, rownum as r
FROM ( SELECT noticeno,subject,content,regdt 
		        FROM tb_notice
		        ORDER BY noticeno DESC
		        )
		        )
WHERE r>=1 AND r<=5 