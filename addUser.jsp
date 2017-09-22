<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="includes/encoding.jsp" flush="true" />
<jsp:include page="includes/adminCheck.jsp" flush="true" />	
<html>
	<head>
		<title>管理员与送餐员的添加</title>
<link rel="stylesheet" type="text/css" href="css/pub.css">
<script language="javascript">
function  check()
{
if(addForm.name.value=="")
{
	alert("请输入用户名！！！");
	return false;
}
else if(addForm.pass1.value=="")
{
	alert("请输入密码！！！");
	return false;
}
else if(addForm.pass2.value=="")
{
	alert("请输入密码！！！");
	return false;
}
else if(addForm.pass2.value!=addForm.pass1.value)
{
	alert("两次输入密码不一致！！！");
	return false;
}
else
{
return true;

}
}
function save(){
	if(check()){
		document.addForm.action="userdo.do?method=add&action=save";
		document.addForm.submit();
	}
}
function goOn(){
	if(check()){
		document.addForm.action="userdo.do?method=add&action=continue";
		document.addForm.submit();
	}
}
// 检查用户名是否可用
function getName()
{
	var name=addForm.name.value;
	if(name==""){
	alert("用户名不得为空");
	return;
	}
document.addForm.action="userdo.do?method=isUsed&privledge=1";
document.addForm.submit();
}
</script>
	</head>
	<body background="images/bg2.jpg">

			<h2 align="center">
				添加管理员
			</h2>
			<hr>
			
	<%
		String picture = request.getParameter("picture");
		//设置默认图片
		if (picture == null) {
			picture = "face1.gif";
		}
	
	%>
			<form action="userdo.do?method=add" name="addForm" method="post">
			<input type="hidden" name="privledge" value="1">
				<table align="center" border="1">
				<tr>
						<td>
							头像
						</td>
						<td align="center">
							<IMG SRC="images/user/<%=picture%>" WIDTH="40" HEIGHT="40" BORDER=0
								ALT="">
							&nbsp;&nbsp;
							<INPUT TYPE="hidden" name="picture" value="<%=picture%>">
							<input type="button" name="change" onclick="javascript:window.location.href='userPicture.jsp?path=addUser.jsp'" value="选择">
							</td>
					</tr>
					<tr>
						<td>
							用户名
						</td>
						<td>
							<input type="text" name="name" value="">
							<a href="#" onclick="getName()" style="font-size:13px">[看看该用户名是否可用]</a>
						</td>
					</tr>
					<tr>
						<td>
							密&nbsp;&nbsp;码:
						</td>
						<td>
							<input type="password" name="pass1">
					</tr>
					<tr>
						<td>
							密码确认:
						</td>
						<td>
							<input type="password" name="pass2">
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
							<input type="text" name="email" value="@" align="middle">
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
							地址；
						</td>
						<td>
							<input type="text" name="address">
						</td>
					</tr>
					<tr>
						<td>
							备注:
						</td>
						<td>
							<textarea name="memo" rows="6" cols="30"></textarea>
							<p>
					</tr>
					<tr>
						<td colspan="2" align="center">
							<input type="button" value="保存" onclick="save()" >
							<input type="button" value="保存并继续" onclick="goOn()" >
							<input type="reset" value="重置">
						</td>
					</tr>
				</table>
			</form>
	
		<jsp:include page="includes/alert.jsp" flush="true" />
	</body>
</html>
