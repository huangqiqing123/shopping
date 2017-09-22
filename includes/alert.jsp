<%
String msg=(String)request.getAttribute("msg");
//request.removeAttribute("msg");
if(!"".equals(msg)&&msg!=null){
out.print("<script>alert('"+msg+"');</script>");
}
%>  