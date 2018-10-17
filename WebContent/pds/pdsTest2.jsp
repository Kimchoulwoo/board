<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>pdsTest2.jsp</title>
</head>
<body>
<p>* 파일 다중 업로드 테스트 *</p>
<form action="pdsTestProc2.jsp" method='post'
		 enctype="multipart/form-data">
이름 : <input type="text" name="uname" size='20'><br>
제목 : <input type="text" name="title" size='20'><br>
내용 : <textarea name="content" rows='5' cols='20'></textarea><br>
파일첨부① : <input type="file" name="filenm1"><br>
파일첨부② : <input type="file" name="filenm2"><br>
<input type="submit" value="등록">
</form>

</body>
</html>