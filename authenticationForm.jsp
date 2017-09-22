<%@ page contentType="text/html;charset=GBK" %>
<%@ page import="org.loushang.cas.client.login.*"%>

<%
String formUserIdKey = LoginServlet.FORM_USER_ID_KEY;
String formPasswordKey = LoginServlet.FORM_PASSWORD_KEY;
String userId = (String)request.getAttribute(formUserIdKey);
String password = (String)request.getAttribute(formPasswordKey);
if(userId==null)  
	userId = "";
if(password==null) 
	password = "";
String j_auth_action = request.getContextPath()+LoginServlet.AUTHENTICATION_URL;
%>
<form name="form1" method="post" action="<%=j_auth_action%>">
	<input type="text" name="<%=formUserIdKey%>" value="<%=userId%>"/>
	<input type="text" name="<%=formPasswordKey%>" value="<%=password%>"/>
</form>
<script language="javascript">
function submitToService(){
	document.forms[0].action = "<%=j_auth_action%>";
	document.forms[0].submit();
}
alert('<%=userId%>');
submitToService();
</script>