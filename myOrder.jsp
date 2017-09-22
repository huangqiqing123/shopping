<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Iterator"%>
<jsp:directive.page import="cn.sdfi.operate.OrderDAO" />
<jsp:directive.page import="cn.sdfi.model.User" />
<jsp:directive.page import="cn.sdfi.model.Order" />
<jsp:directive.page import="cn.sdfi.model.Detail" />
<jsp:directive.page import="cn.sdfi.operate.DetailDAO" />
<jsp:directive.page import="java.util.List;"/>
<jsp:include page="includes/encoding.jsp" flush="true" />

<html>
	<head>
		<title>信息查询</title>
		<link rel="stylesheet" type="text/css" href="css/pub.css">
	</head>
	<body background="images/bg2.jpg">
		<%
			User user = (User) session.getAttribute("user");
			if (user == null || user.getPrivledge() != 3) {
				out
				.print("<script>alert('对不起，你还没有登陆!!!!');javascript:window.location.href='main.jsp';</script>");
				return;
			}

			List list = new OrderDAO().queryByUserId(user.getId());
			Iterator iter = list.iterator();
			if (list.size() < 1) {
				out
				.print("<script>alert('暂无订单信息!!!!');javascript:window.location.href='main.jsp';</script>");
				return;
			}
		%>
		<h2 align="center">
			你的订单信息如下(按订单生成先后顺序排列)
		</h2>
		你好！
		<font color="red"> <%=user.getName()%> </font> [
		<a href="main.jsp">返回主页</a>]
		<hr>


		<form action="myOrder.jsp" name="showDetail" method="post">

			<table border="1" align="center">
				<tr>
					<th>
						选择
					<th>
						订单编号
					<th>
						客户名称
					<th>
						餐位位置
					<th>
						订单生成时间
					<th>
						用餐时间
					<th>
						金额
					</th>
				</tr>
				<%
						while (iter.hasNext()) {
						Order view = (Order) iter.next();
				%>
				<tr>
					<td>
						<input type="radio" name="orderId" value="<%=view.getId()%>">
					</td>
					<td>
						<%=view.getId()%>
					</td>
					<td>
						<%=view.getUserName()%>
					</td>
					<td>
						<%=view.getLocation()%>
					</td>
					<td>
						<%=view.getCreateTime()%>
					</td>
					<td>
						<%=view.getDemandTime()%>
					</td>
					<td>
						<%=view.getMoney()%>
					</td>
				</tr>

				<%
				}
				%>
				<tr>
					<td colspan="7" align="center">
						<input type="submit" name="showD" value="查看明细">
					</td>
			</table>
		</form>
		<%
			String orderId = request.getParameter("orderId");
			if (orderId != null && !"".equals(orderId)) {
		%>
		<h3 align="center">
			编号：
			<%=orderId%>
			订单明细
		</h3>
		<hr>
		<table align="center" border="1" title="">
			<tr>
				<th>
					餐品名称
				</th>
				<th>
					数量
				</th>
				<th>
					单价
				</th>
				<th>
					小计
				</th>
			</tr>
			<%
					List<Detail> result = new DetailDAO().queryByOrderId(orderId);
					for (int i = 0; i < result.size(); i++) {
			%>
			<tr>
				<td>
					<%=result.get(i).getFoodName()%>
				</td>
				<td>
					<%=result.get(i).getAmount()%>
				</td>
				<td>
					<%=result.get(i).getPrice()%>
				</td>
				<td>
					<%=result.get(i).getAccount()%>
				</td>
			</tr>

			<%
				}
				}
			%>
		</table>
	</body>
</html>
