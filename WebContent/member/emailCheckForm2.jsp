<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:include page="../header.jsp"></jsp:include>
<!-- 본문 시작 template.jsp -->
<div style="text-align:center;">
	<p>* E-Mail 중복 확인 *</p>
	<form method="post" action="emailCheckProc2.jsp" onsubmit="return blankCheck(this)">
	E-Mail : <input type="text" name="email" autofocus>
			   <input type="submit" value="검색">
	</form>
	</div>
<script>
	function blankCheck(f){
		var email=f.email.value;
		email=email.trim();
		if(email.indexOf('@')==-1 || email.indexOf('.')==-1){
			alert("E-Mail 주소의 @와 .을 확인해주세요");
			f.email.focus();
			return false;
		}
		return true;
	}//blankCheck() end
</script>	

<!-- 본문 끝 -->
<jsp:include page="../footer.jsp"></jsp:include>