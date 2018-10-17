<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>index.jsp</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="css/bootstrap.min.css">
  <link rel="stylesheet" href="css/mystyle.css?ver=1">
  <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
  <script src="js/jquery-3.2.1.min.js"></script>
  <script src="js/bootstrap.min.js"></script>
<script>
		//시계
		function showtime(){
			var today = new Date();
			var str="";

			str+=today.getFullYear()+".";
			
			if(today.getMonth()+1<10){
				srt+="0";
			}
			str+=(today.getMonth()+1)+".";

			if(today.getDate()+1<10){
				str+="0";
			}
			str+=(today.getDate()+1)+" ";

			switch(today.getDay()){
				case 1:str+="(월) "; break;
				case 2:str+="(화) "; break;
				case 3:str+="(수) "; break;
				case 4:str+="(목) "; break;
				case 5:str+="(금) "; break;
				case 6:str+="(토) "; break;
				case 7:str+="(일) "; break;
			}

			if(today.getHours()>11){
				if((today.getHours()-12)<10){
					str+="PM"+"0"+(today.getHours()-12)+":";
				}
			}else{
				if((today.getHours())<10){
					str+="AM"+"0"+(today.getHours())+":";
				}
			}

			if(today.getMinutes()<10){
				str+="0";
			}
			str+=today.getMinutes()+":";
			
			if(today.getSeconds()<10){
				str+="0";
			}
			str+=today.getSeconds();
			
			var time = document.getElementById('time');
			time.innerHTML=str;
			timer1=setTimeout(showtime, 1000);
		}//showtime() end

		//이미지		
		var ctnt=[];
		ctnt[0]="<img src='images/3.png' width=85px>";
		ctnt[1]="<img src='images/4.png' width=85px>";
		ctnt[2]="<img src='images/5.png' width=85px>";
		ctnt[3]="<img src='images/7.png' width=85px>";
		ctnt[4]="<img src='images/8.png' width=85px>";
		ctnt[5]="<img src='images/9.png' width=85px>";
		ctnt[6]="<img src='images/10.png' width=85px>";
		ctnt[7]="<img src='images/11.png' width=85px>";
		ctnt[8]="<img src='images/12.png' width=85px>";
		ctnt[9]="<img src='images/13.png' width=85px>";
		
		function start(){
			for(idx=0; idx<ctnt.length; idx++){			
				document.write("<div id='area"+idx+"' style='position:absolute;top:0px;left:"+(90*idx)+"px'>");
				document.write(ctnt[idx]);
				document.write("</div>");
			}//for end
			window.setTimeout(scroll, 80);
		}//start() end
		
		var temp;
		function scroll(){
			for(idx=0; idx<ctnt.length; idx++){
				temp=document.getElementById("area"+idx).style;
				temp.left = parseInt(temp.left)-10 + "px";

				if(parseInt(temp.left)<-90){
					temp.left=90*(ctnt.length-1) +"px";
				}
			}//for end
			timer2=window.setTimeout(scroll, 80);
		}//scroll() end

		var timer1, timer2;
		function killtime(){
			clearTimeout(timer1);
			clearTimeout(timer2);
		}//killtime() end
		
		//-------------------------------------		
		function getCookie(name) { 
			  var nameOfCookie = name + "="; 
			  var x = 0; 
			  while ( x <= document.cookie.length ) 
			  { 
			    var y = (x+nameOfCookie.length); 
			    if ( document.cookie.substring( x, y ) == nameOfCookie ) { 
			      if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 ) 
			      endOfCookie = document.cookie.length; 
			      return unescape( document.cookie.substring( y, endOfCookie ) ); 
			    } 
			    x = document.cookie.indexOf( " ", x ) + 1; 
			    if ( x == 0 ) break; 
			  } 
			  return ""; 
			}//end
			//팝업창 관련  <input type="checkbox" name="popcookie">에 체크하지 않았다면
			if(getCookie("popcookie")!="done"){
				window.open("popup.html","popwind","width=300,height=350");
			}

		
  </script>
  <style>
		#layer_popup{width:400px; height:200px; text-align:center; position:relative; }
  </style>
</head>
<body onunload="killtime()">

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
        <li><a href="bbs2/bbslist.do">게시판(MVC)</a></li>
        <li><a href="member2/loginForm.do">로그인(MVC)</a></li>
      </ul>
    </div>
  </div>
</nav>
<!-- First Container -->
<div class="container-fluid bg-2 text-center">
  <!-- 디지털 시계 -->
 	<div class="time" id='time'>
 		<script>
 			showtime();
 		</script>
 	</div>
</div>

<!-- Second Container -->
<div class="container-fluid bg-1 text-center">
  <h3 class="margin"> 바른생활  </h3>
  <img src="images/EE.gif" class="img-responsive img-circle margin" style="display:inline" width="350" height="350">
</div>

<!-- Third Container (Grid) -->
<div class="container-fluid bg-3 text-center">    
  <div class="row">
    <div class="col-sm-12">
    <!-- 이미지 스크롤 시작 -->
		<div id="myfilm" >
			<script>
				start();
			</script>
		</div>
	<!-- 이미지 스크롤 종료 -->    
  </div>
</div>
</div>

<!-- Footer -->
<footer class="container-fluid bg-4 text-center">
  Copyright &copy; 2018 my web 
</footer>
</body>
</html>
