<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:include page="../header.jsp"></jsp:include>
<%@ include file="ssi.jsp" %>
<%@ include file="auth.jsp" %>
<!-- 본문 시작 memberUpdate.jsp -->
* 회원정보수정 *<br>
<%
if(s_id.equals("guest")) {
	//쿠키값 가져오기
	Cookie[] cookies = request.getCookies();
	String c_id="";
	if(cookies!=null){  //쿠키가 존재하는지?
		for(int i=0; i<cookies.length; i++){
			Cookie cookie = cookies[i]; //쿠키를 하나씩 추출
			if(cookie.getName().equals("c_id")==true){ //쿠키변수 c_id 가 있는지?
				c_id = cookie.getValue();
			}
		}
	}//if end	
}else{
%>
<form method='post'
		action="memberUpdateForm.jsp"
		onsubmit="return Up_De_Check(this)">
		<table style="margin:auto" border='1' align="center">
		<tr>
			<td>아이디</td>
			<td><input type="id" name="signUpInput" value="<%=s_id %>"></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="password" name="passwd"></td>
		</tr>
		<tr>
			<td colspan='2'><input type="submit" value="확인"></td>
		</tr>
		</table>
</form>
<%
 out.println("<a href='loginForm.jsp'>[취소]</a>");
}	
%>
<!-- 본문 끝 -->
<jsp:include page="../footer.jsp"></jsp:include>