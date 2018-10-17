<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:include page="../header.jsp"></jsp:include>
<!-- 본문 시작 template.jsp -->
* 답변작성 *
<%
	//부모의 글 번호
	int bbsno=Integer.parseInt(request.getParameter("bbsno"));
%>

<form name="bbsfrm" 
		method="post" 
		action="bbsReplyProc.jsp" 
		onsubmit="return bbsCheck(this)"
		class="bbsfrm">
<input type="hidden" name="bbsno" value="<%=bbsno %>">
<table id="table-2">
<tr>
    <th>작성자</th>
    <td><input type="text" name="wname" size="10"></td>
</tr> 
<tr>
    <th>제목</th>
    <td><input type="text" name="subject" size="20"></td>
</tr> 
<tr>
    <th>내용</th>
    <td>
      <textarea rows="5" cols="30" name="content"></textarea>
    </td>
</tr> 
<tr>
    <th>비밀번호</th>
    <td><input type="password" name="passwd" size="10"></td>
</tr> 
<tr>
    <td colspan="2" align="center">
      <input type="submit" value="답변쓰기">
      <input type="reset"  value="취소">
    </td>
</tr> 
</table>
</form>
<!-- 본문 끝 -->
<jsp:include page="../footer.jsp"></jsp:include>