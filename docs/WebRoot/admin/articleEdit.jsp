<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="base.util.*"%>
<%
	PermissionUtil.checkAdmin(request, response);
	String articleId = (String) request.getParameter("articleId");
	if(articleId == null){
		articleId = "";
	}
	String categoryId = (String) request.getParameter("categoryId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>文章编辑</title>
		<link rel="stylesheet" type="text/css" href="../themes/default/easyui.css" />
		<link rel="stylesheet" type="text/css" href="../themes/icon.css" />
		<link rel="stylesheet" href="../kindEditor/themes/default/default.css" />
		<script charset="utf-8" src="../js/common.js"></script>
		<script charset="utf-8" src="../kindEditor/kindeditor-min.js"></script>
		<script charset="utf-8" src="../kindEditor/lang/zh_CN.js"></script>
		<script type="text/javascript" src="../js/jquery.min.js"></script>
		<script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="../js/easyui-lang-zh_CN.js"></script>
		<script type="text/javascript">
			var editor;
			KindEditor.ready(function(K) {
				editor = K.create('#content', {
					resizeType : 1,
					allowPreviewEmoticons : false,
					allowImageUpload : true,
					allowImageRemote : false,
					items : [ 'forecolor', 'hilitecolor', 'bold', '|', 'image' ],
					afterCreate : function() {
						K(this.edit.doc).bind('paste', function (e) {  
					    	var blob;
					    	if (window.clipboardData) {//ie
								for (var i = 0; i < window.clipboardData.files.length; i++) {  
					                blob = window.clipboardData.files[0];  
					                break;  
						        }
							}else{//chrome firefox
						    	var file;
						    	for (var i = 0; i < e.event.clipboardData.items.length; i++) {  
						            if (e.event.clipboardData.items[i].kind === "file") {  
						                file = e.event.clipboardData.items[i];  
						                break;  
						            }  
						        }
						        if(file){
							        blob = file.getAsFile();
						        }
							}
							if(blob){
								if(blob.type != "image/png"){
									alert("文件类型错误");
									e.stop();
									return;
								}
					            if (blob.size === 0) {
					                return;
					            }else{
					            	e.stop();//阻止某些浏览器把图片以base64放进去
					            	uploadCopy(blob);
					            }
							}else{
								return;
							}
					    });
					}
				});
			});
			initArticle();
			function uploadCopy(blob){
				blobToDataURL(blob, function(result){
					$.ajax({
	                    type: "POST",
	                    url: "../uploadCopyServlet.do",
	                    data: "image=" + result,
	                    success: function(msg) {
	                    	var data = eval('('+msg+')');
	                    	var insert = "<img src='"+data.url+"'/>";
	                    	editor.insertHtml(insert);
	                    },
	                    error: function(msg) {
	                        alert(msg.toString());
	                    }
                	});
				});
			}
		    function blobToDataURL(blob, callback) {
		        var a = new FileReader();
		        a.onloadend = function (e) { 
		        	callback(encodeURIComponent(a.result)); 
		        };
		        a.readAsDataURL(blob);
		    }
		    
		    function submitAdd() {
		    	$("#content").val(encodeURIComponent(editor.html()));
				$("#addArticleForm").form("submit", {
				    url:"../documentServlet.do?sign=add",//&content=" + encodeURIComponent(editor.html()),
				    success:function(data){
				    	var data = eval('(' + data + ')');
				    	if(data.result == 0){
				    		alert(data.reason);
				    	}else{
				    		alert(data.data);
				    	}
				    }
				});
			}
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
                    	editor.insertHtml(data.data.content);
                    	$("#title").val(data.data.title);
                    },
                    error: function(msg) {
                        alert(msg.toString());
                    }
            	});
		    }
		</script>
	</head>
	<body class="easyui-layout">
		<div id="addArticle" class="easyui-panel" title="文章编辑" style="width: 100%; padding: 10px;">
			<form id="addArticleForm" method="post">
				<input type="hidden" name="articleId" value="<%=articleId %>" />
				<input type="hidden" name="categoryId" value="<%=categoryId %>" />
				<table>
					<tr >
						<td>标题:</td>
						<td><input class="easyui-validatebox" style="width: 700px;padding: 5px;" id="title" name="title" type="text"  data-options="required:true"/><td>
				    </tr>
				    <tr >
						<td>正文:</td>
						<td>
							<textarea name="content" id="content" style="width: 700px; height: 450px; visibility: hidden;"></textarea>
						<td>
				    </tr>
				    <tr >
						<td colspan="2" align="center" style="padding-top: 20px;">
							<a href='javascript:;' class='l-btn l-btn-small l-btn-plain' onclick='submitAdd();'>
								<span class='l-btn-left l-btn-icon-left'>
									<span class='l-btn-text'>保存</span>
									<span class='l-btn-icon icon-save'>&nbsp;</span>
								</span>
							</a>
						</td>
				    </tr>
			    </table>
			</form>
		</div>
	</body>
</html>
