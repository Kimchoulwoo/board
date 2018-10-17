<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:include page="../header.jsp"></jsp:include>
<%@ include file="ssi.jsp" %>
<!-- 본문 시작 template.jsp -->
* 글수정 *<br>
<form method='post'
		action="bbsUpdateForm.jsp"
		onsubmit="return pwCheck(this)">
		<input type="hidden" name="bbsno" value="<%=request.getParameter("bbsno") %>">
		<input type="hidden" name="col" value="<%=col %>">
		<input type="hidden" name="word" value="<%=word %>">
		<table style="margin:auto" border='1' align="center">
		<tr>
			<td>비밀번호</td>
			<td><input type="password" name="passwd"></td>
		</tr>
		<tr>
			<td colspan='2'><input type="submit" value="확인"></td>
		</tr>
		</table>
</form>
<!-- 본문 끝 -->
<jsp:include page="../footer.jsp"></jsp:include>