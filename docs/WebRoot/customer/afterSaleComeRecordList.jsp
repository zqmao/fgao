<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="base.util.*"%>
<html>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>售后管理</title>
	<link rel="stylesheet" type="text/css" href="../easyUi/themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="../easyUi/themes/icon.css" />
	<script type="text/javascript" src="../easyUi/jquery.min.js"></script>
	<script type="text/javascript" src="../easyUi/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../easyUi/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript">
            $(function() {
            	$("#addAscr").panel({
            		title: '添加售后收货记录',
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
        					$("#addAscr").panel("close");
        				}
        			}]
            		});
                $("#addAscr").panel("open");
                $("#grant").dialog("close");
                $("#ascrGrid").datagrid({
                    selectOnCheck: true,
                    checkOnSelect: true,
                    pagination: true,
                    url: "../afterSaleComeRecordServlet.do?sign=list",
                    frozenColumns: [[
                            {field: 'ck', checkbox: true},
                            {title: '编号', field: 'id', width: 60},
                            {title: '快递单号', field: 'courierNum', width: 120},
                            {title: '物品名称', field: 'goodsName', width: 120, align: 'center'},
                            {title: '检查结果', field: 'checkResult', width: 120, align: 'center'},
                            {title: '旺旺', field: 'wangwang', width: 120, align: 'center'},
                            {title: '手机号', field: 'phoneNum', width: 120, align: 'center'},
                            {title: '订单号', field: 'orderNum', width: 120, align: 'center'},
                            {title: '创建人员', field: 'creator', width: 100, align: 'center'},
                            {title: '创建时间', field: 'createTime', width: 180, align: 'center'},
                            {title: '备注', field: 'remark', width: 100, align: 'center', formatter:formatCellTooltip},
                            {title: '状态', field: 'status', width: 100, align: 'center'}
                        ]],
                    loadFilter: function(data){
                   		if (data.data){
                   			return data.data;
                   		} else {
                   			return data;
                   		}
                   	},
                    toolbar: [{
                        iconCls: 'icon-add',
                        text: '增加',
                        handler: function() {
                            $("#addAscr").form("clear");
                            $("#addAscr").panel("open");
                        }
                    }, {
                        iconCls: 'icon-edit',
                        text: '修改',
                        handler: function() {
                            var ids = getChecked("ascrGrid");
                            var len = ids.length;
                            if (len == 0) {
                                $.messager.alert('提示', '至少选择一个', 'Warning');
                            } else if (len > 1) {
                                $.messager.alert('提示', '只能选择一个', 'Warning');
                            } else {
                                var row = $("#ascrGrid").datagrid("getChecked");
                                $("#addAscr").panel("open");
                                $("#addAscr").form("load", {
                                    ascrId: row[0].id,
                                    courierNum: row[0].courierNum,
                                    goodsName: row[0].goodsName,
                                    checkResult: row[0].checkResult,
                                    wangwang: row[0].wangwang,
                                    phoneNum: row[0].phoneNum,
                                    orderNum: row[0].orderNum,
                                    remark: row[0].remark,
                                    status: row[0].status
                                });
                            }
                        }
                    }, {
                        iconCls: 'icon-remove',
                        text: '删除',
                        handler: function() {
                            var ids = getChecked("ascrGrid");
                            var len = ids.length;
                            if (len == 0) {
                                $.messager.alert('提示', '至少选择一个', 'Warning');
                            } else {
                                $.messager.confirm('Confirm', '确认要删除选择的项吗？', function(r) {
                                    if (r) {
                                        $.ajax({
                                            type: "POST",
                                            url: "../afterSaleComeRecordServlet.do?sign=delete",
                                            data: "ascrIds=" + ids,
                                            success: function(msg) {
                                                $("#ascrGrid").datagrid("reload");
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
            });

            function formatCellTooltip(value){  
	            return "<span title='" + value + "'>" + value + "</span>";  
	        } 
            
            function getChecked(id) {
                var ids = [];
                var rows = $('#' + id).datagrid("getChecked");
                for (var i = 0; i < rows.length; i++) {
                    ids.push(rows[i].id);
                }
                return ids;
            }
            
            function submitAdd() {
				$("#addAscrForm").form("submit", {
				    url:"../afterSaleComeRecordServlet.do?sign=add",
				    success:function(result){
				    	var data = eval('(' + result + ')');
				    	if(data.result == 0){
				    		alert(data.reason);
				    	}else{
							$("#addAscrForm").form("clear");
        					$("#ascrGrid").datagrid("reload");
				    	}
				    }
				});
			}
			
        </script>
	</head>

	<body class="easyui-layout">
		<div title="售后收货记录列表" class="easyui-panel" style="width: 100%">
			<table id="ascrGrid" style="height: 340px;"></table>
		</div>

		<div id="addAscr" class="easyui-panel" title="添加售后收货记录" style="width: 100%; height: 500px;padding: 10px;">
			<form id="addAscrForm" method="post">
				<input type="hidden" name="ascrId" value="" />
				<table>
				<tr >
						<td>快递单号:</td>
						<td><input class="easyui-validatebox" name="courierNum" type="text" style="width: 400px;" data-options="required:true"/><td>
				    </tr>
				 <tr >
						<td>物品名称:</td>
						<td><input class="easyui-validatebox" name="goodsName" type="text" style="width: 400px;" data-options="required:true"/><td>
				    </tr>
				    <tr >
						<td>检测结果:</td>
						<td><input class="easyui-validatebox" name="checkResult" type="text" style="width: 400px;" data-options="required:true"/><td>
				    </tr>
				    <tr >
						<td>订单号:</td>
						<td><input class="easyui-validatebox" name="orderNum" type="text" style="width: 400px;"  data-options="required:true"/><td>
				    </tr>
					
				   
				    <tr >
						<td>旺旺:</td>
						<td><input class="easyui-validatebox" name="wangwang" type="text" style="width: 400px;"/><td>
				    </tr>
				    <tr >
						<td>手机号:</td>
						<td><input class="easyui-validatebox" name="phoneNum" type="text" style="width: 400px;"/><td>
				    </tr>
				    <tr >
						<td>备注:</td>
						<td><textarea name="remark" style="width:100%;height:100px" style="width: 400px;" ></textarea><td>
				    </tr>
				    <tr >
						<td>处理状态:</td>
						<td>
							<input type="radio" name="status" value="待处理" checked="checked" />待处理
							<input type="radio" name="status" value="已处理" />已处理
						<td>
						
				    </tr>
			    </table>
			</form>
		</div>
		
	</body>
</html>
