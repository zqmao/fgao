<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page language="java" import="base.util.*"%>
<%
	int userId = PermissionUtil.check(request, response);
	boolean coupon = false;
	if(userId != 0){
		coupon = PermissionUtil.checkCoupon(request, response);
	}
%>

<html>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>优惠券列表</title>
	<link rel="stylesheet" type="text/css" href="../easyUi/themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="../easyUi/themes/icon.css" />
	<script type="text/javascript" src="../easyUi/jquery.min.js"></script>
	<script type="text/javascript" src="../easyUi/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="../easyUi/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="../js/clipboard.min.js"></script>

	
	<script type="text/javascript">
            $(function() {
            	loadTableData();
                $("#addCoupon").panel({
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
        					$("#addCoupon").panel("close");
        				}
        			}]
                });
                if(<%=coupon%>){
                	$("#addCoupon").panel("open");
            	}else{
            		$("#addCoupon").panel("close");
            	}
                
                $("#category").combobox({
                	onSelect: function(record){
                		if(record.value == "商品优惠券"){
                			$("#goodsName").show();
                		}else{
                			$("#goodsName").hide();
                		}
					}
                });
            });
            
            function loadTableData(){
            	
            	$("#couponGrid").datagrid({
                    selectOnCheck: true,
                    checkOnSelect: true,
                    pagination: true,
                    nowrap: false,
                    fit: false,
                    url: '../couponServlet.do?sign=list',
                    frozenColumns: [[
                            {field: 'ck', checkbox: true},
                            {title: '序号', field: 'id', width: 60},
                            {title: '店铺名称', field: 'shopName', width: 100, align: 'center'},
                            {title: '优惠券类型', field: 'category', width: 150, align: 'center'},
                            {title: '商品名称', field: 'goodsName', width: 80, align: 'center'},
                            {title: '优惠券内容', field: 'content', width: 400, align: 'center'},
                            {title: '有效期', field: 'deadLine', width: 180, align: 'center'},
                            {title: '备注', field: 'remark', width: 200, align: 'center'},
                            {title: '链接', field: 'link', width: 300, align: 'center'},
                            {title: '操作', field: 'opt', width: 100, align: 'center',
                            	formatter: function(value, rowData, rowIndex) {
                            		var opt = 
                            			"<a name='opt' data-clipboard-text='"+rowData.link+"' href='javascript:;' class='l-btn l-btn-small l-btn-plain' >"
	                            			+"<span class='l-btn-left l-btn-icon-left'><span class='l-btn-text'>复制</span><span class='l-btn-icon icon-cut'>&nbsp;</span></span>"
	                            		+"</a>";
                                	return opt;
                            	}
                            }
                        ]],
                    onLoadSuccess:function(data){
                    	var btn = document.getElementsByName('opt');
                        var clipboard = new Clipboard(btn);

                        clipboard.on('success', function(e) {
                            alert("复制成功");
                        });

                        clipboard.on('error', function(e) {
                        	alert("复制失败");
                        });
                    },
                    loadFilter: function(data){
                   		if (data.data){
                   			return data.data;
                   		} else {
                   			return data;
                   		}
                   	},
                   	onBeforeLoad: function(data){
                    	if(<%=coupon%>){
                    		$("#toolbar-remove-coupon-add").show();
                    		$("#toolbar-remove-coupon-edit").show();
                    		$("#toolbar-remove-coupon-delete").show();
                    	}else{
                    		$("#toolbar-remove-coupon-add").hide();
                    		$("#toolbar-remove-coupon-edit").hide();
                    		$("#toolbar-remove-coupon-delete").hide();
                    	}
                    },
                    toolbar: [{
                    	id: 'toolbar-remove-coupon-add',
                    	text:'增加',
                        iconCls: 'icon-add',
                        handler: function() {
                            $("#addCouponForm").form('clear');
                            $("#category").combobox('select', "店铺优惠券");
                            $("#addCoupon").panel('open');
                        }
                    }, {
                    	id: 'toolbar-remove-coupon-edit',
                    	text:'修改',
                        iconCls: 'icon-edit',
                        handler: function() {
                            var ids = getChecked("couponGrid");
                            var len = ids.length;
                            if (len == 0) {
                                $.messager.alert('提示', '至少选择一个', 'Warning');
                            } else if (len > 1) {
                                $.messager.alert('提示', '只能选择一个', 'Warning');
                            } else {
                                var row = $("#couponGrid").datagrid('getChecked');
                                $("#addCoupon").panel('open');
                                $("#addCoupon").form('load', {
                                	shopName: row[0].shopName,
                                	category: row[0].category,
                                	goodsName: row[0].goodsName,
                                	content: row[0].content,
                                	deadLine: row[0].deadLine,
                                	link: row[0].link,
                                	couponId: row[0].id,
                                	remark: row[0].remark
                                });
                            }
                        }
                    }, {
                    	id: 'toolbar-remove-coupon-delete',
                    	text:'删除',
                        iconCls: 'icon-remove',
                        handler: function() {
                            var ids = getChecked("couponGrid");
                            var len = ids.length;
                            if (len == 0) {
                                $.messager.alert('提示', '至少选择一个', 'Warning');
                            } else {
                                $.messager.confirm('Confirm', '确认要删除选择的项吗？', function(r) {
                                    if (r) {
                                        $.ajax({
                                            type: "POST",
                                            url: "../couponServlet.do?sign=delete",
                                            data: "couponIds=" + ids,
                                            success: function(msg) {
                                                $("#couponGrid").datagrid('reload');
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
				$("#addCouponForm").form('submit', {
				    url:"../couponServlet.do?sign=add",
				    success:function(result){
				    	var data = eval('(' + result + ')');
				    	if(data.result == 0){
				    		alert(data.reason);
				    	}else{
							$("#addCouponForm").form('clear');
        					$("#couponGrid").datagrid("reload");
        					$("#category").combobox('select', "店铺优惠券");
				    	}
				    }
				});
			}
            
        </script>
	</head>

	<body class="easyui-layout">
		<div class="easyui-panel" title="优惠券列表" style="width: 100%;">
			<table id="couponGrid" style="height: 500px;"></table>
		</div>
		<div id="addCoupon" class="easyui-panel" title="添加优惠券" style="width: 100%; height: 400px;padding: 10px;">
			<form id="addCouponForm" method="post">
				<input type="hidden" name="couponId" value="" />
				<table style="width: 100%">
					<tr >
						<td style="width:100px;"><label>选择类型:</label></td>
						<td>
							<select class="easyui-combobox" id="category" name="category" style="width:200px;">
							    <option value="店铺优惠券" checked="true">店铺优惠券</option>
							    <option value="商品优惠券">商品优惠券</option>
							</select>
						</td>
				    </tr>
				    <tr >
						<td style="width:100px;"><label>店铺名称:</label></td>
						<td><input class="easyui-textbox" type="text" name="shopName" style="width:200px;height:30px;"/></td>
				    </tr>
				    <tr id="goodsName">
						<td style="width:100px;"><label>商品名称:</label></td>
						<td><input class="easyui-textbox" type="text" name="goodsName" style="width:200px;height:30px;"/></td>
				    </tr>
				    <tr >
						<td style="width:100px;"><label>优惠券内容:</label></td>
						<td><input class="easyui-textbox" type="text" name="content" style="width:80%;height:30px;"/></td>
				    </tr>
				    <tr >
						<td style="width:100px;"><label>有效期:</label></td>
						<td>
							<input type="datetime" name="deadLine" class="easyui-datetimebox" style="width:200px;height:30px;"/>
						</td>
				    </tr>
				    <tr >
						<td style="width:100px;"><label>录入备注:</label></td>
						<td><input class="easyui-textbox" type="text" name="remark" style="width:80%;height:30px;"/></td>
				    </tr>
				    <tr >
						<td style="width:100px;"><label>优惠券链接:</label></td>
						<td><input class="easyui-textbox" type="text" name="link" style="width:400px;height:30px;"/></td>
				    </tr>
			    </table >
			</form>
		</div>
	</body>
</html>
