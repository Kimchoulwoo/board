<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:include page="../header.jsp"></jsp:include>
<%@ include file="ssi.jsp" %>
<!-- 본문 시작 pdsRead.jsp -->
* 사진 상세보기 *
<p>
	<a href='pdsForm.jsp'>[사진올리기]</a> &nbsp;&nbsp;
	<a href='pdsList.jsp'>[목록]</a>
</p>
<%
	int pdsno = Integer.parseInt(request.getParameter("pdsno"));
	dto=dao.read(pdsno);
	if(dto==null){
		out.println("<p>상세보기 실패!</p>");
		out.println("<a href='javascript:history.back()'>[다시시도]</a>");
	}else{
		dao.incrementCnt(pdsno);
%>
	<table border='1' style='margin:auto; text-align:center'>
		<tr>
			<th style='text-align:center'>제목</th>
			<td><%=dto.getSubject() %></td>
			<th style='text-align:center'>작성자</th>
			<td><%=dto.getWname() %></td>
		</tr>
		<tr>
			<td colspan='4'><img src='../upload/<%=dto.getFilename()%>' style="margin: auto; padding: 5px"></td>			
		</tr>
		<tr>
			<th style='text-align:center'>파일이름</th>
			<td><%=dto.getFilename() %></td>
			<th style='text-align:center'>파일크기</th>
			<td><%=dto.getFilesize()/1024 %>KB</td>
		</tr>
		<tr>
			<th style='text-align:center'>조회수</th>
			<td><%=dto.getReadcnt() %></td>
			<th style='text-align:center'>작성일</th>
			<td><%=dto.getRegdate().substring(0, 10) %></td>
		</tr>
	</table>
	<br>
	<form>
		<input type='hidden' name='pdsno' value="<%=pdsno %>">
		<input type='hidden' name='filename' value="<%=dto.getFilename() %>">
		<input type='hidden' name='nowPage' value='<%=nowPage%>'>
		<input type='button' value="목록" onclick="move(this.form, 'pdsList.jsp')">
	    <input type='button' value="삭제" onclick="move(this.form, 'pdsDel.jsp')">	    
	    <input type='button' value="수정" onclick="move(this.form, 'pdsUpdate.jsp')">
	</form>
	<script>
	     	function move(f, file){
	     		f.action = file;
	     		f.submit();
	     	}
	</script>
<%
	}
%>
<!-- 본문 끝 -->
<jsp:include page="../footer.jsp"></jsp:include>