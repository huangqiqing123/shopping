<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="cn.sdfi.model.Food"%>
<%@page import="cn.sdfi.model.User"%>
<%@page import="cn.sdfi.operate.UserOperate"%>
<jsp:directive.page import="cn.sdfi.tools.GetPicNames"/>
<jsp:directive.page import="cn.sdfi.tools.Const"/>
<jsp:include page="includes/encoding.jsp" flush="true" />
<jsp:include page="includes/adminCheck.jsp" flush="true" />
<html>
	<head>
		<title>信息维护</title>
		<link rel="stylesheet" type="text/css" href="css/pub.css">
	</head>

	<body background="images/bg2.jpg">
		<%
User user =null;
if(request.getAttribute("query.data")!=null){
session.setAttribute("view",request.getAttribute("query.data"));
}
String pic=request.getParameter("picture");
if(pic!=null&&!"".equals(pic)){
	user=(User)session.getAttribute("view");
	user.setPicture(pic);
	session.setAttribute("view",user);
}
user=(User)session.getAttribute("view");
	
		%>
		<center>
			
			<h2>
				用户信息更新
			</h2>
			<hr noshade="noshade">
			<form action="userdo.do?method=updateToDB" name="addForm" method="post">
				<input type="hidden" name="id" value="<%=user.getId()%>">
				<input type="hidden" name="time"
					value="<%=user.getRegisterTime()%>">
				<table border="1">
				<tr>
						<td>
							用户名
						</td>
						<td align="center">
							<%=user.getName()%>
							<input type="hidden" name="name" value="<%=user.getName()%>">
						</td>
					</tr>
				<tr>
						<td>
							头像
						</td>
						<td align="center">
							<INPUT TYPE="hidden" name="picture" value="<%=user.getPicture() %>">
							<IMG SRC="images/user/<%=user.getPicture() %>" WIDTH="40" HEIGHT="40" BORDER=0	ALT="">	
							&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="button"  onclick="javascript:window.location.href='userPicture.jsp?path=updateUser.jsp'" value="选择">
							</td>
					</tr>
					
					<tr>
						<td>
							密&nbsp;&nbsp;码:
						</td>
						<td>
							<input type="password" name="pass1" value="<%=user.getPassword()%>">
					</tr>
					<tr>
						<td>
							密码确认:
						</td>
						<td>
							<input type="password" name="pass2" value="<%=user.getPassword()%>">
					</tr>
					<tr>
						<td>
							身&nbsp;&nbsp;份:
						</td>
						<td>
							<input type="radio" name="privledge" value="1"
								<%=user.getPrivledge() == 1 ? "checked" : ""%>>
							管理员
							
							<input type="radio" name="privledge" value="3"
								<%=user.getPrivledge() == 3 ? "checked" : ""%>>
							客户
					</tr>
					<tr>
						<td>
							性&nbsp;&nbsp;别:
						</td>
						<td>
							<input type="radio" name="sex" value="男"
								<%	if(user.getSex().indexOf("男")>=0){%> checked="checked" <%}%>>
							男
							<input type="radio" name="sex" value="女"
								<%	if(user.getSex().indexOf("女")>=0){%> checked="checked" <%}%>>
							女
					</tr>
					<tr>
						<td>
							邮箱；
						</td>
						<td>
							<input type="text" name="email" value=<%=user.getEmail()%>>
						</td>
					</tr>
					<tr>
						<td>
							电话；
						</td>
						<td>
							<input type="text" name="phone" value=<%=user.getPhone()%>>
						</td>
					</tr>
					<tr>
						<td>
							地址；
						</td>
						<td>
							<input type="text" name="address" value=<%=user.getAddress()%>>
						</td>
					</tr>
					<tr>
						<td>
							备注:
						</td>
						<td>
							<textarea name="memo" rows="6" cols="30" title="备注">
								<%=user.getMemo()%>
							</textarea>
							<p>
					</tr>
					<tr>
						<td align="center" colspan="2">
							<input type=submit value="提交">
							<input type="reset" value="重置">
							<input type="button" value="返回"
								onClick="javascript:parent.history.back(); return;">
						</td>
					</tr>
				</table>
			</form>
		</center>
	
	</body>
</html>
