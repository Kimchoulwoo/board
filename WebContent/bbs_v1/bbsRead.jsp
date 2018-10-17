<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file='ssi.jsp' %>
<jsp:include page="../header.jsp"></jsp:include>
<!-- 본문 시작 template.jsp -->
* 게시글 상세보기 *
<p>
	<a href='bbsForm.jsp'>[글쓰기]</a> &nbsp;&nbsp;
	<a href='bbsList.jsp'>[글목록]</a>
</p>
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
		<table id='table-2' >
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
	     <form>
	     	<input type='hidden' name='bbsno' value='<%=bbsno%>'>
	     	<input type='button' value="목록" onclick="move(this.form, 'bbsList.jsp')">
	     	<input type='button' value="답변" onclick="move(this.form, 'bbsReply.jsp')">
	     	<input type='button' value="삭제" onclick="move(this.form, 'bbsDel.jsp')">
	     	<input type='button' value="수정" onclick="move(this.form, 'bbsUpdate.jsp')">
	     </form>
	     <script>
	     	function move(f, file){
	     		f.action = file;
	     		f.submit();
	     	}
	     </script>
	<%	
		}//if end
	%>
<!-- 본문 끝 -->
<jsp:include page="../footer.jsp"></jsp:include>