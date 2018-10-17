<%@page import="java.io.PrintWriter"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>sessionTest.jsp</title>
</head>
<body>
* session 내부객체 *<br>
<%
	//HttpSession session
	out.println("현재 세션 유지 시간 : ");
	out.println(session.getMaxInactiveInterval());
	out.println("초(30분)");
	out.println("<hr>");
	
	session.setMaxInactiveInterval(60*10);
	out.println("변경된 세션 유지 시간 : ");
	out.println(session.getMaxInactiveInterval());
	out.println("초(10분)");
	out.println("<hr>");

	/*
		web.xml 배치관리자(환경설정, 초기값설정)
		※ 주의사항 : web.xml 수정이 되면 반드시 서버를 재시작해야 함
		<!-- 세션 유지 시간 설정 -->
		  <session-config>
		  	<session-timeout>600</session-timeout>
		  </session-config>
	
	*/
	//세션변수
	session.setAttribute("id", "soldesk");
	session.setAttribute("passwd", "1234");
	session.setAttribute("mlevel", "D1");
	
	Object obj = session.getAttribute("id");
	String id = (String)obj;
	String passwd = (String)session.getAttribute("passwd");
	String mlevel = (String)session.getAttribute("mlevel");
	
	out.println("세션변수 id : "+id);
	out.println("세션변수 passwd : "+passwd);
	out.println("세션변수 mlevel : "+mlevel);
	
	//세션변수 삭제(로그아웃)
	session.removeAttribute("id");
	session.removeAttribute("passwd");
	session.removeAttribute("mlevel");
	
	//세션영역에 있는 모든 값 전부 삭제
	//session.invalidate();
	
	out.println("<hr>");
	out.println("세션변수 id : "+session.getAttribute("id"));
	
	//세션에서 발급해주는 아이디
	out.println("<hr>");
	out.println("세션 발급 id : "+session.getId());
%>
<hr>
* application 내부 객체 *<br>
<%
	application.setAttribute("comp", "soldesk");
	out.println("<hr>");
	out.println("application 변수 : "+application.getAttribute("comp"));
	
	//member폴더의 실제 물리적인 경로 파악
	//웹경로 : http://localhost:9090/myweb/member
	//실제경로 : D:\java0927\workspace\myweb\WebContent\member
	out.println("<br>");
	out.println(application.getRealPath("/member")); //강추!!
	out.println(request.getRealPath("/member"));
	
%>
<hr>
* request 내부 객체 *<br>
<%
	request.setAttribute("kor", 100);

	// 서버 -> 서버
	out.println("<hr>");
	out.println(request.getAttribute("kor"));
	// 사용자(http://localhost:9090/myweb/test.jsp?kor=100) -> 서버
	out.println("<hr>");
	out.println(request.getParameter("kor"));
%>
<hr>
* response 내부객체 *<br>
<%
	//페이지 이동
	//response.sendRedirect("파일명")
	
	//요청한 사용자에게 개별 응답함
	//PrintWriter write= response.getWriter();
	//write.print();
%>

</body>
</html>












