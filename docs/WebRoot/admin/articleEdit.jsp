<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>Simple Examples</title>
		<link rel="stylesheet" href="../kindEditor/themes/default/default.css" />
		<script charset="utf-8" src="../js/common.js"></script>
		<script charset="utf-8" src="../kindEditor/kindeditor-min.js"></script>
		<script charset="utf-8" src="../kindEditor/lang/zh_CN.js"></script>
		<script type="text/javascript" src="../js/jquery.min.js"></script>
		<script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
		<script type="text/javascript">
			var editor;
			KindEditor.ready(function(K) {
				editor = K.create('textarea[name="content"]', {
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
		</script>
	</head>
	<body>
		<h3>
			默认模式
		</h3>
		<form>
			<textarea name="content" id="content"
				style="width: 700px; height: 200px; visibility: hidden;">KindEditor</textarea>
		</form>
	</body>
</html>
