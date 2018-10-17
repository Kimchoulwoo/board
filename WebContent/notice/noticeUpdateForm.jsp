<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:include page="../header.jsp"></jsp:include>
<%@ include file="ssi.jsp" %>
<!-- 본문 시작 template.jsp -->
* 공지사항 수정 *
<%
int noticeno = Integer.parseInt(request.getParameter("noticeno"));
dto.setNoticeno(noticeno);

dto=dao.updateForm(noticeno);
if(dto==null){
	out.println("<script>");
	out.println("		alert('수정이 실패하였습니다.');");
	out.println("		window.history.back();");
	out.println("</script>");
}else{
%>
<form name="noticeUpdatefrm" 
		method="post" 
		action="noticeUpdateProc.jsp" 
		onsubmit="return noticeCheck(this)"
		class="noticeupdate">
<input type="hidden" name="noticeno" value="<%=request.getParameter("noticeno") %>">
<input type="hidden" name="col" value="<%=col %>">
<input type="hidden" name="word" value="<%=word %>">
<input type="hidden" name="nowPage" value="<%=nowPage %>">
<table id="table-2">
<tr>
    <th>제목</th>
    <td><input type="text" name="subject" size="20" value='<%=dto.getSubject() %>'></td>
</tr> 
<tr>
    <th>내용</th>
    <td>
      <textarea rows="5" cols="30" name="content"><%=dto.getContent() %></textarea>
    </td>
</tr> 
<tr>
    <td colspan="2" align="center">
      <input type="submit" value="수정하기">
      <input type="reset"  value="취소">
    </td>
</tr> 
</table>
</form>
<%
	}
%>
<!-- 본문 끝 -->
<jsp:include page="../footer.jsp"></jsp:include>