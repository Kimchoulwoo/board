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
		if(res==1) {  //���� ����
			return "logout.jsp";
			
		}else {  //���� ����
			msg +="<!DOCTYPE html>";
			msg +="<head></head>";
			msg +="<body>";
			msg +="		<script>";
			msg +="			alert('��й�ȣ�� ��ġ���� �ʽ��ϴ�!!');";
			msg +="			history.go(-1);";
			msg +="		</script>";
			msg +="</body>";
			msg +="</html>";
		}
		req.setAttribute("msg", msg);
		
		return "procResult.jsp";
	}

}
