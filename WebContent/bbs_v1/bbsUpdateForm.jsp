<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:include page="../header.jsp"></jsp:include>
<%@ include file="ssi.jsp" %>
<!-- 본문 시작 template.jsp -->

* 게시판 글 수정 *<br>
<%
int bbsno = Integer.parseInt(request.getParameter("bbsno"));
String passwd=request.getParameter("passwd").trim();
dto.setBbsno(bbsno);
dto.setPasswd(passwd);

dto=dao.updateForm(bbsno, passwd);
if(dto==null){
	out.println("<script>");
	out.println("		alert('비밀번호가 일치하지 않습니다.');");
	out.println("		window.history.back();");
	out.println("</script>");
}else{
%>
<form name="bbsupdate" 
		method="post" 
		action="bbsUpdateProc.jsp" 
		onsubmit="return bbsCheck(this)"
		class="bbsupdate">
<input type="hidden" name="bbsno" value="<%=request.getParameter("bbsno") %>">
<table id="table-2">
<tr>
    <th>작성자</th>
    <td><input type="text" name="wname" size="10" value="<%=dto.getWname() %>"></td>
</tr> 
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
    <th>비밀번호</th>
    <td><input type="password" name="passwd" size="10" value='<%=passwd %>'></td>
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