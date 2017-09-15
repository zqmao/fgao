<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="base.util.*"%>
<%@ page language="java" import="base.api.*"%>
<%
	User user = PermissionUtil.getCurrentUser(request, response);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>默认页面</title>
<script src="script/jquery-1.11.1.min.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="css/templatecss.css"/>
<script type="text/javascript">
	$(document).ready(function(){
	  //请求当前人员的签到和签退状态，刷新按钮
		$.ajax({
            type: "POST",
            url: "../signRecordServlet.do?sign=query",
            success: function(msg) {
            	var data = eval('('+msg+')');
            	if(data.result == 0){
            		alert(data.reason);
            	}else{
            		if(data.data == "00"){
            			disableSignIn(true)
            			disableSignOut(true);
            		}else if(data.data == "01"){
            			disableSignIn(true)
            			disableSignOut(false);
            		}else if(data.data == "10"){
            			disableSignIn(false)
            			disableSignOut(true);
            		}else if(data.data == "11"){
            			disableSignIn(false)
            			disableSignOut(false);
            		}
            	}
            }
        });
	})
	function signIn(){
		$.ajax({
            type: "POST",
            url: "../signRecordServlet.do?sign=signIn",
            success: function(msg) {
            	var data = eval('('+msg+')');
            	if(data.result == 0){
            		alert(data.reason);
            	}else{
            		alert("签到成功");
            		disableSignIn(false);
            	}
            }
        });
	}
	
	function signOut(){
		$.ajax({
            type: "POST",
            url: "../signRecordServlet.do?sign=signOut",
            success: function(msg) {
            	var data = eval('('+msg+')');
            	if(data.result == 0){
            		alert(data.reason);
            	}else{
            		alert("签退成功");
            		disableSignOut(false);
            	}
            }
        });
	}
	
	function disableSignIn(disable){
		if(disable){
			$("#signIn").text("签到");
		}else{
			$("#signIn").text("已签到");
			$("#signIn").parent().css("background-color","#b9c7cc");	
		}
		
	}
	
	function disableSignOut(disable){
		if(disable){
			$("#signOut").text("签退");
		}else{
			$("#signOut").text("已签退");
			$("#signOut").parent().css("background-color","#b9c7cc");
		}
	}
</script>
</head>

<body>
	<div style="width: 100%; height: 100px;">
		<div>
			<h4>
				<strong><%=user.getName()%>，</strong>
			</h4>
			<p>欢迎登录管理系统！</p>
		</div>
		<div style="height: 80px;">
			<p id="xq">星期二</p>
			<p>
				<span><b id="year">2016</b></span>年<b id="month">8</b>月<b id="day">23</b>日
			</p>
		</div>
		<div style="height: 50px;">
			<strong id="sj">9:00</strong>
		</div>
		<script language="JavaScript">
			clock();
			setInterval("clock()", 10000);
			function clock() {
				var t = new Date()
				var xq = "星期" + "日一二三四五六".charAt(new Date().getDay());
				$("#xq").text(xq);
				$("#year").text(t.getFullYear());
				$("#month").text(t.getMonth() + 1);
				$("#day").text(t.getDate());
				var h = t.getHours(); //获取当前小时数(0-23)
				var m = t.getMinutes();
				if(m < 10){
					m = "0" + m;
				}
				$("#sj").text(h + ":" + m);
			}
		</script>
		
		<div class="margin-tb manage-detail-con clearfix" >
			<table>
				<tr>
					<td>
						<a class="custom" onclick="signIn();" style="line-height:50px;height:50px;"><b id="signIn">签到</b></a>
					</td>
					<td>
						<a class="recharge" onclick="signOut();" style="line-height:50px;height:50px;"><b id="signOut">签退</b></a>
					</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>
