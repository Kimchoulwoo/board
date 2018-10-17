<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:include page="../header.jsp"></jsp:include>
<%@ include file="ssi.jsp" %>
<!-- 본문 시작 pdsUpdateForm.jsp -->
* 포토갤러리 수정 *
<%
int pdsno = Integer.parseInt(request.getParameter("pdsno"));
String passwd=request.getParameter("passwd").trim();
String saveDir = application.getRealPath("./upload");
String filename = request.getParameter("filename").trim();

dto.setPdsno(pdsno);
dto.setPasswd(passwd);

dto=dao.updateForm(pdsno, passwd);
if(dto==null){
	out.println("<script>");
	out.println("		alert('비밀번호가 일치하지 않습니다.');");
	out.println("		window.history.back();");
	out.println("</script>");
}else{
%>
	<form name="pdsupdate" 
			method="post" 
			action="pdsUpdateProc.jsp" 
			enctype="multipart/form-data" 
			onsubmit="return checkData2(this)">
	<input type="hidden" name="pdsno" value="<%=request.getParameter("pdsno") %>">
	<input type="hidden" name="nowPage" value="<%=nowPage %>">
	<input type="hidden" name="updateFile" value="<%=dto.getFilename() %>">
	<input type="hidden" name="updateFileSize" value="<%=dto.getFilesize() %>">
	<table border="1" style='margin:auto;'>
	  <tr> 
	    <th colspan="2">파일 등록 (* 필수 입력사항)</th>
	  </tr>
	  <tr> 
	    <td colspan="2" height="30"> </td>
	  </tr>
	  <tr> 
	    <th width="97">성명*</th>
	    <td width="5"><input type="text" name="wname" value='<%=dto.getWname()%>'> </td>
	  </tr>
	  <tr> 
	    <th>제목*</th>
	    <td><textarea name="subject" rows='5' cols='50' ><%=dto.getSubject() %></textarea></td>
	  </tr>
	  <tr> 
	    <th>비밀번호*</th>
	    <td><input type="password" name="passwd" value='<%=dto.getPasswd()%>'></td>
	  </tr>
	  <tr> 
	    <th>파일</th>
	    <td><img src='../upload/<%=dto.getFilename() %>' width=100></td>
	  </tr>
	  <tr> 
	    <th>파일명*</th>
	    <td><input type="file" name="filename" size="50" ></td>
	  </tr>
	  <tr> 
	     <td colspan="2" align="center">
	        <input type="submit" value="수정">               
	        <input type="reset"  value="취소">               
	        <input type="button" value="목록"
	               onclick="javascript:location.href='./pdsList.jsp'">
	     </td>
	  </tr>
	  </table>
	</form>
<%
	}
%>
<!-- 본문 끝 -->
<jsp:include page="../footer.jsp"></jsp:include>