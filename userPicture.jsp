<%@ page contentType="text/html;charset=gb2312"%>
<jsp:directive.page import="cn.sdfi.tools.GetPicNames"/>
<jsp:directive.page import="cn.sdfi.tools.Const"/>
<HTML>
<HEAD>
<TITLE>----��ѡ����ϲ����ͷ��----</TITLE>
</HEAD>
<BODY background="images/bg2.jpg">
<h2 align="center">��ѡ����ϲ����ͷ��</h2>
<hr>

<%
String path=request.getParameter("path");

// ��ȡ ָ�� Ŀ¼�µ������� jpg ��  gif ��β��ͼƬ����
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
