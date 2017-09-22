<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:directive.page import="cn.sdfi.model.Seat"/>
<jsp:include page="includes/encoding.jsp" flush="true" />

<html>
	<head>
		<!-- 该页面只有管理员在成功登录以后才能够查看并操作，其他用户无权进入 -->
		<title>餐位信息明细</title>
		<link rel="stylesheet" type="text/css" href="css/pub.css">

	</head>
	<body background="images/bg2.jpg">

		<%
		Seat view = (Seat) request.getAttribute("view.data");
		%>
		<center>
			<br>
			<br>
			<h2>
				餐位信息明细
			</h2>
			<hr>
			<table border="1">
				<tr>
					<td>
						<table border="1">
							<tr>
								<th>
									餐品编号
								</th>
								<td>
									<%=view.getSeatId()%>
								</td>

							</tr>
							<tr>
								<th>
									位置
								</th>
								<td>
									<%=view.getLocation()%>
								</td>
							</tr>
							<tr>
								<th>
									容纳人数
								</th>
								<td>
									<%=view.getNums()%>
								</td>
							</tr>
							<tr>
								<th>
									收费标准
								</th>
								<td>
									<%=view.getMoney()%>
								</td>
							</tr>
							<tr>
								<th>
									是否空闲
								</th>
								<td>
									<%=view.getAvailable()%>
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
						<IMG SRC="images/seat/<%=view.getPicture()%>" WIDTH="100" HEIGHT="100"
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
