<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<jsp:include page="includes/encoding.jsp" flush="true" />
<jsp:include page="includes/adminCheck.jsp" flush="true" />
<html>
	<head>
		<title>后台管理</title>
	</head>
	<frameset cols="18%,92%" border="1" >
		<frame src="menu.jsp" scrolling="auto" name="left">
		<frameset rows="85%,15%" border="0.5">
			<frame src="welcome.jsp" scrolling="auto" name="show">
			<frame src="includes/copyright.jsp" scrolling="auto" name="copyRight">
		</frameset>
		<noframes>
			<body>
				你的浏览器不支持页面分割！！！
			</body>
		</noframes>

	</frameset>
</html>
