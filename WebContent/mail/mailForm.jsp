<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:include page="../header.jsp"></jsp:include>
<!-- 본문 시작 template.jsp -->
<p>* 문의 메일 보내기 *</p>
<form name='mailForm' method="post" action="./shopProc.jsp">
<table border="1" align="center">
<tr>
	<th bgcolor='silver'>받는사람</th>
	<td><input type="text" name="to" size="30"></td>
</tr>
<tr>
	<th bgcolor='silver'>보내는사람</th>
	<td><input type="text" name="from" size="30"></td>
</tr>
<tr>
	<th bgcolor='silver'>제 목</th>
	<td><input type="text" name="subject" size="30"></td>
</tr>
<tr>
	<th bgcolor='silver'>내 용</th>
	<td>
		<textarea name="msgText" rows="15" cols='50'></textarea>
	</td>
</tr>
</table>
<div align='center'>
	<input type="submit" value="보내기">
	<input type="reset" value="취소">
</div>
<!-- 본문 끝 -->
<jsp:include page="../footer.jsp"></jsp:include>