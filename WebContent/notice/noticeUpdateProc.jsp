<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:include page="../header.jsp"></jsp:include>
<%@ include file="ssi.jsp" %>
<!-- 본문 시작 noticeUpdateProc.jsp -->
<%
	int noticeno = Integer.parseInt(request.getParameter("noticeno"));
	String subject = request.getParameter("subject");
	String content = request.getParameter("content");
	dto.setNoticeno(noticeno);
	dto.setSubject(subject);
	dto.setContent(content);
	
	int res = dao.update(dto);
	if(res==0){
		out.print("<p>수정에 실패하였습니다.</p>");
		out.print("<a href='javascript:history.back()'>[다시시도]</a>");
	}else{
		out.print("<script>");
		out.print("	alert('수정을 완료하였습니다.');");
		out.print("	location.href='noticeList.jsp?col="+col+"&word="+word+"&nowPage="+nowPage+"';");
		out.print("</script>");
	}

%>
<!-- 본문 끝 -->
<jsp:include page="../footer.jsp"></jsp:include>