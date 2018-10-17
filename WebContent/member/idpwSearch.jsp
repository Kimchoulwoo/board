<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:include page="../header.jsp"></jsp:include>
<!-- 본문 시작 template.jsp -->
* 아이디 / 비밀번호 찾기 *

<form action="idpwSearchProc.jsp" onsubmit="return idpwSearch(this)" class='signUp'>
이   름 : <input type="text" name="mname" class="signUpInput"><br>
이메일 : <input type="text" name="email" class="signUpInput"><br>
<input type='submit' value="확인">
<input type='submit' value="취소">
</form>
<!-- 본문 끝 -->
<jsp:include page="../footer.jsp"></jsp:include>