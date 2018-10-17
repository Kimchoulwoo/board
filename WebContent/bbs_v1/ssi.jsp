<%@ page contentType="text/html; charset=UTF-8"%>

<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<%@ page import="net.bbs.*" %>
<%@ page import="net.utility.*" %>

<jsp:useBean id="dao" class="net.bbs.BbsDAO" ></jsp:useBean>
<jsp:useBean id="dto" class="net.bbs.BbsDTO" ></jsp:useBean>

<% request.setCharacterEncoding("UTF-8"); %>