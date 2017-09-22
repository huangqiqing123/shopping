<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="cn.sdfi.model.Food"%>
<jsp:directive.page import="cn.sdfi.model.User"/>
<jsp:include page="includes/encoding.jsp" flush="true" />
<html>
	<head>
		<title>餐品信息明细</title>
		<link rel="stylesheet" type="text/css" href="css/pub.css">
		<script type="text/javascript">
		function putInToCart(){
			document.putInTo.action="showCart.jsp";
			putInTo.submit();
		}
		
		</script>
	</head>

	<body background="images/bg2.jpg">
			<%
				User user=(User)session.getAttribute("user");
				Food view = (Food)request.getAttribute("view.data");
			%>
			<h2 align="center">
				餐品[<font color=green><%=view.getName()%></font>]信息明细
			</h2>
			<a href="main.jsp">[返回主页]</a>
			
			<hr>

			<form name="putInTo" action="" method="post">
				<input type="hidden" name="foodId" value="<%=view.getId() %>">
				<input type="hidden" name="foodName" value="<%=view.getName() %>">
				<input type="hidden" name="price" value="<%=view.getPrice() %>">
				<table border="1" align="center">
					<tr>
						<td>
							<table border="1">
								<tr>
									<th>
										餐品名称
									</th>
									<td>
										<%=view.getName()%>
									</td>

								</tr>
								<tr>
									<th>
										价格
									</th>
									<td>
										<%=view.getPrice()%>
									</td>
								</tr>
								<tr>
									<th>
										所属类别
									</th>
									<td>
										<%=view.getType()%>
									</td>
								</tr>
								<tr>
									<th>
										入库时间
									</th>
									<td>
										<%=view.getAddTime()%>
									</td>
								</tr>
								<tr>
									<th>
										备注:
									</th>
									<td>
										<textarea name="memo" rows="6" cols="30" readonly="readonly">
										<%=view.getMemo()%>
									</textarea>
								</tr>
							</table>
						</td>

						<td>
							<IMG SRC="images/food/<%=view.getPicture()%>" WIDTH="100" HEIGHT="100"
								BORDER=0 ALT="" title="图片">
						</td>
					</tr>
					<%
						if(user!=null&&user.getPrivledge()==3){
						
						%>
					<tr>
						<td colspan="2" align="center">
							<font size='4' color='green' face="隶书">修改数量</font>&nbsp;&nbsp;&nbsp;&nbsp;
							<select name="amount" title="选择要放入购物车中的数量">
								<%
								for (int k = 1; k < 100; k++) {
								%>
								<option value="<%=k%>">
									<%=k%>
								</option>
								<%
								}
								%>
							</select>
						</td>
					</tr>
					<%
						}
					%>
					<tr>
						<td align="center" colspan="2">
						<%
						if(user!=null&&user.getPrivledge()==3){
						
						%>
						【<img src="images/shopcart.gif" onclick="putInToCart()" style="cursor:hand">】
						<%
						}
						 %>	
							
						</td>
					</tr>
					<tr>
						<td align="center" colspan="2">
						 <a href=javascript:parent.history.back();>[返回]</a>
						</td>
					</tr>
				</table>
			</form>
			<hr>
			<jsp:include page="includes/copyright.jsp" flush="true" />
	
	</body>
</html>








