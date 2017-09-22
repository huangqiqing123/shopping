<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:directive.page import="cn.sdfi.model.Order" />
<jsp:directive.page import="cn.sdfi.model.Detail" />
<jsp:directive.page import="cn.sdfi.model.User"/>
<jsp:directive.page import="java.util.List;"/>
<jsp:include page="includes/encoding.jsp" flush="true" />
<html>
	<head>
		<title>查看订单明细</title>
		<link rel="stylesheet" type="text/css" href="css/pub.css">
		<script type="text/javascript">
		// 执行删除操作
		function del(){
		if(confirm('确认删除该条记录？')){
		document.showOrder.action="orderdo.do?method=delete";
		document.showOrder.submit(); 
		}
		}
		</script>
	</head>
	<body background="images/bg2.jpg">
		<jsp:include page="includes/deliverCheck.jsp" flush="true" />
		<%
					User user=(User)session.getAttribute("user");
					int privledge=user.getPrivledge();
					if (privledge==2) {
					out.print("送餐员【<font color=red>" +user.getName()+ "</font>】");
					out.print("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;【<a href=logOut.jsp>安全退出</a>】");
				}
					Order order = (Order) request.getAttribute("view.data");
		%>
		<p align="center">
			<font face="隶书" size="5" color="#0080ff">&nbsp;查看订单明细</font>
		</p>

		<hr align="center" noshade></hr>
		<form name="showOrder" method="post" >
		<!--   以下是订单记录     -->
		<input type="hidden" name="id" value="<%=order.getId() %>">
			<table border="1" align="center">
				<tr>
					<th>
						订单编号
					<th>
						客户名称
					<th>
						餐位
					<th>
						订单生成时间
					<th>
						用餐时间
					<th>
						金额
					</th>
				</tr>
				<tr>
					<td>
						<%=order.getId()%>
					</td>
					<td>
						<%=order.getUserName()%>
					</td>
					<td>
						<%=order.getLocation()%>
					</td>
					<td>
						<%=order.getCreateTime()%>
					</td>
					<td>
						<%=order.getDemandTime()%>
					</td>
					<td>
						<%=order.getMoney()%>
					</td>
				</tr>
				<tr>
			</table>
			<hr>
			<!--   以下是订单明细     -->
			<table align="center" border="1">
				<tr>
					<th>
						餐品名称
					<th>
						餐品数量
					<th>
						单价
					<th>
						小计
					</th>
				</tr>
			<%
				List<Detail> list = order.getList();
				Detail detail = null;
				for (int i = 0; i < list.size(); i++) {
					detail = list.get(i);
			%>
				<tr>
					<td>
						<%=detail.getFoodName()%>
					</td>
					<td>
						<%=detail.getAmount()%>
					</td>
					<td>
						<%=detail.getPrice()%>
					</td>
					<td>
						<%=detail.getAccount()%>
					</td>
				</tr>
				<%
				}
				%>
				<tr>
					<td colspan="4" align="center">
						<input type="button" value="返回"
							onclick="javascript:parent.history.back(); return;" />
							<%
							if(privledge==1){
							 %>
							<input type="button" value="删除" onclick="del()" />
							<% } %>
					</td>
				</tr>
			</table>

		</form>
		<jsp:include page="includes/alert.jsp" flush="true" />
	</body>
</html>
