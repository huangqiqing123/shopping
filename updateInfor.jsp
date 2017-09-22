<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="cn.sdfi.model.User"%>
<jsp:directive.page import="cn.sdfi.tools.GetPicNames"/>
<jsp:directive.page import="cn.sdfi.tools.Const"/>
<jsp:include page="includes/encoding.jsp" flush="true" />

<html>
	<head>
		<title>客户信息维护页面</title>
	<link rel="stylesheet" type="text/css" href="css/pub.css">
	</head>
	<body background="images/bg2.jpg">
	<%
			User user=(User)session.getAttribute("user");
			if (user==null||user.getPrivledge()!=3) {
					out.print("<script>alert('对不起，你还没有登陆!!!!');javascript:window.location.href='main.jsp';</script>");
					return;
				}
		// 此处很必要	
if(request.getAttribute("query.data")!=null){
session.setAttribute("user",request.getAttribute("query.data"));
}
String pic=request.getParameter("picture");
if(pic!=null&&!"".equals(pic)){
	user=(User)session.getAttribute("user");
	user.setPicture(pic);
	session.setAttribute("user",user);
}
user=(User)session.getAttribute("user");	
	%>
		<div align=center>
		
			<h2>
				客户信息更新
			</h2>
			<hr>
			<form action="userdo.do?method=updateToDB" name="updateForm" method="post">
			<!-- 不可更改的信息 -->
			<input type="hidden" name="privledge" value="<%=user.getPrivledge() %>">
			<input type="hidden" name="id" value="<%=user.getId() %>">
			<table border="1">
				
				<tr>
						<td>
							注册时间
						</td>
						<td>
							<%=user.getRegisterTime()%>
							</td>
					</tr>
						<tr>
						<td>
							用户名
						</td>
						<td>
							<%=user.getName()%>
							
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
							<input type="button"  onclick="javascript:window.location.href='userPicture.jsp?path=updateInfor.jsp'" value="选择">
							</td>
					</tr>
					<tr>
						<td>
							新密码:
						</td>
						<td>
							<input type="password" name="pass1" value="<%=user.getPassword() %>">
					</tr>
					<tr>
						<td>
							密码确认:
						</td>
						<td>
							<input type="password" name="pass2" value="<%=user.getPassword() %>">
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
							地址:
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
							<textarea name="memo" rows="6" cols="30">
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
			</div>
			<hr>
			<jsp:include page="includes/copyright.jsp" flush="true" />
		</body>
</html>
