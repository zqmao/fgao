<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<html>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>待办事项</title>
	<link rel="stylesheet" type="text/css" href="themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="themes/icon.css" />
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<script type="text/javascript" src="js/jquery.easyui.min.js"></script>
	<script type="text/javascript">
            $(function() {
                $("#addBug").dialog("close");
                $("#passBug").dialog("close");
                
                $("#bugGrid").datagrid({
                    selectOnCheck: true,
                    checkOnSelect: true,
                    pagination: true,
                    url: '../bugServlet.do?sign=list',
                    frozenColumns: [[
                            {field: 'ck', checkbox: true},
                            {title: '序号', field: 'id', width: 60},
                            {title: '类别', field: 'category', width: 120, align: 'center'},
                            {title: '标题', field: 'title', width: 400},
                            {title: '创建者', field: 'createrName', width: 100, align: 'center'},
                            {title: '完成者', field: 'finisherName', width: 100, align: 'center'},
                            {title: '详情', field: 'opt', width: 100, align: 'center',
                            	formatter: function(value, rowData, rowIndex) {
                                	return "<a href='bugDetail.jsp?bugId="+rowData.id+"' target='_blank' style='color:red'>查看详情</a>";
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
                    	text:'增加',
                        iconCls: 'icon-add',
                        handler: function() {
                            $("#addBug").form('clear');
                            $("#addBug").dialog({
                            	title: '添加',
                            	buttons:[{
                    				text:'保存',
                    				iconCls:'icon-ok',
                    				handler:function(){
                    					$('#addBugForm').form('submit', {
                    					    url:'../bugServlet.do?sign=add',
                    					    success:function(data){
                    					    	var data = eval('(' + data + ')');
                    					    	if(data.result == 0){
                    					    		alert(data.reason);
                    					    	}else{
	                    							$("#addBug").dialog("close");
	                            					$("#bugGrid").datagrid("reload");
                    					    	}
                    					    }
                    					});
                    				}
                    			},{
                    				text:'取消',
                    				iconCls:'icon-cancel',
                    				handler:function(){
                    					$("#addBug").dialog("close");
                    				}
                    			}]
                            });
                            $("#addBug").dialog('open');
                        }
                    }, {
                    	text:'修改',
                        iconCls: 'icon-edit',
                        handler: function() {
                            var ids = getChecked("bugGrid");
                            var len = ids.length;
                            if (len == 0) {
                                $.messager.alert('提示', '至少选择一个。', 'Warning');
                            } else if (len > 1) {
                                $.messager.alert('提示', '只能选择一个。', 'Warning');
                            } else {
                                var row = $("#bugGrid").datagrid('getChecked');
                                $("#addBug").form('clear');
                                $("#addBug").dialog({
                                	title: '修改',
                                	buttons:[{
                        				text:'保存',
                        				iconCls:'icon-ok',
                        				handler:function(){
                        					$('#addBugForm').form('submit', {
                        					    url:'../bugServlet.do?sign=add',
                        					    success:function(data){
                        					    	var data = eval('(' + data + ')');
                        					    	if(data.result == 0){
                        					    		alert(data.reason);
                        					    	}else{
    	                    							$("#addBug").dialog("close");
    	                            					$("#bugGrid").datagrid("reload");
                        					    	}
                        					    }
                        					});
                        				}
                        			},{
                        				text:'取消',
                        				iconCls:'icon-cancel',
                        				handler:function(){
                        					$("#addBug").dialog("close");
                        				}
                        			}]
                                });
                                $("#addBug").dialog('open');
                                $("#addBug").form('load', {
                                	category: row[0].category,
                                	title: row[0].title,
                                	createRemark: row[0].createRemark,
                                	bugId: row[0].id
                                });
                            }
                        }
                    }, {
                    	text:'删除',
                        iconCls: 'icon-remove',
                        handler: function() {
                            var ids = getChecked("bugGrid");
                            var len = ids.length;
                            if (len == 0) {
                                $.messager.alert('提示', '至少选择一个。', 'Warning');
                            } else {
                                $.messager.confirm('Confirm', '确认要删除选择的项吗？', function(r) {
                                    if (r) {
                                        $.ajax({
                                            type: "POST",
                                            url: "../bugServlet.do?sign=delete",
                                            data: "bugIds=" + ids,
                                            success: function(msg) {
                                                $("#bugGrid").datagrid('reload');
                                            },
                                            error: function(msg) {
                                                alert(msg.toString());
                                            }
                                        });
                                    }
                                });
                            }
                        }
                    },
                    {
                    	text:'完成',
                        iconCls: 'icon-ok',
                        handler: function() {
                        	var ids = getChecked("bugGrid");
                        	$.ajax({
                                type: "POST",
                                url: "../bugServlet.do?sign=finish",
                                data: "bugIds=" + ids,
                                success: function(msg) {
                                    $("#bugGrid").datagrid('reload');
                                },
                                error: function(msg) {
                                    alert(msg.toString());
                                }
                            });
                        }
                    },
                    {
                    	text:'指派给',
                        iconCls: 'icon-redo',
                        handler: function() {
                        	var ids = getChecked("bugGrid");
                            var len = ids.length;
                            if (len == 0) {
                                $.messager.alert('提示', '至少选择一个。', 'Warning');
                            } else if (len > 1) {
                                $.messager.alert('提示', '只能选择一个。', 'Warning');
                            } else {
                                var row = $("#bugGrid").datagrid('getChecked');
                                $("#passUser").combobox({
                                    url:'userServlet.do?sign=select',
                                    valueField:'id',
                                    textField:'text',
                                    loadFilter: function(data){
                                    	$.ajax({
                                            type: "POST",
                                            url: "../bugServlet.do?sign=current",
                                            data: "bugId=" + row[0].id,
                                            success: function(msg) {
                                            	var data = eval('('+msg+')');
                                                $("#currentMan").val(data.data);
                                            },
                                            error: function(msg) {
                                                alert(msg.toString());
                                            }
                                        });
                                   		if (data.data){
                                   			return data.data;
                                   		} else {
                                   			return data;
                                   		}
                                   	}
                                });
                                $("#passBug").dialog({
                                	title: '指派',
                                	buttons:[{
                        				text:'指派',
                        				iconCls:'icon-ok',
                        				handler:function(){
                        					$('#passBugForm').form('submit', {
                        					    url:'../bugServlet.do?sign=passBug',
                        					    success:function(data){
                        					    	var data = eval('(' + data + ')');
                        					    	if(data.result == 0){
                        					    		alert(data.reason);
                        					    	}else{
    	                    							$("#passBug").dialog("close");
    	                            					$("#bugGrid").datagrid("reload");
                        					    	}
                        					    }
                        					});
                        				}
                        			},{
                        				text:'取消',
                        				iconCls:'icon-cancel',
                        				handler:function(){
                        					$("#passBug").dialog("close");
                        				}
                        			}]
                                });
                                $("#passBug").dialog('open');
                                $("#passBug").form('load', {
                                    bugId: row[0].id
                                });
                            }
                        }
                    }]
                });
            });

            function getChecked(id) {
                var ids = [];
                var rows = $('#' + id).datagrid('getChecked');
                for (var i = 0; i < rows.length; i++) {
                    ids.push(rows[i].id);
                }
                return ids;
            }
            
        </script>
	</head>

	<body class="easyui-layout">
		<div class="easyui-panel" title="待办列表" style="width: 100%">
			<table id="bugGrid"></table>
		</div>
		<div id="addBug" class="easyui-dialog" data-options="modal:true"
			title="添加待办" style="width: 30%; height: 40%;padding: 10%;">
			<form id="addBugForm" method="post">
				<input type="hidden" name="bugId" value="" />
				<div >
					<label for="category">类别:</label>
					<select class="easyui-combobox" name="category" style="width:40%;">
					    <option value="售后" selected="selected">售后</option>
					    <option value="返现">返现</option>
					</select>
			    </div>
			    <br/>
				<div >
					<label for="title">标题:</label>
					<input class="easyui-validatebox" type="text" name="title" style="width:80%;padding: 5px;" data-options="required:true" />
			    </div>
			    <br/>
			    <div >
					<label for="createRemark">描述:</label>
					<input class="easyui-validatebox" type="text" name="createRemark" style="width:80%;padding: 5px;" data-options="required:true" />
			    </div>
			    
			</form>
		</div>
		<div id="passBug" class="easyui-dialog" data-options="modal:true"
			title="指派待办" style="width: 30%; height: 400px;padding: 10%;">
			<form id="passBugForm" method="post">
				<input type="hidden" name="bugId" value="" />
				<div >
					<label for="currentMan">当前处理人员:</label>
					<input id="currentMan" class="easyui-validatebox" type="text" disabled="disabled" name="currentMan" style="width:30%;padding: 5px;"/>
			    </div>
			    <br/>
				<div >
					<div style="padding-bottom: 10px;">指派给:</div>
					<input id="passUser" name="passUser" />
			    </div>
			    <br/>
			    <div >
					<div style="padding-bottom: 10px;">描述:</div>
					<input class="easyui-textbox" type="text" name="remark" style="width:80%;height:100px" data-options="multiline:true" />
			    </div>
			    <br/>
			</form>
		</div>
	</body>
</html>
