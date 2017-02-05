<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>Simple Examples</title>
		<link rel="stylesheet" href="../kindEditor/themes/default/default.css" />
		<script charset="utf-8" src="../kindEditor/kindeditor-min.js"></script>
		<script charset="utf-8" src="../kindEditor/lang/zh_CN.js"></script>
		<script>
			var editor;
			KindEditor.ready(function(K) {
				editor = K.create('textarea[name="content"]', {
					resizeType : 1,
					allowPreviewEmoticons : false,
					allowImageUpload : true,
					allowImageRemote : false,
					items : [
						'forecolor', 'hilitecolor', 'bold',
						'|', 'justifyleft', 'justifycenter',
						'|', 'image']
				});
			});
		</script>
	</head>
	<body>
		<h3>默认模式</h3>
		<form>
			<textarea name="content" style="width:700px;height:200px;visibility:hidden;">KindEditor</textarea>
		</form>
	</body>
</html>
