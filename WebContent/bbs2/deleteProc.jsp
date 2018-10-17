<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../header.jsp" %>
<%@ include file="/view/color.jspf" %>
<!-- 본문 시작 deleteProc.jsp -->
<c:if test="${check==1 }">
	<meta http-equiv="Refresh" content="0;url=/myweb/bbs2/bbslist.do?pageNum=${pageNum }">
</c:if>

<c:if test="${check==0 }">
	<p>비밀번호가 다릅니다.</p>
	<a href="javascript:history.go(-1)">[비밀번호 재입력]</a>
</c:if>

<!-- 본문 끝 -->
<%@ include file="../footer.jsp" %>