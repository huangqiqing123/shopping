<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Iterator"%>
<jsp:directive.page import="cn.sdfi.model.User"/>
<jsp:include page="includes/encoding.jsp" flush="true" />
<jsp:include page="includes/adminCheck.jsp" flush="true" />	
<html>
<head>
<title>在线用户信息查看</title> 
<link rel="stylesheet" type="text/css" href="css/pub.css">
</head>
<body background="images/bg2.jpg">
<div align=center>
<%
User user;
HashMap map=(HashMap)application.getAttribute("map");
if(map==null){
	out.print("<h2>没有在线用户</h2>");
	return;
}
%>
当前在线用户信息如下
<br>
共【<font color=red><%=map.size() %></font>】人
<div align="right">
<img src="images/boy.gif">男&nbsp;&nbsp;
<img src="images/girl.gif">女&nbsp;&nbsp;
[<a href="#" onclick="window.location.href='showOnLineUsers.jsp'">刷新</a>]
</div>
<hr>
<table border="1" align="center">
<tr><th>用户角色</th><th>用户名</th><th>性别</th><th>邮箱</th><th>电话</th><th>上线时间</th><th>头像</th></tr>
<%
Set set=map.keySet();
Iterator iter=set.iterator();
while(iter.hasNext()){
user=(User)map.get(iter.next());
%>
	<tr><td>
	<%
	if(user.getPrivledge()==1){out.print("管理员");}
	if(user.getPrivledge()==3){out.print("客户");}
	%>
	</td>
	<td><%=user.getName() %></td>
	<td>
	<%
	if(user.getSex().indexOf("男")>=0){
	%>
	<img src="images/boy.gif">
	<% }else{ %>
	<img src="images/girl.gif">
	<%}	%>
	</td>
	<td><%=user.getEmail() %></td>
	<td><%=user.getPhone() %></td>
	<td><%=user.getLoginTime() %></td>
	<td><IMG SRC="images/user/<%=user.getPicture() %>" WIDTH="30" HEIGHT="30" BORDER=0	ALT="">	</td>
	</tr>
	<%
    }
    %>
</table>
</body>
</html>