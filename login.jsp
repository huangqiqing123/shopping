<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="includes/encoding.jsp" flush="true" />
<html>
	<head>
		<title>用户登陆</title>
		<link rel="stylesheet" type="text/css" href="css/pub.css">
		<script language="javascript">
function check()
{
if(loginForm.name.value=="")
alert("请输入用户名！！！");
 
else if(loginForm.checkNumber.value=="")
alert("请输入验证码！！！");
else
{  
document.loginForm.submit();
}
}
</script>

	</head>
	<body  text="#0000FF" bgcolor="" background="images/bg2.jpg">
<form name="loginForm" action="userdo.do?method=login" method="post" >
<input type="hidden" name="privledge" value="1">
		<table width="457" height="315" align="center" border="0"
			cellspacing="0" cellpadding="0" background="images/login.jpg">
			<tr height="120">
				<td width="30%">
					&nbsp;
				</td>
				<td width="10%">
					&nbsp;
				</td>
				<td width="30%">
					&nbsp;
				</td>
				<td width="30%">
					&nbsp;
				</td>
			</tr>

			<tr>
				<td>
					&nbsp;
				</td>
				<td>
					用户名：
				</td>
				<td>
					<input type="text" name="name" value="admin">
				</td>
				<td>
					&nbsp;
				</td>
			</tr>
			<tr>
				<td>
					&nbsp;
				</td>
				<td>
					密&nbsp;&nbsp;码：
				</td>
				<td>
					<input type="password" name="password" value="admin">
				</td>
				<td>
					&nbsp;
				</td>
			</tr>
			
			<tr>
			<td>
				&nbsp;
				</td>
				<td>
					<img src="includes/checkNum.jsp">
				</td>
				<td>
					<input type="text" name="checkNumber" value="">
				</td>
				<td>
				&nbsp;
				</td>
			</tr>
			<tr>
			  <td>&nbsp;</td>
   				 <td>&nbsp;</td>
				<td align="right">
					<input type="button" value="提交" onclick="check()" />
					<input type="reset" value="重置">
				</td>
				<td>&nbsp;</td>
			</tr>

			<tr height="80">
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
				<td>
					&nbsp;
				</td>
			</tr>
		</table>

</form>
<br><br><br><br><br>

		<hr>
		<jsp:include page="includes/copyright.jsp" flush="true" />
		<jsp:include page="includes/alert.jsp" flush="true" />
	</body>
</html>
