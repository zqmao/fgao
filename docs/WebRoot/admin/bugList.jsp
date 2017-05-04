<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="base.util.*"%>
<%
	int userId = PermissionUtil.checkAdmin(request, response);
%>

<html>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>待办事项</title>
	<link rel="stylesheet" type="text/css" href="../easyUi/themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="../easyUi/themes/icon.css" />
	<script type="text/javascript" src="../easyUi/jquery.min.js"></script>
	<script type="text/javascript" src="../easyUi/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../easyUi/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript">
			var first_user = 1;
			var first_type = 1;
			var option_user = "0";
			var option_type = "0";
            $(function() {
            	$("#finishBug").dialog({
            		iconCls: 'icon-save',
    				buttons: [{
    					text:'完成',
    					iconCls:'icon-ok',
    					handler:function(){
    						finishBug();
    					}
    				},{
    					text:'取消',
    					iconCls:'icon-cancel',
    					handler:function(){
    						$("#finishBug").dialog("close");
    					}
    				}]
            	});
				$("#finishBug").dialog('close');
                $("#addBug").panel({
                	title: '添加',
                	tools:[{
        				text:'保存',
        				iconCls:'icon-ok',
        				handler:function(){
        					submitAdd();
        				}
        			},{
           				text:'-',
           				iconCls:'icon-blank',
           				handler:function(){}
           			},{
        				text:'取消',
        				iconCls:'icon-cancel',
        				handler:function(){
        					$("#addBug").panel("close");
        				}
        			}]
                });
                $("#addBug").panel('open');
                $("#passBug").panel({
                	title: '指派',
                	tools:[{
        				text:'指派',
        				iconCls:'icon-ok',
        				handler:function(){
        					submitPass();
        				}
        			},{
        				text:'-',
        				iconCls:'icon-blank',
        				handler:function(){}
        			},{
        				text:'取消',
        				iconCls:'icon-cancel',
        				handler:function(){
        					$("#passBug").panel("close");
        				}
        			}]
                });
                $("#passBug").panel("close");
                $("#option_user").combobox({
                    url:'../userServlet.do?sign=select',
                    valueField:'id',
                    textField:'text',
                    loadFilter: function(data){
                   		if (data.data){
                   			$("#option_user").combobox('select', <%=userId%>);
                   			return data.data;
                   		} else {
                   			return data;
                   		}
                   	},
                	onSelect: function(record){
						option_user = record.id + "";
						if(first_user == 0){
							var queryParams =$("#bugGrid").datagrid("options").queryParams;
							queryParams.selectUser = option_user;
							$("#bugGrid").datagrid("reload");
						}else{
							loadTableData();
						}
						first_user = 0;
					}
                }
                );
                $("#option_type").combobox({
					onSelect: function(record){
						option_type = record.value;
						if(first_type == 0){
							var queryParams =$("#bugGrid").datagrid("options").queryParams;
							queryParams.option = option_type;
							$("#bugGrid").datagrid("reload");
						}
						first_type = 0;
					}
				});
            });

			function loadTableData() {
				$("#bugGrid").datagrid({
                    selectOnCheck: true,
                    checkOnSelect: true,
                    pagination: true,
                    url: '../bugServlet.do?sign=list',
                    queryParams:{option : option_type, selectUser : option_user},
                    frozenColumns: [[
                            {field: 'ck', checkbox: true},
                            {title: '序号', field: 'id', width: 60},
                            {title: '类别', field: 'category', width: 120, align: 'center'},
                            {title: '标题', field: 'title', width: 400},
                            {title: '创建者', field: 'createrName', width: 100, align: 'center'},
                            {title: '当前处理人员', field: 'currentName', width: 100, align: 'center'},
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
                            $("#addBugForm").form('clear');
                            $("#category").combobox('select', '售后');
                            $("#addBug").panel('open');
                        }
                    }, {
                    	text:'修改',
                        iconCls: 'icon-edit',
                        handler: function() {
                            var ids = getChecked("bugGrid");
                            var len = ids.length;
                            if (len == 0) {
                                $.messager.alert('提示', '至少选择一个', 'Warning');
                            } else if (len > 1) {
                                $.messager.alert('提示', '只能选择一个', 'Warning');
                            } else {
                                var row = $("#bugGrid").datagrid('getChecked');
                                $("#addBug").panel('open');
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
                                $.messager.alert('提示', '至少选择一个', 'Warning');
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
                    }, {
                    	text:'完成',
                        iconCls: 'icon-ok',
                        handler: function() {
                        	var ids = getChecked("bugGrid");
                        	if (ids.length == 0) {
                                $.messager.alert('提示', '至少选择一个', 'Warning');
                                return;
                            }
                        	openFinishBug(ids);
                        }
                    }, {
                    	text:'指派给',
                        iconCls: 'icon-redo',
                        handler: function() {
                        	var ids = getChecked("bugGrid");
                            var len = ids.length;
                            if (len == 0) {
                                $.messager.alert('提示', '至少选择一个', 'Warning');
                            } else if (len > 1) {
                                $.messager.alert('提示', '只能选择一个', 'Warning');
                            } else {
                                var row = $("#bugGrid").datagrid('getChecked');
                                $("#passUser").combobox({
                                    url:'../userServlet.do?sign=select',
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
                                   			$("#passUser").combobox('select', data.data[0].id);
                                   			return data.data;
                                   		} else {
                                   			return data;
                                   		}
                                   	}
                                });
                                $("#passBug").panel('open');
                                $("#passBug").form('load', {
                                    bugId: row[0].id
                                });
                            }
                        }
                    }]
                });
			}
            function getChecked(id) {
                var ids = [];
                var rows = $('#' + id).datagrid('getChecked');
                for (var i = 0; i < rows.length; i++) {
                    ids.push(rows[i].id);
                }
                return ids;
            }
            
            document.onkeydown = function(event_e){
				if(window.event) {
					event_e = window.event;
				}
				var int_keycode = event_e.charCode||event_e.keyCode;
				if( int_keycode == '13' ) {
					submitAdd();
					return false;
				}
			};
			
			function submitAdd() {
				
				$("#addBugForm").form('submit', {
				    url:"../bugServlet.do?sign=add",
				    success:function(result){
				    	var data = eval('(' + result + ')');
				    	if(data.result == 0){
				    		alert(data.reason);
				    	}else{
							$("#addBugForm").form('clear');
				    		$("#category").combobox('select', '售后');
        					$("#bugGrid").datagrid("reload");
				    	}
				    }
				});
			}
			
			function submitPass() {
				$("#passBugForm").form('submit', {
				    url:"../bugServlet.do?sign=passBug",
				    success:function(result){
				    	var data = eval('(' + result + ')');
				    	if(data.result == 0){
				    		alert(data.reason);
				    	}else{
				    		$("#passBug").panel("close");
				    		$("#passBugForm").form('clear');
        					$("#bugGrid").datagrid("reload");
				    	}
				    }
				});
			}
            
			function openFinishBug(ids){
				$("#finishBug").dialog('open');
                $("#finishBugForm").form('load', {
                	bugIds: ids
                });
			}
			
			function finishBug(){
				$("#finishBugForm").form('submit', {
				    url:"../bugServlet.do?sign=finish",
				    success:function(result){
				    	var data = eval('(' + result + ')');
				    	if(data.result == 0){
				    		alert(data.reason);
				    	}else{
				    		$("#finishBug").panel("close");
				    		$("#finishBugForm").form('clear');
        					$("#bugGrid").datagrid("reload");
				    	}
				    }
				});
			}
        </script>
	</head>

	<body class="easyui-layout">
		<div class="easyui-panel" title="待办列表" style="width: 100%">
		
			<div style="padding-left: 5px;padding-top: 10px;padding-bottom: 10px;">
				<label for="option_user">筛选:</label>
				<input id="option_user" />
		    </div>
			<div style="padding-left: 5px;padding-top: 10px;padding-bottom: 10px;">
				<label for="option_type">筛选:</label>
				<select class="easyui-combobox" id="option_type" style="width:250px;">
				    <option value="0">全部</option>
				    <option value="1">他创建的</option>
				    <option value="2" selected="selected">他正在处理的</option>
				    <option value="3">他完成的</option>
				    <option value="4">他参与过的</option>
				</select>
		    </div>
			<table id="bugGrid" style="height: 340px;"></table>
		</div>
		<div id="addBug" class="easyui-panel" data-options="modal:true"
			title="添加待办" style="width: 100%; height: 200px;padding: 10px;">
			<form id="addBugForm" method="post">
				<input type="hidden" name="bugId" value="" />
				<div >
					<label for="category">类别:</label>
					<select class="easyui-combobox" id="category" name="category" style="width:40%;">
					    <option value="售后">售后</option>
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
					<input class="easyui-textbox" type="text" name="createRemark" style="width:80%;height:50px;" data-options="multiline:true" />
			    </div>
			    
			</form>
		</div>
		<div id="passBug" class="easyui-panel" data-options="modal:true"
			title="指派待办" style="width: 100%; height: 200px;padding: 10px;">
			<form id="passBugForm" method="post">
				<input type="hidden" name="bugId" value="" />
				<div >
					<label for="currentMan">当前处理人员:</label>
					<input id="currentMan" class="easyui-validatebox" type="text" disabled="disabled" name="currentMan" style="width:30%;"/>
			    </div>
			    <br/>
				<div >
					<label style="padding-bottom: 10px;">指派:</label>
					<input id="passUser" name="passUser" />
			    </div>
			    <br/>
			    <div >
					<label style="padding-bottom: 10px;">描述:</label>
					<input class="easyui-textbox" type="text" name="remark" style="width:80%;height:50px" data-options="multiline:true" />
			    </div>
			    <br/>
			</form>
		</div>
		<div id="finishBug" class="easyui-dialog" title="完成待办" style="width: 30%; height: 250px;padding: 10px;">
			<form id="finishBugForm" method="post">
				<input type="hidden" name="bugIds" value="" />
				<table style="width: 100%;">
				    <tr >
						<td>完成备注:</td>
						<td><input class="easyui-textbox" type="text" name="finishRemark" style="width:100%;height:50px" data-options="multiline:true" /><td>
				    </tr>
			    </table>
			</form>
		</div>
	</body>
</html>
