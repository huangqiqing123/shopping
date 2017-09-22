<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>  
<jsp:directive.page import="cn.sdfi.operate.MessageDAO"/>
<jsp:directive.page import="cn.sdfi.model.Message"/>
<jsp:include page="includes/encoding.jsp" flush="true" />
<html>
	<head>
		<title>留言板</title>
<link rel="stylesheet" type="text/css" href="css/pub.css">
		</head>
<body background="images/bg2.jpg">
<jsp:include page="includes/userCheck.jsp" flush="true" />
	
	<%
	int showPage = 1;//显示第showpage页

	int pageSize = 10;//每页显示记录数
	List list=new MessageDAO().queryAll();
	int recordCount =list.size();//获取数据库中总记录数

	int pageCount =(recordCount % pageSize == 0) ? (recordCount / pageSize): (recordCount / pageSize + 1);//总页数
	%>
		<p align="center">
			<font face="隶书" size="5" color="#0080ff">&nbsp;欢迎光临留言板系统</font>
		</p>
		<span style="text-decoration:none;font-size:13px"> <a
			href="main.jsp">返回主页</a> ||<a href="leaveMessage.jsp">我要留言</a> ||<a
			href="javascript:window.external.AddFavorite('http://localhost:8080/shop/showAllMessages.jsp','在线点餐系统')">
				放入收藏夹 </a> ||【<a href="logOut.jsp">注销</a>】 </span>
		<hr align="center" noshade></hr>
		<form action="msgdo.do?method=detail" method="post">
			<table border="1" align="center">
				<tr>
					<th>
						操作
					</th>
					<th>
						序号
					</th>
					<th>
						留言人
					</th>
					<th>
						主题
					</th>

					<th>
						留言时间
					</th>
					<th>
						状态
					</th>
				</tr>
				<%
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
				//显示第showPage页 (showPage - 1) * pageSize 
					int count = 1;
					Message view=null;	
					for(int k=(showPage - 1) * pageSize ;k<(showPage - 1) * pageSize+pageSize;k++) {
						if(k>=recordCount) break;
						view = (Message)list.get(k);
				%>
				<tr>
					<td>
						<input type="radio" name="id" checked="checked" value="<%=view.getId()%>" />
					</td>
					<td>
						<%=count++%>
					</td>
					<td>
						<%=view.getUserName() %>
					</td>
					<td>
						<%=view.getTitle()%>
					</td>
					<td>
						<%=view.getLeaveTime()%>
					</td>
					<td>
					<%
				if(view.getReply()!=null&&!"".equals(view.getReply()))
				{
				out.print("<font color=green  size=2>已回复</font>");
				}
				else
				{
				out.print("<font color=red  size=2>待回复</font>");
				}
					%>
					</td>
				</tr>

				<%
				}
				%>
				<tr>
					<td align="center" colspan="6">
						<input type="submit" value="查看详情" />
					</td>
				</tr>
			</table>
		</form>
		<p></p>
		<div align=center>
			<font size=2> 共有[<font color="red"><%=pageCount%> </font>]页，每页显示[<font
				color="red"><%=pageSize%> </font>]条记录, 共有[<font color="red"><%=recordCount%>
			</font>]条记录，当前显示第[<font color="red"><%=showPage%> </font>]页
				<p></p> <a href="showAllMessages.jsp?view=1">第一页</a> <a
				href="showAllMessages.jsp?view=2">上一页</a> <a
				href="showAllMessages.jsp?view=3">下一页</a> <a
				href="showAllMessages.jsp?view=4">最后一页</a> </font>
		</div>
		<hr>
		<jsp:include page="includes/copyright.jsp" flush="true" />
		<jsp:include page="includes/alert.jsp" flush="true" />
	</body>
</html>
