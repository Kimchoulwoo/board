<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:include page="../header.jsp"></jsp:include>
<%@ include file="ssi.jsp" %>
<!-- 본문 시작 template.jsp -->
<div style="text-align:center;">
	<p>* E-Mail 중복확인 결과 *</p>
<%
	String email = request.getParameter("email").trim();
	int cnt = dao.duplecateEmail(email);
	out.println("입력 ID : <strong>"+email+"</strong>");
	if(cnt==1){
		out.println("<p>해당 E-Mail은 이미 가입된 E-Mail입니다.</p>");
	}else{
		out.println("<p>해당 E-mail은 사용가능합니다.</p>");
		out.println("<a href='javascript:apply(\"" + email + "\")'>[사용]</a>");
%>
		<script>
		function apply(email){
			opener.document.regUpdateForm.email.value=email;
			window.close();
		}//apply() end
		</script>
<%		
	}
%>
<hr>
<a href="javascript:window.history.back()">[다시 검색]</a>
<a href="javascript:window.close()">[닫기]</a>
<!-- 본문 끝 -->
<jsp:include page="../footer.jsp"></jsp:include>