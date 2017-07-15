<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="base.util.*"%>
<%
	int userId = PermissionUtil.check(request, response);
%>

<html>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>修改个人信息</title>
	<link rel="stylesheet" type="text/css" href="../easyUi/themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="../easyUi/themes/icon.css" />
	<script type="text/javascript" src="../easyUi/jquery.min.js"></script>
	<script type="text/javascript" src="../easyUi/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../easyUi/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="../js/clipboard.min.js"></script>

	
	<script type="text/javascript">
            $(function() {
            	$("#editUser").panel({
                	title: '修改个人信息',
                	tools:[{
        				text:'保存',
        				iconCls:'icon-ok',
        				handler:function(){
        					submitAdd();
        				}
        			}]
                });
            });
            
            document.onkeydown = function(event_e){
				if(window.event) {
					event_e = window.event;
				}
				var int_keycode = event_e.charCode||event_e.keyCode;
				if( int_keycode == '13' ) {
					submitAdd();
					return false;
				}
			};
            
            function submitAdd() {
				$("#editUserForm").form('submit', {
				    url:"../userServlet.do?sign=edit",
				    success:function(result){
				    	var data = eval('(' + result + ')');
				    	if(data.result == 0){
				    		alert(data.reason);
				    	}else{
							$("#editUserForm").form('clear');
							alert("修改成功");
				    	}
				    }
				});
			}
            
        </script>
	</head>

	<body class="easyui-layout">
		<div id="editUser" class="easyui-panel" title="修改个人信息" style="width: 100%; height: 400px;padding: 10px;">
			<form id="editUserForm" method="post">
				<table style="width: 100%">
				    <tr >
						<td style="width:100px;"><label>原密码:</label></td>
						<td style="width:100px;height:30px;"><input class="easyui-textbox" type="password" name="originPassword"/></td>
						<td style="width:100px;height:30px;"><label>*修改密码必填</label></td>
				    </tr>
				    <tr >
						<td style="width:100px;"><label>新密码:</label></td>
						<td style="width:100px;height:30px;"><input class="easyui-textbox" type="password" name="newPassword" /></td>
						<td><label>*修改密码必填</label></td>
				    </tr>
				    <tr >
						<td style="width:100px;"><label>确认密码:</label></td>
						<td style="width:100px;height:30px;"><input class="easyui-textbox" type="password" name="confirmPassword"/></td>
						<td><label>*修改密码必填</label></td>
				    </tr>
				    <tr >
						<td style="width:100px;"><label>手机号:</label></td>
						<td style="width:100px;height:30px;"><input class="easyui-textbox" type="text" name="phone" /></td>
						<td><label>*不填不会修改</label></td>
				    </tr>
			    </table >
			</form>
		</div>
	</body>
</html>
