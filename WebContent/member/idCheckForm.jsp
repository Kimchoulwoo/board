<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>idCheckForm.jsp</title>
</head>
<body>
	<div style="text-align:center;">
	<p>* 아이디 중복 확인 *</p>
	<form method="post" action="idCheckProc.jsp" onsubmit="return blankCheck(this)">
	아이디 : <input type="text" name="id" maxlength="10" autofocus>
			   <input type="submit" value="검색">
	</form>
	</div>
<script>
	function blankCheck(f){
		var id=f.id.value;
		id=id.trim();
		if(id.length<5){
			alert("아이디는 5~10글자로 입력바랍니다.");
			f.id.focus();
			return false;
		}
		return true;
	}//blankCheck() end
</script>	
</body>
</html>