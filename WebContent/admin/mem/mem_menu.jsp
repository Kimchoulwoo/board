<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mem_menu.jsp</title>
<base target="down">
</head>
<body>
<form name="memfrm" method="post">
<table>
<tr>
  <td><strong>회/원/관/리</strong></td>
  <td>
    <input type="button" value="회원목록" onclick="goMove('memList.jsp')">
  </td>
  <td>
    <input type="button" value="회원등급변경" onclick="goMove('memLevel.jsp')">
  </td>
  <td>    
     <input type="button" value="회원삭제" onclick="goMove('memDel.jsp')">
  </td>
</tr>
</table>
</form>

<script>
function goMove(file){
  document.memfrm.action=file;
  document.memfrm.submit();
}
</script>
</body>
</html>
