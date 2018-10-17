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
		Calendar cal=Calendar.getInstance();
		String str="";
		str+=cal.get(Calendar.YEAR);
		str+=(cal.get(Calendar.MONTH)+1);
		str+=cal.get(Calendar.DATE);
		str+=cal.get(Calendar.HOUR_OF_DAY);
		if(cal.get(Calendar.MINUTE)<10){
			str+=0;
		}
		str+=cal.get(Calendar.MINUTE);
		if(cal.get(Calendar.SECOND)<10){
			str+=0;
		}
		str+=cal.get(Calendar.SECOND);
		str+="001";
		//HTML태그
		msgText +="<p>주문번호 : "+str+"</p>";
		msgText +="<p><strong>주문금액 : 55,000원<strong></p>";
		msgText +="<br><br>";
		msgText +="<table border='1'>";
		msgText +="<tr>";
		msgText +="	<th colspan='5'>주 / 문 / 내 / 역</th>";
		msgText +="</tr>";
		msgText +="<tr>";
		msgText +="	<th style='text-align:center'>상품명</th>";
		msgText +="	<th style='text-align:center'>가격</th>";
		msgText +="	<th style='text-align:center'>수량</th>";
		msgText +="	<th style='text-align:center'>금액</th>";
		msgText +="	<th style='text-align:center'>상품</th>";
		msgText +="</tr>";
		msgText +="<tr>";
		msgText +="	<td style='text-align:center'>사과</td>";
		msgText +="	<td style='text-align:center'>10,000</td>";
		msgText +="	<td style='text-align:center'>5</td>";
		msgText +="	<td style='text-align:center'>50,000</td>";
		msgText +="	<td><img style='width:50px; height:50px' src='http://172.16.4.27:9090/myweb/images/apple.jpg'></td>";
		msgText +="</tr>";
		msgText +="<tr>";
		msgText +="	<td style='text-align:center'>수박</td>";
		msgText +="	<td style='text-align:center'>5,000</td>";
		msgText +="	<td style='text-align:center'>1</td>";
		msgText +="	<td style='text-align:center'>5,000</td>";
		msgText +="	<td><img style='width:50px; height:50px' src='http://172.16.4.27:9090/myweb/images/watermelon.jpg'></td>";
		msgText +="</tr>";
		msgText +="</table>";

		
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










