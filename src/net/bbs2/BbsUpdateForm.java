package net.bbs2;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.CommandAction;

public class BbsUpdateForm implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {
		int num=Integer.parseInt(req.getParameter("num"));
		String passwd = req.getParameter("passwd");
		String pageNum = req.getParameter("pageNum");
		
		BoardDBBean dao = new BoardDBBean();
		BoardDataBean article=dao.updateArticle(num,passwd);
		
		req.setAttribute("num", new Integer(num));		
		req.setAttribute("pageNum", new Integer(pageNum));
		req.setAttribute("article", article);
		
		return "bbsUpdateForm.jsp";
	}//requestPro() end

}//class end
