<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<jsp:directive.page import="cn.sdfi.model.User"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>注销处理</title>
</head>
<body>
<%
if(session==null||session.getAttribute("user")==null){
	response.sendRedirect("main.jsp");;
	return;
}
User user = (User)session.getAttribute("user");
if(user.getPrivledge()==3){
	session.invalidate();
	response.sendRedirect("main.jsp");
	
}
else { 
	session.invalidate();
	response.sendRedirect("login.jsp");
}
%>
</body>
</html>