<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:directive.page import="cn.sdfi.operate.VoteDAO"/>
<jsp:directive.page import="java.util.List"/>
<jsp:directive.page import="cn.sdfi.model.Vote"/>
<html>
	<head>
		<title>投票查看界面</title>
				<link rel="stylesheet" type="text/css" href="css/pub.css">
	</head> 
	<body background="images/bg2.jpg">
	<p align="center">
		<font face="隶书" size="5" color="#0080ff" > <MARQUEE
				direction="right">
				用户至上       用心服务   ........
			</MARQUEE>
		</font>
	</p>
	<hr>
			<div align='center'>
			<table border='1'>
				<tr>
					<th colspan="3" align="center">
						投票结果
					</th>
				</tr>
				<tr>
					<td>
						序号
					</td>
					<td>
						选项
					</td>
					<td>
						投票率
					</td>
				</tr>
				<%
						VoteDAO dao = new VoteDAO();
						List<Vote> list=dao.queryAll();
						int total = dao.getAllVotesNumber();
						Vote view=null;
						for(int i=0;i<list.size();i++) {
						view=list.get(i);
				 %>
				<tr>
					<td>
						<%=view.getId()%>
					</td>
					<td>
						<%=view.getIterm()%>
					</td>
					<td align='left'>
						<img src="images/vote.bmp"
							width="<%=Math.floor(view.getNumber() * 200 / total)%>"	height='10'>
						<%=Math.floor(view.getNumber() * 100 / total)%>
						%[
						<font size='2'>得:<%=view.getNumber()%>票&nbsp;共:<%=total%>票</font>]
					</td>
				</tr>

				<%
					}
					%>
	</table>
			</div>
	</body>
	<jsp:include page="includes/alert.jsp" flush="true" />
</html>
