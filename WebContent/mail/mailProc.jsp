<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="net.utility.*" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<jsp:include page="../header.jsp"></jsp:include>
<!-- 본문 시작 template.jsp -->
<p>* 메일 보내기 결과 *</p>
<%
	//1) 카페24 메일서버(POP3 / SMTP서버)
	String mailServer="mw-002.cafe24.com";
	Properties props = new Properties();
	props.put("mail.smtp.host", mailServer);
	props.put("mail.smtp.auth", true);
	
	//2) 메일서버에서 인증받은 아이디/비번
	Authenticator myAuth = new MyAuthenticator();
	
	//3) 1)과 2)를 검증
	Session sess = Session.getInstance(props, myAuth);
	out.println("메일 서버 인증 가능!!");
	
	//4) 메일보내기(받는사람, 보내는사람, 참조, 숨은참조, 제목, 내용, 보낸날짜..)
	try{
		request.setCharacterEncoding("UTF-8");
		String to = request.getParameter("to");
		String from = request.getParameter("from");
		String subject = request.getParameter("subject");
		String msgText = request.getParameter("msgText");
		
		//엔터, 특수문자 변경
		msgText=Utility.convertChar(msgText);
		
		//HTML태그
		msgText +="<br><br>";
		msgText +="<table border='1'>";
		msgText +="<tr>";
		msgText +="	<th>상품명</th>";
		msgText +="	<th>가격</th>";
		msgText +="</tr>";
		msgText +="<tr>";
		msgText +="	<td>운동화</td>";
		msgText +="	<td style='color:red;font=weight:bold;'>15,000원</td>";
		msgText +="</tr>";
		msgText +="</table>";
		
		//이미지 보여주기
		msgText +="<p>";
		msgText +="<img src='http://172.16.4.27:9090/myweb/images/torres.jpg'>";
		msgText +="</p>";
		
		//받는 사람
		InternetAddress[] address={ new InternetAddress(to) };
		
		/* 수신인 여러명
		InternetAddress[] address={ new InternetAddress(to),
											   new InternetAddress(to),
											   new InternetAddress(to)
											  };
		*/
		Message msg = new MimeMessage(sess);
		//받는사람
		msg.setRecipients(Message.RecipientType.TO, address);		
		//보내는사람
		msg.setFrom(new InternetAddress(from));
		
		//보내는 사람(한글)
		//msg.setFrom(new InternetAddress(new InternetAddress(from).getAddress()));
		
		
		//메일제목
		msg.setSubject(subject);
		//메일내용
		msg.setContent(msgText, "text/html; charset=UTF-8");
		//보낸날짜
		msg.setSentDate(new Date());
		
		//메일전송
		Transport.send(msg);
		out.println(to + "님에게 메일이 발송되었습니다.");		
		
	}catch(Exception e){
		out.print("<p>메일전송실패!!"+e+"</p>");
		out.print("<p><a href='javascript:window.history.back();'>[다시시도]</p>");
	}
%>
<!-- 본문 끝 -->
<jsp:include page="../footer.jsp"></jsp:include>










