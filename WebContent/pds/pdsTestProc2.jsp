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
<title>pdsTestProc2.jsp</title>
</head>
<body>
<p>* 파일 다중 업로드 테스트 결과 *</p>
<%
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
		//<input type='file'>
		//<input type="file">
		Enumeration files = mr.getFileNames();
		//전송된 파일이 역순으로 전송된다(MultipartRequest 스택구조)
		//① 파일--------------------------------------------------------------------
		String item1 = (String)files.nextElement();
		String fileName1 = mr.getFilesystemName(item1);
		String ofileName1 = mr.getOriginalFileName(item1);		
		out.println("원본 파일명① : "+ofileName1+"<hr>");
		out.println("저장 파일명① : "+fileName1+"<hr>");
		
		File obj1 = mr.getFile(item1);
		if(obj1.exists()){
			out.println(fileName1+"파일이 존재함<hr>");
			out.println("파일명① : "+obj1.getName()+"<hr>");
			out.println("파일크기① : "+obj1.length()+"<hr>");
		}//if end
		//② 파일--------------------------------------------------------------------
				String item2 = (String)files.nextElement();
				String fileName2 = mr.getFilesystemName(item2);
				String ofileName2 = mr.getOriginalFileName(item2);		
				out.println("원본 파일명② : "+ofileName2+"<hr>");
				out.println("저장 파일명② : "+fileName2+"<hr>");
				
				File obj2 = mr.getFile(item2);
				if(obj2.exists()){
					out.println(fileName2+"파일이 존재함<hr>");
					out.println("파일명② : "+obj2.getName()+"<hr>");
					out.println("파일크기② : "+obj2.length()+"<hr>");
				}//if end
		
		
	}catch(Exception e){
		out.print(e);
		out.print("<p>파일 업로드 실패!!</p>");
		out.print("<a href='javascript:history.back()'>[다시시도]</a>");
	}
	
%>
</body>
</html>






