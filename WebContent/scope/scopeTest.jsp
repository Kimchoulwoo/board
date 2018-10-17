<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>scopreTest.jsp</title>
</head>
<body>
* 웹페이지의 SCOPE(유효범위) *<br>
<%
	/*
	- SCOPE의 종류
	 1) page
	 2) request
	 3) session
     4) application

	- 각 SCOPE의 변수 선언 형식 //변수명은 자료형 x, 사용할때 형변환 해서 써야함
	 1) pageContext.setAttribute("변수명", 값); 
	 2) request.setAttribute("변수명", 값);
	 3) session.setAttribute("변수명", 값);
	 4) application.setAttribute("변수명", 값);
	 
	- 각 SCOPE의 변수값 가져오기
	 1) pageContext.getAttribute("변수명");
	 2) request.getAttribute("변수명");
	 3) session.getAttribute("변수명");
	 4) application.getAttribute("변수명");
	 
	- 각 SCOPE의 변수값 삭제하기
	 1) pageContext.removeAttribute("변수명");
	 2) request.removeAttribute("변수명");
	 3) session.removeAttribute("변수명");
	 4) application.removeAttribute("변수명");
	 */
	 
	 
	 //각 SCOPE에 값 올리기
	 pageContext.setAttribute("kor", 100);
	 request.setAttribute("eng", 200);
	 session.setAttribute("mat", 300);
	 application.setAttribute("name", "soldesk");
	 
	 //각 SCOPE값 가져오기 -> 원하는 형태로 형변환!!!
	 Object obj = pageContext.getAttribute("kor");
	 int kor=(int)obj;
	 //request.getParameter("") 주의!!
	 int eng=(int)request.getAttribute("eng");
	 int mat=(int)session.getAttribute("mat");
	 String name = (String)application.getAttribute("soldesk");
	 
	 //출력
	 out.println("1) pageContext 영역 : "+ kor + "<hr>");
	 out.println("2) request 영역 : "+ eng + "<hr>");
	 out.println("3) session 영역 : "+ mat + "<hr>");
	 out.println("4) application 영역 : "+ name + "<hr>");
	 
	 /*---------------------------------------------------
	 //변수 삭제
	 out.println("<p>* SCOPE영역 변수 삭제 후 *</p>");  // null 값
	 pageContext.removeAttribute("kor");
	 request.removeAttribute("eng");
	 session.removeAttribute("mat");
	 application.removeAttribute("name");
	 
	 out.println("1) pageContext 영역 : "+ pageContext.getAttribute("kor") + "<hr>");
	 out.println("2) request 영역 : "+ request.getAttribute("eng") + "<hr>");
	 out.println("3) session 영역 : "+ session.getAttribute("mat") + "<hr>");
	 out.println("4) application 영역 : "+ application.getAttribute("name") + "<hr>");
	 */
	 /*페이지 이동
	 	<a href="">
	 	<form action="">
	 	location.href=""
	 	<jsp:forward page=""></jsp:forward>
	 	response.sendRedirect("");
	 
	 */
	 
%>
<!--① 
     page영역의 값 : null 
 	 request영역의 값 : null (URL로 값을 넘거줘야 한다)
 	 session영역의 값 : 300
    application영역의 값: soldesk
  <a href="scopeResult.jsp">[SCOPE 결과 페이지 이동]</a>
-->

<!--②
    page영역의 값 : null
  	request영역의 값 : null (URL로 값을 넘거줘야 한다)
  	session영역의 값 : 300
    application영역의 값: soldesk
  <form action="scopeResult.jsp">
	  <input type="submit" value="[SCOPE 결과 페이지 이동]">
  </form>
-->

<!--③
    page영역의 값 : null 
    request영역의 값 : null (URL로 값을 넘거줘야 한다)
    session영역의 값 : 300
    application영역의 값: soldesk
  <script>
	  alert("확인을 누르면 결과페이지로 이동합니다.");
	  location.href="scopeResult.jsp";
  </script>
-->

<!--④ 
    page영역의 값 : null 
    request영역의 값 : 200
    session영역의 값 : 300
    application영역의 값: soldesk -->
  <%-- <jsp:forward page="scopeResult.jsp"></jsp:forward> --%>

<!--⑤
    page영역의 값 : null
    request영역의 값 : null (URL로 값을 넘거줘야 한다)
    session영역의 값 : 300
    application영역의 값: soldesk 
     <%-- <% response.sendRedirect("scopeResult.jsp"); %> --%>

 -->
 
 <!--⑥
    page영역의 값 : null
    request영역의 값 : 200
    session영역의 값 : 300
    application영역의 값: soldesk--> 
<%
    String view = "scopeResult.jsp";
	RequestDispatcher rd = request.getRequestDispatcher(view);
	rd.forward(request, response);
  %>  


</body>
</html>











