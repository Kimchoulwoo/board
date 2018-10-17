<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:include page="../header.jsp"></jsp:include>
<%@ include file="ssi.jsp" %>
<!-- 본문 시작 pdsIns.jsp -->
<p>* 사진올리기 결과 *</p>
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
	String wname = mr.getParameter("wname").trim();
	String subject = mr.getParameter("subject").trim();
	String passwd = mr.getParameter("passwd").trim();
	
	dto.setWname(wname);
	dto.setSubject(subject);
	dto.setPasswd(passwd);
	dto.setFilename(fileName);
	dto.setFilesize(fileSize);
	
	boolean flag = dao.insert(dto);
	if(flag){
		out.println("<p>이미지를 추가했습니다.</p>");
		out.println("<a href='./pdsForm.jsp'>[사진 계속 올리기]</a>");
		out.println("<a href='./pdsList.jsp'>[사진 목록으로 가기]</a>");
	}else{
		out.println("<p><strong>이미지 등록 실패!</strong></p>");
		out.println("<a href='javascript:history.back()'>[다시시도]</a>");
	}
		
	}catch(Exception e){
		out.print(e);
		out.print("<p>사진 올리기 실패!!</p>");
		out.print("<a href='javascript:history.back()'>[다시시도]</a>");
	}//try() end


%>
<!-- 본문 끝 -->
<jsp:include page="../footer.jsp"></jsp:include>