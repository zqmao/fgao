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
				$("#sj").text(h + ":" + m);
			}
		</script>
	</div>
</body>
</html>
