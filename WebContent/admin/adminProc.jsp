<%@ page contentType="text/html; charset=UTF-8"%>
<%@include file="../member/ssi.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>adminProc.jsp</title>
</head>
<body>
<div style="text-align:center;">
* 관리자 페이지 로그인 결과 *<br>
<%
	String admin_id = request.getParameter("adminid").trim();
	String admin_pw = request.getParameter("adminpw").trim();
	dto.setId(admin_id);
	dto.setPasswd(admin_pw);
	
	String mlevel=dao.login(dto);
	
	if(mlevel==null){
		out.print("<p>아이디와 비밀번호를 다시 확인바랍니다.</p>");
		out.print("<a href='javascript:history.back()'>[다시시도]</a> ");
	}else{
		//로그인 성공(A1, B1등급만 관리자페이지 입장 가능)
		if(mlevel.equals("A1") || mlevel.equals("B1")){
			//로그인 여부 판단 : null이면 로그인 x
			session.setAttribute("s_admin_id", admin_id);
			session.setAttribute("s_admin_pw", admin_pw);
			session.setAttribute("s_admin_mlevel", mlevel);
			response.sendRedirect("adminStart.jsp");
		}else if(mlevel.equals("C1") || mlevel.equals("D1")){
			out.println("<p>등업 후 로그인 가능합니다.!!</p>");
			out.println("<p><a href='javascript:window.history.back();'>[다시시도]</p>");
		}
	}//if end
%>
</body>
</html>