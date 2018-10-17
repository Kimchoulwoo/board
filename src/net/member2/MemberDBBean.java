package net.member2;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import net.utility.DBClose;
import net.utility.DBOpen;

public class MemberDBBean {
	DBOpen dbopen=null;
	DBClose dbclose=null;
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	StringBuffer sql = null;
	
	public MemberDBBean(){
		//데이터베이스 연결 객체 할당
		dbopen = new DBOpen();
		dbclose = new DBClose();
	}//MemberDBBean() end
	
	//아래 영역에 메소드 작성
	public int login(String id, String passwd) throws Exception{
		int res=0;
		try {
			con=dbopen.getConnection();
			sql=new StringBuffer();
			sql.append(" SELECT COUNT(id) as cnt ");
			sql.append(" FROM member ");
			sql.append(" WHERE id = ? AND passwd = ? ");
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			pstmt.setString(2, passwd);
			rs=pstmt.executeQuery();
			if(rs.next()==true) {
				res=rs.getInt("cnt");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose.close(con, pstmt, rs);
		}
		return res;
	}//login() end
	
	//회원가입
	public int insertmem(MemberDataBean mem) throws Exception{
		int res=0;
		try {
			con = dbopen.getConnection();
			sql = new StringBuffer();
			sql.append(" INSERT INTO member ");
			sql.append(" (id, passwd, mname, job, email, zipcode, address1, address2, mlevel, mdate) ");
			sql.append(" VALUES(?,?,?,?,?,?,?,?,'D1',sysdate) ");
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, mem.getId());
			pstmt.setString(2, mem.getPasswd());
			pstmt.setString(3, mem.getMname());
			pstmt.setString(4, mem.getJob());
			pstmt.setString(5, mem.getEmail());
			pstmt.setString(6, mem.getZipcode());
			pstmt.setString(7, mem.getAddress1());
			pstmt.setString(8, mem.getAddress2());
			res=pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dbclose.close(con,pstmt,rs);
		}
		return res;
	}//insertmem() end
	
	//아이디 찾기
	public MemberDataBean idSearch(String id) throws Exception{
		MemberDataBean mod = null;
		try {
			con=dbopen.getConnection();
			sql=new StringBuffer();
			sql.append(" SELECT * FROM member WHERE id=? ");
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				mod=new MemberDataBean();
				mod.setId(rs.getString("id"));
				mod.setAddress1(rs.getString("address1"));
				mod.setAddress2(rs.getString("address2"));
				mod.setEmail(rs.getString("email"));
				mod.setJob(rs.getString("job"));
				mod.setPasswd(rs.getString("passwd"));
				mod.setZipcode(rs.getString("zipcode"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose.close(con,pstmt,rs);
		}		
		return mod;
	}//idSearch() end
	
	public MemberDataBean modify(String id, String passwd) throws Exception{
		MemberDataBean member = null;
		try {
			con=dbopen.getConnection();
			sql = new StringBuffer();
			sql.append(" SELECT id, passwd, mname, email, zipcode, address1, address2, mlevel, mdate, job ");
			sql.append(" FROM member ");
			sql.append(" where id=? AND passwd=? ");
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			pstmt.setString(2, passwd);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				member = new MemberDataBean();
				member.setId(rs.getString("id"));
				member.setPasswd(rs.getString("passwd"));
				member.setMname(rs.getString("mname"));
				member.setEmail(rs.getString("email"));
				member.setZipcode(rs.getString("zipcode"));
				member.setAddress1(rs.getString("address1"));
				member.setAddress2(rs.getString("address2"));
				member.setMlevel(rs.getString("mlevel"));
				member.setMdate(rs.getString("mdate"));
				member.setJob(rs.getString("job"));
			}			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose.close(con,pstmt,rs);			
		}
		return member;
	}//modify() end
	
	//회원수정
	public int modifyMem(MemberDataBean mod) throws Exception{
		int res=0;
		try {
			con=dbopen.getConnection();
			sql = new StringBuffer();
			sql.append(" UPDATE member SET id=?, passwd=?, mname=?, email=?, zipcode=?, address1=?, address2=?, job=? ");
			sql.append(" WHERE id=? ");
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, mod.getId());
			pstmt.setString(2, mod.getPasswd());
			pstmt.setString(3, mod.getMname());
			pstmt.setString(4, mod.getEmail());
			pstmt.setString(5, mod.getZipcode());
			pstmt.setString(6, mod.getAddress1());
			pstmt.setString(7, mod.getAddress2());
			pstmt.setString(8, mod.getJob());				
			pstmt.setString(9, mod.getId());
			res=pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose.close(con,pstmt,rs);
		}
		return res;
	}//modifyMem() end
	
	//회원삭제
	public int withdraw(String id, String passwd) throws Exception{
		int res=0;
		try {
			con=dbopen.getConnection();
			sql=new StringBuffer();
			sql.append(" DELETE FROM member ");
			sql.append(" WHERE id=? AND passwd=? ");
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			pstmt.setString(2, passwd);
			res=pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose.close(con,pstmt,rs);
		}		
		return res;
	}//withdraw() end
	
	//아이디 중복
	public int duplicateId(String id) throws Exception{
			int res=0;
			try {
				con=dbopen.getConnection();
				sql=new StringBuffer();
				sql.append(" SELECT id ");
				sql.append(" FROM member ");
				sql.append(" WHERE id=? ");
				pstmt=con.prepareStatement(sql.toString());
				pstmt.setString(1, id);
				res=pstmt.executeUpdate();				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				dbclose.close(con,pstmt,rs);
			}		
			return res;
		}//duplicateId() end
	
	//이메일 중복
	public int duplecateEmail(String email) throws Exception{
		int res=0;
		try {
			con=dbopen.getConnection();
			sql=new StringBuffer();
			sql.append(" SELECT email ");
			sql.append(" FROM member ");
			sql.append(" WHERE email=? ");
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, email);
			res=pstmt.executeUpdate();				
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dbclose.close(con,pstmt,rs);
		}		
		return res;
	}
	
}//class end
