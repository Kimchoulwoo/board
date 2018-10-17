package net.bbs2;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.action.CommandAction;
import net.utility.Utility;

public class BbsUpdateProc implements CommandAction {

	@Override
	public String requestPro(HttpServletRequest req, HttpServletResponse resp) throws Throwable {
		String pageNum=req.getParameter("pageNum");
		
		BoardDataBean article = new BoardDataBean(); //DTO
		article.setNum(Integer.parseInt(req.getParameter("num")));
		article.setWriter(req.getParameter("writer"));
		article.setEmail(req.getParameter("email"));
		article.setSubject(req.getParameter("subject"));
		article.setPasswd(req.getParameter("passwd"));
		article.setReg_date(new Timestamp(System.currentTimeMillis()));
		article.setContent(req.getParameter("content"));
		article.setIp(req.getRemoteAddr());
		
		BoardDBBean dao = new BoardDBBean(); //DAO
		dao.updateFormArticle(article);
		
		// view 재구성
		//<meta http-equiv="refresh" content="0;url=/myweb/bbs2/bbslist.do">
		String msg="";
		String root=Utility.getRoot();  //  /myweb  불러옴
		msg+="<meta http-equiv='refresh' content='0;url="+root+"/bbs2/bbslist.do?pageNum="+pageNum+"'>";
		req.setAttribute("msg", msg);
				
		return "bbsResult.jsp";
	}//requestPro() end

}//class end
