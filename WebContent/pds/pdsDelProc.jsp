<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:include page="../header.jsp"></jsp:include>
<%@ include file="ssi.jsp" %>
<!-- 본문 시작 pdsDelProc.jsp -->
<%
	int pdsno = Integer.parseInt(request.getParameter("pdsno"));
	String passwd = request.getParameter("passwd").trim();
	String filename = request.getParameter("filename").trim();
	
	dto.setPdsno(pdsno);
	dto.setPasswd(passwd);
	dto.setFilename(filename);
	String saveDir = application.getRealPath("/upload");
	
	int res=dao.delete(dto, saveDir);
	if(res==0){
		out.println("<p>비밀번호가 일치하지 않습니다.</p>");
		out.println("<a href='javascript:history.back()'>[다시시도]</a>");
	}else{
		out.println("<script>");
		out.println("		alert('삭제되었습니다.');");
		out.println("    location.href='pdsList.jsp?nowPage="+nowPage+"'; ");
		out.println("</script>");
	}
%>
<!-- 본문 끝 -->
<jsp:include page="../footer.jsp"></jsp:include>