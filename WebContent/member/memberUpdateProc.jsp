<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:include page="../header.jsp"></jsp:include>
<%@ include file="ssi.jsp" %>
<%@ include file="auth.jsp" %>
<!-- 본문 시작 bbsUpdateProc.jsp -->
<%
String id = s_id;
String passwd = request.getParameter("passwd").trim();
String mname = request.getParameter("mname");
String email = request.getParameter("email");
String zipcode = request.getParameter("zipcode");
String address1 = request.getParameter("address1");
String address2 = request.getParameter("address2");
String job = request.getParameter("job");

dto.setId(id);
dto.setPasswd(passwd);
dto.setMname(mname);
dto.setEmail(email);
dto.setZipcode(zipcode);
dto.setAddress1(address1);
dto.setAddress2(address2);
dto.setJob(job);
int res=dao.update(dto);

if(dto==null){
	out.println("<script>");
	out.println("		alert('비밀번호가 일치하지 않습니다.');");
	out.println("		window.history.back();");
	out.println("</script>");
}else{
		  out.println("<script>");
    	  out.println("	  alert('수정이 완료되었습니다.');");
    	  out.println("    location.href='../index.jsp';"); //페이지이동
    	  out.println("</script>");
}	
	
%>
<!-- 본문 끝 -->
<jsp:include page="../footer.jsp"></jsp:include>