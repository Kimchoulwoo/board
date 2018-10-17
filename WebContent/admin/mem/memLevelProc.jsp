<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../../member/ssi.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>memLevelProc.jsp</title>
</head>
<body>
<%
	String id = request.getParameter("id").trim();
	String mlevel = request.getParameter("mlevel").trim();
	
	int res=dao.levelUpdate(id, mlevel);
	if(res==0){
		out.print("<p>등급변경에 실패하였습니다.</p>");
		out.print("<a href='javascript:history.back()'>[다시시도]</a> ");
	}else{
		out.print("<script>");
		out.println("	  alert('등급변경이 완료되었습니다.');");
		out.print("</script>");
		response.sendRedirect("memLevel.jsp");
	}
%>
</body>
</html>