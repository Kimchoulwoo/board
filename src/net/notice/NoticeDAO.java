package net.notice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import net.utility.DBClose;
import net.utility.DBOpen;

public class NoticeDAO {
	DBOpen dbopen=null;
	DBClose dbclose=null;
	
	Connection con = null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	StringBuilder sql = null;

	public NoticeDAO() {
		dbopen = new DBOpen();
		dbclose = new DBClose();
	}//MemberDao() end
	
	public int insert(NoticeDTO dto) {
		int res=0;
		try {
			con=dbopen.getConnection();
			sql=new StringBuilder();
			sql.append(" INSERT INTO tb_notice(noticeno, subject, content, regdt) "); 
			sql.append(" VALUES(noticeno_seq.nextval,?,?,sysdate) ");
			
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getContent());
			res=pstmt.executeUpdate();			
			
		}catch(Exception e){
			System.out.println("insert실패!"+e);
		}finally {
			dbclose.close(con,pstmt);
		}
		return res;
	}//insert() end
	
	public ArrayList<NoticeDTO> list() {
		ArrayList<NoticeDTO> list = null;
		try {
			con=dbopen.getConnection();
			sql=new StringBuilder();
			sql.append(" SELECT noticeno, subject, content, regdt ");
			sql.append(" FROM tb_notice ");
			sql.append(" ORDER BY noticeno DESC ");
			
			pstmt=con.prepareStatement(sql.toString());
			rs=pstmt.executeQuery();
			if(rs.next()) {
				 list= new ArrayList<>();
				 do {
					NoticeDTO dto = new NoticeDTO();
					dto.setNoticeno(rs.getInt("noticeno"));
					dto.setSubject(rs.getString("subject"));
					dto.setContent(rs.getString("content"));
					dto.setRegdt(rs.getString("regdt"));
					list.add(dto);
				 }while(rs.next());
			}//if end
		}catch(Exception e) {
			System.out.println("list실패!!"+e);
		}finally {
			dbclose.close(con,pstmt,rs);
		}
		return list;
	}//list() end
	
	public NoticeDTO read(int noticeno) {
		NoticeDTO dto = null;
		try {
			con=dbopen.getConnection();
			sql=new StringBuilder();
			sql.append(" SELECT subject, content, regdt FROM tb_notice ");
			sql.append(" where noticeno=? ");
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, noticeno);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				dto=new NoticeDTO();
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setRegdt(rs.getString("regdt"));
			}
		}catch (Exception e) {
			System.out.println("상세보기 실패!"+e);
		}finally {
			dbclose.close(con,pstmt,rs);
		}		
		return dto;
	}//read() end
	
	public int delete(NoticeDTO dto) {
		int res=0;
		try {
			con=dbopen.getConnection();
			sql=new StringBuilder();
			sql.append(" DELETE FROM tb_notice ");
			sql.append(" WHERE noticeno=? ");
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, dto.getNoticeno());
			res=pstmt.executeUpdate();
		}catch (Exception e) {
			System.out.println("삭제실패!"+e);
		}finally {
			dbclose.close(con,pstmt);
		}		
		return res;
	}//delete() end
	
	public NoticeDTO updateForm(int noticeno) {
		NoticeDTO dto=null;
		try {
			con=dbopen.getConnection();
			sql=new StringBuilder();
			sql.append(" SELECT subject, content ");
			sql.append(" FROM tb_notice ");
			sql.append(" WHERE noticeno=? ");
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, noticeno);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				dto = new NoticeDTO();
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
			}
		}catch (Exception e) {
			System.out.println("수정폼 실패"+e);
		}finally {
			dbclose.close(con,pstmt,rs);
		}		
		return dto;
	}//updateForm() end
	
	public int update(NoticeDTO dto) {
		int res=0;
		try {
			con=dbopen.getConnection();
			sql=new StringBuilder();
			sql.append(" UPDATE tb_notice ");
			sql.append(" SET subject=?,content=?  ");
			sql.append(" WHERE noticeno=? ");
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getSubject());
			pstmt.setString(2, dto.getContent());
			pstmt.setInt(3, dto.getNoticeno());
			res=pstmt.executeUpdate();
		}catch (Exception e) {
			System.out.println("수정 실패"+e);
		}finally {
			dbclose.close(con,pstmt);
		}
		return res;
	}//update() end
	
	public ArrayList<NoticeDTO> list(String col, String word) {
		 ArrayList<NoticeDTO> list=null;
		 
		 try {
			 con=dbopen.getConnection();
			 sql=new StringBuilder();
			 sql.append(" SELECT noticeno,subject, content, regdt ");
			 sql.append(" FROM tb_notice ");
			 
			 //검색어가 존재하는지?
			 if(word.length()>=1) {
				 String search="";
				if(col.equals("subject")) {
					 search+=" WHERE subject LIKE '%"+ word +"%' ";
				 }else if(col.equals("content")) {
					 search+=" WHERE content LIKE '%"+ word +"%' ";
				 }else if(col.equals("subject_content")) {
					 search+=" WHERE subject LIKE '%"+ word +"%' ";
					 search+= " OR content LIKE '%"+word+"%' ";
				 }
				 sql.append(search);
			 }//if end
			 
			 sql.append(" ORDER BY grpno DESC, ansnum ASC");
			 
			 pstmt=con.prepareStatement(sql.toString());
			 rs=pstmt.executeQuery();
			 
			 if(rs.next()) {
				 list= new ArrayList<>();
				 do {
					 NoticeDTO dto = new NoticeDTO();
					 dto.setNoticeno(rs.getInt("noticeno"));
					 dto.setSubject(rs.getString("subject"));
					 dto.setContent(rs.getString("content"));
					 dto.setRegdt(rs.getString("regdt"));
					 list.add(dto);
				 }while(rs.next());
			}//if end			 
		 }catch(Exception e) {
			 System.out.println("list2 실패!!" + e);
		 }finally {
			dbclose.close(con,pstmt,rs);
		}		
		return list;
	}//list() end
	
	
	public int count(String col, String word) {
		int totalRecord=0;
		try {
			con=dbopen.getConnection();
			sql= new StringBuilder();
			sql.append(" SELECT count(noticeno) FROM tb_notice ");
			
			if(word.length()>=1) {
				 String search="";
				 if(col.equals("subject")) {
					 search+=" WHERE subject LIKE '%"+ word +"%' ";
				 }else if(col.equals("content")) {
					 search+=" WHERE content LIKE '%"+ word +"%' ";
				 }else if(col.equals("subject_content")) {
					 search+=" WHERE subject LIKE '%"+ word +"%' ";
					 search+= " OR content LIKE '%"+word+"%' ";
				 }
				 sql.append(search);
			 }//if end
			
			pstmt=con.prepareStatement(sql.toString());
			rs=pstmt.executeQuery();
			if(rs.next()) {
				totalRecord=rs.getInt("count(noticeno)");
			}
		}catch(Exception e) {
			System.out.println("카운트 실패!!"+e);
		}finally {
			dbclose.close(con,pstmt,rs);
		}			
		return totalRecord;
	}//count() end
	
	public ArrayList<NoticeDTO> list(String col, String word, int nowPage, int recordPerPage) {
		ArrayList<NoticeDTO> list = null;
		int startRow = ((nowPage-1) * recordPerPage) + 1 ;  
		int endRow   = nowPage * recordPerPage;
		try {
			  con=dbopen.getConnection();
		      sql=new StringBuilder(); 
		      
		      word = word.trim();
			 //1) 검색을 하지 않는 경우
		      if(word.length()==0) {
		        sql.append(" SELECT noticeno, subject, content, regdt, r ");
		        sql.append(" FROM( SELECT noticeno, subject, content, regdt, rownum as r ");
		        sql.append("       FROM ( SELECT noticeno, subject, content, regdt ");
		        sql.append("              FROM tb_notice");
		        sql.append("              ORDER BY noticeno DESC ");
		        sql.append("           )");
		        sql.append("     )");
		        sql.append(" WHERE r>=" + startRow + " AND r<=" + endRow) ;
		      } else {
		        //2) 검색을 하는 경우
			    sql.append(" SELECT noticeno,subject,content,regdt, r ");
			    sql.append(" FROM( SELECT noticeno,subject,content,regdt, rownum as r ");
			    sql.append("       FROM ( SELECT noticeno,subject,content,regdt ");
			    sql.append("              FROM tb_notice");
		        
		        String search="";
		        if(col.equals("subject")) {
		          search += " WHERE subject LIKE '%" + word + "%'";
		        } else if(col.equals("content")) {
		          search += " WHERE content LIKE '%" + word + "%'";
		        } else if(col.equals("subject_content")) {
		          search += " WHERE subject LIKE '%" + word + "%'";
		          search += " OR content LIKE '%" + word + "%'";
		        }
		        
		        sql.append(search);        
		        
		        sql.append("              ORDER BY noticeno DESC ");
		        sql.append("           )");
		        sql.append("     )");
		        sql.append(" WHERE r>=" + startRow + " AND r<=" + endRow) ;
		      }//if end
		      
		      pstmt=con.prepareStatement(sql.toString());
		      rs=pstmt.executeQuery();
		      if(rs.next()){
		        list=new ArrayList<>();
		        do{
		          NoticeDTO dto=new NoticeDTO();
		          dto.setNoticeno(rs.getInt("noticeno"));
		          dto.setSubject(rs.getString("subject"));
		          dto.setContent(rs.getString("content"));
		          dto.setRegdt(rs.getString("regdt"));		          
		          list.add(dto);
		        }while(rs.next());
		      }
		}catch(Exception e) {
			System.out.println("list3실패!!"+e);
		}finally {
			dbclose.close(con,pstmt,rs);
		}
		return list;
	}//list() end
	
	public int count() {
		int totalRecord=0;
		try {
			con=dbopen.getConnection();
			sql= new StringBuilder();
			sql.append(" SELECT count(noticeno) FROM tb_notice ");
			pstmt=con.prepareStatement(sql.toString());
			rs=pstmt.executeQuery();
			if(rs.next()) {
				totalRecord=rs.getInt("count(noticeno)");
			}
		}catch(Exception e) {
			System.out.println("카운트 실패!!"+e);
		}finally {
			dbclose.close(con,pstmt,rs);
		}			
		return totalRecord;
	}//count() end
	
	public ArrayList<NoticeDTO> list(String col2) {
		ArrayList<NoticeDTO> list = null;
		try {
			con=dbopen.getConnection();
			sql=new StringBuilder();
			sql.append(" SELECT noticeno, subject, regdt,content ");
			sql.append(" FROM tb_notice ");
			if(col2.equals("") || col2.equals("noticenoAsc")) {
				sql.append(" ORDER BY noticeno ASC ");
			}else if(col2.equals("noticenoDesc")) {
				sql.append(" ORDER BY noticeno DESC ");
			}else if(col2.equals("subjectAsc")) {
				sql.append(" ORDER BY subject ASC ");
			}else if(col2.equals("subjectDesc")) {
				sql.append(" ORDER BY subject DESC ");
			}else if(col2.equals("regdtAsc")) {
				sql.append(" ORDER BY regdt ASC ");
			}else if(col2.equals("regdtDesc")) {
				sql.append(" ORDER BY regdt DESC ");
			}
			
			pstmt=con.prepareStatement(sql.toString());
			rs=pstmt.executeQuery();
			if(rs.next()) {
				 list= new ArrayList<>();
				 do {
					NoticeDTO dto = new NoticeDTO();
					dto.setNoticeno(rs.getInt("noticeno"));
					dto.setSubject(rs.getString("subject"));
					dto.setRegdt(rs.getString("regdt"));
					dto.setContent(rs.getString("content"));
					list.add(dto);
				 }while(rs.next());
			}//if end
		}catch(Exception e) {
			System.out.println("list실패!!"+e);
		}finally {
			dbclose.close(con,pstmt,rs);
		}
		return list;
	}//list() end
}//class end













