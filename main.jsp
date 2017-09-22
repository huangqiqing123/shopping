<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:directive.page import="cn.sdfi.model.User" />
<jsp:directive.page import="cn.sdfi.operate.SeatDAO" />
<jsp:directive.page import="cn.sdfi.model.Seat" />
<jsp:directive.page import="java.util.List" />
<jsp:include page="includes/encoding.jsp" flush="true" />

<%@page import="org.loushang.cas.client.login.LoginServlet"%><html>
	<head>
		<title>在线订餐系统</title>
		<script language="javascript" src="js/clock.js"></script>
		<script language="javascript">
// 登录前的非空验证
function check()
{
if(login.name.value=="")
alert("请输入用户名！！！");
 
else if(login.password.value=="")
alert("请输入密码！！！");
else
{  
document.login.action="userdo.do?method=login";
document.login.submit();
}
}
</script>
	</head>

	<body onload=startclock() background="images/bg2.jpg">
	<div align="right" style="font-size:13px">

				<A style="BEHAVIOR: url(#default#homepage)"
					onclick="this.style.behavior='url(#default#homepage)';this.setHomePage('http://localhost:8080/shop/');return(false);"
					href="http://pub.sdfi.edu.cn/info/#">设为主页</A>|
				<a
					href="javascript:window.external.AddFavorite('http://localhost:8080/shop/showAllMessages.jsp','在线订餐系统')">
					放入收藏夹</a>|
				<a href="#" onclick="window.location.href='login.jsp'" >管理员入口</a>
				
		</div>
		
		<%
			int showPage = 1;//显示第showpage页
			int pageSize = 9;//每页显示记录数
			List list = new SeatDAO().queryAll();
			int recordCount = list.size(); //获取数据库中总记录数
			int pageCount = (recordCount % pageSize == 0) ? (recordCount / pageSize)
					: (recordCount / pageSize + 1);//总页数
		%>
		<%
			User user = (User) session.getAttribute("user");
			if (user != null) {
				out.print("<img src='images/user/" + user.getPicture()
				+ "' WIDTH=40 HEIGHT=40 border=0>");
				out
				.print("<font size=2>你好:&nbsp;</font><font size=3 color=red>");
				out.print(user.getName());
				out
				.print("</font>【<a href='logOut.jsp'><font size=2>安全退出</font></a>】");
			}
			if (request.getParameter("view") != null) {
				int select = Integer.parseInt(request.getParameter("view"));
				switch (select) {
				case 1:
					showPage = 1;
					break;
				case 2:
					if (showPage == 1) {
				showPage = 1;
					} else {
				showPage--;
					}
					break;
				case 3:
					if (showPage == pageCount) {
				showPage = pageCount;
					} else {
				showPage++;
					}
					break;
				case 4:
					showPage = pageCount;
					break;
				//default:
				}
			}
		%>
		<center>
			<p>
				<font face="隶书" size="5" color="#0080ff"><MARQUEE height="10"
						width="300" style="padding: 0px; white-space: nowrap;">
						欢迎光临财院在线点餐系统
					</MARQUEE> </font>
			</p>
			
			<form action="userdo.do?method=login" name="login" method="post">
				<input type="hidden" value="3" name="privledge">
				<table align="center" style="font-size:13px">
					<tr>
						<td>
							<input name="time" style="font-size: 13px;color:#CA0000;border:0"
								size="30">
						</td>
						<td>
						<a href="#" onclick="window.location.href='help.jsp'" >餐品浏览</a>
						|
						</td>
						<td>
						<a href="#" onclick="window.location.href='myOrder.jsp'" >我的订单</a>
						|
						</td>
						<td>
							<a
								href="userdo.do?method=update&privledge=3&id=<%=user == null ? "" : user.getId()%>">个人信息维护</a>
								|
						</td>
						<td>
						<a href="#" onclick="window.location.href='showAllMessages.jsp'" >留言板</a>
						 |
						</td>
						<td>
						<a href="#" onclick="window.location.href='vote.jsp'" >在线调查</a>
						|
						</td>
						<td>
						<a href="#" onclick="window.location.href='showCart.jsp'" >查看购物车</a>
						</td>
						<td>
							用户名
						</td>
						<td>
							<input type="text" size="10" name="name" value="" style="font-size: 13px;color:#CA0000;border:1">
						</td>
						<td>
							密码
						</td>
						<td>
							<input type="password" size="10" name="password" style="font-size: 13px;color:#CA0000;border:1">
						</td>
						<td>
							<a href="#" onclick="check()">[登陆]</a>
						</td>
						<td>
							<a href="#" onclick="window.location.href='register.jsp'" >[注册]</a>
						</td>

					</tr>
				</table>
			</form>

			<hr align="center" noshade>
			<table border="1" align="center">
				<tr>
					<%
						//显示第showPage页，起始记录：(showPage - 1) * pageSize 

						int i = 0;
						Seat seat;

						for (int k = (showPage - 1) * pageSize; k < (showPage - 1)
								* pageSize + pageSize; k++) {
							if (k >= recordCount)
								break;
							seat = (Seat) list.get(k);
					%>
					<td>
						<a href="seatdo.do?method=detail&seatId=<%=seat.getSeatId()%>">
							<img src="images/seat/<%=seat.getPicture()%>" WIDTH="90"
								HEIGHT="90" border="0"> </a>
					</td>
					<td>
						<table style="text-decoration:none;font-size:13px">
							<tr>
								<td align=left>
									餐位位置：
									<%=seat.getLocation()%>
								</td>
							</tr>
							<tr>
								<td align=left>
									容纳人数：
									<%=seat.getNums()%>
								</td>
							</tr>
							<tr>
								<td align=left>
									消费标准：
									<%=seat.getMoney()%>
								</td>
							</tr>
							<tr>
								<td align=left>
									是否空闲：
									<%
										// 空闲则用 绿 色字体显示，否则，用红色
										String available = seat.getAvailable().trim();
										if ("是".equals(available)) {
								%>
									<font color="green"><%=available%>
									</font>
									<%
									} else {
									%>
									<font color="red"><%=available%>
									</font>
									<%
									}
									%>
								</td>
							</tr>

							<tr>
								<td align="center">
									<%
									if ("是".equals(available)) {
									%>
									<a
										href="seatdo.do?method=changeState&seatId=<%=seat.getSeatId()%>&newState=否">[预订]</a>
									<%
									}
									%>

									<a href="seatdo.do?method=detail&seatId=<%=seat.getSeatId()%>">[明细]</a>
								</td>
							</tr>
						</table>
					</td>
					<%
							i++;
							if (i % 3 == 0) {
								out.print("</tr><tr>");
							}
						}
					%>
				</tr>
			</table>
			<p></p>
			<font size=2> 共有[<font color="red"><%=pageCount%> </font>]页，每页显示[<font
				color="red"><%=pageSize%> </font>]条记录, 共有[<font color="red"><%=recordCount%>
			</font>]条记录，当前显示第[<font color="red"><%=showPage%> </font>]页
				<p align="center">
					<a href="main.jsp?view=1">第一页</a>
					<a href="main.jsp?view=2">上一页</a>
					<a href="main.jsp?view=3">下一页</a>
					<a href="main.jsp?view=4">最后一页</a>
			</font>
			<hr>
			<jsp:include page="includes/copyright.jsp" flush="true" />
			<jsp:include page="includes/alert.jsp" flush="true" />
		</center>
	</body>
</html>
