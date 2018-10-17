package net.bbs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import net.utility.DBClose;
import net.utility.DBOpen;

public class BbsDAO {
	DBOpen dbopen=null;
	DBClose dbclose=null;
	
	Connection con = null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	StringBuilder sql = null;

	public BbsDAO() {
		dbopen = new DBOpen();
		dbclose = new DBClose();
	}
	
	//비지니스 로직
	
	//bbsIns
	public int insert(BbsDTO dto) {
		int res=0;
		try {
			con=dbopen.getConnection();
			sql=new StringBuilder();
			sql.append(" INSERT INTO tb_bbs(bbsno, wname, subject, content, passwd, ip, grpno)" );
			sql.append(" VALUES(bbsno_seq.nextval, ");
			sql.append(" ?,  ?,  ?,  ?,  ?, ");
			sql.append(" (select nvl(max(bbsno),0)+1 from tb_bbs)) ");
			
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getWname());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPasswd());
			pstmt.setString(5, dto.getIp());
			
			res=pstmt.executeUpdate();			
			
		}catch(Exception e) {
			System.out.println("추가 실패!!! " +e);
		}finally {
			dbclose.close(con,pstmt);
		}
		return res;
	}//insert() end
	
	//BbsList
	public ArrayList<BbsDTO> list() {
		 ArrayList<BbsDTO> list=null;
		 
		 try {
			 con=dbopen.getConnection();
			 sql=new StringBuilder();
			 sql.append(" SELECT bbsno,subject, wname, regdt, readcnt, ip, indent ");
			 sql.append(" FROM tb_bbs ");
			 sql.append(" ORDER BY grpno DESC, ansnum ASC");
			 pstmt=con.prepareStatement(sql.toString());
			 rs=pstmt.executeQuery();
			 
			 if(rs.next()) {
				 list= new ArrayList<>();
				 do {
					 BbsDTO dto = new BbsDTO();
					 dto.setBbsno(rs.getInt("bbsno"));
					 dto.setSubject(rs.getString("subject"));
					 dto.setWname(rs.getString("wname"));
					 dto.setRegdt(rs.getString("regdt"));
					 dto.setReadcnt(rs.getInt("readcnt"));
					 dto.setIp(rs.getString("ip"));
					 dto.setIndent(rs.getInt("indent"));
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
	
	public BbsDTO read(int bbsno) {
		BbsDTO dto =null;
		try {
			con=dbopen.getConnection();
			sql=new StringBuilder();
			sql.append(" SELECT wname, subject, content, readcnt, grpno, ip, regdt, passwd" );
			sql.append(" FROM tb_bbs" );
			sql.append(" WHERE bbsno=? ");
			
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);
			
			rs=pstmt.executeQuery();
			if(rs.next()) {
				dto = new BbsDTO();
				dto.setWname(rs.getString("wname"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setReadcnt(rs.getInt("readcnt"));
				dto.setGrpno(rs.getInt("grpno"));
				dto.setIp(rs.getString("ip"));
				dto.setRegdt(rs.getString("regdt"));
				dto.setPasswd(rs.getString("passwd"));
			}//if end
		}catch(Exception e) {
			System.out.println("상세보기 실패!!" +e);
		}finally {
			dbclose.close(con,pstmt,rs);
		}
		return dto;
	}//read() end
	
	public void incrementCnt(int bbsno) {
		try {
		con=dbopen.getConnection();
		sql=new StringBuilder();
		
		sql.append(" UPDATE tb_bbs ");
		sql.append(" SET readcnt=readcnt+1 "); 
		sql.append(" WHERE bbsno=?");
		pstmt=con.prepareStatement(sql.toString());
		pstmt.setInt(1, bbsno);
		pstmt.executeUpdate();
		}catch(Exception e) {
			System.out.println("조회수 증가 실패!!"+e);
		}finally {
			dbclose.close(con,pstmt);
		}		
	}//incrementCnt() end
	
	public int reply(BbsDTO dto) {
		int res=0;
		try {
			con=dbopen.getConnection();
			sql=new StringBuilder();
			
			//1) 부모글 정보 가져오기(그룹번호, 들여쓰기, 글순서) SELECT문
			int grpno=0, indent=0, ansnum=0;
			sql.append(" SELECT grpno, indent, ansnum ");
			sql.append(" FROM tb_bbs ");
			sql.append(" WHERE bbsno=? ");
			
			pstmt = con.prepareStatement(sql.toString());
			pstmt.setInt(1, dto.getBbsno());
			rs=pstmt.executeQuery();
			if(rs.next()) {
				grpno = rs.getInt("grpno");        //부모글 그룹번호
				indent = rs.getInt("indent")+1;   //부모글 들여쓰기 +1
				ansnum=rs.getInt("ansnum")+1; //부모글 글순서+1
			}
			
			//2) 글순서 재조정 UPDATE문
			// 1)에서 사용한 sql오브젝트를 초기화 해줘야 함
			//초기화방법
			sql.delete(0, sql.length());         //또는 sql=new StringBuilder();
			
			sql.append(" UPDATE tb_bbs ");
			sql.append(" SET ansnum = ansnum+1 ");
			sql.append(" WHERE grpno=? AND ansnum>=? ");
			
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, grpno);
			pstmt.setInt(2, ansnum);
			pstmt.executeUpdate();
			
			//3) 답변글 추가 INSERT문
			sql.delete(0, sql.length());
			sql.append(" INSERT INTO tb_bbs(bbsno, wname, subject, content, passwd, ip, grpno, indent, ansnum)"); 
			sql.append(" values(bbsno_seq.nextval, ");
			sql.append(" ?, ?, ?, ?, ?, ?, ?, ?) ");
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getWname());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPasswd());
			pstmt.setString(5, dto.getIp());
			pstmt.setInt(6, grpno);
			pstmt.setInt(7, indent);
			pstmt.setInt(8, ansnum);
			res=pstmt.executeUpdate();
			
		}catch(Exception e){
			System.out.println("답변등록 실패!!"+e);
		}finally {
			dbclose.close(con,pstmt,rs);
		}
		return res;
	}//reply() end
	
	public int delete(BbsDTO dto) {
		int res=0;
		try {
			con=dbopen.getConnection();
			sql=new StringBuilder();
			
			sql.append(" DELETE FROM tb_bbs" ); 
			sql.append(" WHERE bbsno=? AND passwd=? ");
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, dto.getBbsno());
			pstmt.setString(2, dto.getPasswd());
			res=pstmt.executeUpdate();			
		}catch(Exception e){
			System.out.println("삭제 실패!!" +e);
		}finally {
			dbclose.close(con,pstmt,rs);
		}
		return res;
	}//delete() end
	
	public BbsDTO updateForm(int bbsno,String passwd) {
		BbsDTO dto = null;
		try {
			con=dbopen.getConnection();
			sql= new StringBuilder();
			
			sql.append(" SELECT wname, subject, content ");
			sql.append(" FROM tb_bbs "); 
			sql.append(" WHERE bbsno=? AND passwd=? ");
			
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);
			pstmt.setString(2, passwd);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				dto= new BbsDTO();
				dto.setWname(rs.getString("wname"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
			}//if end			
		}catch(Exception e) {
			System.out.println("수정폼 실패"+e);
		}finally{
			dbclose.close(con,pstmt,rs);
		}
		return dto;
	}//updateForm
	
	public int update(BbsDTO dto) {
		int res=0;
		try {
			con=dbopen.getConnection();
			sql=new StringBuilder();

			sql.append(" UPDATE tb_bbs ");
			sql.append(" SET wname=?, subject=?, content=?, passwd=?, ip=?, regdt=sysdate "); 
			sql.append(" WHERE bbsno=? ");
			
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getWname());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPasswd());
			pstmt.setString(5, dto.getIp());
			pstmt.setInt(6, dto.getBbsno());
			res=pstmt.executeUpdate();
		}catch(Exception e) {
			System.out.println("수정실패!!"+e);
		}finally {
			dbclose.close(con,pstmt);
		}
		
		return res;
	}//update() end
	
	//검색 목록
		public ArrayList<BbsDTO> list(String col, String word) {
			 ArrayList<BbsDTO> list=null;
			 
			 try {
				 con=dbopen.getConnection();
				 sql=new StringBuilder();
				 sql.append(" SELECT bbsno,subject, wname, regdt, readcnt, ip, indent ");
				 sql.append(" FROM tb_bbs ");
				 
				 //검색어가 존재하는지?
				 if(word.length()>=1) {
					 String search="";
					 if(col.equals("wname")) {
						 search+=" WHERE wname LIKE '%"+ word +"%' ";
					 }else if(col.equals("subject")) {
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
						 BbsDTO dto = new BbsDTO();
						 dto.setBbsno(rs.getInt("bbsno"));
						 dto.setSubject(rs.getString("subject"));
						 dto.setWname(rs.getString("wname"));
						 dto.setRegdt(rs.getString("regdt"));
						 dto.setReadcnt(rs.getInt("readcnt"));
						 dto.setIp(rs.getString("ip"));
						 dto.setIndent(rs.getInt("indent"));
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
		
		public int count() {
			int totalRecord=0;
			try {
				con=dbopen.getConnection();
				sql= new StringBuilder();
				sql.append(" SELECT count(bbsno) FROM tb_bbs ");
					pstmt=con.prepareStatement(sql.toString());
				rs=pstmt.executeQuery();
				if(rs.next()) {
					totalRecord=rs.getInt("count(bbsno)");
				}
			}catch(Exception e) {
				System.out.println("카운트 실패!!"+e);
			}finally {
				dbclose.close(con,pstmt,rs);
			}			
			return totalRecord;
		}//count() end
	
		//글갯수
		public int count(String col, String word) {
			int totalRecord=0;
			try {
				con=dbopen.getConnection();
				sql= new StringBuilder();
				sql.append(" SELECT count(bbsno) FROM tb_bbs ");
				
				if(word.length()>=1) {
					 String search="";
					 if(col.equals("wname")) {
						 search+=" WHERE wname LIKE '%"+ word +"%' ";
					 }else if(col.equals("subject")) {
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
					totalRecord=rs.getInt("count(bbsno)");
				}
			}catch(Exception e) {
				System.out.println("카운트 실패!!"+e);
			}finally {
				dbclose.close(con,pstmt,rs);
			}			
			return totalRecord;
		}//count() end
		
		//한 페이지에 출력될 레코드 리스트
		 public ArrayList<BbsDTO> list(String col, String word, int nowPage, int recordPerPage){
			    ArrayList<BbsDTO> list=null;
			    
			    // 페이지당 출력할 레코드 갯수 (10개를 기준)
			    // 1 page : WHERE r>=1 AND r<=10
			    // 2 page : WHERE r>=11 AND r<=20
			    // 3 page : WHERE r>=21 AND r<=30
     		    //nowPage : 1(ssi.jsp), recordPerPage : 5(bbsList.jsp)
			    int startRow = ((nowPage-1) * recordPerPage) + 1 ;  
			    int endRow   = nowPage * recordPerPage;
			    
			    try{
			      con=dbopen.getConnection();
			      sql=new StringBuilder(); 
			      
			      word = word.trim(); //검색어의 좌우 공백 제거

			      //1) 검색을 하지 않는 경우
			      if(word.length()==0) {
			        sql.append(" SELECT bbsno,subject,wname,readcnt,indent,regdt,ip, r");
			        sql.append(" FROM( SELECT bbsno,subject,wname,readcnt,indent,regdt,ip, rownum as r");
			        sql.append("       FROM ( SELECT bbsno,subject,wname,readcnt,indent,regdt,ip");
			        sql.append("              FROM tb_bbs");
			        sql.append("              ORDER BY grpno DESC, ansnum ASC");
			        sql.append("           )");
			        sql.append("     )");
			        sql.append(" WHERE r>=" + startRow + " AND r<=" + endRow) ;
			      } else {
			        //2) 검색을 하는 경우
			        sql.append(" SELECT bbsno,subject,wname,readcnt,indent,regdt,ip, r");
			        sql.append(" FROM( SELECT bbsno,subject,wname,readcnt,indent,regdt,ip, rownum as r");
			        sql.append("       FROM ( SELECT bbsno,subject,wname,readcnt,indent,regdt,ip");
			        sql.append("              FROM tb_bbs");
			        
			        String search="";
			        if(col.equals("wname")) {
			          search += " WHERE wname LIKE '%" + word + "%'";
			        } else if(col.equals("subject")) {
			          search += " WHERE subject LIKE '%" + word + "%'";
			        } else if(col.equals("content")) {
			          search += " WHERE content LIKE '%" + word + "%'";
			        } else if(col.equals("subject_content")) {
			          search += " WHERE subject LIKE '%" + word + "%'";
			          search += " OR content LIKE '%" + word + "%'";
			        }
			        
			        sql.append(search);        
			        
			        sql.append("              ORDER BY grpno DESC, ansnum ASC");
			        sql.append("           )");
			        sql.append("     )");
			        sql.append(" WHERE r>=" + startRow + " AND r<=" + endRow) ;
			      }//if end
			      
			      pstmt=con.prepareStatement(sql.toString());
			      rs=pstmt.executeQuery();
			      if(rs.next()){
			        list=new ArrayList<>();
			        do{
			          BbsDTO dto=new BbsDTO();
			          dto.setBbsno(rs.getInt("bbsno"));
			          dto.setSubject(rs.getString("subject"));
			          dto.setWname(rs.getString("wname"));
			          dto.setReadcnt(rs.getInt("readcnt"));
			          dto.setRegdt(rs.getString("regdt"));
			          dto.setIndent(rs.getInt("indent"));
			          dto.setIp(rs.getString("ip"));
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
		 
		 public ArrayList<BbsDTO> list(String col2) {
			 ArrayList<BbsDTO> list=null;
			 
			 try {
				 con=dbopen.getConnection();
				 sql=new StringBuilder();
				 sql.append(" SELECT bbsno, subject, wname, readcnt, regdt, ip ");
				 sql.append(" FROM tb_bbs ");
				 if(col2.equals("") || col2.equals("bbsnoAsc")) {
						sql.append(" ORDER BY bbsno ASC ");
					}else if(col2.equals("bbsnoDesc")) {
						sql.append(" ORDER BY bbsno DESC ");
					}else if(col2.equals("wnameAsc")) {
						sql.append(" ORDER BY wname ASC ");
					}else if(col2.equals("wnameDesc")) {
						sql.append(" ORDER BY wname DESC ");
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
						 BbsDTO dto = new BbsDTO();
						 dto.setBbsno(rs.getInt("bbsno"));
						 dto.setSubject(rs.getString("subject"));
						 dto.setWname(rs.getString("wname"));
						 dto.setReadcnt(rs.getInt("readcnt"));
						 dto.setRegdt(rs.getString("regdt"));
						 dto.setIp(rs.getString("ip"));
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
		 
		 public int delete(int bbsno) {
				int res=0;
				try {
					con=dbopen.getConnection();
					sql=new StringBuilder();
					
					sql.append(" DELETE FROM tb_bbs" ); 
					sql.append(" WHERE bbsno=? ");
					pstmt=con.prepareStatement(sql.toString());
					pstmt.setInt(1, bbsno);
					res=pstmt.executeUpdate();			
				}catch(Exception e){
					System.out.println("삭제 실패!!" +e);
				}finally {
					dbclose.close(con,pstmt,rs);
				}
				return res;
			}//delete() end
}//class end









