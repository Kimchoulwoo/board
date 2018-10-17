<%@page import="net.utility.Utility"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>pdsTestProc.jsp</title>
</head>
<body>
<p>* 파일 업로드 테스트 결과 *</p>
<%
	/* 폼에 enctype이 추가되면 request객체가 가지고 있는 값을
		제대로 읽어올 수 없다!!
		-> request.getParameter("") 메소드는 null값이 반환된다.
	request.setCharacterEncoding("UTF-8");
	out.println(request.getParameter("uname"));
	out.println("<hr>");
	out.println(request.getParameter("title"));
	out.println("<hr>");
	out.println(request.getParameter("content"));
	out.println("<hr>");
	out.println(request.getParameter("filenm"));
	out.println("<hr>");
	*/
	
	try{
		String saveDirectory = application.getRealPath("/upload");
		int maxPostSize=1024*1024*10;  //10Mb
		String encoding="UTF-8";
		
		//전송된 파일을 저장하기(request, 저장위치, 파일최대크기,인코딩,동명파일일때(a.jpg / a1.jpg / a2.jpg))
		MultipartRequest mr = new MultipartRequest(request,saveDirectory,maxPostSize,encoding,new DefaultFileRenamePolicy());
		
		out.println("<p>파일 전송 성공</p>");
		
		//mr 객체가 보관하고 있는 정보 가져오기
		String uname=mr.getParameter("uname");
		String title=mr.getParameter("title");
		String content=mr.getParameter("content");
		
		out.println("이름 : "+uname+"<hr>");
		out.println("제목 : "+title+"<hr>");
		out.println("내용 : "+content+"<hr>");
		
		//전송된 파일과 관련된 정보
		
		//1) 사용자가 전송시킨 파일 정보를 담고있는 모든 값 가져오기
		//<input type="file">
		Enumeration files = mr.getFileNames();
		
		//2) 1번중에서 요소를 개별적으로 가져오기
		//    <input name="filenm">
		String item = (String)files.nextElement();
		out.print(item+"<hr>");
		
		//3) mr 객체에서 2)파일 관련자료 가져오기
		String fileName = mr.getFilesystemName(item);
		String ofileName = mr.getOriginalFileName(item);
		
		out.println("원본 파일명"+ofileName+"<hr>");
		out.println("저장 파일명"+fileName+"<hr>");
		
		//4) upload폴더에 저장된 파일의 세부정보 확인하지
		//    mr객체에서 전송된 실제 파일을 가져와 obj 객체에 옮겨담기
		File obj = mr.getFile(item);
		if(obj.exists()){
			out.println(fileName+"파일이 존재함<hr>");
			out.println("파일명 : "+obj.getName()+"<hr>");
			out.println("파일크기 : "+obj.length()+"<hr>");
			out.println("파일크기 : "+(obj.length()/1024)+"KB<hr>");
			out.println("파일크기 : "+Utility.toUnitStr(obj.length())+"<hr>");
			
			//파일다운로드
			//단, .html .jpg .gif .png .jsp .asp .php등
			//웹브라우저에서 해석되는 페이지 일단 제외
			out.println("첨부파일 : ");
			out.println("<a href='../upload/"+obj.getName()+"'>");
			out.println(obj.getName());
			out.println("</a>");
			
			
		}//if end
		
		
		
	}catch(Exception e){
		out.print(e);
		out.print("<p>파일 업로드 실패!!</p>");
		out.print("<a href='javascript:history.back()'>[다시시도]</a>");
	}
	
%>
</body>
</html>






