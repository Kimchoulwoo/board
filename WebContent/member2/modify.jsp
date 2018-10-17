<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../header.jsp" %>
<!-- 본문 시작 modifyForm.jsp -->
<form method='post'
		action="./modifyForm.do"
		onsubmit="return Up_De_Check(this)">
		<table style="margin:auto" border='1' align="center">
		<tr>
			<td>아이디</td>
			<td><input type="id" name="id" value="${id }"></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="password" name="passwd"></td>
		</tr>
		<tr>
			<td colspan='2'><input type="submit" value="확인">
			<input type="button" onClick="location.href='./loginForm.do'" value="취소">
			</td>			
		</tr>
		</table>
</form>
<!-- 본문 끝 -->
<%@ include file="../footer.jsp" %>