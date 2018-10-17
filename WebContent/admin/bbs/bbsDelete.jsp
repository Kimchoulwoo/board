<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../../bbs/ssi.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>memLevelProc.jsp</title>
</head>
<body>
<%
	int bbsno = Integer.parseInt(request.getParameter("bbsno").trim());
	
	int res=dao.delete(bbsno);
	if(res==0){
		out.print("<p>게시글 삭제에 실패하였습니다.</p>");
		out.print("<a href='javascript:history.back()'>[다시시도]</a> ");
	}else{
		response.sendRedirect("bbsList.jsp");
	}
%>
</body>
</html>