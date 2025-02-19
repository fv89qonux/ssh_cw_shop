<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>宠物管理系统</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/jquery-easyui-1.3.3/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
	
	//查询订单
	function searchOrder(){
		$("#dg").datagrid('load',{
			"s_order.orderNo":$("#s_orderNo").val(),
			"s_order.user.userName":$("#s_userName").val()
		});
	}
	//格式化用户ID
	function formatUserId(val,row){
		return row.user.id;
	}
	//格式化用户Name
	function formatUserName(val,row){
		return row.user.userName;
	}
	//格式化订单状态
	function formatStatus(val,row){
		if(val==1){
			return "待审核";
		}else if(val==2){
			return "审核通过";
		}else if(val==3){
			return "卖家已发货";
		}else if(val==4){
			return "交易已完成";
		}
		return "";
	}
	//格式化商品图片
	function formatProPic(val,row){
		return "<img width=100 height=100 src='${pageContext.request.contextPath}/"+val+"'>";
	}
	//打开商品订单信息Dialog
	function openOrderDetailDialog(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length!=1){
			$.messager.alert("系统提示","请选择一条要查看的数据！");
			return;
		}
		var row=selectedRows[0];
		$("#dg2").datagrid('load',{
			"id":row.id
		});
		$("#orderNo").val(row.orderNo);
		$("#user").val(row.user.userName+"(ID:"+row.user.id+")");
		$("#cost").val(row.cost+"(元)");
		var v=row.status;
		if(v==1){
			$("#status").val("待审核");
		}else if(v==2){
			$("#status").val("审核通过");
		}else if(v==3){
			$("#status").val("卖家已发货");
		}else if(v==4){
			$("#status").val("交易已完成");
		}
		$("#dlg").dialog("open").dialog("setTitle","订单详情");
	}
	//关闭订单信息Dialog
	function closeOrderDetailDialog(){
		$("#dlg").dialog("close");
	}
	//修改订单状态
	function modifyOrderStatus(status){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要处理的数据！");
			return;
		}
		var orderNosStr=[];
		for(var i=0;i<selectedRows.length;i++){
			orderNosStr.push(selectedRows[i].orderNo);
		}
		var orderNos=orderNosStr.join(",");
		$.messager.confirm("系统提示","您确认要处理这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
			if(r){
				$.post("order_modifyOrderStatus.action",{orderNos:orderNos,status:status},function(result){
					if(result.success){
						$.messager.alert("系统提示","数据已成功处理！");
						$("#dg").datagrid("reload");
					}else{
						$.messager.alert("系统提示","数据处理失败！");
					}
				},"json");
			}
		});
	}

</script>
</head>
<body style="margin:1px;">
	<table id="dg" title="订单管理" class="easyui-datagrid"
	 fitColumns="true" pagination="true" rownumbers="true"
	 url="order_list.action" fit="true" toolbar="#tb">
	 <thead>
	 	<tr>
	 		<th field="cb" checkbox="true" align="center"></th>
	 		<th field="id" width="50" align="center">编号</th>
	 		<th field="orderNo" width="100" align="center">订单号</th>
	 		<th field="user.id" width="50" align="center" formatter="formatUserId">订单人ID</th>
	 		<th field="user.userName" width="100" align="center" formatter="formatUserName">订单人用户名</th>
	 		<th field="createTime" width="100" align="center">创建时间</th>
	 		<th field="cost" width="50" align="center">总金额</th>
	 		<th field="status" width="100" align="center" formatter="formatStatus">订单状态</th>
	 	</tr>
	 </thead>
	</table>
	
	<div id="tb">
		<div>
			<a href="javascript:openOrderDetailDialog()" class="easyui-linkbutton" iconCls="icon-detail" plain="true">查看订单详情</a>
			<a href="javascript:modifyOrderStatus(2)" class="easyui-linkbutton" iconCls="icon-shenhe" plain="true">审核通过</a>
			<a href="javascript:modifyOrderStatus(3)" class="easyui-linkbutton" iconCls="icon-fahuo" plain="true">卖家已发货</a>
		</div>
		<div>
			&nbsp;订单号：&nbsp;<input type="text" id="s_orderNo" size="20" />
			&nbsp;订单人：&nbsp;<input type="text" id="s_userName" size="20" />
			<a href="javascript:searchOrder()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
		</div>
	</div>
	
	<div id="dlg" class="easyui-dialog" style="width: 750px;height:400px;padding: 10px 30px"
	  closed="true" buttons="#dlg-buttons">
		<table cellspacing="8px">
			<tr>
				<td>订单号：</td>
				<td><input type="text" id="orderNo" readonly="readonly"/></td>
				<td>&nbsp;</td>
				<td>订单人：</td>
				<td><input type="text" id="user" readonly="readonly"/></td>
			</tr>
			<tr>
				<td>总金额：</td>
				<td><input type="text" id="cost" readonly="readonly"/></td>
				<td>&nbsp;</td>
				<td>订单状态：</td>
				<td><input type="text" id="status" readonly="readonly"/></td>
			</tr>
		</table>
		<br/>
		<table id="dg2" title="订单商品列表" class="easyui-datagrid"
		 fitColumns="true"  rownumbers="true"
		 url="order_findProductListByOrderId.action" fit="true" >
		 <thead>
		 	<tr>
		 		<th field="cb" checkbox="true" align="center"></th>
		 		<th field="productName" width="100" align="center">商品名称</th>
		 		<th field="proPic" width="100" align="center" formatter="formatProPic">商品图片</th>
		 		<th field="price" width="50" align="center">商品价格</th>
		 		<th field="num" width="50" align="center">商品数量</th>
		 		<th field="subtotal" width="50" align="center">小计</th>
		 	</tr>
		 </thead>
		</table>
	</div>
	
	<div id="dlg-buttons">
		<a href="javascript:closeOrderDetailDialog()" class="easyui-linkbutton" iconCls="icon-cancel">关闭</a>
	</div>
</body>
</html>