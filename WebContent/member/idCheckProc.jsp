<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="ssi.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>idCheckProc.jsp</title>
</head>
<body>
	<div style="text-align:center;">
	<p>* 아이디 중복확인 결과 *</p>
<%
	String id = request.getParameter("id").trim();
	int cnt = dao.duplecateID(id);
	out.println("입력 ID : <strong>"+id+"</strong>");
	if(cnt==1){
		out.println("<p>이 ID는 이미 존재하는 ID입니다.</p>");
	}else{
		out.println("<p>이 ID는 사용가능합니다.</p>");
		out.println("<a href='javascript:apply(\"" + id + "\")'>[사용]</a>"); //apply()안에 값은 반드시 " " 나 ' ' 안에 작성(\" 로 작성해야 "가 출력)
%>
		<script>
		function apply(id){
			opener.document.regForm.id.value=id;
			window.close();
		}//apply() end
		</script>
<%		
	}
%>
<hr>
<a href="javascript:window.history.back()">[다시 검색]</a>
<a href="javascript:window.close()">[닫기]</a>
</body>
</html>