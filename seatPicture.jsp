<%@ page contentType="text/html;charset=gb2312"%>
<jsp:directive.page import="cn.sdfi.tools.GetPicNames"/>
<jsp:directive.page import="cn.sdfi.tools.Const"/>
<HTML>
<HEAD>
<TITLE>----请选择餐位图片----</TITLE>
</HEAD>
<BODY background="images/bg2.jpg">

<%
// 获取 指定 目录下的所有以 jpg 结尾的图片名称
String picNames[]=new GetPicNames().getPicNamesEndsWithJpg(Const.SEAT_PIC_PATH);
String path=request.getParameter("path");
for(int i=0;i<picNames.length;i++){
	%>
	<a href="<%=path %>?newPicture=<%=picNames[i] %>">
	<IMG SRC="images/seat/<%=picNames[i] %>" WIDTH="80" HEIGHT="80" BORDER=0 ALT="">
	</a>
<%
}
%>
</BODY>
</HTML>
