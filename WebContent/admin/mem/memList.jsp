<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../adminAuth.jsp" %>
<%@ include file="../../member/ssi.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>memLevel.jsp</title>
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
* 회원 목록 *<br>
전체 회원수 : <strong><%=dao.recordCount() %></strong>
<hr>
<h3 style='text-align:center;'><strong>* 회원목록 *</strong></h3>
<table id="table-1">
	<tr>
		<th>아이디</th>
		<th>비밀번호</th>
		<th>이름</th>
		<th>전화번호</th>
		<th>이메일</th>
		<th>가입일</th>
		<th>등급</th>
	</tr>
<%
	//정렬하고자 하는 칼럼값이 없으면 빈문자열""로 치환
	String col = Utility.checkNull(request.getParameter("col"));
	ArrayList<MemberDTO> list = dao.list(col);
	if(list==null){
		out.println("<tr>");
		out.println("		<td colspan='8'><strong>관련자료 없음!!!!</strong></td></tr></table>");
		out.println("</tr>");
	}else{
		for(int idx=0; idx<list.size(); idx++){
			dto = list.get(idx);
%>
			<tr>
				<td><%=dto.getId() %></td>
				<td><%=dto.getPasswd() %></td>
				<td><%=dto.getMname() %></td>
				<td><%=dto.getTel() %></td>
				<td><%=dto.getEmail() %></td>
				<% String mdate = dto.getMdate(); mdate=mdate.substring(0,10);%>
				<td><%=mdate %></td>
				<td><%=dto.getMlevel() %></td>
				</form>
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
				<form action="memList.jsp">
					<select name="col" onchange="sort(this.form)">
						<option value="idAsc" <%if(col.equals("") || col.equals("idAsc")){out.print("selected");} %>>ID 오름차순
						<option value="idDesc" <%if(col.equals("idDesc")){out.print("selected");} %>>ID 내림차순
						<option value="mnameAsc" <%if(col.equals("mnameAsc")){out.print("selected");} %>>이름 오름차순
						<option value="mnameDesc" <%if(col.equals("mnameDesc")){out.print("selected");} %>>이름 내림차순
						<option value="mdateAsc" <%if(col.equals("mdateAsc")){out.print("selected");} %>>가입일 오름차순
						<option value="mdateDesc" <%if(col.equals("mdateDesc")){out.print("selected");} %>>가입일 내림차순
					</select>
				</form>
			</td>
		</tr>
		</table>
		<script>
			function sort(f){	f.submit(); }
		</script>
<%		
		
		
	}//if end
%>
</table>
</body>
</html>