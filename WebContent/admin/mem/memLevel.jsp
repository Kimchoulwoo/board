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
* 회원 등급 변경 *<br>
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
		<th>등급변경</th>
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
			String mlevel = dto.getMlevel();
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
				<form action="memLevelProc.jsp">
				<input type="hidden" name="id" value="<%=dto.getId() %>">
					<td>
						<select name="mlevel" onchange="levelChange(this.form)">
							<option value="A1" <%if(mlevel.equals("A1")){out.print("selected");} %>>최고관리자
							<option value="B1" <%if(mlevel.equals("B1")){out.print("selected");} %>>중간관리자
							<option value="C1" <%if(mlevel.equals("C1")){out.print("selected");} %>>우수사용자
							<option value="D1" <%if(mlevel.equals("D1")){out.print("selected");} %>>일반사용자
							<option value="E1" <%if(mlevel.equals("E1")){out.print("selected");} %>>비회원
							<option value="F1" <%if(mlevel.equals("F1")){out.print("selected");} %>>탈퇴회원
							<option value="X1" <%if(mlevel.equals("X1")){out.print("selected");} %>>휴면계정
						</select>
					</td>
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
				<form action="memLevel.jsp">
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
			function levelChange(f){
				var message = "회원등급을 변경할까요?";
				if(confirm(message)){f.submit();}
			}
		</script>
<%		
		
		
	}//if end
%>
</table>
</body>
</html>