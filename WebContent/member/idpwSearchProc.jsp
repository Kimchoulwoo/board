<%@page import="java.util.Date"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="ssi.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="net.utility.*" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %>
<jsp:include page="../header.jsp"></jsp:include>
<!-- 본문 시작 idpwSearch.jsp -->
<%

	//1) 입력받은 이름과 이메일 확인
	String mname=request.getParameter("mname").trim();
	String email=request.getParameter("email").trim();
	dto=dao.idpwSearch(mname, email);
	
	
	//2) 맞으면 메일로 아이디와 비밀번호 전송
    //    단, 비밀번호 : 대문자, 소문자, 숫자가 포함된 
    //    랜덤한 10글자 조합한 후 DB에서 수정하고
    //    그 값을 메일로 발송한다.
    if(dto==null){
    	out.print("<p>이름과 이메일을 확인해주세요!!</p>");
    	out.print("<a href='javascript:history.back()'>[다시시도]</a>");
    }else{
    	String newPw="";
    	for(int idx=0; idx<10; idx++){
    		int rand=(int)(Math.random()*3);
    		if(rand==0){
    			char ch = (char)((Math.random()*26)+65);
    			newPw+=ch;
    		}else if(rand==1){
    			char ch2 = (char)((Math.random()*26)+97);
    			newPw+=ch2;
    		}else if(rand==2){
    			int a=(int)(Math.random()*9);
    			newPw+=a;
    		}
    	}
    	String id=dto.getId();
    	int res=dao.updatePw(id, newPw);
    	if(res==0){
    		out.print("<p>새 비밀번호 입력 실패!!</p>");
        	out.print("<a href='javascript:history.back()'>[다시시도]</a>");
    	}else{	    	
			String mailServer="mw-002.cafe24.com";
			Properties props = new Properties();
			props.put("mail.smtp.host", mailServer);
			props.put("mail.smtp.auth", true);
			
			Authenticator myAuth = new MyAuthenticator();
			
			Session sess = Session.getInstance(props, myAuth);
			out.println("메일 서버 인증 가능!!");
			
			try{
				request.setCharacterEncoding("UTF-8");
				String to = email;
				String from = "myweb";
				String subject = "아이디/비밀번호 찾기";
				String msgText = "";
				
				//엔터, 특수문자 변경
						msgText=Utility.convertChar(msgText);
						
						//HTML태그
						msgText +="아이디 : "+id+"<br>";
						msgText +="비밀번호 : "+newPw+"<br>";
					
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
    	}
    }
%>
<!-- 본문 끝 -->
<jsp:include page="../footer.jsp"></jsp:include>










