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
	body,input{font-family: -apple-system,SF UI Text,Arial,PingFang SC,Hiragino Sans GB,Microsoft YaHei,WenQuanYi Micro Hei,sans-serif;} 
        ul,ol{margin: 0;padding: 0;}
        li{list-style: none;}
        .loginBox{
            width: 400px;
            background-color: #fff;
            border-radius: 4px;
            box-shadow: 0 0 8px rgba(0,0,0,0.1);
            padding: 30px 0;
            margin: 30px auto 0;
        }
        .zx_title{
            font-size: 18px;color: #ea6f5a;font-weight: bold;
            text-align: center;
        }
        .zx_form{
            width: 250px;
            border: 1px solid #c8c8c8;
            border-radius: 4px;
            margin: 45px auto 0;
        }
        .zx_form li{
            font-size: 0;
            border-top: 1px solid #c8c8c8;
            padding: 10px;
        }
        .zx_form li:first-child{
            border-top: none;
        }
        .zx_form li i{
            display: inline-block;
            width: 16px;height: 16px;
            margin-right: 6px;
            vertical-align: middle;
        }
        .zx_form li:nth-child(1) i{
            background: url("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAoBAMAAAB+0KVeAAAALVBMVEUAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADBoCg+AAAAD3RSTlMAQDEsOicTITYXDgkdBibh7sAjAAAAzklEQVQoz5XSvQ3CMBCG4csPCSQC6fJDEAKJNHRIpKF3Cw1sABswAukpwiZQMAEdFSNh+yTQ2UXgLR99rs7wf3eBSWNYD2W5gQdUHTkKjVPjtW7CcECYt2NIWDAMCIftSwcphj5ZxrBLOGLoEaYM+6XGBbAuGhuON41Xjq6yBHixkLgBo0ri0sRS4uyXZVxLXHOLKlSt2IlKpM6vz+whiGTpkyxQs29zjTvkbaV10CinD2O0B6gtPEGEVmMIbSzAtTEB38YMHLQDzxQ6tN0bin8lqCE/hG0AAAAASUVORK5CYII=") no-repeat;
            background-size: 100% 100%;
        }
        .zx_form li:nth-child(2) i{
            background: url("data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAoBAMAAAB+0KVeAAAAMFBMVEUAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABaPxwLAAAAEHRSTlMAQD0bLjMVCik5Ng4mIAYw9Fdu/AAAAOFJREFUKM9joBLI+Dm1+QGamKUgEOiiij0VBIPZyGLsioIQsAFJkBPIX9EFJMSRBBsFBd0ZGGoEBaWQdAsKCoPoREHBBLggh6DgARDNLCgYABdkEpSEMAKRDC0UlIEwDAXF4IKJMPZGQWEkQWkI46GgLJCEKRCAGg4XZDduFJQ1BoOLgvLGG6DqkAHUeEdkIZinPmIIYqoUJU/Q2QJFEOaSnRiCCUBfoAtKwlkIQUjYGaIJSoBYF9EEhUCshaiC4EhixrBd5gHfRUzHq34i2e8kBvJBVEERsOATJRQQjiP9AwC8uTtyB9PisQAAAABJRU5ErkJggg==") no-repeat;
            background-size: 100% 100%;
        }
        .zx_form li label{
            display: inline-block;
            width: 200px;
            vertical-align: middle;
        }
        .zx_form li input[type=text],.zx_form li input[type=password]{
            width: 100%;line-height: 18px;
            font-size: 14px;
            background: transparent;
            border: none;
            outline: none;
        }
        .sign-in-button{
            display: block;
            width: 250px;
            font-size: 18px;color: #fff;
            background: #3194d0;
            border: none;
            border-radius: 4px;
            margin: 45px auto 0;
            padding: 9px 18px;
            cursor: pointer;
        }
        .sign-in-button:hover{
            background: #187cb7;
        }
	</style>
</head>
<body style="background-image:url(/image/login_bg.jpg)">
	<div class="loginPage" style="margin-top: 200px;">
		<div class="loginBox" title="登录" style="width: 400px; height: 300px;padding-top:80px;margin:0 auto;text-align:center" >
			<div class="zx_title">登录</div>
			<form id="login" method="post">
				<div class="zx_form">
                    <li class="zx_li1">
                        <i></i>
                        <label>
                            <input type="text" name="name" placeholder="帐号" class="easyui-validatebox" data-options="required:true"/> 
                        </label>
                    </li>
                    <li class="zx_li2">
                        <i></i>
                        <label>
                            <input type="password" name="password" placeholder="密码" class="easyui-validatebox"  data-options="required:true"/>
                        </label>
                    </li>
                </div>
			</form>
			<input type="button" value="登录" onclick="submit();" class="sign-in-button"/>
		</div>
    </div>
	
</body>
</html>