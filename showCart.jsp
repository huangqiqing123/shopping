<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.HashMap"%>
<jsp:directive.page import="java.util.Set"/>
<jsp:directive.page import="cn.sdfi.model.Detail"/>
<jsp:directive.page import="java.util.Iterator"/>
<html>
	<head>
		<title>查看购物车</title>
<link rel="stylesheet" type="text/css" href="css/skin.css">
<style type="text/css">
<!--
body,td,th { 
	font-family: 宋体;
	font-size: 15px;
	color: #0000FF; 
}
-->
</style>
<script language="javascript" src="js/calendar.js"></script>
<script language="javascript" src="js/showCart.js"></script>
</head>	
<body background="images/bg2.jpg">
<jsp:include page="includes/userCheck.jsp" flush="true" />
	<%!
		HashMap<String,Detail> map=null;
		Set set=null;
	 %>
	<%
		//清空购物车
		if ("true".equals(request.getParameter("clear"))) {
			session.removeAttribute("cart");
			%>
			<div align=center>
			<font color=red >你的购物车暂时没有任何餐品<p>
			<a href="main.jsp">返回</a>
			</p>
			</font>
			</div>
			<%
			return;
		}
		//如果是从 putintocart.jsp 跳转过来的
		String amount=request.getParameter("amount");
		if (amount != null && !"".equals(amount)) {
				Detail detail=new Detail();
				detail.setAmount(Integer.parseInt(amount));
				detail.setPrice(request.getParameter("price"));
				detail.setAccount(Float.parseFloat(detail.getPrice())*detail.getAmount()+"");
				detail.setFood_id(Integer.parseInt(request.getParameter("foodId")));
				detail.setFoodName(request.getParameter("foodName"));
				detail.setFk("");
				
			map = (HashMap<String,Detail>)session.getAttribute("cart");
			if (map == null) {//第一次往购物车中放东西
				map = new HashMap<String, Detail>();
			}
			map.put(detail.getFood_id()+"",detail);//把该条购物信息封装 存入 map
			session.setAttribute("cart", map);//将存有该次所购的物品的 map 存入 session
			// 如果是从 main.jsp 跳转过来的,查看购物车
		} 
		else {
			map = (HashMap<String, Detail>) session.getAttribute("cart");
			if (map == null) {
				out
				.print("<div align=center><font color=red>你的购物车暂时没有任何餐品</font><p>");
				out
				.print("<a href=main.jsp><font color=red>返回</font></a></div>");
				return;
			}
		}
	%>
	
			<br>
			<br>
			<br>
			<br>
			<h2 align="center">你的餐车内物品如下：</h2>
			<a href="#" onclick="window.location.href='main.jsp'">[返回主页]</a>
			<hr>
			<form name="showCart" method="post">
				<table border="1" bordercolor="grey" align="center">
					<tr>
						<th>
							删除
						</th>
						
						<th>
							餐品名称
						</th>
						<th>
							单价
						</th>
						<th>
							数量
						</th>
						<th>
							小计
						</th>
					</tr>
					<%
						Detail detail=null;
						float totalMoney=0;//记录当前购物车中餐品的总花费
						set = map.keySet();
						Iterator iter = set.iterator();
						String key = null;
						while (iter.hasNext()) {
							key = (String) iter.next();
							detail = (Detail) map.get(key);
							totalMoney+=Float.parseFloat(detail.getAccount());
					%>
					<tr>
						<td>
							<input type="checkbox" name="detailId" value="<%=detail.getFood_id()%>">

						</td>
						<td>
							<%=detail.getFoodName()%>
						</td>
						
						<td>
							<%=detail.getPrice()%>
						</td>
						<td>
							<%=detail.getAmount()%>
						</td>
						<td align="center">
						<%=detail.getAccount() %>
						</td>
					</tr>

					<%
					}
					%>
					<tr>
					<td colspan="3" align="center">合计</td>
					<td colspan="2" align="center"><%=totalMoney %>
					<input type="hidden" name="money" value="<%=totalMoney %>">
					</td>
					</tr>
					<tr>
						<td colspan="3" align="center">
							用餐时间
						</td>
<td class="tdRight" colspan="3"><input size="16" name="time" class="date_input" value="" onchange="eee.setHidDateValInCalendar('yyyyMMdd');" readonly="readonly" ondblclick="javascript:this.value='';"name="createDate"><button  hideFocus="true" UNSELECTABLE="on" title="日历" class="date_button" onclick="eee.showDate();">6</button><div id="eee" class="date" style="display:none;overflow:hidden;position:absolute;z-index:10;" onpropertychange="eee.doUpDown();"><div><table border="0" cellpadding="1" cellspacing="1" class="date_table"><tr><td>
<div class="dateadjust" style="width:80px;"><div style="position:relative;left:47;top:2;">
<button style="left:9;top:-1;height:10;" hideFocus="true" onclick="eee._uper(this);eee.changeYearAndMonth(this.parentElement.nextSibling.value);"  onmousedown="eee._conti_uper(this);eee.changeYearAndMonth(this.parentElement.nextSibling.value);" onmouseout="eee._stop_inch();" onmouseup="eee._stop_inch();">5</button>
<button style="left:9;top: 8;height:10;" hideFocus="true" onclick="eee._downer(this);eee.changeYearAndMonth(this.parentElement.nextSibling.value);"  onmousedown="eee._conti_downer(this);" onmouseout="eee._stop_inch();" onmouseup="eee._stop_inch();">6</button></div>
<input type=text style="padding-top:2;position:relative;left:2;" value="2008" onblur="eee.doYearBlur(this);" conf="1,1900,2100,"></div></td>
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
</select></span></td></tr></table></div>
<div align=center></div>
<iframe frameborder=0 style="width:100%;height:103%;top:0;left:0;position:absolute;z-index:-1;"></iframe></div>
<script language="javascript">var eee=new Calendar("eee"); eee.init("eee",2008,4,18,13,55,2,"yyyyMMdd","yyyyMMdd"); </script>
</td>
											</tr>
									
										<tr>
											<td colspan="6" align="center">
											<a href="#" onclick="del()">[删除]</a>
											<a href="#" onclick="window.location.href='help.jsp'">[继续点餐]</a>
											<a href="#" onclick="buy()">[生成订单]</a>
											<a href="#" onclick="window.location.href='showCart.jsp?clear=true'">[清空餐车]</a>
						
											</td>
										</tr>
									</table>
									</form>
									<hr>
            <br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<jsp:include page="includes/copyright.jsp" flush="true" />
			<jsp:include page="includes/alert.jsp" flush="true" />
	
	</body>
</html>
		




