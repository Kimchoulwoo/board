<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:include page="../header.jsp"></jsp:include>
<%@ include file="ssi.jsp" %>
<!-- 본문 시작 template.jsp -->
<p>* 로그인 결과 *</p><br>
<%
	
	String id = request.getParameter("id").trim();
	String passwd = request.getParameter("passwd").trim();
	dto.setId(id);
	dto.setPasswd(passwd);
	
	String mlevel=dao.login(dto);
	
	if(mlevel==null){
		out.print("<p>아이디와 비밀번호를 다시 확인바랍니다.</p>");
		out.print("<a href='javascript:history.back()'>[다시시도]</a> ");
	}else{
		//out.print("회원님의 등급은 '"+mlevel+"' 입니다");
		
		//로그인 여부 판단 : null이면 로그인 x
		session.setAttribute("s_id", id);
		session.setAttribute("s_passwd", passwd);
		session.setAttribute("s_mlevel", mlevel);
		
		//------------------------------------------------------------------
		//쿠기(아이지저장) <input type="checkbox" name="c_id" value="SAVE">
		String c_id = Utility.checkNull(request.getParameter("c_id"));
		Cookie cookie = null;
		if(c_id.equals("SAVE")){
			cookie = new Cookie("c_id", id); //Cookie("쿠키변수", 값);
			cookie.setMaxAge(60*60*24*30); //쿠키 생존기간 -> 약 1개월
		}else{
			cookie = new Cookie("c_id", ""); 
			cookie.setMaxAge(0);
		}//if end	
		
		//사용자 PC에 쿠키값을 저장
		response.addCookie(cookie);
		//------------------------------------------------------------------
		
		//페이지 이동
		String root = Utility.getRoot();  // ->   /myweb
		response.sendRedirect(root + "/index.jsp");
		
	}//if end
	
%>

<!-- 본문 끝 -->
<jsp:include page="../footer.jsp"></jsp:include>