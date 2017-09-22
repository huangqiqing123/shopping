<%@ page contentType="text/html;charset=gb2312"%>
<jsp:directive.page import="cn.sdfi.tools.GetPicNames"/>
<jsp:directive.page import="cn.sdfi.tools.Const"/>
<HTML>
<HEAD>
<TITLE>----请选择你喜欢的头像----</TITLE>
</HEAD>
<BODY background="images/bg2.jpg">
<h2 align="center">请选择你喜欢的头像</h2>
<hr>

<%
String path=request.getParameter("path");

// 获取 指定 目录下的所有以 jpg 或  gif 结尾的图片名称
String picNames[]=new GetPicNames().getPicNamesEndsWithJpg(Const.USER_PIC_PATH);
for(int i=0;i<picNames.length;i++){
%>
	<a href="<%=path %>?picture=<%=picNames[i] %>">
	<IMG SRC="images/user/<%=picNames[i] %>" WIDTH="50" HEIGHT="50" BORDER=0 ALT="">
	</a>
<%
}
%>
<hr>
<jsp:include page="includes/copyright.jsp" flush="true" />
<jsp:include page="includes/alert.jsp" flush="true" />
</BODY>
</HTML>
