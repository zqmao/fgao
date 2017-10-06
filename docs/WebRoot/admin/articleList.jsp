<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="base.util.*"%>
<%
	int userId = PermissionUtil.check(request, response);
	boolean edit = false;
	if(userId != 0){
		edit = PermissionUtil.checkEditor(request, response);
	}
%>

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>文章列表</title>
	<link rel="stylesheet" type="text/css" href="../easyUi/themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="../easyUi/themes/icon.css" />
	<script type="text/javascript" src="../easyUi/jquery.min.js"></script>
	<script type="text/javascript" src="../easyUi/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../easyUi/easyui-lang-zh_CN.js"></script>
	<link rel="stylesheet" href="../kindEditor/themes/default/default.css" />
	<script charset="utf-8" src="../kindEditor/kindeditor-min.js"></script>
	<script charset="utf-8" src="../kindEditor/lang/zh_CN.js"></script>
	<script type="text/javascript" src="../js/common.js"></script>
	
	<style type="text/css">
				.titlediv{ 
				font-size: 22px;
				font-family: "Microsoft YaHei";
				border-left: 12px solid #4F9CEE;
				
				display: block;
    font-size: 24px;
    font-family: 'Microsoft YaHei', SimHei, Verdana;
    font-weight: 500;
    line-height: 22px;
    text-indent: 0px;
    clear: both;
    zoom: 1;
    position: relative;
    border-left: 12px solid rgb(79, 156, 238);
    background: url("http://baike.bdimg.com/static/wiki-lemma/normal/resource/img/paraTitle-line_c5e6d61.png");
    overflow: hidden;
				
				}
				.alldiv{
				margin-left:20px;
				margin-right:20px;
				
				}
				.contentdiv{
				
				font-size: 16px;
				}
				.indexHref{
				margin-right:20px;
				text-decoration:none;
				font-weight:bold;
				 line-height:40px;	
				}
				
				.hrefdiv a:link{color: black}
				.hrefdiv a:visited{color: black}
				.hrefdiv a:hover{color: #4f9cee}
				.hrefdiv a:active{color: black}
				
				
				.hrefdiv{
				margin-left:20px;
				margin-right:20px;
				}
				#titleSty{
				font-weight:bold;	
				padding-top: 10px;
				}
				.titlediv{
					height:30px;
					margin-top: 8px;
				    line-height: 30px;
				}
				.rotate{
				-webkit-transform: rotate(180deg);
			}
