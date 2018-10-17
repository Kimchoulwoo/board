<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>notice_menu.jsp</title>
<base target="down">
</head>
<body>
<form name="noticefrm" method="post">
<table>
<tr>
  <td><strong>공/지/사/항/관/리</strong></td>
  <td>
    <input type="button" value="공지사항 목록" onclick="goMove('noticeList.jsp')">
  </td>
  <td>
    <input type="button" value="공지사항 입력" onclick="goMove('noticeForm.jsp')">
  </td>
  <td>
    <input type="button" value="공지사항 수정" onclick="goMove('noticeUpdate.jsp')">
  </td>
  <td>    
     <input type="button" value="공지사항 삭제" onclick="goMove('noticeDelete.jsp')">
  </td>
</tr>
</table>
</form>

<script>
function goMove(file){
  document.noticefrm.action=file;
  document.noticefrm.submit();
}
</script>
</body>
</html>
