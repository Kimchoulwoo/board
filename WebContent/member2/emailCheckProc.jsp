<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../header.jsp" %>
<!-- 본문 시작 emailCheckProc.jsp -->
<p>* E-mail 중복체크 결과 *</p>
<c:if test="${res==1 }">
	<p>이 이메일은 이미 존재하는 이메일입니다.</p>
</c:if>

<c:if test="${res==0 }">
	입력 이메일 : <strong>${email }</strong>
	<p>이 이메일는 사용가능합니다.</p>
	<a href='javascript:apply("${email }")'>[사용]</a>
</c:if>

<script>
function apply(email){
	opener.document.regForm.email.value=email;
	window.close();
}//apply() end
</script>
<hr>
<a href="javascript:window.history.back()">[다시 검색]</a>
<a href="javascript:window.close()">[닫기]</a>
<!-- 본문 끝 -->
<%@ include file="../footer.jsp" %>