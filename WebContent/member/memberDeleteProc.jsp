<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:include page="../header.jsp"></jsp:include>
<%@include file="ssi.jsp" %>
<%@include file="auth.jsp" %>
<!-- 본문 시작 template.jsp -->
<%
	String id =s_id;
	String passwd = request.getParameter("passwd").trim();
	dto.setId(id);
	dto.setPasswd(passwd);
	
	int res=dao.delete(dto);
	if(res==0){
		out.println("<script>");
		out.println("		alert('비밀번호가 일치하지 않습니다.');");
		out.println("		window.history.back();");
		out.println("</script>");
	}else{
		out.println("<script>");
		out.println("		alert('해당 회원정보가 삭제되었습니다.');");
		out.println("		location.href='logout.jsp'; ");
		out.println("</script>");
	}


%>
<!-- 본문 끝 -->
<jsp:include page="../footer.jsp"></jsp:include>