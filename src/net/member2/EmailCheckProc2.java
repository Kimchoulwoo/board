package net.member2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.CommandAction;

public class EmailCheckProc2  implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {
		String email = req.getParameter("email").trim();
		MemberDBBean dao = new MemberDBBean();
		
		int res = dao.duplecateEmail(email);
		
		req.setAttribute("email", email);
		req.setAttribute("res", res);
				
		return "emailCheckProc2.jsp";
	}
}
