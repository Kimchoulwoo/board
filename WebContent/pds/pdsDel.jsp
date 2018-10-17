<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:include page="../header.jsp"></jsp:include>
<%@ include file="ssi.jsp" %>
<!-- 본문 시작 pdsDel.jsp -->
* 포토갤러리 삭제 *
<form method='post'
		action="pdsDelProc.jsp"
		onsubmit="return pwCheck2(this)">
		<input type="hidden" name="pdsno" value="<%=request.getParameter("pdsno") %>">
		<input type="hidden" name="filename" value="<%=request.getParameter("filename") %>">
	    <input type='hidden' name='nowPage' value='<%=nowPage%>'>
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