<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../header.jsp" %>
<%@ include file="/view/color.jspf" %>
<!-- 본문 시작 loginForm.jsp -->
<div id="content" align="center">
<p>* 로/그/인 *</p>

<c:if test="${empty sessionScope.memid }">
	<%//사용자 pc에 저장된 쿠키값 가져오기	
		Cookie[] cookies=request.getCookies();
		String c_id="";
		if(cookies!=null){ //쿠키가 존재하면
			for(int idx=0; idx<cookies.length; idx++){
				Cookie item = cookies[idx];
				if(item.getName().equals("c_id")==true){ //쿠키변수 c_id
					c_id=item.getValue(); //쿠키값 가져오기
				}
			}//for end
		}//if end
	%>
	<form name="loginfrm" method="post" action="./loginPro.do" class="signUp" onsubmit="return loginCheck(this)">
		<table>
		<tr>
			<td><input type="text" name="id" class="signUpInput" value="<%=c_id %>" placeholder="아이디" required></td>
			<td rowspan="2">
				<input type="image" src="../images/bt_login.gif"  style="margin-left:10px; cursor:pointer;">
				</a>
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
		<tr>
			<td height="1" colspan="3"></td>
		</tr>
		</table>
	</form>
</c:if>

<c:if test="${sessionScope.memid!=null }">
	<table widtg=500 cellpadding="0" align="center" border="1">
	<tr>
		<td rowspan="3" bgcolor="${value_c }" align="center">
			${sessionScope.memid } 님이 방문하셨습니다.
			<form method="post" action="./logout.do">
				<input type="submit" value="로그아웃">
			</form>
			<form mothod="post" action="./modify.do">
				<input type="hidden" name="id" value="${sessionScope.memid }">
				<input type="submit" value="회원정보변경">
			</form>
			<form mothod="post" action="./withdrawForm.do">
				<input type="hidden" name="id" value="${sessionScope.memid }">
				<input type="submit" value="회원탈퇴">
			</form>
		</td>
	</tr>
	</table>
</c:if>
<!-- 본문 끝 -->

<%@ include file="../footer.jsp" %>