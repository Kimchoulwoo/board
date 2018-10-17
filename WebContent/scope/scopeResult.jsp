<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>scopeResult.jsp</title>
</head>
<body>
* 웹페이지의 SCOPE(유효범위) 결과 * <br>
<%
out.println("1) pageContext 영역 : "+ pageContext.getAttribute("kor") + "<hr>");
out.println("2) request 영역 : "+ request.getAttribute("eng") + "<hr>");
out.println("3) session 영역 : "+ session.getAttribute("mat") + "<hr>");
out.println("4) application 영역 : "+ application.getAttribute("name") + "<hr>");
%>
</body>
</html>