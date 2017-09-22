<%@ page contentType="text/html;charset=gb2312"%>
<jsp:directive.page import="cn.sdfi.tools.GetPicNames"/>
<jsp:directive.page import="cn.sdfi.tools.Const"/>
<HTML>
<HEAD>
<TITLE>----请选择餐品图片----</TITLE>

</HEAD>
<BODY background="../images/bg2.jpg">

<%
//接收参数path，选择图片后，根据path返回到原来的页面。
String path=request.getParameter("path");
//获取 指定 目录下的所有的图片名称
String picNames[]=new GetPicNames().getPicNamesEndsWithJpg(Const.FOOD_PIC_PATH);
for(int i=0;i<picNames.length;i++){
	%>
	<a href="../<%=path %>?newPicture=<%=picNames[i] %>">
	<IMG SRC="../images/food/<%=picNames[i] %>" WIDTH="80" HEIGHT="80" BORDER=0 ALT="">
	</a>
<%
}
%>
</BODY>
</HTML>
