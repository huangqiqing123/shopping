<%@ page contentType="text/html;charset=gb2312"%>
<jsp:directive.page import="cn.sdfi.tools.GetPicNames"/>
<jsp:directive.page import="cn.sdfi.tools.Const"/>
<HTML>
<HEAD>
<TITLE>----��ѡ���λͼƬ----</TITLE>
</HEAD>
<BODY background="images/bg2.jpg">

<%
// ��ȡ ָ�� Ŀ¼�µ������� jpg ��β��ͼƬ����
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
