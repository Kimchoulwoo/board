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
	
	int res=dao.memberDelete(id);
	if(res==0){
		out.print("<p>회원삭제에 실패하였습니다.</p>");
		out.print("<a href='javascript:history.back()'>[다시시도]</a> ");
	}else{
		out.print("<script>");
		out.print("	  alert('회원삭제가 완료되었습니다.');");
		out.print("</script>");
		response.sendRedirect("memDel.jsp");
	}
%>
</body>
</html>