<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="cn.sdfi.model.Food"%>
<jsp:directive.page import="java.util.List" />
<jsp:directive.page import="cn.sdfi.operate.TypeDAO" />
<jsp:directive.page import="cn.sdfi.model.Type" />
<jsp:include page="includes/encoding.jsp" flush="true" />
<jsp:include page="includes/adminCheck.jsp" flush="true" />
<html>
	<head> 
		<!-- 该页面只有管理员在成功登录以后才能够查看并操作，其他用户无权进入 -->
		<title>餐品信息维护</title>
		<link rel="stylesheet" type="text/css" href="css/pub.css">
		<script language="javascript">
function check()
{
if(addForm.name.value=="")
alert("请输入餐品名！！！");

else if(addForm.price.value=="")
alert("请输入价格！！！");

else if(addForm.picture.value=="")
alert("请输入餐品图片代码！！！");

else
{
document.addForm.action="fooddo.do?method=updateToDB";
document.addForm.submit();
}
}
function changePic(){
	window.location.href="includes/choosePicture.jsp?path=updateFood.jsp";
	}
</script>
	</head>
	<body background="images/bg2.jpg">

		<%
Food view = null;	
if(request.getAttribute("view.data")!=null){
session.setAttribute("food",request.getAttribute("view.data"));
}
String pic=request.getParameter("newPicture");
if(pic!=null&&!"".equals(pic)){
System.out.println("***************"+pic);
	view=(Food)session.getAttribute("food");
	view.setPicture(pic);
	session.setAttribute("food",view);
}
view=(Food)session.getAttribute("food");
		%>
		<center>
			<br>
			<br>
			<h2>
				餐品信息更新
			</h2>
			<hr>
			<form  name="addForm" method="post">
				<input type="hidden" name="id" value="<%=view.getId()%>">
				<input type="hidden" name="time" value="<%=view.getAddTime()%>">
				<table border>
					<tr>
						<td>
							餐品名称
						</td>
						<td>
							<input type="text" name="name" value="<%=view.getName()%>">
						</td>
					</tr>
					<tr>
						<td>
							价格
						</td>
						<td>
							<input type="text" name="price" value="<%=view.getPrice()%>">
						</td>
					</tr>
					<tr>
						<td>
							所属类别
						</td>
						<td>
							<select name="typeId" title="选择类别">
								<option value="">
									--请选择餐品类别--
									<%
									//从数据库中查询出所有类别并显示
									List<Type> typeList = new TypeDAO().queryAll();
									for (int i = 0; i < typeList.size(); i++) {
										Type type = typeList.get(i);
								%>
								
								<option value="<%=type.getId()%>"
									<%=view.getType().equals(type.getName()) ? "selected": ""%>>
									--
									<%=type.getName()%>
									--
								</option>
								<%
								}
								%>

							</select>
						</td>
					</tr>
					<tr>
						<td>
							图片
						</td>
						<td align=center>
							<IMG SRC="images/food/<%=view.getPicture()%>" WIDTH="60" HEIGHT="60" BORDER=0
								ALT="">
							&nbsp;&nbsp;
							<INPUT TYPE="hidden" name="picture" value="<%=view.getPicture()%>">
							<input type="button" name="change" onclick="changePic()" value="更改">
							
						</td>
					</tr>
					<tr>
						<td>
							入库时间
						</td>
						<td>
							<%=view.getAddTime()%>
						</td>
					</tr>
					<tr>
						<td>
							备注:
						</td>
						<td>
							<textarea name="memo" rows="6" cols="30">
								<%=view.getMemo()%>
</textarea>
							<p>
					</tr>
					<tr>
						<td align="center" colspan="2">
							<input type="button" value="更新" onclick="check()">
							<input type="button" value="返回"
								onclick="javascript:parent.history.back(); return;">
						</td>
					</tr>
				</table>
			</form>
		</center>
		<jsp:include page="includes/alert.jsp" flush="true" />
	</body>
</html>
