<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="base.util.*"%>
<%
	int userId = PermissionUtil.checkAdmin(request, response);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>文章列表</title>
	<link rel="stylesheet" type="text/css" href="../easyUi/themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="../easyUi/themes/icon.css" />
	<script type="text/javascript" src="../easyUi/jquery.min.js"></script>
	<script type="text/javascript" src="../easyUi/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../easyUi/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript">
		var categoryId = "";
		var key = "";
		var first = 1;
		$(function() {
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
						var queryParams =$("#articleGrid").datagrid("options").queryParams;
						queryParams.categoryId = categoryId;
						$("#articleGrid").datagrid("reload");
					}else{
						loadTableData();
					}
					first = 0;
				}
			});
		});
		function loadTableData(){
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
                    	window.open("/admin/articleEdit.jsp?categoryId=" + categoryId);
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
                            window.open("/admin/articleEdit.jsp?articleId=" + articleId + "&categoryId=" + categoryId);
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
		}
		function getChecked(id) {
            var ids = [];
            var rows = $('#' + id).datagrid("getChecked");
            for (var i = 0; i < rows.length; i++) {
                ids.push(rows[i].id);
            }
            return ids;
        }
        function searchKey(){
        	key = $("#key").val();
        	var queryParams =$("#articleGrid").datagrid("options").queryParams;
			queryParams.key = key;
			$("#articleGrid").datagrid("reload");
        }
	</script>
  </head>
  
  <body>
  	<div id="cc" class="easyui-layout" style="width:100%;height:100%;">
	  	<div title="分类" style="width: 20%;height: 100%;" data-options="region:'west',collapsible:true">
		    <ul id="tt" class="easyui-tree">
			</ul>
		</div>
		<div class="easyui-panel" title="文章列表" style="width: 80%;height: 100%;" data-options="region:'center',split:true">
		    <div style="padding: 5px;">
		    	筛选：
		    	<input class="easyui-validatebox" style="width: 100px;padding: 5px;" id="key" type="text"/>
		    	<a href="javascript:;" class="l-btn l-btn-small l-btn-plain" onclick="searchKey();">
					<span class="l-btn-left l-btn-icon-left" style="border:1px solid #95B8E7;border-radius:5px;">
						<span class="l-btn-text">搜索</span>
						<span class="l-btn-icon icon-search">&nbsp;</span>
					</span>
				</a>
		    </div>
		    <table id="articleGrid" style="height: 340px;"></table>
		</div>
	</div>
  </body>
</html>
