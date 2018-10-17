<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:include page="../header.jsp"></jsp:include>
<%@include file="auth.jsp" %>
<!-- 본문 시작 template.jsp -->
* 로그인 *<br>
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
%>
	<form name="loginFrm" method="post" action="loginProc.jsp" onsubmit="return loginCheck(this)" class="signUp">
		<table>
		<tr>
			<td><input type="text" name="id" class="signUpInput" value="<%=c_id %>" placeholder="아이디" required></td>
			<td rowspan="2">
				<!-- type="image"의 기본속성은 submit -->
				<input type="image" src="../images/bt_login.gif"  style="margin-left:10px; cursor:pointer;">
			</td>
		</tr>
		<tr>
			<td><input type="password" name="passwd" class="signUpInput" placeholder="비밀번호" required></td>
		</tr>
		<tr>
			<td colspan="2">
			
			<p style="font-size:12px">
			<%-- 체크상태 유지<%if(!c_id.isEmpty()){out.print("checked");} %> --%> 
				<input type="checkbox" name="c_id" class="signUpEtc" value="SAVE" <%if(!c_id.isEmpty()){out.print("checked");} %>>아이디저장  
				&nbsp;|&nbsp;
				<a href="agreement.jsp">회원가입</a>
				&nbsp;|&nbsp;
				<a href="idpwSearch.jsp">아이디/비번찾기</a>
			</p>
			</td>
		</tr>
		</table>
	</form>
<%
}else{
 out.println("<strong>"+s_id+"</strong>");
 out.println("<a href='logout.jsp'>[로그아웃]</a>");
 out.println("<br><br>");
 out.println("<a href='memberUpdate.jsp'><img src='../images/bt_membermod.gif'></a>");
 out.println("<a href='memberDelete.jsp'><img src='../images/bt_memberdel.gif'></a>");
}	
%>
	
<!-- 본문 끝 -->
<jsp:include page="../footer.jsp"></jsp:include>