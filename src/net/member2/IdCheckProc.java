package net.member2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.CommandAction;

public class IdCheckProc  implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {
		String id = req.getParameter("id").trim();
		MemberDBBean dao = new MemberDBBean();
		
		int res = dao.duplicateId(id);
		
		req.setAttribute("id", id);
		req.setAttribute("res", res);
				
		return "idCheckProc.jsp";
	}
}
