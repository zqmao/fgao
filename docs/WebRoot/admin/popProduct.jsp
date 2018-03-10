<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<div id="product_win" class="easyui-window" title="产品搜索框" style="width:800px;height:600px;" closable="true">
<input type="hidden" id="query_id">
<input type="hidden" id="query_name">
		<div id="result_query" style="padding:3px">
			<span>所属店铺:</span>
			<input id="popShopId" class="easyui-combobox"  required="true"
					data-options="
							url:'../shopServlet.do?sign=select',
							method:'post',
							valueField:'id',
							textField:'text',
							panelHeight:'auto'
					">
			<span>产品标题:</span>
			<input id="popTitle" style="line-height:26px;border:1px solid #ccc">
			<a href="#" class="easyui-linkbutton" plain="true" onclick="popSearch()" id="searchButton">搜索(Enter)</a>
		</div>	
		<table id="product_result" class="easyui-datagrid" style="width:785px;height:520px"
				url="../goodsLinkServlet.do?sign=list"
				toolbar="#result_query"
				singleSelect="true"
				pagination="true">

		</table>
		<div style="padding:5px;text-align:center;">
			<a href="javascript:okWin()" class="easyui-linkbutton" icon="icon-ok">确定</a>
			<a href="#" onclick="javascript:$('#product_win').dialog('close')" class="easyui-linkbutton" icon="icon-cancel">关闭</a>
		</div>
</div>

<script type="text/javascript">
$('#product_result').datagrid({
	columns:[[
		{field:'id',title:'编号', width:50,align:'center'},
		{field:'title',title:'标题', width:300,align:'left',
			styler: function(value,row,index){
		
					return 'word-wrap: break-word;';
					// the function can return predefined css class and inline style
					// return {class:'c1',style:'color:red'}
			}
		},
		{field:'shopName',title:'所属店铺', width:150,align:'center'},
		{field:'tid',title:'天猫产品ID', width:100,align:'center'},
		{field:'imgLink',title:'图片', width:70,align:'center',
			formatter: function(value,row,index){
				if (row.tid){
					return "<img src='"+value+"' width='60'/>";
				} else {
					return value;
				}
			}
		},
		{field:'op',title:'操作', width:50,align:'center',
			formatter: function(value,row,index){
				if (row.tid){
					return "<a href='https://detail.tmall.com/item.htm?id="+row.tid+"' target='_blank'>查看</a>";
				} else {
					return value;
				}
			}
		}
		
	]],
	onDblClickRow:function(rowIndex, rowData){
		okWin();
	}
});

$(document).ready(function(){
	$('#product_win').dialog('close');
});


document.onkeydown = function (event) {	
    var e = event || window.event || arguments.callee.caller.arguments[0];
    if (e && e.keyCode == 13) {
    	popSearch();
    }
};

$('#win_name').change(function(){
	//console.log($(this).val());
	console.log('123');
});

function popSearch(){
 	$('#product_result').datagrid('load',{
 		eq_shopId: $('#popShopId').val(),
		li_title: $('#popTitle').val()
 	});
 }
	
	
</script>