<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../adminAuth.jsp" %>
<%@ include file="../../notice/ssi.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>noticeUpdate.jsp</title>
<style>
	#table-1
	{
		font-family: "Lucida Sans Unicode", "Lucida Grande", Sans-Serif;
		font-size: 13px;
		text-align:center;
		background: #fff;
		width: 70%;
		border-collapse: collapse;
		text-align: center;
		margin:auto;
	}
		#table-1 th
	{
		font-size: 15px;
		font-weight: normal;
		color: #000000;
		padding: 10px 8px;
		border-bottom: 2px solid #000000;
		text-align: center;
	}
	#table-1 td
	{
		color: #000000;
		padding: 9px 8px 0px 8px;

	}
	#table-1 tbody tr:hover td
	{
		color: #009;
		background:#DCEBFF;
	}
</style>
</head>
<body>
<%
	int noticeno = Integer.parseInt(request.getParameter("noticeno"));
	dto.setNoticeno(noticeno);
	
	int res=dao.delete(dto);
	if(res==0){
		out.print("<p>삭제에 실패하였습니다.</p>");
		out.print("<a href='javascript:history.back()'>[다시시도]</a> ");
	}else{
		response.sendRedirect("noticeDelete.jsp");
	}

%>
</table>
</body>
</html>