<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="base.util.*"%>
<%
	PermissionUtil.check(request, response);
%>

<html>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>待办事项</title>
	<link rel="stylesheet" type="text/css" href="../easyUi/themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="../easyUi/themes/icon.css" />
	<script type="text/javascript" src="../easyUi/jquery.min.js"></script>
	<script type="text/javascript" src="../easyUi/jquery.easyui.min.js"></script>
	<script type="text/javascript">
			var first = 1;
			var option = "";
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
				$("#handleBug").dialog({
            		iconCls: 'icon-save',
    				buttons: [{
    					text:'确认',
    					iconCls:'icon-ok',
    					handler:function(){
    						handleBug();
    					}
    				},{
    					text:'取消',
    					iconCls:'icon-cancel',
    					handler:function(){
    						$("#handleBug").dialog("close");
    					}
    				}]
            	});
				$("#handleBug").dialog('close');
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
                $("#addBug").panel("open");
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
                $("#option").combobox({
					onSelect: function(record){
						option = record.value;
						if(first == 0){
							var queryParams =$("#bugGrid").datagrid("options").queryParams;
							queryParams.option = option;
							$("#bugGrid").datagrid("reload");
						}
						first = 0;
					}
				});
                $("#bugGrid").datagrid({
                    selectOnCheck: true,
                    checkOnSelect: true,
                    pagination: true,
                    url: '../bugServlet.do?sign=list',
                    queryParams:{option : option},
                    frozenColumns: [[
                            {field: 'ck', checkbox: true},
                            {title: '序号', field: 'id', width: 30},
                            {title: '录入时间', field: 'createTime', width: 150, align: 'center',formatter:jsonYearMonthDay},
                            {title: '旺旺', field: 'wangwang', width: 120, align: 'center'},
                            {title: '产品型号', field: 'goods', width: 120, align: 'center'},
                            {title: '类别', field: 'category', width: 120, align: 'center'},
                            {title: '标题', field: 'title', width: 200,formatter:formatCellTooltip},
                            {title: '描述', field: 'createRemark', width: 200,formatter:formatCellTooltip},
                            {title: '创建者', field: 'createrName', width: 100, align: 'center'},
                            {title: '当前处理人员', field: 'currentName', width: 100, align: 'center'},
                            {title: '完成者', field: 'finisherName', width: 100, align: 'center'},
                            {title: '备注', field: 'finishRemark', width: 100, align: 'center',formatter:formatCellTooltip},
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
                                	wangwang: row[0].wangwang,
                                	goods: row[0].goods,
                                	bugId: row[0].id
                                });
                            }
                        }
                    }, {
                    	text:'处理',
                        iconCls: 'icon-ok',
                        handler: function() {
                        	var ids = getChecked("bugGrid");
                        	if (ids.length == 0) {
                                $.messager.alert('提示', '至少选择一个', 'Warning');
                                return;
                            }
                        	openHandleBug(ids);
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
                    },
                    {
                    	text:'指派给',
                        iconCls: 'icon-redo',
                        handler: function() {
                        	var ids = getChecked("bugGrid");
                            var len = ids.length;
                            if (len == 0) {
                                $.messager.alert('提示', '至少选择一个', 'Warning');
                            }else {
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
                                    bugIds: ids
                                });
                            }
                        }
                    }]
                });
            });
            function formatCellTooltip(value){  
	            return "<span title='" + value + "'>" + value + "</span>";  
	        } 
			function jsonYearMonthDay(milliseconds) {
			    var datetime = new Date();
			    datetime.setTime(milliseconds);
			    var year = datetime.getFullYear();
			    var month = datetime.getMonth() + 1 < 10 ? "0" + (datetime.getMonth() + 1) : datetime.getMonth() + 1;
			    var date = datetime.getDate() < 10 ? "0" + datetime.getDate() : datetime.getDate();
			    var hour = datetime.getHours() < 10 ? "0" + datetime.getHours() : datetime.getHours();
		        var minute = datetime.getMinutes() < 10 ? "0" + datetime.getMinutes() : datetime.getMinutes();
		        var second = datetime.getSeconds() < 10 ? "0" + datetime.getSeconds() : datetime.getSeconds();
			    return year + "-" + month + "-" + date + " " + hour + ":" + minute + ":" + second;
			 
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
			function openHandleBug(ids){
				$("#handleBug").dialog('open');
                $("#handleBugForm").form('load', {
                	bugIds: ids
                });
			}
			function handleBug(){
				$("#handleBugForm").form('submit', {
				    url:"../bugServlet.do?sign=handle",
				    success:function(result){
				    	var data = eval('(' + result + ')');
				    	if(data.result == 0){
				    		alert(data.reason);
				    	}else{
				    		$("#handleBug").panel("close");
				    		$("#handleBugForm").form('clear');
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
				<label for="option">筛选:</label>
				<select class="easyui-combobox" id="option" style="width:250px;">
				    <!-- option value="0">全部</option> -->
				    <option value="1">我创建的</option>
				    <option value="2" selected="selected">我正在处理的</option>
				    <option value="3">我完成的</option>
				    <option value="4">我参与过的</option>
				</select>
		    </div>
			<table id="bugGrid" style="height: 340px;"></table>
		</div>
		<div id="addBug" class="easyui-panel" data-options="modal:true"
			title="添加待办" style="width: 100%; height: 220px;padding: 10px;">
			<form id="addBugForm" method="post">
				<input type="hidden" name="bugId" value="" />
				<div >
					<label for="category">类别:</label>
					<select class="easyui-combobox" id="category" name="category" style="width:100px;">
					    <option value="售后">售后</option>
					    <option value="返现">返现</option>
					    <option value="礼物采购">礼物采购</option> 
					</select>
					<label for="wangwang">旺旺:</label>
					<input class="easyui-validatebox" type="text" name="wangwang" style="width:200px;"/>
					<label for="goods">产品型号:</label>
					<input class="easyui-validatebox" type="text" name="goods" style="width:200px;" data-options="required:true" />
			    </div>
			    <br/>
				<div >
					<label for="title">标题:</label>
					<input class="easyui-textbox" type="text" name="title" style="width:80%;height: 50px;" data-options="multiline:true" />
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
				<input type="hidden" name="bugIds" value="" />
				<div >
					<label for="currentMan">当前处理人员:</label>
					<input id="currentMan" class="easyui-validatebox" type="text" disabled="disabled" name="currentMan" style="width:30%;"/>
			    </div>
			    <br/>
				<div >
					<label style="padding-bottom: 10px;">指派给:</label>
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
		<div id="handleBug" class="easyui-dialog" title="处理待办" style="width: 30%; height: 250px;padding: 10px;">
			<form id="handleBugForm" method="post">
				<input type="hidden" name="bugIds" value="" />
				<table style="width: 100%;">
				    <tr >
						<td>备注:</td>
						<td><input class="easyui-textbox" type="text" name="finishRemark" style="width:100%;height:50px" data-options="multiline:true" /><td>
				    </tr>
			    </table>
			</form>
		</div>
	</body>
</html>
