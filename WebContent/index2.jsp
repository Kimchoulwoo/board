<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>index2.jsp</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="css/bootstrap.min.css">
  <link rel="stylesheet" href="css/mystyle.css">
  <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
  <script src="js/jquery-3.2.1.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
</head>
<body>

<!-- 메인 카테고리 -->
<nav class="navbar navbar-default">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="<%=request.getContextPath() %>/index.jsp">HOME</a> 
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav navbar-right">
        <li><a href="bbs/bbsList.jsp">게시판</a></li>
        <li><a href="notice/noticeList.jsp">공지사항</a></li>
        <li><a href="member/loginForm.jsp">로그인</a></li>
        <li><a href="pds/pdsList.jsp">포토갤러리</a></li>
        <li><a href="mail/mailForm.jsp">메일보내기</a></li>
        <li><a href="bbs2/bbsList.do">게시판(MVC)</a></li>
        <li><a href="member2/loginForm.do">로그인(MVC)</a></li>
      </ul>
    </div>
  </div>
</nav>

<!-- contents 시작 -->
<div class="container-fluid bg-3 text-center">    
  <div class="row">
    <div class="col-sm-12">
    	<!-- 본문 시작 -->
		여기에 내용을 작성하세요
		<!-- 본문 끝 -->
    </div>
  </div>
</div>
<!-- contents 끝 -->

<!-- Footer -->
<footer class="container-fluid bg-4 text-center">
  Copyright &copy; 2018 my web 
</footer>

</body>
</html>
