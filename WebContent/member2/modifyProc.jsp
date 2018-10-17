<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../header.jsp" %>
<!-- 본문 시작 modifyProc.jsp -->
<c:if test="${res==1 }">
	<script>alert("수정이 완료되었습니다.");</script>
	<meta http-equiv="Refresh" content="0;url=/myweb/member2/loginForm.do">
</c:if>

<c:if test="${res==0 }">
	수정에 실패하였습니다.<br>
	<a href="javascript:history.go(-1)">[다시시도]</a>
</c:if>
<!-- 본문 끝 -->
<%@ include file="../footer.jsp" %>