<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mem_menu.jsp</title>
<base target="down">
</head>
<body>
<form name="bbsfrm" method="post">
<table>
<tr>
  <td><strong>게/시/판/관/리</strong></td>
</tr>
<td>    
     <input type="button" value="게시판목록" onclick="goMove('bbsList.jsp')">
  </td>
</table>
</form>

<script>
function goMove(file){
  document.bbsfrm.action=file;
  document.bbsfrm.submit();
}
</script>
</body>
</html>
