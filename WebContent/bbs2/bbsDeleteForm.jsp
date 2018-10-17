<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="../header.jsp" %>
<%@ include file="/view/color.jspf" %>
<!-- 본문 시작 bbsDeleteForm.jsp -->
<p><strong>글삭제</strong></p>
<form method="post" name="delForm" 
		 action="./bbsdeleteproc.do?pageNum=${pageNum }"
		 onsubmit="return deleteSave()">
<table border='1' align="center" cellspacing="0" cellpadding="0" width="360">
<tr height="30">
	<td aligh="center" bgcolor="${value_c }">
		<strong>비밀번호를 입력해주세요.</strong>
	</td>
</tr>
<tr height="30">
	<td aligh="center" >비밀번호 :
		<input type="password" name="passwd" size="8" maxlength="12">
		<input type="hidden" name="num" value="${num }">
	</td>
</tr>
<tr height="30">
	<td aligh="center" bgcolor="${value_c }">
		<input type="submit" value="글삭제">
		<input type="button" value="글목록"
				  onclick="location.href='./bbslist.do?pageNum=${pageNum}'">
	</td>
</tr>
</table>
</form>

<script>
	function deleteSave(){
		if(document.delForm.passwd.value==""){
			alert("비밀번호를 입력하십시요");
			document.delForm.passwd.focus();
			return false;
		}
		return true;
	}//deleteSave() end
</script>


<!-- 본문 끝 -->
<%@ include file="../footer.jsp" %>