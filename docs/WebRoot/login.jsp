<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page language="java" import="base.api.User"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录页面</title>
</head>
<% 
	User user = (User)session.getAttribute("loginUser");
	if(user == null){
		out.print("asdasd");
	}else{
		out.print(user.getLoginName());
	}
%>
<body>

<form method="post" action="/userServlet.do?sign=login">

	帐号：<input type="text" name="name"/>
	<br/>
	密码：<input type="password" name="password">
	<br/>
	<input type="submit" value="登录">

</form>

</body>
</html>