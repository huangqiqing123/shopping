<%@ page contentType="text/html;charset=gb2312"%>
<jsp:directive.page import="cn.sdfi.tools.GetPicNames"/>
<jsp:directive.page import="cn.sdfi.tools.Const"/>
<HTML>
<HEAD>
<TITLE>----��ѡ���ƷͼƬ----</TITLE>

</HEAD>
<BODY background="../images/bg2.jpg">

<%
//���ղ���path��ѡ��ͼƬ�󣬸���path���ص�ԭ����ҳ�档
String path=request.getParameter("path");
//��ȡ ָ�� Ŀ¼�µ����е�ͼƬ����
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
