<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../header.jsp" %>
<!-- 본문 시작 loginPro.jsp -->
<c:if test="${res==1 }">
	<c:set var="memid" value="${sessionScope.s_id }" scope="session"/>
	<meta http-equiv="Refresh" content="0;url=/myweb/member2/loginForm.do">
</c:if>

<c:if test="${res==0 }">
	아이디 및 비밀번호가 다릅니다<br>
	<a href="javascript:history.go(-1)">[돌아가기]</a>
</c:if>

<!-- 본문 끝 -->
<%@ include file="../footer.jsp" %>