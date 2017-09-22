<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:directive.page import="cn.sdfi.model.Message"/>
<jsp:directive.page import="cn.sdfi.model.User"/>
<jsp:include page="includes/encoding.jsp" flush="true" />
<html>
	<head>
		<title>留言板</title>
<link rel="stylesheet" type="text/css" href="css/pub.css">
<script type="text/javascript">
// 删除留言
		function del()
		{
		if(confirm('确认删除该条留言？')){
		document.form2.action="msgdo.do?method=delete";
		document.form2.submit(); 
		}
		}
// 回复留言
		function replyfun()
		{	
		if(form2.reply.value=="")
		{
			alert('回复内容不得为空！！');
			return;
		}	
		document.form2.action="msgdo.do?method=reply";
		document.form2.submit(); 	
		}
</script>
		</head>
<body background="images/bg2.jpg">
		<p align="center">
			<font face="隶书" size="5" color="#0080ff">欢迎光临留言板系统</font>
		</p>
		<%
			
			User user=(User)session.getAttribute("user");
			if(user==null)
			{
				response.sendRedirect("main.jsp");
				return;
			}
			Message msg = (Message)request.getAttribute("view.data");
			if(user.getPrivledge()==3){   //普通会员显示
		%>
		
		<span style="text-decoration:none;font-size:13px"> <a
			href="main.jsp">返回主页</a> ||<a href="leaveMessage.jsp">我要留言</a> ||<a
			href="updateInfor.jsp">个人信息维护</a> ||<a
			href="javascript:window.external.AddFavorite('http://localhost:8080/shop/main.jsp','在线点餐系统');">
				放入收藏夹 </a> ||【<a href="logOut.jsp">注销</a>】 </span>
				<% } %>
		<hr align="center" noshade></hr>
		<form name="form2" method="post">
		<!-- 隐式传值 -->
		<input type="hidden" name="id" value="<%=msg.getId() %>">
			<table border="1" align="center">
				<tr>

					<td>
						留言人
					</td>
					<td>
						<%=msg.getUserName()%>
					</td>

				</tr>
				<tr>
					<td>
						主题
					</td>
					<td>
						<%=msg.getTitle()%>
					</td>
				</tr>
				<tr>

					<td>
						留言时间
					</td>
					<td>
						<%=msg.getLeaveTime()%>
					</td>
				</tr>
				<tr>
					<td>
						留言内容
					</td>

					<td>
						<textarea name="content" cols="50" rows="6" readonly="readonly">
							<%=msg.getContent()%>
						</textarea>
					</td>
				</tr>
				
				<tr><td colspan="2" align="center">
				<strong>
				<% 
				if(msg.getReply()!=null&&!"".equals(msg.getReply()))
				{
				out.print("<font color=green size=2>已回复</font>");
				}
				else
				{
				out.print("<font color=red  size=2>待回复</font>");
				}
				 %>
				</strong></td></tr>
				<tr><td colspan="2" align="right">
				<textarea name="reply" cols="50" rows="6"
					 <% 
					 	if((msg.getReply()!=null&&!"".equals(msg.getReply()))||user.getPrivledge()!=1){
					 	out.print("readonly=\"readonly\" ");
					 }
					  %>>
						<%
							if(msg.getReply()!=null&&!"".equals(msg.getReply())){
							out.print(msg.getReply());
							}
						 %>
						</textarea>
				</td></tr>
				
				<tr>
					<td align="center" colspan="2">
						<input type="button" value="返回"
							onclick="javascript:parent.history.back(); return;" />
							<% if(user.getPrivledge()==1){ %>
							<input type="button" name="btn_reply" value="提交" onclick="replyfun()" 
							<%
							if(msg.getReply()!=null&&!"".equals(msg.getReply())){
								out.print("disabled=\"disabled\"");
							}
							 %>>
							<input type="button" name="btn_delete" value="删除" onclick="del()" >
							<% } %>
					</td>
				</tr>
				
			</table>
		</form>
<%
	if(user.getPrivledge()!=1){
 %>
 <hr>
<jsp:include page="includes/copyright.jsp" flush="true" />
<% } %>
<jsp:include page="includes/alert.jsp" flush="true" />
	</body>
</html>
