<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:include page="../header.jsp"></jsp:include>
<%@ include file="ssi.jsp" %>
<%@ include file="../member/auth.jsp" %>
<!-- 본문 시작 noticeRead.jsp -->
* 상세보기 *
<%
	int noticeno=Integer.parseInt(request.getParameter("noticeno"));
	dto=dao.read(noticeno);
	if(dto==null){
		out.print("관련 자료 없음!!!!!");
	}else{
		%>
		<table id='table-2' >
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
	     	<th>등록일</th>
	     	<td><%=dto.getRegdt() %></td>
	     </tr>

	     </table>
	     <br>
	     <form>
	     	<input type='hidden' name='noticeno' value='<%=noticeno%>'>
	     	<input type='hidden' name='col' value='<%=col%>'>
	     	<input type='hidden' name='word' value='<%=word%>'>
	     	<input type='hidden' name='nowPage' value='<%=nowPage%>'>
	     	<input type='button' value="목록" onclick="move(this.form, 'noticeList.jsp')">
	     	<%if(s_mlevel.equals("A1")){ %>
	     	<input type='button' value="삭제" onclick="move(this.form, 'noticeDel.jsp')">
	     	<input type='button' value="수정" onclick="move(this.form, 'noticeUpdateForm.jsp')">
	     	<% } %>
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