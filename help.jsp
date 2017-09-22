<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="cn.sdfi.model.Food"%>
<jsp:directive.page import="cn.sdfi.model.Type" />
<jsp:directive.page import="cn.sdfi.operate.TypeDAO" />
<jsp:directive.page import="java.util.ArrayList" />
<jsp:directive.page import="cn.sdfi.model.Seat"/>
<jsp:directive.page import="java.util.List;"/>
<jsp:include page="includes/encoding.jsp" flush="true" />
<html>
	<head>
		<title>点餐页面</title>
		<link rel="stylesheet" type="text/css" href="css/pub.css">
		<script type="text/javascript">
		
		// 放入购物车
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
		document.form2.action="fooddo.do?method=detail";
		document.form2.submit(); 
		} 
		}
		
		</script>
	</head>
	<body background="images/bg2.jpg">

			<h2 align="center">
				请选择你需要的餐品
			</h2>
			
		<%
			Seat seat=(Seat)session.getAttribute("seat");
				
		 %>
			<form name=formQuery action="fooddo.do?method=query&privledge=3"
				method="post">
				<table align="left" style="font-size:13px">
			<tr>
				<td style="font-size:13px" >
				<% if(seat==null){out.print("<font color=red>你还没有预订餐位</font>");}else{ %>
				 已预订餐位：<a href="seatdo.do?method=detail&seatId=<%=seat.getSeatId() %>">[<%=seat.getLocation() %>]</a>
				<% } %>||
				</td>
				<td style="font-size:13px"> <a href="main.jsp">返回主页</a>||</td>
				<td style="font-size:13px"> <a href="register.jsp">注册</a>||</td>
				<td style="font-size:13px"> <a	href="myOrder.jsp">我的订单</a>||</td>
				<td style="font-size:13px"><a href="showCart.jsp">查看购物车</a></td>	
				<td style="font-size:13px">
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
				</td>
						<td style="font-size:13px">
							名称
						</td>
						<td style="font-size:13px">
							<input type="text" name="name" size="10" value="">
						</td>

						<td style="font-size:13px">
							<select name="typeId" title="选择类别">
								<option value="-1">
									--请选择餐品类别--
									<%
									//从数据库中查询出所有类别并显示
									List<Type> typeList = new TypeDAO().queryAll();
									for (int i = 0; i < typeList.size(); i++) {
								%>
								
								<option value="<%=typeList.get(i).getId()%>">
									--
									<%=typeList.get(i).getName()%>
									--
									<%
																}
																%>
								
							</select>
						</td>

						<td style="font-size:13px">
							<input type="radio" name="style" value="accurate">
							精确
						</td>
						<td style="font-size:13px">
							<input type="radio" name="style" value="blur" checked>
							模糊
						<td>
							<input type="submit" value="查询">
						</td>
					</tr>
				</table>
			</form>
	<hr align="center" >	<hr align="center" >		<hr align="center" >			
			<form name="form2" method="post">
			<input type="hidden" name="privledge" value="3">
				<table border="1" align="center">
					<tr>
						<th>
							选择
						<th>
							名称
						<th>
							价格
						<th>
							所属类别
						<th>
							入库时间
						<th>
							图片
						</th>
					</tr>
					<%
						List list = new ArrayList();

						//显示查询结果
						if (request.getAttribute("view.data") != null) {

							list = (List) request.getAttribute("view.data");
							if (list.size() < 1) {
								out.println("<font color=red>Sorry，无符合条件的记录</font>");

								return;

							}
							session.setAttribute("list", list);
						}
						list = (List) session.getAttribute("list");

						if (list == null || list.size() < 1) {

							return;
						}
						int showPage = 1;//显示第showpage页
						int pageSize = 8;//每页显示记录数
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
					
						Food view = null;

						for (int k = (showPage - 1) * pageSize; k < (showPage - 1)
								* pageSize + pageSize; k++) {
							if (k >= recordCount)
								break;
							view = (Food) list.get(k);
					%>
					<tr>
						<td>
							<input type="radio" name="id" value="<%=view.getId()%>">
						</td>
						<td>
							<%=view.getName()%>
						</td>
						<td>
							<%=view.getPrice()%>
						</td>
						<td>
							<%=view.getType()%>
						</td>

						<td>
							<%=view.getAddTime()%>
						</td>
						<td>
							<IMG SRC="images/food/<%=view.getPicture()%>" WIDTH="30" HEIGHT="30"
								BORDER=0 ALT="">
							<input type="hidden" name="picture"
								value="<%=view.getPicture()%>">
						</td>
					</tr>

					<%
					}
					%>
					<tr>
						<td colspan="6" align="center">
							<input type="button" name="btn_detail" value="明细"
								onclick="detail()">
					</td>
					</tr>
				</table>
			</form>
			<p align="center">
				<font size=2> 共有[<font color="red"><%=pageCount%> </font>]页，每页显示[<font
					color="red"><%=pageSize%> </font>]条记录, 共有[<font color="red"><%=recordCount%>
				</font>]条记录，当前显示第[<font color="red"><%=showPage%> </font>]页
				<br><br>
						<a href="help.jsp?view=1">第一页</a>
						<a href="help.jsp?view=2">上一页</a>
						<a href="help.jsp?view=3">下一页</a>
						<a href="help.jsp?view=4">最后一页</a>
				</font>
			<hr>
			<jsp:include page="includes/copyright.jsp" flush="true" />
			<jsp:include page="includes/alert.jsp" flush="true" />
	</body>
</html>
