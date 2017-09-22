<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="cn.sdfi.model.Food"%>
<jsp:include page="includes/encoding.jsp" flush="true" />
<jsp:include page="includes/adminCheck.jsp" flush="true" />
<html>
	<head>
		<!-- 该页面只有管理员在成功登录以后才能够查看并操作，其他用户无权进入 -->
		<title>餐品信息明细</title>
		<link rel="stylesheet" type="text/css" href="css/pub.css">

	</head>
	<body background="images/bg2.jpg">

		<%
		Food view = (Food) request.getAttribute("view.data");
		%>
		<center>
			<br>
			<br>
			<h2>
				餐品信息明细
			</h2>
			<hr>
			<table border="1">
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
									<textarea name="memo" rows="6" cols="30" readonly="readonly"><%=view.getMemo()%></textarea>
							</tr>
						</table>
					</td>

					<td>
						<IMG SRC="images/food/<%=view.getPicture()%>" WIDTH="100" HEIGHT="100"
							BORDER=0 ALT="" title="图片">
					</td>
				</tr>

				<tr>
					<td align="center" colspan="2">
						<input type="button" value="返回"
							onclick="javascript:parent.history.back(); return;">
					</td>
				</tr>
			</table>

		</center>
		<jsp:include page="includes/alert.jsp" flush="true" />
	</body>
</html>
