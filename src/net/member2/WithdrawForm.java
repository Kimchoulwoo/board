package net.member2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.CommandAction;

public class WithdrawForm implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {
		String id = (String)req.getParameter("id");
		
		req.setAttribute("id", id);
		
		return "withdrawForm.jsp";
	}

}
