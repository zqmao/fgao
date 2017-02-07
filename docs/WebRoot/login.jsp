<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page language="java" import="base.api.User"%>
<% 
	String backUrl = request.getParameter("backUrl");
	if(backUrl == null){
		backUrl = "";
	}
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>登录页面</title>
	<link rel="stylesheet" type="text/css" href="easyUi/themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="easyUi/themes/icon.css" />
	<script type="text/javascript" src="easyUi/jquery.min.js"></script>
	<script type="text/javascript" src="easyUi/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="easyUi/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript">
		function submit() {
			$("#login").form("submit", {
			    url:"/userServlet.do?sign=login",
			    success:function(data){
			    	var data = eval('(' + data + ')');
			    	if(data.result == 0){
			    		alert(data.reason);
			    	}else{
			    		var backUrl = "<%=backUrl%>";
			    		if(backUrl === ""){
			    			if(data.data.admin == 0){
			    				backUrl = "<%=basePath%>/customer/main.jsp";
			    			}else{
			    				backUrl = "<%=basePath%>/admin/main.jsp";
			    			}
			    		}
		    			window.location.href=backUrl;
			    	}
			    }
			});
		}
		document.onkeydown = function(event_e){
			if(window.event) {
				event_e = window.event;
			}
			var int_keycode = event_e.charCode||event_e.keyCode;
			if( int_keycode == '13' ) {
				submit();
				return false;
			}
		};
	</script>
</head>
<body>
<div class="easyui-panel" title="登录" style="width: 400px; height: 300px;padding: 10px;margin:0 auto;text-align:center" >
	<form id="login" method="post">
	
		帐号：<input type="text" name="name" class="easyui-validatebox" data-options="required:true"/>
		<br/>
		<br/>
		密码：<input type="password" name="password" class="easyui-validatebox"  data-options="required:true"/>
		<br/>
	
	</form>
	<input type="button" value="登录" onclick="submit();">
</div>
</body>
</html>