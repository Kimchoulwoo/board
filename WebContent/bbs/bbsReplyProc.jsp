<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:include page="../header.jsp"></jsp:include>
<%@ include file="ssi.jsp" %>
<!-- 본문 시작 bbsReplyProc.jsp -->
<%
	int bbsno = Integer.parseInt(request.getParameter("bbsno"));
	String wname = request.getParameter("wname").trim();
	String subject = request.getParameter("subject").trim();
	String content = request.getParameter("content").trim();
	String passwd = request.getParameter("passwd").trim();
	String ip = request.getRemoteAddr().trim();
		
	dto.setBbsno(bbsno);
	dto.setWname(wname);
	dto.setSubject(subject);
	dto.setContent(content);
	dto.setPasswd(passwd);
	dto.setIp(ip);
	
	int res=dao.reply(dto);
	
	if(res==0){
		out.print("<p>답변추가 실패!!</p>");
		out.print("<a href='javascript:window.history.back()'>[다시시도]</a> ");
	}else{
		  out.println("<script>");
    	  out.println("	  alert('답변이 입력되었습니다.');");
    	  out.println("    location.href='bbsList.jsp?col="+col+"&word="+word+"&nowPage="+nowPage+"';"); //페이지이동
    	  out.println("</script>");
	}	
	
%>
<!-- 본문 끝 -->
<jsp:include page="../footer.jsp"></jsp:include>