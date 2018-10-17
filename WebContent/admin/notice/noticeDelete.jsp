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
* 공지사항 수정 *<br>
공지사항 수 : <strong><%=dao.count() %></strong>
<hr>
<h3 style='text-align:center;'><strong>* 공지사항목록 *</strong></h3>
<table id="table-1">
	<tr>
		<th>글번호</th>
		<th>제목</th>
		<th>작성일</th>
		<th>삭제</th>
	</tr>
<%
	//정렬하고자 하는 칼럼값이 없으면 빈문자열""로 치환
	String col2 = Utility.checkNull(request.getParameter("col2"));
	ArrayList<NoticeDTO> list = dao.list(col2);
	if(list==null){
		out.println("<tr>");
		out.println("		<td colspan='8'><strong>관련자료 없음!!!!</strong></td></tr></table>");
		out.println("</tr>");
	}else{
		for(int idx=0; idx<list.size(); idx++){
			dto = list.get(idx);
%>
			<tr>
				<td><%=dto.getNoticeno() %></td>
				<td><a href="noticeRead.jsp?noticeno=<%=dto.getNoticeno()%>"><%=dto.getSubject() %></a></td>
				<% String regdt = dto.getRegdt(); regdt=regdt.substring(0,10);%>
				<td><%=regdt %></td>
				<td><a href='noticeDeleteProc.jsp?noticeno=<%=dto.getNoticeno() %>' onclick="deleteNotice()">[삭제하기]</a></td>
			</tr>
<%
		}//for end
%>
		</table>
		<br>
		<!-- 정렬 -->
		<table>
		<tr>
			<td>
				<form action="noticeList.jsp">
					<select name="col2" onchange="sort(this.form)">
						<option value="noticenoAsc" <%if(col2.equals("") || col2.equals("noticenoAsc")){out.print("selected");} %>>글번호 오름차순
						<option value="noticenoDesc" <%if(col2.equals("noticenoDesc")){out.print("selected");} %>>글번호 내림차순
						<option value="subjectAsc" <%if(col2.equals("subjectAsc")){out.print("selected");} %>>제목 오름차순
						<option value="subjectDesc" <%if(col2.equals("subjectDesc")){out.print("selected");} %>>제목 내림차순
						<option value="regdtAsc" <%if(col2.equals("regdtAsc")){out.print("selected");} %>>작성일 오름차순
						<option value="regdtDesc" <%if(col2.equals("regdtDesc")){out.print("selected");} %>>작성일 내림차순
					</select>
				</form>
			</td>
		</tr>
		</table>
		<script>
			function sort(f){	f.submit(); }
			function deleteNotice(){
				var message = "해당글을 삭제할까요?";
				if(confirm(message)){submit();}
			}
		</script>
<%		
		
		
	}//if end
%>
</table>
</body>
</html>