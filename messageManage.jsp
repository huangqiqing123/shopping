<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:directive.page import="cn.sdfi.model.Message" />
<jsp:directive.page import="cn.sdfi.model.User"/>
<jsp:directive.page import="cn.sdfi.operate.MessageDAO"/>
<jsp:directive.page import="java.util.List;"/>
<html>
	<head>
		<title>留言版管理</title>
		<link rel="stylesheet" type="text/css" href="css/pub.css">
		<script type="text/javascript">
		
		// 执行查询明细
		function detail()
		{ 
		 var obj=document.getElementsByName("id");
		 
		 if(obj!=null){
		 var count=0;
		 for(i=0;i<obj.length;i++){
          if(obj[i].checked==true){
          count++;
         }
         }
   		 if(count!=1){
     	 alert("请选择一条记录!!");
     	 return;
   		 }
		document.form2.action="msgdo.do?method=detail";
		document.form2.submit(); 
		} 
		}
		
		// 执行删除操作
		function del()
		{
		 obj=document.getElementsByName("id");
		
		 if(obj!=null){
		 var count=0;
		 for(i=0;i<obj.length;i++){
          if(obj[i].checked==true){
          count++;
         }
         }
   		 if(count < 1){
     	 alert("请选择要删除的记录!!");
     	 return;
   		 }
		if(confirm('确认删除选中记录？')){
		document.form2.action="msgdo.do?method=delete";
		document.form2.submit(); 
		}
		}
		}
		</script>
	</head>
	<body background="images/bg2.jpg">
		
	<%
					User user=(User)session.getAttribute("user");
					if(user==null||user.getPrivledge()!=1){
					response.sendRedirect("login.jsp");
					return;
				}
	%>
	
	<%
	int showPage = 1;//显示第showpage页

	int pageSize = 10;//每页显示记录数
	List list=new MessageDAO().queryAll();
	int recordCount =list.size();//获取数据库中总记录数

	int pageCount =(recordCount % pageSize == 0) ? (recordCount / pageSize): (recordCount / pageSize + 1);//总页数
	%>
		<p align="center">
			<font face="隶书" size="5" color="#0080ff">&nbsp;留言板管理</font>
		</p>
		<hr align="center" noshade></hr>
		<form  name="form2" action="" method="post">
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
						<input type="checkbox" name="id"  value="<%=view.getId()%>" />
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
						<td colspan="6" align="center">
							<input type="button" name="btn_add" value="回复" onclick="detail()">
							<input type="button" name="btn_delete" value="删除" onclick="del()">
							<input type="button" name="btn_detail" value="明细" onclick="detail()">
						</td>
					</tr>
			</table>
		</form>
		<hr>
		<div align=center>
			<font size=2> 共有[<font color="red"><%=pageCount%> </font>]页，每页显示[<font
				color="red"><%=pageSize%> </font>]条记录, 共有[<font color="red"><%=recordCount%>
			</font>]条记录，当前显示第[<font color="red"><%=showPage%> </font>]页
				<p></p> <a href="messageManage.jsp?view=1">第一页</a> <a
				href="messageManage.jsp?view=2">上一页</a> <a
				href="messageManage.jsp?view=3">下一页</a> <a
				href="messageManage.jsp?view=4">最后一页</a> </font>
		</div>
		<hr>
		<jsp:include page="includes/alert.jsp" flush="true" />
	</body>
</html>
