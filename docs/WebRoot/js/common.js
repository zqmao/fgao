function getClipboard() {
	alert("hello");
}

var editor;
function initKindEditor(domId){
	KindEditor.ready(function(K) {
		editor = K.create('#'+domId, {
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
}

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
function initArticle(articleId){
	if(articleId == ""){
		editor.html("");
		return;
	}
	$.ajax({
        type: "POST",
        url: "../documentServlet.do?sign=query&id="+articleId,
        success: function(msg) {
        	editor.html("");
        	var data = eval('('+msg+')');
        	editor.insertHtml(data.data.content);
        	$("#title").val(data.data.title);
        },
        error: function(msg) {
            alert(msg.toString());
        }
	});
}