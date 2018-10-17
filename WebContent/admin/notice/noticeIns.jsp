<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../../notice/ssi.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>noticeIns.jsp</title>
</head>
<body>
<%
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	
	dto.setSubject(subject);
	dto.setContent(content);
	
	int res = dao.insert(dto);
	if(res==0){
		out.print("<p>입력이 실패하였습니다.</p>");
		out.print("<a href='javascript:history.back()'>[다시시도]</a> ");
	}else{
		out.println("<script>");
		out.println("	  alert('입력이 완료되었습니다.');");
		out.println("    location.href='noticeList.jsp';"); //페이지이동
		out.println("</script>");
	}
%>
</body>
</html>