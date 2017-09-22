<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.page import="cn.sdfi.model.Type"/>
<jsp:directive.page import="cn.sdfi.operate.TypeDAO"/>
<jsp:directive.page import="java.util.List"/>
<jsp:include page="includes/encoding.jsp" flush="true" />
<jsp:include page="includes/adminCheck.jsp" flush="true" />
<html>
	<head>
		<title>餐品类别添加</title>
<script language="javascript">
function  check()
{ 
if(addForm.name.value=="")
{
	alert("请输入类别名称！！！");
	return false;
}
else
{
return true;

}
}
function save(){
	if(check()){
		document.addForm.action="typedo.do?method=add";
		document.addForm.submit();
	}
}
function goOn(){
	if(check()){
		document.addForm.action="typedo.do?method=add&action=continue";
		document.addForm.submit();
	}
}
</script>
<link rel="stylesheet" type="text/css" href="css/pub.css">
	</head>

	<%
		List<Type> list=new TypeDAO().queryAll();
	%>
	<body background="images/bg2.jpg">

		<center>
			<br>
			<br>
			<h2>
				餐品类别添加
			</h2>
			<hr>
			<form  name="addForm" method="post">
				<table border="1">
				
					<tr>
						<td>
							类别名称
						</td>
						<td>
							<input type="text" name="name" value="">
						</td>
					</tr>
					
					<tr>
						<td>
							父类别
						</td>
						<td>
						<select name="parentId" title="选择父类别" >
						<%
						//从数据库中查询出所有类别并显示
						for(int i=0;i<list.size();i++){
						%>
							<option value="<%=list.get(i).getId() %>">--<%=list.get(i).getName() %>--
						<%} %>
						
						</select>
							
						</td>
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




