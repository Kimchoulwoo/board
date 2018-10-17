<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../adminAuth.jsp" %>
<%@ include file="../../bbs/ssi.jsp" %>
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
<%
int bbsno=Integer.parseInt(request.getParameter("bbsno"));
String ip = request.getRemoteAddr().trim();
dto=dao.read(bbsno);
if(dto==null){
	out.print("관련 자료 없음!!!!!");
}else{
	//조회수 증가
	dao.incrementCnt(bbsno);
	%>
	<p align="center"><a href="bbsList.jsp">[게시판 목록]</a></p>
	<table id='table-2' >
	<tr>
		<th colspan='2' style='text-align: center; font-size:20px; color:#000000; border-top:0px; border-bottom:0px'>
			<strong>* 상세보기 *</strong>
		</th>
	</tr>
     <tr>
     	<th>이름</th>
     	<td><%=dto.getWname() %></td>
     </tr>
     <tr>
     	<th>제목</th>
     	<td><%=dto.getSubject() %></td>
     </tr>
     <tr>
     	<th>내용</th>
     	<td>
<%
			//엔터 -> <br>, 특수기호 <> 치환
			String content = Utility.convertChar(dto.getContent());
			out.print(content);
%>
     	</td>
     </tr>
     <tr>
     	<th>조회수</th>
     	<td><%=dto.getReadcnt() %></td>
     </tr>
     <tr>
     	<th>그룹번호</th>
     	<td><%=dto.getGrpno() %></td>
     </tr>
     <tr>
     	<th>등록일</th>
     	<td><%=dto.getRegdt() %></td>
     </tr>
     <tr>
     	<th>IP</th>
     	<td><%=dto.getIp() %></td>
     </tr>
     </table>
     <br>
     <script>
     	function move(f, file){
     		f.action = file;
     		f.submit();
     	}
     </script>
<%	
	}//if end
%>
</body>
</html>