</style>
	<script type="text/javascript">
		var categoryId = "";
		var key = "";
		var first = 1;
		//$("#addArticle").hide();
		
		$(function() {
			$('#addArticle').dialog({
			    width:800,
			    height:600,
			    modal:true,
			    buttons:[{
			    	text:'保存',
			    	iconCls:'icon-add',
				    handler:function(){
				    	submitAdd();
				    }
				},{
					text:'取消',
				    iconCls:'icon-cancel',
				    handler:function(){
				    	$("#addArticle").dialog("close");
				    }
			    }]
			});
			$('#addArticle').dialog("close");
			
			
			$('#tt').tree({
				url: '../userCategoryServlet.do?sign=listByUser&userId=<%=userId%>',
				loadFilter: function(data){
					return data.data;
				},
				onLoadSuccess: function(node, data){
					var node = $('#tt').tree('find', data[0].id);
					$('#tt').tree('select', node.target);
				},
				onSelect: function(node){
					categoryId = node.id;
					if(first == 0){
						//var queryParams =$("#articleGrid").datagrid("options").queryParams;
						//queryParams.categoryId = categoryId;
						//$("#articleGrid").datagrid("reload");
					
						aticleReload(categoryId,key);
						
						
					}else{
						//loadTableData();
					}
					first = 0;
				}
			});
			
			
		});
		function aticleReload(categoryId,key){
                     $.ajax({
                         type: "POST",
                         url: "../documentServlet.do?sign=list",
                         
                         data: "categoryId=" + categoryId +"&key="+key,
                        
                         
                         success: function(msg) {
                        	 var jsonmsg=$.parseJSON( msg );
                        	 datajson=jsonmsg.data.rows;
                        	 var articleHtml='';
                        	 var indexHtml="";
                        	 var i=1;
                        	 var j=1;
                        	 
                        	 $.each(datajson, function(idx, obj) {
                         		/*  alert(obj.title);
                         		 alert(obj.content); */
                         		 articleHtml = articleHtml+"</br><div class='alldiv' id	='"+"ahref"+i+"'>"+"<div class='titlediv'><span style='background:#ffffff'>&nbsp;&nbsp;"+i+"."+obj.title+"&nbsp;</span>"
                         		 +"<img class='apear' style='height: 16px;right: 0px;position: absolute;top: 3px;cursor: pointer; display:none;' onclick='apear(this)' src='../img/jiantou.jpg'>"
                         		 +"<img class='disapear' style='height: 16px;right: 0px;position: absolute;top: 3px;cursor: pointer;' onclick='disapear(this)' src='../img/jiantou2.jpg'>"
                         		 +"<span style='height: 15px;right: 40px; position: absolute;top: -3px;font-size: 16px;cursor: pointer;' onclick='contenteditor(this)' >&nbsp;编辑&nbsp;</span>"
                         		 +"<input type='hidden' name='articleId' value='"+obj.id+"' />"
                         		 +"</div>"
                         		 +"</br><div class='cotentdiv'>"+obj.content+"</div>"+"</div>";   
                         		 i++;
                         		});
                        	 $.each(datajson, function(idx, obj) {
                        		/*  alert(obj.title);
                        		 alert(obj.content); */
                        		 indexHtml = indexHtml+"<a class='indexHref' href='#"+'ahref'+j+"'>"+j+'.'+obj.title+"</a>"
                        		 j++;
                        		});
                        	 indexHtml="<div class='hrefdiv'><p style='height:40px;' id='titleSty'>标题目录:</p>"+indexHtml+'</div>';
                        	 
                        	 var methodHtml = '<input type="button" id="submission" value="隐藏" onclick="contenthide();" style="padding: 5px; width: 50px;margin-left: 18px; margin-top: 10px;color: rgba(245, 245, 245, 0.98); background-color: #4F9CEE;border-radius: 5px;">'
                        	 				+'<input type="button" id="submission" value="显示" onclick="contentshow();" style="padding: 5px; width: 50px;margin-left: 10px; margin-top: 10px;color: rgba(245, 245, 245, 0.98); background-color: #4F9CEE;border-radius: 5px;">'
                        	 				+'<input type="button" id="submission" value="新增" onclick="addeditor('+categoryId+');" style="padding: 5px; width: 50px;margin-left: 10px; margin-top: 10px;color: rgba(245, 245, 245, 0.98); background-color: #4F9CEE;border-radius: 5px;">'
                        	 				+'<input class="easyui-validatebox" style="width: 100px;padding: 5px;margin-left: 30px;" id="key" type="text"/>'
                        	 				+'<input type="button" id="submission" value="搜索" onclick="searchditor();" style="padding: 5px; width: 50px;margin-left: 10px; margin-top: 10px;color: rgba(245, 245, 245, 0.98); background-color: #4F9CEE;border-radius: 5px;">';
                        	 articleHtml=indexHtml+methodHtml+articleHtml;
                        	 $("#zz").html(articleHtml);
                  /*       	 var data = eval(msg);
                        	
                        	 alert(result);
                        	 alert(result+"---result");  */
                        	 /* for(var i ,i<result.length,i++){
                        		 
                        	 } */
                        
                         },
                         error: function(msg) {
                             alert(msg.toString());
                         }
                     });
                 
            
		}
		//搜索
		function searchditor(){
			key = $("#key").val();
			aticleReload(categoryId,key);
			$("#articleGrid").datagrid("reload");
		}
		//新增
		function addeditor(){
			editor.html("");
        	$("#addArticleForm").form('clear');
        	$("#addArticleForm").form('load', {
        		categoryId: categoryId
            });
			$('#addArticle').dialog('open');
		}
		//编辑
		function contenteditor(obj){
			if(<%=edit%>){
				var articleId = $(obj).next().val();
				$("#addArticle").parent().css("position","fixed");
				 initArticle(articleId);
	             $("#addArticleForm").form('clear');
	             $("#addArticleForm").form('load', {
	            	
	         		categoryId: categoryId,
	         		articleId: articleId
	             });
					$('#addArticle').dialog('open');
			}else{
				alert("你没有编辑权限");
			}
				
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
		function disapear(obj){
			 $(obj).hide();
			 $(obj).prev().show();
			 $(obj).parent().next().next().hide();
			
    		/*  $("img").click(function(){
    			  $("img").addClass("rodata");
    			 src = $(obj).attr("src");
         		alert(src);
         		  var html = "<img style='height:100%;width:100%;' onclick='changeHide(this)' onclick='changehide()' src='"+src+"'>";
         		 $("#searchId").html(html);
    		 });  */
		}
		function apear(obj){
			$(obj).next().show();
			 $(obj).hide();
			 
			 $(obj).parent().next().next().show();
		}
		function contenthide(){
			$(".cotentdiv").hide();
			$(".apear").show();
			$(".disapear").hide();
		}
		function contentshow(){
			$(".cotentdiv").show();
			$(".apear").hide();
			$(".disapear").show();
		}
		/* function loadTableData(){
			
			$("#articleGrid").datagrid({
                selectOnCheck: true,
                checkOnSelect: true,
                pagination: true,
                url: "../documentServlet.do?sign=list",
                queryParams:{categoryId : categoryId, key : key},
                
                
                
               frozenColumns: [[
                        {field: 'ck', checkbox: true},
                        {title: '序号', field: 'id', width: 60},
                        {title: '分类', field: 'categoryId', width: 0, align: 'center', hidden:true},
                        {title: '分类', field: 'categoryName', width: 120, align: 'center'},
                        {title: '标题', field: 'title', width: 300, align: 'center'},
                        {title: '作者', field: 'userName', width: 120, align: 'center'},
                        {title: '创作时间', field: 'time', width: 180, align: 'center'},
                        {title: '预览', field: 'opt', width: 100, align: 'center',
                        	formatter: function(value, rowData, rowIndex) {
                            	return "<a href='articleDetail.jsp?articleId="+rowData.id+"' target='_blank' style='color:red'>文章预览</a>";
                        	}
                        }
                    ]], 
                loadFilter: function(data){
               		if (data.data){
               			return data.data;
               		} else {
               			return data;
               		}
               	},
                toolbar: [{
                	id: 'add',
                    iconCls: 'icon-add',
                    text: '增加',
                    handler: function() {
                    	//window.open("/admin/articleEdit.jsp?categoryId=" + categoryId);
                    	editor.html("");
                    	$("#addArticleForm").form('clear');
                    	$("#addArticleForm").form('load', {
                    		categoryId: categoryId
                        });
						$('#addArticle').dialog('open');
                    }
                }, {
                    iconCls: 'icon-edit',
                    text: '修改',
                    handler: function() {
                        var ids = getChecked("articleGrid");
                        var len = ids.length;
                        if (len == 0) {
                            $.messager.alert('提示', '至少选择一个', 'Warning');
                        } else if (len > 1) {
                            $.messager.alert('提示', '只能选择一个', 'Warning');
                        } else {
                            var row = $("#articleGrid").datagrid("getChecked");
                            var articleId = row[0].id;
                            var categoryId = row[0].categoryId;
                            //window.open("/admin/articleEdit.jsp?articleId=" + articleId + "&categoryId=" + categoryId);
                            initArticle(articleId);
                            $("#addArticleForm").form('clear');
                            $("#addArticleForm").form('load', {
                        		categoryId: categoryId,
                        		articleId: articleId
                            });
    						$('#addArticle').dialog('open');
                        }
                    }
                }, {
                    iconCls: 'icon-remove',
                    text: '删除',
                    handler: function() {
                        var ids = getChecked("articleGrid");
                        var len = ids.length;
                        if (len == 0) {
                            $.messager.alert('提示', '至少选择一个', 'Warning');
                        } else {
                            $.messager.confirm('Confirm', '确认要删除选择的项吗？', function(r) {
                                if (r) {
                                    $.ajax({
                                        type: "POST",
                                        url: "../documentServlet.do?sign=delete",
                                        data: "articleIds=" + ids,
                                        success: function(msg) {
                                            $("#articleGrid").datagrid("reload");
                                        },
                                        error: function(msg) {
                                            alert(msg.toString());
                                        }
                                    });
                                }
                            });
                        }
                    }
                }],
                onBeforeLoad: function(data){
                	//如果是在全部或者我的分类下面，不能创建文章，因为category是虚拟的
                	if(categoryId == '-1' || categoryId == '-2'){
                		$("#add").hide();
                	}else{
                		$("#add").show();
                	}
                } 
			});
		} */
		function getChecked(id) {
            var ids = [];
            var rows = $('#' + id).datagrid("getChecked");
            for (var i = 0; i < rows.length; i++) {
                ids.push(rows[i].id);
            }
            return ids;
        }
       /*  function searchKey(){
        	key = $("#key").val();
        	var queryParams =$("#articleGrid").datagrid("options").queryParams;
			queryParams.key = key;
			$("#articleGrid").datagrid("reload");
        } */
        //var editor;
        initKindEditor("content");
	     function submitAdd() {
	    	$("#content").val(encodeURIComponent(editor.html()));
			$("#addArticleForm").form("submit", {
			    url:"../documentServlet.do?sign=add",//&content=" + encodeURIComponent(editor.html()),
			    success:function(result){
			    	var data = eval('(' + result + ')');
			    	if(data.result == 0){
			    		alert(data.reason);
			    	}else{
			    		$("#addArticle").dialog("close");
			    		$("#articleGrid").datagrid("reload");
			    		aticleReload(categoryId,"");
			    	}
			    }
			});
		} 
	</script>
  </head>
  
  <body style="width:100%;height:10000px;" >
  	<div id="cc" class="easyui-layout" style="width:100%;height:100%;">
	  	<div title="分类" style="width: 20%;height: 100%;" data-options="region:'west',collapsible:true">
		    <ul id="tt" class="easyui-tree">
			</ul>
		</div>
		<div  id="zz" style="width:80%;height:100%;margin-left: 20%; background-color: #ffffff;margin-top: -17px;" >
			
		</div>
		
	</div>
	<div id="addArticle" class="easyui-dialog" title="文章编辑" style="width: 800px;display: block; top:220px; padding: 10px;">
		<form id="addArticleForm" method="post">
			<input type="hidden" name="articleId" value="" />
			<input type="hidden" name="categoryId" value="" />
			<table>
				<tr >
					<td>标题:</td>
					<td><input class="easyui-validatebox" style="width: 600px;padding: 5px;" id="title" name="title" type="text"  data-options="required:true"/><td>
			    </tr>
			    <tr >
					<td>正文:</td>
					<td>
						<textarea name="content" id="content" style="width: 600px; height: 450px; visibility: hidden;"></textarea>
					<td>
			    </tr>
		    </table>
		</form>
	</div>
	
  </body>
</html>
