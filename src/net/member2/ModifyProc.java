package net.member2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.CommandAction;

public class ModifyProc implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {
		String id = req.getParameter("id");
		String passwd = req.getParameter("passwd");
		String mname = req.getParameter("mname");
		String email = req.getParameter("email");
		String zipcode = req.getParameter("zipcode");
		String address1 = req.getParameter("address1");
		String address2 = req.getParameter("address2");
		String job = req.getParameter("job");
		
		MemberDataBean member = new MemberDataBean();
		member.setId(id);
		member.setPasswd(passwd);
		member.setMname(mname);
		member.setEmail(email);
		member.setZipcode(zipcode);
		member.setAddress1(address1);
		member.setAddress2(address2);
		member.setJob(job);
		
		MemberDBBean dao = new MemberDBBean();
		int res = dao.modifyMem(member);
		req.setAttribute("res", res);
		
		return "modifyProc.jsp";
	}

}
