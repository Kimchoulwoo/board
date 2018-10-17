<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:include page="../header.jsp"></jsp:include>
<%@ include file="ssi.jsp" %>
<!-- 본문 시작 bbsUpdateProc.jsp -->
<%
	int bbsno = Integer.parseInt(request.getParameter("bbsno"));
	String wname=request.getParameter("wname").trim();
	String subject=request.getParameter("subject").trim();
	String content=request.getParameter("content").trim();
	String passwd=request.getParameter("passwd").trim();
	String ip=request.getRemoteAddr().trim();
	
	dto.setWname(wname);
	dto.setSubject(subject);
	dto.setContent(content);
	dto.setPasswd(passwd);
	dto.setIp(ip);
	dto.setBbsno(bbsno);
	int res=dao.update(dto);
	
	if(res==0){
		out.print("<p>수정이 실패하였습니다.</p>");
		out.print("<a href='javascript:history.back()'>[다시시도]</a> ");
	}else{
		  out.println("<script>");
    	  out.println("	  alert('수정이 완료되었습니다.');");
    	  out.println("    location.href='bbsList.jsp?col="+col+"&word="+word+"&nowPage="+nowPage+"';"); //페이지이동
    	  out.println("</script>");
	}	
	
%>
<!-- 본문 끝 -->
<jsp:include page="../footer.jsp"></jsp:include>