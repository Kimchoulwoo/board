<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../adminAuth.jsp" %>
<%@ include file="../../notice/ssi.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>noticeForm.jsp</title>
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
<p align="center"><a href="noticeList.jsp">[공지사항 목록]</a></p>
<form name="noticefrm" 
		method="post" 
		action="noticeIns.jsp" 
		onsubmit="return noticeCheck(this)"
		class="noticefrm">
<table id="table-2">
<tr>
	<th colspan='2' style='text-align: center; font-size:20px; color:#000000; border-top:0px; border-bottom:0px'><strong>* 공지사항 입력 *</strong></th>
</tr>
<tr>
    <th>제목</th>
    <td><input type="text" name="subject" size="20"></td>
</tr> 
<tr>
    <th>내용</th>
    <td>
      <textarea rows="5" cols="30" name="content"></textarea>
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
</body>
</html>