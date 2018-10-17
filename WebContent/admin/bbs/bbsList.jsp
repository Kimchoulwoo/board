<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../adminAuth.jsp" %>
<%@ include file="../../bbs/ssi.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>bbsLidt.jsp</title>
<style>
	#table-1
	{
		font-family: "Lucida Sans Unicode", "Lucida Grande", Sans-Serif;
		font-size: 13px;
		text-align:center;
		background: #fff;
		width: 90%;
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
* 글목록 *<br>
전체 글갯수 : <strong><%=dao.count() %></strong>
<hr>
<h3 style='text-align:center;'><strong>* 게시판목록 *</strong></h3>
<table id="table-1">
	<tr>
		<th>글번호</th>
		<th>제목</th>
		<th>작성자</th>
		<th>조회수</th>
		<th>작성일</th>
		<th>IP</th>
		<th>글삭제</th>
	</tr>
<%
	//정렬하고자 하는 칼럼값이 없으면 빈문자열""로 치환
	String col2 = Utility.checkNull(request.getParameter("col2"));
	ArrayList<BbsDTO> list = dao.list(col2);
	if(list==null){
		out.println("<tr>");
		out.println("		<td colspan='8'><strong>관련자료 없음!!!!</strong></td></tr></table>");
		out.println("</tr>");
	}else{
		for(int idx=0; idx<list.size(); idx++){
			dto = list.get(idx);
%>
			<tr>
				<td><%=dto.getBbsno() %></td>
				<td><a href="bbsRead.jsp?bbsno=<%=dto.getBbsno()%>"><%=dto.getSubject() %></td>
				<td><%=dto.getWname() %></td>
				<td><%=dto.getReadcnt() %></td>
				<% String mdate = dto.getRegdt(); mdate=mdate.substring(0,10);%>
				<td><%=mdate %></td>
				<td><%=dto.getIp() %></td>
				<td><a href='bbsDelete.jsp?bbsno=<%=dto.getBbsno() %>' onclick="bbsDelete()">[글삭제]</a></td>
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
				<form action="bbsList.jsp">
					<select name="col2" onchange="sort(this.form)">
						<option value="bbsnoAsc" <%if(col2.equals("") || col2.equals("bbsnoAsc")){out.print("selected");} %>>글번호 오름차순
						<option value="bbsnoDesc" <%if(col2.equals("bbsnoDesc")){out.print("selected");} %>>글번호 내림차순
						<option value="wnameAsc" <%if(col2.equals("wnameAsc")){out.print("selected");} %>>작성자 오름차순
						<option value="wnameDesc" <%if(col2.equals("wnameDesc")){out.print("selected");} %>>작성자 내림차순
						<option value="regdtAsc" <%if(col2.equals("regdtAsc")){out.print("selected");} %>>작성일 오름차순
						<option value="regdtDesc" <%if(col2.equals("regdtDesc")){out.print("selected");} %>>작성일 내림차순
					</select>
				</form>
			</td>
		</tr>
		</table>
		<script>
			function sort(f){	f.submit(); }
			function bbsDelete(){
				var message = "게시글을 삭제할까요??";
				if(confirm(message)){submit();}
			}
		</script>
<%		
		
		
	}//if end
%>
</table>
</body>
</html>