<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:include page="../header.jsp"></jsp:include>
<%@ include file="ssi.jsp" %>
<!-- 본문 시작 noticeDel.jsp -->
* 공지사항 삭제 *
<%
	int noticeno = Integer.parseInt(request.getParameter("noticeno"));	
	
	dto.setNoticeno(noticeno);
	
	int res=dao.delete(dto);
	if(res==0){
		out.println("<script>");
		out.println("		alert('비밀번호가 일치하지 않습니다.');");
		out.println("		window.history.back();");
		out.println("</script>");
	}else{
		out.println("<script>");
		out.println("		alert('해당글이 삭제되었습니다.');");
		out.println("		location.href='noticeList.jsp?col="+col+"&word="+word+"&nowPage="+nowPage+"'; ");
		out.println("</script>");
	}
%>
<!-- 본문 끝 -->
<jsp:include page="../footer.jsp"></jsp:include>