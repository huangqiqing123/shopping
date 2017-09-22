<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.page import="cn.sdfi.model.User"/>
<%

		User user = (User)session.getAttribute("user");
		if (user==null||user.getPrivledge()!=1) {
		out.print("<script>alert('请先登陆!!!!');javascript:window.location.href='login.jsp';</script>");
		return;
		}
	%>