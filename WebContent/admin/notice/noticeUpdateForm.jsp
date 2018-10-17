<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../adminAuth.jsp" %>
<%@ include file="../../notice/ssi.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>noticeUpdate.jsp</title>
<script src="../../js/myScript.js"></script>
<style>
	#table-2
	{
		font-family: "Lucida Sans Unicode", "Lucida Grande", Sans-Serif;
		font-size: 12px;
		width: 50%;
		text-align: left;
		border-collapse: collapse;
		margin:auto;
	}
	#table-2 th
	{
		font-size: 14px;
		font-weight: normal;
		padding: 12px 15px;
		border-top: 1px solid #000000;
	}
	#table-2 td
	{
		padding: 10px 15px;
		border-top: 1px solid #000000;
	}
</style>
</head>
<body>
<%
	int noticeno = Integer.parseInt(request.getParameter("noticeno"));
	dto = dao.read(noticeno);
	if(dto==null){
		out.print("<p>내용을 불러올 수 없습니다.</p>");
		out.print("<a href='javascript:history.back()'>[다시시도]</a> ");
	}else{
%>
<p align="center"><a href="noticeUpdate.jsp">[뒤로가기]</a></p>
<form name="noticefrm" 
		method="post" 
		action="noticeUpdateProc.jsp" 
		onsubmit="return noticeCheck(this)"
		class="noticefrm">
		<input type="hidden" name="noticeno" value="<%=request.getParameter("noticeno") %>">
<table id="table-2">
<tr>
	<th colspan='2' style='text-align: center; font-size:20px; color:#000000; border-top:0px; border-bottom:0px'><strong>* 공지사항 입력 *</strong></th>
</tr>
<tr>
    <th>제목</th>
    <td><input type="text" name="subject" size="20" value="<%=dto.getSubject() %>"></td>
</tr> 
<tr>
    <th>내용</th>
    <td>
      <textarea rows="5" cols="30" name="content" ><%=dto.getContent() %></textarea>
    </td>
</tr> 
<tr>
    <td colspan="2" align="center">
      <input type="submit" value="쓰기">
      <input type="reset"  value="취소">
    </td>
</tr> 
</table>
</form>
<%} %>
</body>
</html>