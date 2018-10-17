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
<title>pdsTestProc3.jsp</title>
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
		//filenm=appleGreen.png&filenm=appleRed.png&filenm=coffee.png
		Enumeration files = mr.getFileNames();
		
		String item="";
		String fileName="";
		String ofileName="";
		File file = null;
		
		int idx=1;
		while(files.hasMoreElements()){  //요소가 존재하는지?
			item = (String)files.nextElement();  //요소값 가져오기
			//out.print(item);
			fileName = mr.getFilesystemName(item);
			ofileName = mr.getOriginalFileName(item);
			
			if(fileName!=null){  //파일이 있으면
				file = mr.getFile(item); //name=filenm이 갖고있는 파일 가져오기
				if(file.exists()){  //파일이 존재하면
					long fileSize = file.length();
					out.println(idx+")파일크기 : "+file.length()+"<br>");
					out.println(idx+")파일명 : "+file.getName()+"<br>");
					out.println(idx+")원본파일명 : "+ofileName+"<br>");
				}
			}//if end
			out.println("<hr>");
		}//while end		
	}catch(Exception e){
		out.print(e);
		out.print("<p>파일 업로드 실패!!</p>");
		out.print("<a href='javascript:history.back()'>[다시시도]</a>");
	}
	
%>
</body>
</html>






