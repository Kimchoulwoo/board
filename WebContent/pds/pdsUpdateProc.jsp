<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:include page="../header.jsp"></jsp:include>
<%@ include file="ssi.jsp" %>
<!-- 본문 시작 pdsUpdateProc.jsp -->
<%
	try{
		String saveDirectory = application.getRealPath("/upload");
		int maxPostSize=1024*1024*10;  //10Mb
		String encoding="UTF-8";
		
		//1)파일 저장
		//전송된 파일을 저장하기(request, 저장위치, 파일최대크기,인코딩,동명파일일때(a.jpg / a1.jpg / a2.jpg))
		MultipartRequest mr = new MultipartRequest(request,
																	 saveDirectory,
																	 maxPostSize,
																	 encoding,
																	 new DefaultFileRenamePolicy());
		//-------------------------------------------------------------------------------------------
		//2) 파일명과 파일크기
		String fileName="";
		long fileSize=0;
		File fileobj=null;
		String formInput="";
		
		Enumeration formInputs = mr.getFileNames();  //<input type='file'>
		while(formInputs.hasMoreElements()){
			formInput = (String)formInputs.nextElement();
			fileName = mr.getFilesystemName(formInput); //파일명
			//파일크기
			if(fileName!=null){
				fileobj = mr.getFile(formInput); //mr 객체에서 파일 가져와서 담기
				fileSize=fileobj.length();			  // 파일크기	
			}//if end
		}//while() end		
		//----------------------------------------------------------------------------------------------
		//3)테이블에 저장하기위한 정보를 dto 객체에 담기
		int pdsno = Integer.parseInt(mr.getParameter("pdsno"));
		String wname = mr.getParameter("wname").trim();
		String subject = mr.getParameter("subject").trim();
		String passwd = mr.getParameter("passwd").trim();		
		String saveDir = application.getRealPath("/upload");
		int nowPage2 = Integer.parseInt(mr.getParameter("nowPage"));
		
		String updateFile = mr.getParameter("updateFile").trim();
		Long updateFileSize = Long.parseLong(mr.getParameter("updateFileSize"));
		int res=0;
		if(fileName==null){
			dto.setPdsno(pdsno);
			dto.setWname(wname);
			dto.setSubject(subject);
			dto.setPasswd(passwd);
			dto.setFilename(updateFile);
			dto.setFilesize(updateFileSize);			
			res=dao.update(dto);
		
		}else{
			dto.setPdsno(pdsno);
			dto.setWname(wname);
			dto.setSubject(subject);
			dto.setPasswd(passwd);
			dto.setFilename(fileName);
			dto.setFilesize(fileSize);
			res=dao.update(dto, saveDir, updateFile);
		}
		if(res==0){
			out.print("<p>수정이 실패하였습니다.</p>");
			out.print("<a href='javascript:history.back()'>[다시시도]</a> ");
		}else{
			out.println("<script>");
		  	out.println("	  alert('수정이 완료되었습니다.');");
		   	out.println("    location.href='pdsList.jsp?nowPage="+nowPage2+"';"); //페이지이동
		   	out.println("</script>");
		}
		
	}catch(Exception e){
		out.print(e);
		out.print("<p>사진 올리기 실패!!</p>");
		out.print("<a href='javascript:history.back()'>[다시시도]</a>");
}//try() end
%>
<!-- 본문 끝 -->
<jsp:include page="../footer.jsp"></jsp:include>