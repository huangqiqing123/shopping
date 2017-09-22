<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:directive.page import="cn.sdfi.model.User" />
<jsp:include page="includes/encoding.jsp" flush="true" />
<html>
	<head>
		<title>留言板</title>
<link rel="stylesheet" type="text/css" href="css/pub.css">
		</head>
<body background="images/bg2.jpg">
<jsp:include page="includes/userCheck.jsp" flush="true" />
<%
	User user=(User)session.getAttribute("user");

 %>
		<h3 align="center">
			<font size="6" face="隶书">欢迎你留言</font>
		</h3>
		<font size='2'>当前位置:<a href='main.jsp'>主页</a>--><a
			href='showAllMessages.jsp'>留言板</a>--<a href='leaveMessage.jsp'>留言页面</a>
		</font>
		<hr />
		<form action="msgdo.do?method=add" method="post" name="form1">
		<input type="hidden" name="userId" value="<%=user.getId() %>">
			<table  border="1" align="center" >
				<tr>
					<td align="center">
						留&nbsp;言&nbsp;人：
					</td>
					<td align="center">
						<font color="red"><%=user.getName() %> </font>
					</td>
				</tr>
				<tr>
					<td align="left">
						留言主题：
					</td>
					<td>
						<input type="text" name="title" value="" />
					</td>
				</tr>
				<tr align="left">
					<td>
						留言信息：
					</td>
				
					<td>
						<textarea name="content" cols="50" rows="6"></textarea>
					</td>
				</tr>
				<tr align="center">
					<td colspan="2">
						<input name="Submit" type="submit" class="code" value="留言" />
						
						<input name="Submit2" type="button" value="返回"
							onclick="javascript:parent.history.back(); return;"></input>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>
