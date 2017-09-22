<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:directive.page import="cn.sdfi.operate.VoteDAO"/>
<jsp:directive.page import="java.util.List"/>
<jsp:directive.page import="cn.sdfi.model.Vote"/>
<html>
	<head>
		<title>投票界面</title>
		<link rel="stylesheet" type="text/css" href="css/pub.css">
	</head>
	<p align="center"> 
		<font face="隶书" size="5" color="#0080ff" > <MARQUEE
				direction="right">
				欢迎你投票，我们将继续努力........
			</MARQUEE>
		</font>
	</p>
	<font size='2' color='blue' >[<a href='main.jsp'>返回主页</a>][当前位置：主页--&gt;投票]</font>
	<hr>
	<body background="images/bg2.jpg">
	<jsp:include page="includes/userCheck.jsp" flush="true" />
			<form action="votedo.do?method=vote" method="post" name="vote">
				<table border="1" align="center">
					<tr>
						<th colspan="2">
							<h3>你对我们的服务质量</h3>
						</th>
					</tr>
					<tr>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<th>
							投票
						</th>
						<th>
							选项
						</th>
					</tr>
					<%
						VoteDAO dao = new VoteDAO();
						List<Vote> list=dao.queryAll();
						Vote view=null;
						for(int i=0;i<list.size();i++) {
						view=list.get(i);
					 %>
					<tr>
						<td>
							<input type="radio" name="itermId" value="<%=view.getId() %>" checked="checked">
						</td>
						<td align="center">
							<%=view.getIterm() %>
						</td>
					</tr>
					<% } %>
					<tr>
						<td align="center" colspan="2">
							<a href="javascript:document.vote.submit()">【投票】</a>
						
						<a href="javascript:window.location.href='vote.jsp?showResult=true'">【查看结果】</a>
						</td>
					</tr>
				</table>
			</form>
			<%
					if ("true".equals(request.getParameter("showResult"))) {
					
					int total = dao.getAllVotesNumber();
					
			%>
			<hr>
			<table border='1'  align="center">
				<tr>
					<th colspan="3" >
						查看投票结果
					</th>
				</tr>
				<tr>
					<td>
						序号
					</td>
					<td>
						选项
					</td>
					<td align="center">
						投票率
					</td>
				</tr>
				<%
				for(int i=0;i<list.size();i++) {
				%>
				<tr>
					<td align="center">
						<%=list.get(i).getId() %>
					</td>
					<td align="center">
						<%=list.get(i).getIterm() %>
					</td>
					<td align='left'>
						<img src="images/vote.bmp"
							width="<%=Math.floor(list.get(i).getNumber() * 200 / total)%>"
							height='10'>
						<%=Math.floor(list.get(i).getNumber() * 100 / total)%>
						%[
						<font size='2'>得:<%=list.get(i).getNumber()%>票&nbsp;共:<%=total%>票</font>]
					</td>
				</tr>

				<%
					}
					}
				%>
			</table>
			<hr>
			<jsp:include page="includes/copyright.jsp" flush="true" />
			<jsp:include page="includes/alert.jsp" flush="true" />
	</body>
</html>
