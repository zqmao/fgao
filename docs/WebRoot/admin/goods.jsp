<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="base.util.*"%>
<%
	int userId = PermissionUtil.checkAdmin(request, response);
	boolean goodIn = false;
	boolean goodOut = false;
	if(userId != 0){
		goodIn = PermissionUtil.checkGoodsIn(request, response);
		goodOut = PermissionUtil.checkGoodsOut(request, response);
	}
%>
<html>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>货物管理</title>
	<link rel="stylesheet" type="text/css" href="../easyUi/themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="../easyUi/themes/icon.css" />
	<script type="text/javascript" src="../easyUi/jquery.min.js"></script>
	<script type="text/javascript" src="../easyUi/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../easyUi/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript">
            $(function() {
            	$("#tabs").tabs({
            	    border:false,
            	    onSelect:function(title,index){
            	        if(index == 1){
            	        	loadGoodsIn();
            	        	initPermission();
            	        }else if(index == 2){
            	        	loadGoodsOut();
            	        	initPermission();
            	        }else if(index == 0){
            	        	loadGoods();
            	        	initPermission();
            	        }
            	    }
            	});
            	$("#goodsComeList").dialog({
            		left:100,
             	    top:100,
            	});
            	$("#goodsComeList").dialog("close");
            	$("#goodsIn").dialog({
            		iconCls: 'icon-save',
    				buttons: [{
    					text:'进货',
    					iconCls:'icon-ok',
    					handler:function(){
    						goodsIn();
    					}
    				},{
    					text:'取消',
    					iconCls:'icon-cancel',
    					handler:function(){
    						$("#goodsIn").dialog("close");
    					}
    				}]
            	});
            	$("#goodsIn").dialog("close");
            	$("#goodsOut").dialog({
            		iconCls: 'icon-save',
    				buttons: [{
    					text:'出货',
    					iconCls:'icon-ok',
    					handler:function(){
    						goodsOut();
    					}
    				},{
    					text:'取消',
    					iconCls:'icon-cancel',
    					handler:function(){
    						$("#goodsOut").dialog("close");
    					}
    				}]
            	});
            	$("#goodsOut").dialog("close");
            	$("#goodsCome").dialog({
            		iconCls: 'icon-save',
    				buttons: [{
    					text:'收货',
    					iconCls:'icon-ok',
    					handler:function(){
    						goodsCome();
    					}
    				},{
    					text:'取消',
    					iconCls:'icon-cancel',
    					handler:function(){
    						$("#goodsCome").dialog("close");
    					}
    				}]
            	});
            	$("#goodsCome").dialog("close");
            	$("#addGoods").panel({
            		title: '添加货物',
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
        					$("#addGoods").panel("close");
        				}
        			}]
            		});
                $("#addGoods").panel("close");
                loadGoods();
                initPermission();
            });

            function getChecked(id) {
                var ids = [];
                var rows = $('#' + id).datagrid("getChecked");
                for (var i = 0; i < rows.length; i++) {
                    ids.push(rows[i].id);
                }
                return ids;
            }
            
            function submitAdd() {
				$("#addGoodsForm").form("submit", {
				    url:"../goodsServlet.do?sign=add",
				    success:function(result){
				    	var data = eval('(' + result + ')');
				    	if(data.result == 0){
				    		alert(data.reason);
				    	}else{
							$("#addGoodsForm").form("clear");
        					$("#goodsGrid").datagrid("reload");
				    	}
				    }
				});
			}
            
            function loadGoods(){
            	$("#goodsGrid").datagrid({
                    selectOnCheck: true,
                    checkOnSelect: true,
                    pagination: true,
                    url: "../goodsServlet.do?sign=list",
                    frozenColumns: [[
                            {field: 'ck', checkbox: true},
                            {title: '序号', field: 'id', width: 60},
                            {title: '货物名称', field: 'name', width: 220, align: 'center'},
                            {title: '库存', field: 'stock', width: 220, align: 'center'},
                            {title: '操作', field: 'opt', width: 220, align: 'center',
                            	formatter: function(value, rowData, rowIndex) {
                            		var opt = "";
                           			if(<%=goodOut%>){
                           				opt += "<a href='javascript:;' class='l-btn l-btn-small l-btn-plain' onclick='openGoodsOut("+rowData.id+")'><span class='l-btn-left l-btn-icon-left'><span class='l-btn-text'>出货</span><span class='l-btn-icon icon-remove'>&nbsp;</span></span></a>"
                           			}
                           			if(<%=goodIn%>){
                           				opt += "<a href='javascript:;' class='l-btn l-btn-small l-btn-plain' onclick='openGoodsIn("+rowData.id+")'><span class='l-btn-left l-btn-icon-left'><span class='l-btn-text'>进货</span><span class='l-btn-icon icon-add'>&nbsp;</span></span></a>";
                           			}
                                	return opt;
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
                    	id: 'toolbar-add-goods',
                        iconCls: 'icon-add',
                        text: '增加',
                        handler: function() {
                            $("#addGoodsForm").form("clear");
                            $("#addGoods").panel("open");
                        }
                    }, {
                    	id: 'toolbar-edit-goods',
                        iconCls: 'icon-edit',
                        text: '修改',
                        handler: function() {
                            var ids = getChecked("goodsGrid");
                            var len = ids.length;
                            if (len == 0) {
                                $.messager.alert('提示', '至少选择一个', 'Warning');
                            } else if (len > 1) {
                                $.messager.alert('提示', '只能选择一个', 'Warning');
                            } else {
                                var row = $("#goodsGrid").datagrid("getChecked");
                                $("#addGoods").panel("open");
                                $("#addGoodsForm").form("load", {
                                	goodsId: row[0].id,
                                    name: row[0].name,
                                });
                            }
                        }
                    }, {
                    	id: 'toolbar-remove-goods',
                        iconCls: 'icon-remove',
                        text: '删除',
                        handler: function() {
                            var ids = getChecked("goodsGrid");
                            var len = ids.length;
                            if (len == 0) {
                                $.messager.alert('提示', '至少选择一个', 'Warning');
                            } else {
                                $.messager.confirm('Confirm', '确认要删除选择的项吗？', function(r) {
                                    if (r) {
                                        $.ajax({
                                            type: "POST",
                                            url: "../goodsServlet.do?sign=delete",
                                            data: "goodsIds=" + ids,
                                            success: function(msg) {
                                                $("#goodsGrid").datagrid("reload");
                                            },
                                            error: function(msg) {
                                                alert(msg.toString());
                                            }
                                        });
                                    }
                                });
                            }
                        }
                    }]
                });
            }
            
            function loadGoodsIn(){
            	$("#goodsInGrid").datagrid({
                    selectOnCheck: true,
                    checkOnSelect: true,
                    pagination: true,
                    url: "../goodsInServlet.do?sign=list",
                    frozenColumns: [[
                            {field: 'ck', checkbox: true},
                            {title: '序号', field: 'id', width: 60},
                            {title: '进货时间', field: 'time', width: 220, align: 'center'},
                            {title: '货物名称', field: 'goodsName', width: 220, align: 'center'},
                            {title: '进货数量', field: 'count', width: 120, align: 'center'},
                            {title: '收货情况', field: 'comeInfo', width: 120, align: 'center',
                            	formatter: function(value, rowData, rowIndex) {
                            		var opt = "<a href='javascript:;' class='l-btn l-btn-small l-btn-plain' onclick='openGoodsComeList("+rowData.id+")'><span class='l-btn-left l-btn-icon-left'><span class='l-btn-text'>"+value+"</span><span class='l-btn-icon icon-search'>&nbsp;</span></span></a>";
                                	return opt;
                            	}},
                            {title: '欠货数量', field: 'oweCount', width: 120, align: 'center'},
                            {title: '备注', field: 'remark', width: 120, align: 'center'},
                            {title: '操作', field: 'opt', width: 120, align: 'center',
                            	formatter: function(value, rowData, rowIndex) {
                            		var opt = "";
                            		if(<%=goodOut%>){
                           				opt += "<a href='javascript:;' class='l-btn l-btn-small l-btn-plain' onclick='openGoodsCome("+rowData.id+")'><span class='l-btn-left l-btn-icon-left'><span class='l-btn-text'>收货</span><span class='l-btn-icon icon-add'>&nbsp;</span></span></a>";
                           			}
                                	return opt;
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
                    	id: 'toolbar-edit-goods-in',
                        iconCls: 'icon-edit',
                        text: '修改',
                        handler: function() {
                            var ids = getChecked("goodsInGrid");
                            var len = ids.length;
                            if (len == 0) {
                                $.messager.alert('提示', '至少选择一个', 'Warning');
                            } else if (len > 1) {
                                $.messager.alert('提示', '只能选择一个', 'Warning');
                            } else {
                                var row = $("#goodsInGrid").datagrid("getChecked");
                                openGoodsIn(0, row[0].id, row[0].count, row[0].remark);
                            }
                        }
                    }, {
                    	id: 'toolbar-remove-goods-in',
                        iconCls: 'icon-remove',
                        text: '删除',
                        handler: function() {
                            var ids = getChecked("goodsInGrid");
                            var len = ids.length;
                            if (len == 0) {
                                $.messager.alert('提示', '至少选择一个', 'Warning');
                            } else {
                                $.messager.confirm('Confirm', '确认要删除选择的项吗？', function(r) {
                                    if (r) {
                                        $.ajax({
                                            type: "POST",
                                            url: "../goodsInServlet.do?sign=delete",
                                            data: "recordIds=" + ids,
                                            success: function(msg) {
                                                $("#goodsInGrid").datagrid("reload");
                                            },
                                            error: function(msg) {
                                                alert(msg.toString());
                                            }
                                        });
                                    }
                                });
                            }
                        }
                    }]
                });
            }
            
            function loadGoodsOut(){
            	$("#goodsOutGrid").datagrid({
                    selectOnCheck: true,
                    checkOnSelect: true,
                    pagination: true,
                    url: "../goodsOutServlet.do?sign=list",
                    frozenColumns: [[
                            {field: 'ck', checkbox: true},
                            {title: '序号', field: 'id', width: 60},
                            {title: '出货时间', field: 'time', width: 220, align: 'center'},
                            {title: '货物名称', field: 'goodsName', width: 220, align: 'center'},
                            {title: '出货数量', field: 'count', width: 120, align: 'center'},
                            {title: '备注', field: 'remark', width: 220, align: 'center'}
                        ]],
                    loadFilter: function(data){
                   		if (data.data){
                   			return data.data;
                   		} else {
                   			return data;
                   		}
                   	},
                    toolbar: [{
                    	id: 'toolbar-remove-goods-out',
                        iconCls: 'icon-remove',
                        text: '删除',
                        handler: function() {
                            var ids = getChecked("goodsOutGrid");
                            var len = ids.length;
                            if (len == 0) {
                                $.messager.alert('提示', '至少选择一个', 'Warning');
                            } else {
                                $.messager.confirm('Confirm', '确认要删除选择的项吗？', function(r) {
                                    if (r) {
                                        $.ajax({
                                            type: "POST",
                                            url: "../goodsOutServlet.do?sign=delete",
                                            data: "recordIds=" + ids,
                                            success: function(msg) {
                                                $("#goodsOutGrid").datagrid("reload");
                                            },
                                            error: function(msg) {
                                                alert(msg.toString());
                                            }
                                        });
                                    }
                                });
                            }
                        }
                    }]
                });
            }
            
            function openGoodsIn(goodsId, recordId, count, remark){
            	$("#goodsIn").dialog("open");
                $("#goodsInForm").form("load", {
                	goodsId: goodsId,
                	recordId: recordId,
                	count: count,
                	remark: remark
                });
            }
            
            function openGoodsOut(goodsId){
            	$("#goodsOut").dialog("open");
                $("#goodsOutForm").form("load", {
                	goodsId: goodsId
                });
            }
            
            function openGoodsCome(recordId){
            	$("#goodsCome").dialog("open");
                $("#goodsComeForm").form("load", {
                	recordId: recordId
                });
            }
            
            function goodsIn() {
				$("#goodsInForm").form("submit", {
				    url:"../goodsInServlet.do?sign=add",
				    success:function(result){
				    	var data = eval('(' + result + ')');
				    	if(data.result == 0){
				    		alert(data.reason);
				    	}else{
							$("#goodsInForm").form("clear");
							$("#goodsIn").dialog("close");
        					$("#goodsGrid").datagrid("reload");
        					$("#goodsInGrid").datagrid("reload");
				    	}
				    }
				});
			}
            
            function goodsOut() {
				$("#goodsOutForm").form("submit", {
				    url:"../goodsOutServlet.do?sign=add",
				    success:function(result){
				    	var data = eval('(' + result + ')');
				    	if(data.result == 0){
				    		alert(data.reason);
				    	}else{
							$("#goodsOutForm").form("clear");
							$("#goodsOut").dialog("close");
        					$("#goodsGrid").datagrid("reload");
				    	}
				    }
				});
			}
            
            function goodsCome() {
				$("#goodsComeForm").form("submit", {
				    url:"../goodsInServlet.do?sign=come",
				    success:function(result){
				    	var data = eval('(' + result + ')');
				    	if(data.result == 0){
				    		alert(data.reason);
				    	}else{
							$("#goodsComeForm").form("clear");
							$("#goodsCome").dialog("close");
        					$("#goodsInGrid").datagrid("reload");
				    	}
				    }
				});
			}
            
            function openGoodsComeList(recordId){
            	$("#goodsComeList").dialog("open");
            	$("#goodsComeGrid").datagrid({
                    selectOnCheck: true,
                    checkOnSelect: true,
                    pagination: true,
                    url: "../goodsInServlet.do?sign=listComes",
                    queryParams:{recordId:recordId},
                    frozenColumns: [[
                            {field: 'ck', checkbox: true},
                            {title: '序号', field: 'id', width: 60},
                            {title: '收货时间', field: 'time', width: 220, align: 'center'},
                            {title: '货物名称', field: 'goodsName', width: 220, align: 'center'},
                            {title: '收货数量', field: 'count', width: 120, align: 'center'},
                            {title: '订单号', field: 'orderNum', width: 220, align: 'center'}
                        ]],
                    loadFilter: function(data){
                   		if (data.data){
                   			return data.data;
                   		} else {
                   			return data;
                   		}
                   	},
                    toolbar: [{
                    	id: 'toolbar-remove-goods-come',
                        iconCls: 'icon-remove',
                        text: '删除',
                        handler: function() {
                            var ids = getChecked("goodsComeGrid");
                            var len = ids.length;
                            if (len == 0) {
                                $.messager.alert('提示', '至少选择一个', 'Warning');
                            } else {
                                $.messager.confirm('Confirm', '确认要删除选择的项吗？', function(r) {
                                    if (r) {
                                        $.ajax({
                                            type: "POST",
                                            url: "../goodsInServlet.do?sign=deleteComes",
                                            data: "recordIds=" + ids,
                                            success: function(msg) {
                                                $("#goodsComeGrid").datagrid("reload");
                                                $("#goodsInGrid").datagrid("reload");
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
                    	if(<%=goodOut%>){
                    		$("#toolbar-remove-goods-come").show();
                    	}else{
                    		$("#toolbar-remove-goods-come").hide();
                    	}
                    }  
                });
            }
			
            function initPermission(){
            	if(<%=goodIn%>){
            		$("#toolbar-add-goods").show();
            		$("#toolbar-edit-goods").show();
            		$("#toolbar-remove-goods").show();
            		$("#toolbar-edit-goods-in").show();
            		$("#toolbar-remove-goods-in").show();
            		
            	}else{
            		$("#toolbar-add-goods").hide();
            		$("#toolbar-edit-goods").hide();
            		$("#toolbar-remove-goods").hide();
            		$("#toolbar-edit-goods-in").hide();
            		$("#toolbar-remove-goods-in").hide();
            	}
            	if(<%=goodOut%>){
            		$("#toolbar-remove-goods-out").show();
            	}else{
            		$("#toolbar-remove-goods-out").hide();
            	}
            }
        </script>
	</head>

	<body class="easyui-layout">
		<div id="tabs" class="easyui-tabs" style="width:100%;height:500px;">
			<div title="货物列表" style="padding:5px;">
				<table id="goodsGrid" style="height: 340px;"></table>
			</div>
			<div title="进货管理" style="padding:5px;">
				<table id="goodsInGrid" style="height: 340px;"></table>
			</div>
			<div title="出货管理" style="padding:5px;">
				<table id="goodsOutGrid" style="height: 340px;"></table>
			</div>
		</div>
		<div id="addGoods" class="easyui-panel" title="添加货物" style="width: 100%; height: 200px;padding: 10px;">
			<form id="addGoodsForm" method="post">
				<input type="hidden" name="goodsId" value="" />
				<table>
					<tr >
						<td>货物名称:</td>
						<td><input class="easyui-validatebox" name="name" type="text"  data-options="required:true"/><td>
				    </tr>
			    </table>
			</form>
		</div>
		
		<div id="goodsIn" class="easyui-dialog" title="进货" style="width: 30%; height: 250px;padding: 10px;">
			<form id="goodsInForm" method="post">
				<input type="hidden" name="goodsId" value="" />
				<input type="hidden" name="recordId" value="" />
				<table style="width: 100%;">
					<tr >
						<td>进货数量:</td>
						<td><input class="easyui-validatebox" name="count" type="text"  data-options="required:true"/><td>
				    </tr>
				    <tr >
						<td>备注:</td>
						<td><input class="easyui-textbox" type="text" name="remark" style="width:100%;height:50px" data-options="multiline:true" /><td>
				    </tr>
			    </table>
			</form>
		</div>
		
		<div id="goodsOut" class="easyui-dialog" title="出货" style="width: 30%; height: 250px;padding: 10px;">
			<form id="goodsOutForm" method="post">
				<input type="hidden" name="goodsId" value="" />
				<table style="width: 100%;">
					<tr >
						<td>出货数量:</td>
						<td><input class="easyui-validatebox" name="count" type="text"  data-options="required:true"/><td>
				    </tr>
				    <tr >
						<td>备注:</td>
						<td><input class="easyui-textbox" type="text" name="remark" style="width:100%;height:50px" data-options="multiline:true" /><td>
				    </tr>
			    </table>
			</form>
		</div>
		
		<div id="goodsCome" class="easyui-dialog" title="收货" style="width: 30%; height: 250px;padding: 10px;">
			<form id="goodsComeForm" method="post">
				<input type="hidden" name="recordId" value="" />
				<table style="width: 100%;">
					<tr >
						<td>收货数量:</td>
						<td><input class="easyui-validatebox" name="count" type="text"  data-options="required:true"/><td>
				    </tr>
				    <tr >
						<td>单号:</td>
						<td><input class="easyui-textbox" type="text" name="orderNum" style="width:100%;height:50px" data-options="multiline:true" /><td>
				    </tr>
			    </table>
			</form>
		</div>
		
		<div id="goodsComeList" class="easyui-dialog" title="收货情况" style="width: 50%">
			<table id="goodsComeGrid" style="height: 340px;"></table>
		</div>
	</body>
</html>
