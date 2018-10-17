package net.bbs2;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import net.utility.DBClose;
import net.utility.DBOpen;

public class BoardDBBean {    //dao 개념
  DBOpen  dbopen =null;
  DBClose dbclose=null;

  Connection con = null;
  PreparedStatement pstmt = null;
  ResultSet rs = null;
  StringBuffer sql = null;

  public BoardDBBean() {
    dbopen =new DBOpen(); //데이터베이스 연결 객체 할당
    dbclose=new DBClose();
  }

  //여기에 비지니스 로직 작성
  public void insertArticle(BoardDataBean article) throws Exception{
	  
	  int num = article.getNum();
	  int ref = article.getRef();
	  int re_step = article.getRe_step();
	  int re_level = article.getRe_level();
	  int number=0;
	  
	  try {
		con=dbopen.getConnection();
		sql = new StringBuffer();
		//그룹번호
		pstmt=con.prepareStatement(" SELECT max(num) FROM board ");
		rs=pstmt.executeQuery();
		
		if(rs.next()) {
			number=rs.getInt(1)+1;
		}else {
			number=1;
		}//if end
		
		//답변쓰기에서 글순서 재조정
		if(num!=0) {
			sql.delete(0, sql.length());
			sql.append(" UPDATE board SET re_step=re_step+1 WHERE ref=? AND re_step>? ");
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, ref);
			pstmt.setInt(2, re_step);
			pstmt.executeUpdate();
			re_step=re_step+1;
			re_level=re_level+1;			
		}else {
			ref=number;
			re_step=0;
			re_level=0;
		}//if end
		
		sql.delete(0, sql.length());
		sql.append(" INSERT INTO board(num, writer, email, subject, passwd, reg_date, ref, re_step, re_level, content, ip ) ");
		sql.append(" VALUES(board_seq.nextval, ?, ? ,? ,? ,?, ?, ? ,? ,?, ? ) ");
		
		pstmt=con.prepareStatement(sql.toString());
		pstmt.setString(1, article.getWriter());
		pstmt.setString(2, article.getEmail());
		pstmt.setString(3, article.getSubject());
		pstmt.setString(4, article.getPasswd());
		pstmt.setTimestamp(5, article.getReg_date());
		pstmt.setInt(6, ref);
		pstmt.setInt(7, re_step);
		pstmt.setInt(8, re_level);
		pstmt.setString(9, article.getContent());
		pstmt.setString(10, article.getIp());
		pstmt.executeUpdate();
		
	} catch (Exception e) {
		e.printStackTrace();
	}finally {
		dbclose.close(con, pstmt, rs);
	}	  
  }//insertArticle() end
  
  public int getArticleCount() throws Exception{
	  int x=0;
	  try {
		con=dbopen.getConnection();
		pstmt=con.prepareStatement(" SELECT count(*) FROM board ");
		rs=pstmt.executeQuery();
		if(rs.next()) {
			x=rs.getInt(1);
		}//if end
	} catch (Exception e) {
		e.printStackTrace();
	}finally {
		if(rs!=null) try {rs.close();} catch(SQLException e) {}
		if(pstmt!=null) try {pstmt.close();} catch(SQLException e) {}
		if(con!=null) try {con.close();} catch(SQLException e) {}
	}
	  return x;
  }//getArticleCount() end
  
  public List getArticles(int start, int end) throws Exception{
	  List articleList=null;
	  sql=new StringBuffer();
	  
	  sql.append(" SELECT a.* ");
	  sql.append(" FROM ( ");
	  sql.append(" 		SELECT ROWNUM as RNUM, b.* ");
	  sql.append(" 		FROM ( ");
	  sql.append(" 				SELECT num,writer,email,subject,passwd,reg_date,ref ");
	  sql.append(" 						   ,re_step,re_level,content,ip,readcount ");
	  sql.append(" 				FROM board ORDER BY ref desc, re_step ASC ");
	  sql.append(" 				) b ");
	  sql.append(" 			) a ");
	  sql.append(" WHERE a.RNUM>=? AND a.RNUM<=? ");
	  
	  try {
		con=dbopen.getConnection();
		pstmt=con.prepareStatement(sql.toString());
		pstmt.setInt(1, start);
		pstmt.setInt(2, end);
		rs=pstmt.executeQuery();
		
		if(rs.next()) {
			articleList=new ArrayList(end);
			do{
				BoardDataBean article=new BoardDataBean();
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setEmail(rs.getString("email"));
				article.setSubject(rs.getString("subject"));
				article.setPasswd(rs.getString("passwd"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setReadcount(rs.getInt("readcount"));
				article.setRef(rs.getInt("ref"));
				article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
				article.setContent(rs.getString("content"));
				article.setIp(rs.getString("ip"));
				
				articleList.add(article);
				
			}while(rs.next());
		}//if end
	  } catch (Exception e) {
		e.printStackTrace();
	  }finally {
		dbclose.close(con,pstmt, rs);
	}
	  return articleList;
		  
  }//getAricles() end	  
  
  public BoardDataBean getArticle(int num) throws Exception{
	  BoardDataBean article=null;
	  try {
		con=dbopen.getConnection();
		StringBuffer sql = new StringBuffer();
		sql.append(" UPDATE board SET readcount=readcount+1 WHERE num=? ");
		pstmt=con.prepareStatement(sql.toString());
		pstmt.setInt(1, num);
		pstmt.executeUpdate();
		
		sql.delete(0, sql.length());
		sql.append(" SELECT num,writer,email,subject,passwd,reg_date ");
		sql.append("            ,ref,re_step,re_level,content,ip,readcount ");
		sql.append(" FROM board WHERE num=? ");
		pstmt=con.prepareStatement(sql.toString());
		pstmt.setInt(1, num);
		rs=pstmt.executeQuery();
		if(rs.next()) {
			article=new BoardDataBean();
			article.setNum(rs.getInt("num"));
			article.setWriter(rs.getString("writer"));
			article.setEmail(rs.getString("email"));
			article.setSubject(rs.getString("subject"));
			article.setPasswd(rs.getString("passwd"));
			article.setReg_date(rs.getTimestamp("reg_date"));
			article.setReadcount(rs.getInt("readcount"));
			article.setRef(rs.getInt("ref"));
			article.setRe_step(rs.getInt("re_step"));
			article.setRe_level(rs.getInt("re_level"));
			article.setContent(rs.getString("content"));
			article.setIp(rs.getString("ip"));
		}//if end
		
	}catch(Exception e){
		e.printStackTrace();
	}finally {
		dbclose.close(con,pstmt,rs);
	}
	  
	  return article;
  }//getArticle() end
  
  public int deleteArticle(int num,String passwd) {
	  String dbpasswd="";
	  int x=-1;
	  try {
		  con=dbopen.getConnection();
		  pstmt=con.prepareStatement(" SELECT passwd FROM board WHERE num=? ");
		  pstmt.setInt(1, num);  
		  rs=pstmt.executeQuery();
		  
		  if(rs.next()) {
			  dbpasswd=rs.getString("passwd");
			  if(dbpasswd.equals(passwd)) {
				  pstmt=con.prepareStatement(" DELETE FROM board WHERE num=? ");
				  pstmt.setInt(1, num);
				  pstmt.executeUpdate();
				  x=1;
			  }else {
				  x=0;
			  }//if end
		  }//if end
	  }catch(Exception ex) {
		  ex.printStackTrace();
	  }finally {
		dbclose.close(con,pstmt,rs);
	}
	  return x;
  }//deleteArticle() end

  public BoardDataBean updateArticle(int num, String passwd) {
	  String dbpasswd="";
	  BoardDataBean article=null;
	  try {
		  con=dbopen.getConnection();
		  pstmt=con.prepareStatement(" SELECT passwd FROM board WHERE num=? ");
		  pstmt.setInt(1, num);  
		  rs=pstmt.executeQuery();
		  
		  if(rs.next()) {
			  dbpasswd=rs.getString("passwd");
			  if(dbpasswd.equals(passwd)) {
				  pstmt=con.prepareStatement(" SELECT num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount FROM board WHERE num=? ");
				  pstmt.setInt(1, num);
				  rs=pstmt.executeQuery();
				  if(rs.next()) {
					  article=new BoardDataBean();
					  article.setNum(rs.getInt("num"));
					  article.setWriter(rs.getString("writer"));
					  article.setEmail(rs.getString("email"));
					  article.setSubject(rs.getString("subject"));
					  article.setPasswd(rs.getString("passwd"));
					  article.setReg_date(rs.getTimestamp("reg_date"));
					  article.setReadcount(rs.getInt("readcount"));
					  article.setRef(rs.getInt("ref"));
					  article.setRe_step(rs.getInt("re_step"));
					  article.setRe_level(rs.getInt("re_level"));
					  article.setContent(rs.getString("content"));
					  article.setIp(rs.getString("ip"));
				  }
			  }
		  }//if end
		  
	  }catch(Exception ex) {
		  ex.printStackTrace();
	  }finally {
		dbclose.close(con,pstmt,rs);
	}
	  return article;
  }//updateArticle() end
  
  public int updateFormArticle(BoardDataBean article) {
	  int res=0;
	  try {
	    con=dbopen.getConnection();
		StringBuffer sql = new StringBuffer();
		sql.append(" UPDATE board ");
		sql.append(" SET writer=?, subject=?, content=?, passwd=?, email=?, reg_date=?, ip=? "); 
		sql.append(" WHERE num=? ");
		pstmt=con.prepareStatement(sql.toString());
		pstmt.setString(1, article.getWriter());
		pstmt.setString(2, article.getSubject());
		pstmt.setString(3, article.getContent());
		pstmt.setString(4, article.getPasswd());
		pstmt.setString(5, article.getEmail());
		pstmt.setTimestamp(6, article.getReg_date());
		pstmt.setString(7, article.getIp());
		pstmt.setInt(8, article.getNum());
		res=pstmt.executeUpdate();
	  }catch(Exception e){
		  e.printStackTrace();
	  }finally {
		  dbclose.close(con,pstmt);
	}
	  return res;
  }//updateFormArticle() end

}//class end