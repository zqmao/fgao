<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page language="java" import="base.api.User"%>
<% 
	String backUrl = request.getParameter("backUrl");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录页面</title>
<link rel="stylesheet" type="text/css" href="themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="themes/icon.css" />
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript">
		function submit() {
			$('#login').form('submit', {
			    url:'/userServlet.do?sign=login',
			    success:function(data){
			    	var data = eval('(' + data + ')');
			    	if(data.result == 0){
			    		alert(data.reason);
			    	}else{
			    		window.location.href='<%=backUrl%>';
			    	}
			    }
			});
		}
	</script>
</head>
<body>
<div class="easyui-panel" title="登录" style="width: 400px; height: 300px;padding: 10px;margin:0 auto;text-align:center" >
	<form id="login" method="post">
	
		帐号：<input type="text" name="name"/>
		<br/>
		<br/>
		密码：<input type="password" name="password">
		<br/>
	
	</form>
	<input type="button" value="登录" onclick="submit();">
</div>
</body>
</html>