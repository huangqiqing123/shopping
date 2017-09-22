<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<jsp:include page="includes/encoding.jsp" flush="true" />
<html>
	<head>
		<title>用户注册页面</title>
<link rel="stylesheet" type="text/css" href="css/pub.css">	
<script language="javascript" src="js/register.js"></script>
	</head>
	<body background="images/bg2.jpg">

	<%
		String picture = request.getParameter("picture");
		//设置默认图片
		if (picture == null) {
			picture = "face1.gif";
		}
	
	%>
		<center>
			<h2>
				会员注册
			</h2>
			<hr>
			<form name="regist" method="post">
			<input type="hidden" name="privledge" value="3">
				<table Border="1" align="center">
				<tr>
						<td>
							头像
						</td>
						<td align="center">
							<IMG SRC="images/user/<%=picture%>" WIDTH="40" HEIGHT="40" BORDER=0
								ALT="">
							&nbsp;&nbsp;
							<INPUT TYPE="hidden" name="picture" value="<%=picture%>">
							<input type="button" name="change" onclick="javascript:window.location.href='userPicture.jsp?path=register.jsp'" value="选择">
							</td>
					</tr>
					<tr>
						<td align="left" valign="middle" >
							用户名:
						</td>
						<td>
							<input type="text" id="name" name="name" value="">
							<a href="#" onclick="getName()" style="font-size:13px">[看看该用户名是否可用]</a>
							
						</td>
					</tr>
					<tr>
						<td>
							密&nbsp;&nbsp;码:
						</td>
						<td>
							<input type="password" name="pass1" value="">
					</tr>
					<tr>
						<td>
							密码确认:
						</td>
						<td>
							<input type="password" name="pass2" value="">
					</tr>
					<tr>
						<td>
							性&nbsp;&nbsp;别:
						</td>
						<td>
							<input type="radio" name="sex" value="男" checked>
							男
							<input type="radio" name="sex" value="女">
							女
					</tr>
					<tr>
						<td>
							邮箱；
						</td>
						<td>
							<input type="text" name="email" value="xx@xx.xx" align="middle">
						</td>
					</tr>
					<tr>
						<td>
							地址；
						</td>
						<td>
							<input type="text" name="address">
						</td>
					</tr>
					<tr>
						<td>
							电话；
						</td>
						<td>
							<input type="text" name="phone">
						</td>
					</tr>
					<tr>
						<td>
							备注:
						</td>
						<td>
							<textarea name="memo" rows="6" cols="30">
							</textarea>
							
					</tr>
					<tr>
						<td  align="center" colspan="2">
							<input type="button" value="提交" onclick="check()">
							<input type="reset" value="重写">
							<input type="button" value="返回"
								onClick="javascript:parent.history.back(); return;">
						</td>
					</tr>
				</table>
			</form>
		</center>
		<hr>
		<jsp:include page="includes/copyright.jsp" flush="true" />
		<jsp:include page="includes/alert.jsp" flush="true" />
	</body>
</html>
