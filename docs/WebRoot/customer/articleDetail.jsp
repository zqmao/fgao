<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String articleId = (String) request.getParameter("articleId");
	if(articleId == null){
		articleId = "";
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>文章详情</title>
		<link rel="stylesheet" type="text/css" href="../easyUi/themes/default/easyui.css" />
		<link rel="stylesheet" type="text/css" href="../easyUi/themes/icon.css" />
		<script type="text/javascript" src="../easyUi/jquery.min.js"></script>
		<script type="text/javascript" src="../easyUi/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="../easyUi/easyui-lang-zh_CN.js"></script>
		<script type="text/javascript">
			initArticle();
		    function initArticle(){
		    	var articleId = <%=articleId%> + "";
		    	if(articleId == ""){
		    		return;
		    	}
		    	$.ajax({
                    type: "POST",
                    url: "../documentServlet.do?sign=query&id="+articleId,
                    success: function(msg) {
                    	var data = eval('('+msg+')');
                    	$("#content").html(data.data.content);
                    	$("#title").html(data.data.title);
                    	$("#user").html(data.data.userName);
                    	$("#time").html(data.data.time);
                    },
                    error: function(msg) {
                        alert(msg.toString());
                    }
            	});
		    }
		</script>
	</head>
  
  <body class="easyui-layout">
		<div id="addArticle" class="easyui-panel" title="文章详情" style="width: 100%;height: 100%; padding-top: 10px;padding-bottom: 10px;padding-left: 5%;padding-right: 5%;">
			<h1 align="center"><span id="title"></span></h1>
			<hr/>
			<div align="center" style="padding: 20px;">
				<font size="4" color="#278080"><span id="user"></span></font>&nbsp;&nbsp;<font size="4">创建于</font>&nbsp;&nbsp;<font size="4" color="#278080"><span id="time"></span></font>
			</div>
			<div id="content" style="text-indent: 20px;"></div>
		</div>
	</body>
</html>
