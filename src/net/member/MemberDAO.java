package net.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import net.bbs.BbsDTO;
import net.utility.DBClose;
import net.utility.DBOpen;
import net.utility.Utility;

public class MemberDAO {
	DBOpen dbopen=null;
	DBClose dbclose=null;
	
	Connection con = null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	StringBuilder sql = null;

	public MemberDAO() {
		dbopen = new DBOpen();
		dbclose = new DBClose();
	}//MemberDao() end
	
	//회원가입
	public int insert(MemberDTO dto) {
		int res=0;
		try {
			con=dbopen.getConnection();
			sql=new StringBuilder();
			sql.append(" INSERT INTO member(id, passwd, mname, tel, email, zipcode, address1, address2, job, mlevel, mdate ) "); 
			sql.append(" VALUES(?,?,?,?,?,?,?,?,?,'D1',sysdate) ");
			
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPasswd());
			pstmt.setString(3, dto.getMname());
			pstmt.setString(4, dto.getTel());
			pstmt.setString(5, dto.getEmail());
			pstmt.setString(6, dto.getZipcode());
			pstmt.setString(7, dto.getAddress1());
			pstmt.setString(8, dto.getAddress2());
			pstmt.setString(9, dto.getJob());
			res=pstmt.executeUpdate();
			
		}catch(Exception e) {
			System.out.println("insert 실패!!"+e);
		}finally {
			dbclose.close(con,pstmt);
		}
		return res;
	}//insert() end
	
	public int duplecateID(String id) {
		int cnt=0;
		try {
			con=dbopen.getConnection();
			sql = new StringBuilder();
			sql.append(" SELECT count(id) as cnt "); 
			sql.append(" FROM member "); 
			sql.append(" WHERE id=? ");
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			
			rs=pstmt.executeQuery();
			if(rs.next()) {
				cnt=rs.getInt("cnt");
			}
		}catch(Exception e) {
			System.out.println("duplecateID 실패!!"+e);
		}finally {
			dbclose.close(con,pstmt,rs);
		}
		return cnt;
	}//duplecateID() end
	
	public String login(MemberDTO dto) {
		String mlevel=null;
		try {
			con=dbopen.getConnection();
			sql = new StringBuilder();
			sql.append(" SELECT mlevel "); 
			sql.append(" FROM member "); 
			sql.append(" WHERE id=? AND passwd=? ");
			sql.append(" AND mlevel IN ('A1', 'B1', 'C1', 'D1') ");
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPasswd());
			
			rs=pstmt.executeQuery();
			if(rs.next()) {
				mlevel=rs.getString("mlevel");
			}
		}catch(Exception e) {
			System.out.println("login() 실패!"+e);
		}finally {
			dbclose.close(con,pstmt,rs);
		}
		return mlevel;
	}//login() end
	
	public int duplecateEmail(String email) {
		int cnt=0;
		try {
			con=dbopen.getConnection();
			sql = new StringBuilder();
			sql.append(" SELECT count(email) ");
			sql.append(" FROM member ");
			sql.append(" WHERE email=? ");
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, email);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				cnt=rs.getInt("count(email)");
			}
		}catch(Exception e) {
			System.out.println("duplecateEmail()실패!!"+e);
		}finally {
			dbclose.close(con,pstmt,rs);
		}
		return cnt;
	}//duplecateEmail() end
	
	public MemberDTO updateForm(String id, String passwd) {
			MemberDTO dto = null;
			try {
				con=dbopen.getConnection();
				sql= new StringBuilder();
				
				sql.append(" SELECT passwd, mname, email, zipcode, address1, address2, job ");
				sql.append(" FROM member "); 
				sql.append(" WHERE id=? AND passwd=? ");
				
				pstmt=con.prepareStatement(sql.toString());
				pstmt.setString(1, id);
				pstmt.setString(2, passwd);
				rs=pstmt.executeQuery();
				
				if(rs.next()) {
					dto= new MemberDTO();
					dto.setPasswd(rs.getString("passwd"));
					dto.setMname(rs.getString("mname"));
					dto.setEmail(rs.getString("email"));
					dto.setZipcode(rs.getString("zipcode"));
					dto.setAddress1(rs.getString("address1"));
					dto.setAddress2(rs.getString("address2"));
					dto.setJob(rs.getString("job"));
				}//if end			
			}catch(Exception e) {
				System.out.println("수정폼 실패"+e);
			}finally{
				dbclose.close(con,pstmt,rs);
			}
			return dto;
	}
	
	public int update(MemberDTO dto) {
		int res=0;
		try {
			con=dbopen.getConnection();
			sql=new StringBuilder();
			sql.append(" UPDATE member ");
			sql.append(" SET passwd=?, mname=?, email=?, zipcode=?, address1=?, address2=?, job=? "); 
			sql.append(" WHERE id=? ");
			
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getPasswd());
			pstmt.setString(2, dto.getMname());
			pstmt.setString(3, dto.getEmail());
			pstmt.setString(4, dto.getZipcode());
			pstmt.setString(5, dto.getAddress1());
			pstmt.setString(6, dto.getAddress2());
			pstmt.setString(7, dto.getJob());
			pstmt.setString(8, dto.getId());
			res=pstmt.executeUpdate();
		}catch(Exception e) {
			System.out.println("수정실패!!"+e);
		}finally {
			dbclose.close(con,pstmt);
		}
		
		return res;
	}//update() end
	
	public int delete(MemberDTO dto) {
		int res=0;
		try {
			con=dbopen.getConnection();
			sql = new StringBuilder();
			sql.append(" UPDATE member ");
			sql.append(" SET mlevel='F1' ");
			sql.append(" WHERE id=? AND passwd=? ");
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPasswd());
			res=pstmt.executeUpdate();
		}catch(Exception e) {
			System.out.println("delete실패!!"+e);
		}finally {
			dbclose.close(con,pstmt,rs);
		}
		return res;
	}//delete() end
	
	public int recordCount() {
		int cnt=0;
		try {
			con=dbopen.getConnection();
			sql = new StringBuilder();
			sql.append(" SELECT count(id) ");
			sql.append(" FROM member ");
			pstmt=con.prepareStatement(sql.toString());
			rs=pstmt.executeQuery();
			if(rs.next()) {
				cnt=rs.getInt("count(id)");
			}
		}catch (Exception e) {
			System.out.println("recordCount() 실패!!"+e);
		}finally {
			dbclose.close(con,pstmt,rs);
		}
		return cnt;
	}//recordCount() end
	
	public ArrayList<MemberDTO> list(String col) {
		 ArrayList<MemberDTO> list=null;
		try {
			con = dbopen.getConnection();
			sql = new StringBuilder();
			sql.append(" SELECT id, passwd, mname, tel, email, mdate, mlevel ");
			sql.append(" FROM member ");
			if(col.equals("") || col.equals("idAsc")) {
				sql.append(" ORDER BY id ASC ");
			}else if(col.equals("idDesc")) {
				sql.append(" ORDER BY id DESC ");
			}else if(col.equals("mnameAsc")) {
				sql.append(" ORDER BY mname ASC ");
			}else if(col.equals("mnameDesc")) {
				sql.append(" ORDER BY mname DESC ");
			}else if(col.equals("mdateAsc")) {
				sql.append(" ORDER BY mdate ASC ");
			}else if(col.equals("mdateDesc")) {
				sql.append(" ORDER BY mdate DESC ");
			}
			pstmt = con.prepareStatement(sql.toString());
			rs=pstmt.executeQuery();
			if(rs.next()) {
				list = new ArrayList<>();
				do {
					MemberDTO dto = new MemberDTO();
					dto.setId(rs.getString("id"));
					dto.setPasswd(rs.getString("passwd"));
					dto.setMname(rs.getString("mname"));
					dto.setTel(Utility.checkNull(rs.getString("tel")));
					dto.setEmail(rs.getString("email"));
					dto.setMdate(rs.getString("mdate"));
					dto.setMlevel(rs.getString("mlevel"));
					list.add(dto);
				}while(rs.next());
			}//if end			
		}catch (Exception e) {
			System.out.println("list 실패!"+e);
		}finally {
			dbclose.close(con,pstmt,rs);
		}
		return list;
	}//list() end
	
	public int levelUpdate(String id, String mlevel) {
		int res=0;
		String str="";
		try {
			con=dbopen.getConnection();
			sql = new StringBuilder();
			sql.append(" SELECT mlevel FROM member ");
			sql.append(" WHERE id=? ");
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				str=rs.getString("mlevel");
			}//if end			
			sql.delete(0, sql.length());
			sql.append(" UPDATE member ");
			sql.append(" SET mlevel=? ");
			sql.append(" WHERE id=? AND mlevel=? ");
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, mlevel);
			pstmt.setString(2, id);
			pstmt.setString(3, str);
			res=pstmt.executeUpdate();
		}catch (Exception e) {
			System.out.println("등급수정 실패!"+e);
		}finally {
			dbclose.close(con,pstmt);
		}
		return res;
	}//levelUpdate() end
	
	public int memberDelete(String id) {
		int res=0;
		try {
			con=dbopen.getConnection();
			sql=new StringBuilder();
			sql.append(" DELETE FROM member ");
			sql.append(" WHERE id=? ");
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			res=pstmt.executeUpdate();
		}catch (Exception e) {
			System.out.println("회원삭제 실패!!"+e);
		}finally {
			dbclose.close(con,pstmt);
		}
		return res;
	}//memberDelete() end
	
	public MemberDTO idpwSearch(String mname, String email) {
		MemberDTO dto = null;
		try {
			con=dbopen.getConnection();
			sql = new StringBuilder();
			sql.append(" SELECT id, passwd, mname, email  ");
			sql.append(" FROM member ");
			sql.append(" WHERE mname=? AND email=? ");
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, mname);
			pstmt.setString(2, email);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				dto = new MemberDTO();
				dto.setId(rs.getString("id"));
				dto.setPasswd(rs.getString("passwd"));
				dto.setMname(rs.getString("mname"));
				dto.setEmail(rs.getString("email"));
			}
		}catch (Exception e) {
			System.out.println("id/pw찾기 실패!!"+e);
		}finally {
			dbclose.close(con,pstmt,rs);
		}
		return dto;
	}//idpwSearch() end
	
	public int updatePw(String id, String newPw) {
		int res =0;
		try {
			con=dbopen.getConnection();
			sql = new StringBuilder();
			sql.append(" UPDATE member  ");
			sql.append(" SET passwd=? ");
			sql.append(" WHERE id=?");
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, newPw);
			pstmt.setString(2, id);
			res=pstmt.executeUpdate();
		}catch (Exception e) {
			System.out.println("id/pw찾기 실패!!"+e);
		}finally {
			dbclose.close(con,pstmt,rs);
		}
		return res;
	}
	
}//class end
