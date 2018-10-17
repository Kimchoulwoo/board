<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:include page="../header.jsp"></jsp:include>
<%@ include file="ssi.jsp"%>
<!-- 본문 시작 template.jsp -->
<%
String id = request.getParameter("id");
String passwd = request.getParameter("passwd");
String mname = request.getParameter("mname");
String email = request.getParameter("email");
String tel = request.getParameter("tel");
String zipcode = request.getParameter("zipcode");
String address1 = request.getParameter("address1");
String address2 = request.getParameter("address2");
String job = request.getParameter("job");

dto.setId(id);
dto.setPasswd(passwd);
dto.setMname(mname);
dto.setEmail(email);
dto.setTel(tel);
dto.setZipcode(zipcode);
dto.setAddress1(address1);
dto.setAddress2(address2);
dto.setJob(job);

int res = dao.insert(dto);
if(res==0){
	out.print("<p>입력이 실패하였습니다.</p>");
	out.print("<a href='javascript:history.back()'>[다시시도]</a> ");
}else{
	  out.println("<script>");
	  out.println("	  alert('입력이 완료되었습니다.');");
	  out.println("    location.href='loginForm.jsp';"); //페이지이동
	  out.println("</script>");
}

%>
<!-- 본문 끝 -->
<jsp:include page="../footer.jsp"></jsp:include>