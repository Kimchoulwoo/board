<%@ page contentType="text/html; charset=UTF-8"%>

<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<%@ page import="net.bbs.*" %>
<%@ page import="net.utility.*" %>

<jsp:useBean id="dao" class="net.bbs.BbsDAO" ></jsp:useBean>
<jsp:useBean id="dto" class="net.bbs.BbsDTO" ></jsp:useBean>

<% request.setCharacterEncoding("UTF-8"); %>

<%//검색페이지
	String col = request.getParameter("col");      //검색칼럼
	String word = request.getParameter("word"); //검색어
	col = Utility.checkNull(col);
	word = Utility.checkNull(word);
	/*
	if(col==null){ //검색칼럼이 없는 경우
		col="";
	}
	if(word==null){ //검색어가 없을 경우
		word="";
	}
	*/
	
	//현재페이지
	int nowPage=1;
	if(request.getParameter("nowPage")!=null){
		nowPage=Integer.parseInt(request.getParameter("nowPage"));
	}//if end
%>