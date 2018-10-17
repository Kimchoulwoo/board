<%@ page contentType="text/html; charset=UTF-8"%>

<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<%@ page import="net.pds.*" %>
<%@ page import="net.utility.*" %>

<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>


<jsp:useBean id="dao" class="net.pds.PdsDAO" ></jsp:useBean>
<jsp:useBean id="dto" class="net.pds.PdsDTO" ></jsp:useBean>

<% request.setCharacterEncoding("UTF-8"); %>

<%
int nowPage=1;
	if(request.getParameter("nowPage")!=null){
		nowPage=Integer.parseInt(request.getParameter("nowPage"));
	}//if end
%>