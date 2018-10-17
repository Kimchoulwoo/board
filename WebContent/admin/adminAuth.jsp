<%@page import="net.utility.Utility"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<% //adminauth.jsp %>
<%
//관리자 페이지 로그인 상태 확인
String s_admin_id="", s_admin_pw="", s_admin_mlevel="";

if(session.getAttribute("s_admin_id")==null || session.getAttribute("s_admin_pw")==null || session.getAttribute("s_admin_mlevel")==null){ 
	//로그인을 하지 않았다면
	   s_admin_id="guest";
	   s_admin_pw="guest";
	   s_admin_mlevel="E1"; //비회원 등급
	   String root = Utility.getRoot(); //  /myweb
%>
	<!DOCTYPE html>
	<html lang="ko">
	<head>
	<meta charset="UTF-8">
	</head>
	<script>
		function jumpTo(){
			window.top.location.href="<%=root %>"+"/admin/adminLogin.jsp";
		}
	</script>
	<body onload="jumpTo()">
		
	</body>
	</html>

<%
   }else{//로그인을 했다면
	   s_admin_id=(String)session.getAttribute("s_admin_id");
	   s_admin_pw=(String)session.getAttribute("s_admin_pw");
	   s_admin_mlevel=(String)session.getAttribute("s_admin_mlevel");
   }//if end
%>