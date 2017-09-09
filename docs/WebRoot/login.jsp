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
	<link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
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
			    				backUrl = "<%=basePath%>/customer/index.jsp";
			    			}else{
			    				backUrl = "<%=basePath%>/admin/index.jsp";
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
        html,body{
            background: #f1f1f1;
            margin: 0;
        }
        body,input{font-family: Arial,Microsoft YaHei,sans-serif;} 
        ul,ol{margin: 0;padding: 0;}
        li{list-style: none;}

        #view{
            width: 100%;height: 100%;
            background: url("image/login_bg.jpg") no-repeat center;
            position: relative;
            overflow: hidden;
        }
        .loginPage{
            width: 36%;height: 100%;
            background: url("image/login_bg_thumb.jpg") no-repeat center;
            background-size: cover;
            background-attachment: fixed;
            position: absolute;right: 0;top: 0;
        }
        .loginBox{
            width: 50%;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 8px rgba(0,0,0,0.1);
            position: absolute;top: 36%;left: 22%;
            padding: 40px 4%;
        }
        .zx_title{
            font-size: 18px;color: #3194d0;font-weight: bold;
            text-align: center;
        }
        .zx_form{
            width: 100%;
            border: 1px solid #c8c8c8;
            border-radius: 4px;
            margin-top: 20px;
            overflow: hidden;
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
            display: block;
            float: left;
            width: 16px;height: 16px;
            margin: 2px 6px 0 0;
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
            display: block;
            overflow: hidden;
        }
        .zx_form li input[type=text],.zx_form li input[type=password]{
            width: 100%;line-height: 22px;
            font-size: 14px;
            background: transparent;
            border: none;
            outline: none;
        }
        .sign-in-button{
            display: block;
            width: 100%;
            font-size: 18px;color: #fff;
            background: #3194d0;
            border: none;
            border-radius: 4px;
            margin: 35px auto 0;
            padding: 9px 18px;
            cursor: pointer;
        }
        .sign-in-button:hover{
            background: #187cb7;
        }

    </style>
</head>
<body>
	<div id="view">
        <div class="loginPage">
            <div class="loginBox">
                <div class="zx_title">登录</div>
                <form id="login" method="post">
                    <div class="zx_form">
                    	<ul>
	                        <li class="zx_li1">
	                            <i></i>
	                            <label>
	                                <input type="text" name="name" placeholder="手机号或邮箱" class="easyui-validatebox" data-options="required:true"/> 
	                            </label>
	                        </li>
	                        <li class="zx_li2">
	                            <i></i>
	                            <label>
	                                <input type="password" name="password" placeholder="密码" class="easyui-validatebox"  data-options="required:true"/>
	                            </label>
	                        </li>
                        </ul>
                    </div>
                </form>
                <input type="button" value="登录" onclick="submit();" class="sign-in-button"/>
            </div>
        </div>
    </div>
	
</body>
</html>