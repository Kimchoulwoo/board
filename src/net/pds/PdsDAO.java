package net.pds;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import net.bbs.BbsDTO;
import net.utility.DBClose;
import net.utility.DBOpen;
import net.utility.Utility;

public class PdsDAO {
	DBOpen dbopen=null;
	DBClose dbclose=null;
	
	Connection con =null;
	PreparedStatement pstmt=null;
	ResultSet rs = null;
	StringBuilder sql = null;
	
	public PdsDAO() {
		dbopen = new DBOpen();
		dbclose = new DBClose();
	}//psdDAO()	
	
	public boolean insert(PdsDTO dto) {
		boolean flag=false;
		int res=0;
		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();			
			sql.append(" INSERT INTO tb_pds(pdsno, wname, subject, passwd, filename, filesize, regdate) ");
			sql.append(" VALUES(pdsno_seq.nextval, ?, ?, ?, ?, ?, sysdate) ");
			pstmt = con.prepareStatement(sql.toString());
			
			pstmt.setString(1, dto.getWname());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getPasswd());
			pstmt.setString(4, dto.getFilename());
			pstmt.setLong(5, dto.getFilesize());
			res=pstmt.executeUpdate();
			if(res==1) {
				flag=true;
			}
		}catch (Exception e) {
			System.out.println("insert() 실패!"+e);
		}finally {
			dbclose.close(con,pstmt);
		}		
		return flag;
	}//insert() end
	
	public ArrayList<PdsDTO> list() {
		 ArrayList<PdsDTO> list=null;		 
		 try {
			 con=dbopen.getConnection();
			 sql=new StringBuilder();
			 sql.append(" SELECT pdsno, wname, subject, filename, readcnt, regdate ");
			 sql.append(" FROM tb_pds ");
			 sql.append(" ORDER BY regdate DESC ");
			 pstmt=con.prepareStatement(sql.toString());
			 rs=pstmt.executeQuery();
			 
			 if(rs.next()) {
				 list= new ArrayList<>();
				 do {
					 PdsDTO dto = new PdsDTO();
					 dto.setPdsno(rs.getInt("pdsno"));
					 dto.setWname(rs.getString("wname"));
					 dto.setSubject(rs.getString("subject"));					 
					 dto.setFilename(rs.getString("filename"));
					 dto.setReadcnt(rs.getInt("readcnt"));					 
					 dto.setRegdate(rs.getString("regdate"));
					 list.add(dto);
				 }while(rs.next());
			}//if end			 
		 }catch(Exception e) {
			 System.out.println("목록보기 실패!!" + e);
		 }finally {
			dbclose.close(con,pstmt,rs);
		}		
		return list;
	}//list() end
	
	public PdsDTO read(int pdsno) {
		PdsDTO dto = null;
		try {
			con = dbopen.getConnection();
			sql= new StringBuilder();
			sql.append(" SELECT subject, wname, filename, filesize, readcnt, regdate ");
			sql.append(" FROM tb_pds ");
			sql.append(" WHERE pdsno=? ");
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, pdsno);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				dto = new PdsDTO();
				dto.setSubject(rs.getString("subject"));
				dto.setWname(rs.getString("wname"));
				dto.setFilename(rs.getString("filename"));
				dto.setFilesize(rs.getInt("filesize"));
				dto.setReadcnt(rs.getInt("readcnt"));
				dto.setRegdate(rs.getString("regdate"));
			}
		}catch (Exception e) {
			System.out.println("read() 실패!"+e);
		}finally {
			dbclose.close(con,pstmt,rs);
		}		
		return dto;
	}//read() end
	
	public void incrementCnt(int pdsno) {
		try {
			con=dbopen.getConnection();
			sql=new StringBuilder();
			sql.append(" UPDATE tb_pds ");
			sql.append(" SET readcnt=readcnt+1 "); 
			sql.append(" WHERE pdsno=?");
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, pdsno);
			pstmt.executeUpdate();
		}catch(Exception e){
			System.out.println("incrementCnt() 실패!"+e);
		}finally {
			dbclose.close(con,pstmt);
		}
	}//incrementCnt() end
	
	public int count() {
		int totalRecord=0;
		try {
			con=dbopen.getConnection();
			sql= new StringBuilder();
			sql.append(" SELECT count(pdsno) FROM tb_pds ");
				pstmt=con.prepareStatement(sql.toString());
			rs=pstmt.executeQuery();
			if(rs.next()) {
				totalRecord=rs.getInt("count(pdsno)");
			}
		}catch(Exception e) {
			System.out.println("카운트 실패!!"+e);
		}finally {
			dbclose.close(con,pstmt,rs);
		}			
		return totalRecord;
	}//count() end
	
	public ArrayList<PdsDTO> list(int nowPage, int recordPerPage){
	    ArrayList<PdsDTO> list=null;
	    
	    int startRow = ((nowPage-1) * recordPerPage) + 1 ;  
	    int endRow   = nowPage * recordPerPage;
	    
	    try{
	      con=dbopen.getConnection();
	      sql=new StringBuilder();	      
	      sql.append(" SELECT pdsno, wname, subject, filename, readcnt, regdate, r");
	      sql.append(" FROM( SELECT pdsno, wname, subject, filename, readcnt, regdate, rownum as r");
	      sql.append("       FROM ( SELECT pdsno, wname, subject, filename, readcnt, regdate ");
	      sql.append("              FROM tb_pds");
	      sql.append("              ORDER BY pdsno DESC ");
	      sql.append("           )");
	      sql.append("     )");
	      sql.append(" WHERE r>=" + startRow + " AND r<=" + endRow) ;
     
	      pstmt=con.prepareStatement(sql.toString());
	      rs=pstmt.executeQuery();
	      if(rs.next()){
	        list=new ArrayList<>();
	        do{
	          PdsDTO dto=new PdsDTO();
	          dto = new PdsDTO();
	          dto.setPdsno(rs.getInt("pdsno"));
			  dto.setWname(rs.getString("wname"));
			  dto.setSubject(rs.getString("subject"));					 
			  dto.setFilename(rs.getString("filename"));
			  dto.setReadcnt(rs.getInt("readcnt"));					 
			  dto.setRegdate(rs.getString("regdate"));
	          list.add(dto);
	        }while(rs.next());
	      }
	      
	    }catch(Exception e) {
	      System.out.println("목록 실패: "+e);
	    }finally{
	      dbclose.close(con, pstmt, rs);
	    }    
	    return list;
	  }//list() end
	
	public int delete(PdsDTO dto, String saveDir) {
		int res=0;
		try {
			con = dbopen.getConnection();
			sql=new StringBuilder();
			sql.append(" DELETE FROM tb_pds ");
			sql.append(" WHERE pdsno=? AND passwd=? ");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, dto.getPdsno());
			pstmt.setString(2, dto.getPasswd());
			res=pstmt.executeUpdate();
			if(res==1) {
				//테이블에서 성공적으로 레코드가 삭제되면
				//첨부한 파일도 삭제
				Utility.deleteFile(saveDir, dto.getFilename());
			}//if end
			
		}catch (Exception e) {
			System.out.println("delete() 실패!"+e);
		}finally {
			dbclose.close(con,pstmt);
		}
		return res;
	}//delete() end
	
	public PdsDTO updateForm(int pdsno, String passwd) {
		PdsDTO dto = null;
		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append(" SELECT subject, wname, filename, filesize, readcnt, regdate, passwd ");
			sql.append(" FROM tb_pds ");
			sql.append(" WHERE pdsno=? AND passwd=? ");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, pdsno);
			pstmt.setString(2, passwd);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				dto = new PdsDTO();
				dto.setSubject(rs.getString("subject"));
				dto.setWname(rs.getString("wname"));
				dto.setFilename(rs.getString("filename"));
				dto.setFilesize(rs.getLong("filesize"));
				dto.setReadcnt(rs.getInt("readcnt"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setPasswd(rs.getString("passwd"));
			}
		} catch (Exception e) {
			System.out.println("updateForm() 실패!"+e);
		}finally {
			dbclose.close(con,pstmt,rs);
		}
		return dto;
	}//updateForm() end
	
	public int update(PdsDTO dto) {
		int res=0;
		try {
			con=dbopen.getConnection();
			sql=new StringBuilder();

			sql.append(" UPDATE tb_pds ");
			sql.append(" SET wname=?, subject=?, passwd=?, filename=?, filesize=?, regdate=sysdate "); 
			sql.append(" WHERE pdsno=? ");
			
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getWname());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getPasswd());
			pstmt.setString(4, dto.getFilename());
			pstmt.setLong(5, dto.getFilesize());
			pstmt.setInt(6, dto.getPdsno());
			res=pstmt.executeUpdate();
			
			
		}catch(Exception e) {
			System.out.println("수정실패!!"+e);
		}finally {
			dbclose.close(con,pstmt);
		}
		
		return res;
	}//update() end
	
	public int update(PdsDTO dto, String saveDir, String updateFile) {
		int res=0;
		try {
			con=dbopen.getConnection();
			sql=new StringBuilder();

			sql.append(" UPDATE tb_pds ");
			sql.append(" SET wname=?, subject=?, passwd=?, filename=?, filesize=?, regdate=sysdate "); 
			sql.append(" WHERE pdsno=? ");
			
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getWname());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getPasswd());
			pstmt.setString(4, dto.getFilename());
			pstmt.setLong(5, dto.getFilesize());
			pstmt.setInt(6, dto.getPdsno());
			res=pstmt.executeUpdate();
			if(res==1) {
				//테이블에서 성공적으로 레코드가 삭제되면
				//첨부한 파일도 삭제
				Utility.deleteFile(saveDir, updateFile);
			}//if end
		}catch(Exception e) {
			System.out.println("수정실패!!"+e);
		}finally {
			dbclose.close(con,pstmt);
		}		
		return res;
	}//update() end
	
}//class end





