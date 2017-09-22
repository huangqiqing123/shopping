<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<jsp:directive.page import="cn.sdfi.model.Order"/>
<jsp:directive.page import="java.util.List"/>
<jsp:directive.page import="java.util.ArrayList"/>
<jsp:include page="includes/encoding.jsp" flush="true" />
<html>
	<head>
		<title>订单信息维护</title>
<link rel="stylesheet" type="text/css" href="css/skin.css">
<link rel="stylesheet" type="text/css" href="css/pub.css">
<script language="javascript" src="js/calendar.js"></script>
<script language="javascript" src="js/order_manage.js"></script>
	</head>
	<body background="images/bg2.jpg" >
	<jsp:include page="includes/adminCheck.jsp" flush="true" />
			
			<h2 align="center">
				订单管理 
			</h2>
			<hr>
			<form name="formQuery" action="" method="post">
				<table align="center">
					<tr>
					<td>
							订单编号
							<input type="text" size="12" name="orderId" value="" class="date_input">
						</td>
						<td>
							客户名称
							<input type="text" size="12" name="name" value="" class="date_input">
						</td>
						<td>
						用餐时间						
						<input size="12" name="time" class="date_input" value="" onchange="eee.setHidDateValInCalendar('yyyyMMdd');" readonly="readonly" ondblclick="javascript:this.value='';"name="createDate"><button  hideFocus="true" UNSELECTABLE="on" title="日历" class="date_button" onclick="eee.showDate();">6</button><div id="eee" class="date" style="display:none;overflow:hidden;position:absolute;z-index:10;" onpropertychange="eee.doUpDown();"><div><table border="0" cellpadding="1" cellspacing="1" class="date_table"><tr><td>
<div class="dateadjust" style="width:80px;"><div style="position:relative;left:47;top:2;">
<button style="left:9;top:-1;height:10;" hideFocus="true" onclick="eee._uper(this);eee.changeYearAndMonth(this.parentElement.nextSibling.value);"  onmousedown="eee._conti_uper(this);eee.changeYearAndMonth(this.parentElement.nextSibling.value);" onmouseout="eee._stop_inch();" onmouseup="eee._stop_inch();">5</button>
<button style="left:9;top: 8;height:10;" hideFocus="true" onclick="eee._downer(this);eee.changeYearAndMonth(this.parentElement.nextSibling.value);"  onmousedown="eee._conti_downer(this);" onmouseout="eee._stop_inch();" onmouseup="eee._stop_inch();">6</button></div>
<input type=text style="padding-top:2;position:relative;left:2;" value="2008" onblur="eee.doYearBlur(this);" conf="1,1900,2100,"></div><br><br></td>
<td><span  class="month" style="height:19;left:3;"><select size="1" onchange="eee.changeYearAndMonth(null,this.options[this.selectedIndex].value)">
<option value="1">一月</option>
<option value="2">二月</option>
<option value="3">三月</option>
<option value="4">四月</option>
<option value="5">五月</option>
<option value="6">六月</option>
<option value="7">七月</option>
<option value="8">八月</option>
<option value="9">九月</option>
<option value="10">十月</option>
<option value="11">十一月</option>
<option value="12">十二月</option>
</select></span><br><br></td></tr></table></div>
<div align=center></div>
<iframe frameborder=0 style="width:100%;height:103%;top:0;left:0;position:absolute;z-index:-1;"></iframe></div>
<script language="javascript">
var eee=new Calendar("eee"); 
eee.init("eee",2008,4,18,13,55,2,"yyyyMMdd","yyyyMMdd");
 </script>
</td>
<td>
&nbsp;&nbsp;
<img src="images/search.gif"  title="搜索" onclick="query()" style="cursor:hand">
</td>
</tr>
</table>
</form>
<hr>
<form name="showOrder" method="post">
<table border="1" align="center">
			
					<%
					List list = new ArrayList();

						//显示查询结果
						if (request.getAttribute("query.data") != null) {

							list = (List) request.getAttribute("query.data");
							if (list.size() < 1) {
								out.println("<font color=red>Sorry，无符合条件的记录</font>");

								return;

							}
							session.setAttribute("order.list", list);
						}
						list = (List) session.getAttribute("order.list");

						if (list == null || list.size() < 1) {

							return;
						}
	int showPage = 1;//显示第showpage页
	int pageSize = 9;//每页显示记录数
	int recordCount = list.size();         //获取数据库中总记录数
	int pageCount = (recordCount % pageSize == 0) ? (recordCount / pageSize): (recordCount / pageSize + 1);//总页数
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
					<tr><th>选择<th>订单编号<th>客户名称<th>餐位<th>订单生成时间<th>用餐时间<th>金额</th></tr>
						<%
						//显示第showPage页，起始记录：(showPage - 1) * pageSize 
		
					Order order=null;
					for(int k=(showPage - 1) * pageSize ;k<(showPage - 1) * pageSize+pageSize;k++) {
						if(k>=recordCount) break;
						order = (Order)list.get(k);
					%>
					
				<tr>
					<td>
						<input type="checkbox" name="id" value=<%=order.getId() %>>
						
					</td>
					<td>
						<%=order.getId()%>
					</td>
					<td>
						<%=order.getUserName()%>
					</td><td>
						<%=order.getLocation()%>
						&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="#"  onclick="window.location.href='seatdo.do?method=detail&action=forupdate&seatId=<%=order.getSeatId() %>'" >
						修改
						</a>
					</td><td>
						<%=order.getCreateTime()%>
					</td><td>
						<%=order.getDemandTime()%>
					</td><td>
						<%=order.getMoney()%>
					</td>
					
					</tr>
					
					<%
					}
					%>
	
				<tr><td colspan="7" align="center">
					
					<input type="button" name="showD" value="明细" onclick="detail()" >
					
					<input type="button" name="delOrder" value="删除" onclick="del()" >
					
					</td></tr>
			</table>
			
			</form>
			<p align="center">
			<font size=2> 共有[<font color="red"><%=pageCount%> </font>]页，每页显示[<font
				color="red"><%=pageSize%> </font>]条记录, 共有[<font color="red"><%=recordCount%>
			</font>]条记录，当前显示第[<font color="red"><%=showPage%> </font>]页
				<br><br>
				<a href="#" onclick="window.location.href='order_manage.jsp?view=1'" >第一页</a>
				<a href="#" onclick="window.location.href='order_manage.jsp?view=2'" >上一页</a>
				<a href="#" onclick="window.location.href='order_manage.jsp?view=3'" >下一页</a>
				<a href="#" onclick="window.location.href='order_manage.jsp?view=4'" >最后一页</a>	
				</font>		
<hr>
			<jsp:include page="includes/alert.jsp" flush="true" />
	</body>
</html>
