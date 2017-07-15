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
			    success:function(result){
			    	var data = eval('(' + result + ')');
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
	<style> 
	body{ text-align:center} 
	.div{ margin:0 auto; width:400px; height:100px;} 
	.sign-in-button {
	    background: #1E90FF;
	    width: 50%;
	    padding: 9px 18px;
	    font-size: 18px;
	    border: none;
	    border-radius: 4px;
	    color: #fff;
	    cursor: pointer;
	    margin-top: 10px;
	}
	</style>
</head>
<body style="background-image:url(/image/login_bg.jpg)">
	<div class="div" style="margin-top: 200px;">
		<div class="easyui-panel" title="登录" style="width: 400px; height: 300px;padding-top:80px;margin:0 auto;text-align:center" >
			<form id="login" method="post">
			
				<font size="3" color="#1E90FF"><b>帐号：</b></font>
				<input type="text" name="name" class="easyui-validatebox" data-options="required:true"/>
				<br/>
				<br/>
				<font size="3" color="#1E90FF"><b>密码：</b></font>
				<input type="password" name="password" class="easyui-validatebox"  data-options="required:true"/>
				<br/>
			
			</form>
			<input type="button" value="登录" onclick="submit();" class="sign-in-button"/>
		</div>
    </div>
	
</body>
</html>