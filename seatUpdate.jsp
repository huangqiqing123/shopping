<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.page import="cn.sdfi.model.Seat"/>
<jsp:include page="includes/encoding.jsp" flush="true" />
<jsp:include page="includes/adminCheck.jsp" flush="true" />
<html>
	<head>
		<title>餐品信息添加</title>
<script language="javascript">
function  check()
{
if(addForm.location.value=="")
{
	alert("请输入餐位位置！！！");
	return false;
}
else if(addForm.money.value=="")
{
	alert("请输入餐位收费标准！！！");
	return false;
}
else if(addForm.nums.value=="")
{
	alert("请选择该餐位容纳人数！！！");
	return false;
}

else
{
return true;

}
}
function save(){
	if(check()){
		document.addForm.action="seatdo.do?method=update";
		document.addForm.submit();
	}
}

</script>
<link rel="stylesheet" type="text/css" href="css/pub.css">
	</head>

	<body background="images/bg2.jpg">&nbsp; 
<% 
Seat view=null;
if(request.getAttribute("view.data")!=null){
session.setAttribute("seat",request.getAttribute("view.data"));
}
String pic=request.getParameter("newPicture");
if(pic!=null&&!"".equals(pic)){
	view=(Seat)session.getAttribute("seat");
	view.setPicture(pic);
	session.setAttribute("seat",view);
}
view=(Seat)session.getAttribute("seat");
 %>
			<h2 align="center">
				餐位信息更新
			</h2>
			<hr>
			<form action="" name="addForm" method="post">
			<input type="hidden" name="seatId" value="<%=view.getSeatId() %>">
				<table border="1" align="center">
					<tr>
						<td>
							图片
						</td>
						<td align="center">
							<IMG SRC="images/seat/<%=view.getPicture() %>" WIDTH="60" HEIGHT="60" BORDER=0
								ALT="">
							&nbsp;&nbsp;
							<INPUT TYPE="hidden" name="picture" value="<%=view.getPicture() %>">
							<input type="button" name="change" onclick="javascript:window.location.href='seatPicture.jsp?path=seatUpdate.jsp'" value="选择">
							</td>
					</tr>
					<tr>
						<td>
							餐位位置
						</td>
						<td>
							<input type="text" name="location" value="<%=view.getLocation() %>">
						</td>
					</tr>
					<tr>
						<td>
							是否空闲
						</td>
						<td>
							<input type="radio" name="available" value="是"
								<%=view.getAvailable().indexOf("是")>=0 ? "checked" : ""%>>
							是
							
						<input type="radio" name="available" value="否"
								<%=view.getAvailable().indexOf("否")>=0 ? "checked" : ""%>>
								否
						</td>
					</tr>
					<tr>
						<td>
							收费标准
						</td>
						<td>
							<input type="text" name="money" value="<%=view.getMoney() %>"><font color="red" size="2">（不低于此数,单位 元）</font>
						</td>
					</tr>
					<tr>
						<td>
							容纳人数
						</td>
						<td>
						<select name="nums" title="选择容纳人数" >
						<option value="1-2" <%="1-2".equals(view.getNums())?"selected":"" %>>1-2人
						<option value="3-4" <%="3-4".equals(view.getNums())?"selected":"" %>>3-4人
						<option value="5-10" <%="5-10".equals(view.getNums())?"selected":"" %>>5-10人
						<option value="11-15" <%="11-15".equals(view.getNums())?"selected":"" %>>11-15人
						<option value="15人以上" <%="15人以上".equals(view.getNums())?"selected":"" %>>15人以上
						</select>	
						</td>
					</tr>
					
					<tr>
						<td>
							备注:
						</td>
						<td>
							<textarea name="memo" rows="6" cols="30"><%=view.getMemo() %></textarea>
							<p>
					</tr>
					<tr>
						<td align="center" colspan="2">
							<input type="button" value="保存" onclick="save()" >
							<input type="button" value="返回" onclick="javascript:parent.history.back(); return;">
						</td>
					</tr>
				</table>
			</form>

		<jsp:include page="includes/alert.jsp" flush="true" />
	</body>
</html>




