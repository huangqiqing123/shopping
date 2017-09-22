<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.page import="cn.sdfi.model.User"/>
<%
			
				User user=(User)session.getAttribute("user");
				if (user==null||user.getPrivledge()!=3) {
					out.print("<script>alert('对不起，你不是会员，请先注册!!!!');javascript:window.location.href='main.jsp';</script>");
					return;
				}
%>