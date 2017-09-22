<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="cn.sdfi.model.User"%>
<%@page import="java.util.Iterator"%>
<jsp:directive.page import="cn.sdfi.operate.UserOperate" />
<jsp:directive.page import="java.util.ArrayList"/>
<jsp:directive.page import="java.util.List"/>
<jsp:include page="includes/encoding.jsp" flush="true" />
<jsp:include page="includes/adminCheck.jsp" flush="true" />
<html>
	<head>
		<title>信息查询</title>
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
		document.form2.action="/shop/userdo.do?method=detail";
		document.form2.submit(); 
		} 
		}
		function update()
		{	
		 var obj=document.getElementsByName("id");
		 // 更新时,对选择的记录数进行校验
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
    	
		document.form2.action="/shop/userdo.do?method=update";
		document.form2.submit(); 
		} 
		}
		// 执行删除操作
		function del()
		{
		var obj=document.getElementsByName("id");
		
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
		document.form2.action="/shop/userdo.do?method=delete";
		document.form2.submit(); 
		}
		}
		}
		</script>
<link rel="stylesheet" type="text/css" href="css/pub.css">
	</head>
	<body background="images/bg2.jpg">
		
			<h2 align="center">
				用户信息维护
			</h2>
			<hr>
			<form name=formQuery action="userdo.do?method=query" method="post">
				<table align="center">
					<tr>
						<td>
							用户名
							<input type="text" name="name" size="8">
						</td>
					
						<td>
						角色
						<select name="privledge" title="选择角色">
								<option value="1">--管理员--
								<option value="3">--客户--
							</select>
						</td>
				
						<td>
							<input type="radio" name="type" value="accurate">
							精确
							<input type="radio" name="type" value="blur" checked>
							模糊
							<input type="submit" value="查询" >
						</td>
					</tr>
				</table>
			</form>
			<form name="form2" method="post">
				<hr>
				<table border="1" align="center">
					<tr>
						<th>
							选择
						<th>
							用户名
						<th>
							性别
						<th>
							权限
						<th>
							注册时间
						
						<th>
							头像
						
						</th>
					</tr>
					<%
						List list = new ArrayList();

						//显示查询结果
						if (request.getAttribute("list") != null) {

							list = (List) request.getAttribute("list");
							if (list.size() < 1) {
								out.println("<font color=red>Sorry，无符合条件的记录</font>");

								return;

							}
							session.setAttribute("user.list", list);
						}
						list = (List) session.getAttribute("user.list");

						if (list == null || list.size() < 1) {

							return;
						}
						int showPage = 1;//显示第showpage页
						int pageSize = 6;//每页显示记录数
						int recordCount = list.size(); //获取查询出的总记录数
						int pageCount = (recordCount % pageSize == 0) ? (recordCount / pageSize)
								: (recordCount / pageSize + 1);//总页数

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
						//显示第showPage页，起始记录：(showPage - 1) * pageSize 
					
						User user = null;

						for (int k = (showPage - 1) * pageSize; k < (showPage - 1)
								* pageSize + pageSize; k++) {
							if (k >= recordCount)
								break;
							user = (User) list.get(k);
					%>
					
					<tr>
						<td>
						<input type="checkbox" name="id" value="<%=user.getId()%>">
						</td>
						<td>
							<%=user.getName()%>
						</td>
						<td>
							<%="男".equals(user.getSex().trim())?"男":"女"%>
						</td>
						<td>
							<%
									if (user.getPrivledge() == 1) {
										out.print("管理员");
									} else {
										out.print("客户");
									}
							%>
						</td>
	
						<td>
							<%=user.getRegisterTime()%>
						</td>
						<td><IMG SRC="images/user/<%=user.getPicture() %>" WIDTH="30" HEIGHT="30" BORDER=0	ALT="">	</td>
					</tr>

					<%
					}
					%>
					<tr>
						<td colspan="5" align="center">
						<input type="button" name="btn_add" value="新增" onclick="window.location.href='/shop/addUser.jsp'">
						<input type="button" name="btn_update" value="修改"	onclick="update()">
						<input type="button" name="btn_delete" value="删除" onclick="del()">
						<input type="button" name="btn_delete" value="明细" onclick="detail()">
						</td>
					</tr>
				</table>
			</form>
			<p align="center">
				<font size=2> 共有[<font color="red"><%=pageCount%> </font>]页，每页显示[<font
					color="red"><%=pageSize%> </font>]条记录, 共有[<font color="red"><%=recordCount%>
				</font>]条记录，当前显示第[<font color="red"><%=showPage%> </font>]页
					<br><br>
						<a href="query.jsp?view=1">第一页</a>
						<a href="query.jsp?view=2">上一页</a>
						<a href="query.jsp?view=3">下一页</a>
						<a href="query.jsp?view=4">最后一页</a>
				</font>
			<hr>
				<jsp:include page="includes/alert.jsp" flush="true" />
	</body>
</html>
