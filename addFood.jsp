<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.page import="cn.sdfi.model.Type"/>
<jsp:directive.page import="cn.sdfi.operate.TypeDAO"/>
<jsp:directive.page import="java.util.List;"/>
<jsp:include page="includes/encoding.jsp" flush="true" />
<jsp:include page="includes/adminCheck.jsp" flush="true" />
<html>
	<head> 
		<title>餐品信息添加</title>
<script language="javascript">
function  check()
{
if(addForm.name.value=="")
{
	alert("请输入餐品名称！！！");
	return false;
}
else if(addForm.price.value=="")
{
	alert("请输入餐品价格！！！");
	return false;
}
else if(addForm.type.value=="")
{
	alert("请选择商品类别！！！");
	return false;
}

else
{
return true;

}
}
function save(){
	if(check()){
		document.addForm.action="fooddo.do?method=add";
		document.addForm.submit();
	}
}
function goOn(){
	if(check()){
		document.addForm.action="fooddo.do?method=add&action=continue";
		document.addForm.submit();
	}
}
</script>
<link rel="stylesheet" type="text/css" href="css/pub.css">
	</head>

	<%
		String picture = request.getParameter("newPicture");
		//设置默认图片
		if (picture == null) {
			picture = "0.jpg";
		}
		List<Type> list=new TypeDAO().queryAll();
	%>
	<body background="images/bg2.jpg">

		<center>
			<br>
			<br>
			<h2>
				餐品添加
			</h2>
			<hr>
			<form action="fooddo.do?method=save" name="addForm" method="post">
				<table border="1">
					<tr>
						<td>
							图片
						</td>
						<td align="center">
							<IMG SRC="images/food/<%=picture%>" WIDTH="60" HEIGHT="60" BORDER=0
								ALT="">
							&nbsp;&nbsp;
							<INPUT TYPE="hidden" name="picture" value="<%=picture%>">
							<input type="button" name="change" onclick="javascript:window.location.href='includes/choosePicture.jsp?path=addFood.jsp'" value="选择">
							</td>
					</tr>
					<tr>
						<td>
							餐品名称
						</td>
						<td>
							<input type="text" name="name">
						</td>
					</tr>
					<tr>
						<td>
							单价
						</td>
						<td>
							<input type="text" name="price">
						</td>
					</tr>
					<tr>
						<td>
							餐品类别
						</td>
						<td>
						<select name="type" title="选择类别" >
						<option value="">--请选择餐品类别--
						<%//从数据库中查询出所有类别并显示
						for(int i=0;i<list.size();i++){
							
						%>
							<option value="<%=list.get(i).getId() %>"><%=list.get(i).getName() %>
						<%} %>
						
						</select>	
						</td>
					</tr>
					<tr>
						<td>
							备注:
						</td>
						<td>
							<textarea name="memo" rows="6" cols="30">
</textarea>
							<p>
					</tr>
					<tr>
						<td align="center" colspan="2">
							<input type="button" value="保存" onclick="save()" >
							<input type="button" value="保存并继续" onclick="goOn()" >
							<input type="reset" value="重置">
						</td>
					</tr>
				</table>
			</form>
		</center>
		<jsp:include page="includes/alert.jsp" flush="true" />
	</body>
</html>




