<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:directive.page import="cn.sdfi.model.User"/>
<jsp:include page="includes/encoding.jsp" flush="true" />
<jsp:include page="includes/adminCheck.jsp" flush="true" />
<html>
	<head>
		<title>超链接列表</title>
	</head>
	<body background="images/bg2.jpg" >
		<div align="center">
		<%
		User user=(User) session.getAttribute("user");
		 %>
		 <IMG SRC="images/user/<%=user.getPicture() %>" WIDTH="40" HEIGHT="40" BORDER=0	ALT="">
		 <br>
		<font size='2'>当前用户[<font size=2 color="red"><%=user.getName() %>	</font> ]
				
				<hr>
				
				【<a href="logOut.jsp" target="_parent">安全退出</a>】</font>
				</div>
		<hr>
		<table border="1">
			<tr>
				<th>
					<font  color='blue' size="3">用户管理</font>
				</th>
			</tr>
			
			<tr>
				<td>
					<a href="addUser.jsp" target="show">
							<font size='3'><li>用户信息添加</li> </font>
						</a>
				</td>
			</tr>
			
			<tr>
				<td>
					<a href="query.jsp" target="show"><font  size="3">
								<li>用户信息维护</li></font></a>
				</td>
			</tr>
			
			<tr>
				<td>
					<a href="showOnLineUsers.jsp" target="show">
								<font  size="3"><li>查看在线用户</li> </font>
							</a>
				</td>
			</tr>
			
			<tr>
				<th>
					<font color='blue'  size="3">类别管理</font>
				</th>
			</tr>
			
			<tr>
				<td bgcolor="">
					<a href="typeAdd.jsp" target="show">
								<font size='3'><li>新增类别信息</li></font>
							 </a>
				</td>
			</tr>
			
			<tr>
				<td bgcolor="">
					<a href="typeQuery.jsp" target="show">
								<font size='3'><li>类别信息维护</li></font>
							 </a>
				</td>
			</tr>
			
			<tr>
				<th>
					<font color='blue'  size="3">餐品管理</font>
				</th>
			</tr>
			
			<tr>
				<td>
					<a href="addFood.jsp" target="show">
								<li><font face="宋体" size="3">餐品信息添加</font></li>
						 </a>
						 
				</td>
			</tr>
			
			<tr>
				<td bgcolor="">
					<a href="foodQuery.jsp" target="show">
								<font size='3'><li>餐品信息维护</li></font>
							 </a>
				</td>
			</tr>
			<tr>
				<th>
					<font color='blue'  size="3">餐位管理</font>
				</th>
			</tr>
			
			<tr>
				<td>
					<font  size="3"><a href="seatAdd.jsp" target="show">
								<li>餐位信息添加	</li>
						 </a>
						 </font>
				</td>
			</tr>
			
			<tr>
				<td bgcolor="">
				<a href="seatQuery.jsp" target="show">
								<font size='3'><li>餐位信息维护</li></font>
							 </a>
				</td>
			</tr>
			
			<tr>
				<th>
					<font color='blue' size="3">订单管理</font>
				</th>
			</tr>
			
			<tr>
				<td>
				<a href="order_manage.jsp" target="show">
								<font size='3'><li>订单信息维护</li> </font>
							</a>
				</td>
			</tr>
			
			<tr>
				<th>
					<font color='blue' size="3">其他</font>
				</th>
			</tr>
			
			<tr>
				<td>
					<font face="宋体"><a href="messageManage.jsp" target="show">
								<font size='3'><li>留言管理</li></font>
							 </a>
				</td>
			</tr>
			
			<tr>
				<td>
					<font face="宋体"><a href="voteManage.jsp" target="show">
								<font size='3'><li>在线调查</li></font>
							 </a>
				</td>
			</tr>
		</table>

	</body>
</html>
