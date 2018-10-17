package net.bbs2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.CommandAction;
import net.utility.Utility;

public class BbsDeleteProc implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {
		int num=Integer.parseInt(req.getParameter("num"));
		String pageNum=req.getParameter("pageNum");
		String passwd=req.getParameter("passwd");
		
		BoardDBBean dao = new BoardDBBean();
		int check=dao.deleteArticle(num,passwd);
		
		//해당 뷰에서 사용할 속성
		req.setAttribute("pageNum", new Integer(pageNum));
		req.setAttribute("check", new Integer(check));
		
		
		//1)
		//return "deleteProc.jsp";  //해당뷰
		
		//2) view 재구성
		String root=Utility.getRoot();   //  /myweb
		String msg="";
		if(check==1) {  //삭제 성공
			msg+="<meta http-equiv='refresh' content='0;url="+root+"/bbs2/bbslist.do?pageNum="+pageNum+"'>";
			
		}else {  //삭제 실패
			msg +="<!DOCTYPE html>";
			msg +="<head></head>";
			msg +="<body>";
			msg +="		<script>";
			msg +="			alert('비밀번호가 일치하지 않습니다!!');";
			msg +="			history.go(-1);";
			msg +="		</script>";
			msg +="</body>";
			msg +="</html>";
		}
		req.setAttribute("msg", msg);
		return "bbsResult.jsp";
		
	}//requestPro() end

}//class end
