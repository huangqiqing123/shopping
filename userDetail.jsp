<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:directive.page import="cn.sdfi.model.User" />

<jsp:include page="includes/encoding.jsp" flush="true" />
<jsp:include page="includes/adminCheck.jsp" flush="true" />
<html>
	<head>
		<title>查看用户信息明细</title>
		<link rel="stylesheet" type="text/css" href="css/pub.css">
	</head>

	<body background="images/bg2.jpg">
		<h2 align="center">
			用户信息明细
		</h2>
		<hr>
		<%
		User user = (User) request.getAttribute("view.data");
		%>
		<table align="center" border="1">
			<tr>
				<td>
					<table align="center" border="1">
						<tr>
							<td>
								用户名
							</td>
							<td align="center">
								<%=user.getName()%>
							</td>
						</tr>
						<tr>
							<td>
								密码
							</td>
							<td align="center">
								<%=user.getPassword()%>
							</td>
						</tr>
						<tr>
							<td>
								性别
							</td>
							<td align="center">
								<%=user.getSex().indexOf("男") >= 0 ? "男" : "女"%>
							</td>
						</tr>
						<tr>
							<td>
								权限
							</td>
							<td align="center">
								<%=user.getPrivledge()%>
							</td>
						</tr>

						<tr>
							<td>
								注册时间
							</td>
							<td align="center">
								<%=user.getRegisterTime()%>
							</td>
						</tr>
						<tr>
							<td>
								地址
							</td>
							<td align="center">
								<%=user.getAddress()%>
							</td>
						</tr>
						<tr>
							<td>
								邮箱
							</td>
							<td align="center">
								<%=user.getEmail()%>
							</td>
						</tr>
						<tr>
							<td>
								电话
							</td>
							<td align="center">
								<%=user.getPhone()%>
							</td>
						</tr>
						<tr>
							<td>
								备注
							</td>
							<td align="center">
								<textarea name="memo" rows="6" cols="30" title="备注"
									readonly="readonly">
		<%=user.getMemo()%>
</textarea>
							</td>
						</tr>
					</table>
				<td>
					<IMG SRC="images/user/<%=user.getPicture()%>" WIDTH="40"
						HEIGHT="40" BORDER=0 ALT="" title="图片">
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="button" value="返回"
						onClick="javascript:parent.history.back(); return;">
				</td>
			</tr>
		</table>
	</body>
</html>
<jsp:include page="includes/alert.jsp" flush="true" />
