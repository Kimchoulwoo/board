package net.member2;

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.CommandAction;

public class ModifyForm implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {
		String id = (String)req.getParameter("id");
		String passwd = (String)req.getParameter("passwd");
		
		MemberDBBean dao = new MemberDBBean();
		MemberDataBean member=dao.modify(id, passwd);
		
		req.setAttribute("member", member);	
		
		return "modifyForm.jsp";
	}

}
