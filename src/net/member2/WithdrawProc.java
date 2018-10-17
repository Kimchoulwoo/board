package net.member2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.CommandAction;
import net.utility.Utility;

public class WithdrawProc implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {
		String id = req.getParameter("id");
		String passwd = req.getParameter("passwd");
		
		MemberDBBean dao = new MemberDBBean();
		int res=dao.withdraw(id, passwd);
				
		String root=Utility.getRoot();   //  /myweb
		String msg="";
		if(res==1) {  //삭제 성공
			return "logout.jsp";
			
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
		
		return "procResult.jsp";
	}

}
