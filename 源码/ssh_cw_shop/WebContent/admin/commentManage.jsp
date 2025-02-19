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

<script type="text/javascript"><!--
	var url;
	//查询浏览
	function searchComment(){
		$('#dg').datagrid('load',{
			"s_comment.title":$("#s_commentTitle").val()
		});
	}
	//打开添加留言Dialog
	function openCommentAddDialog(){
		$("#dlg").dialog("open").dialog("setTitle","添加留言信息");
		url="comment_save.action";
	}
	//保存留言
	function saveComment(){
		$("#fm").form("submit",{
			url:"comment_replay.action",
			onSubmit:function(){
				return $(this).form("validate");
			},
			success:function(result){
				var result = eval('('+result+')');
				if(result.success){
					$.messager.alert("系统提示","回复成功");
					resetValue();
					$("#dlg").dialog("close");
					$("#dg").datagrid("reload");
				}else{
					$.messager.alert("系统提示","保存失败");
					return;
				}
			}
		});
	}
	//重置
	function resetValue(){
		$("#content").val("");
		$("#replyContent").val("");
	}
	//关闭留言Dialog
	function closeCommentDialog(){
		$("#dlg").dialog("close");
		resetValue();
	}
	//删除留言
	function deleteComment(){
		var selectedRows=$("#dg").datagrid('getSelections');
		if(selectedRows.length==0){
			$.messager.alert("系统提示","请选择要删除的数据！");
			return;
		}
		var strIds=[];
		for(var i=0;i<selectedRows.length;i++){
			strIds.push(selectedRows[i].id);
		}
		var ids=strIds.join(",");
		$.messager.confirm("系统提示","您确认要删掉这<font color=red>"+selectedRows.length+"</font>条数据吗？",function(r){
			if(r){
				$.post("comment_delete.action",{ids:ids},function(result){
					if(result.success){
						$.messager.alert("系统提示","数据已成功删除！");							
						$("#dg").datagrid("reload");
					}else{
						$.messager.alert('系统提示',result.errorMsg);
					}
				},"json");
			}
		});
	}
	//打开回复留言Dialog
	function openCommentReplyDialog(id){
		$.post("comment_loadCommentById.action",{commentId:id},function(result){
			$("#id").val(result.id);
			$("#nickName").val(result.nickName);
			$("#content").val(result.content);
			$("#createTime").val(result.createTime);
			$("#dlg").dialog("open").dialog("setTitle","回复留言");
			url="comment_save.action";
		},"json");
	
	}
	//格式化留言内容
	function formatReplyContent(val,row){
		if(val==""){
			return "<a href='javascript:openCommentReplyDialog("+row.id+")' >回复</a>";
		}else{
			return val;
		}
	}
	
</script>
</head>
<body style="margin: 1px;">
<table id="dg" title="留言管理" class="easyui-datagrid" fitColumns="true" 
    pagination="true" rownumbers="true" url="comment_listComment.action" fit="true" toolbar="#tb">
    <thead>
    	<tr>
    		<th field="cb" checkbox="true" align="center"></th>
    		<th field="id" width="50" align="center">编号</th>
    		<th field="content" width="200" align="center" >留言内容</th>
    		<th field="nickName" width="50" align="center" >留言人昵称</th>
    		<th field="createTime" width="50" align="center" >创建时间</th>
    		<th field="replyContent" width="200" align="center"  formatter="formatReplyContent">回复内容</th>
    		<th field="replyTime" width="50" align="center" >回复时间</th>
    	</tr>
    </thead>
</table>
<div id="tb">
	<div>
		<a href="javascript:deleteComment()" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除留言</a>
	</div>
	<div>
		&nbsp;留言名称：&nbsp;<input type="text" name="s_comment.name"  id="s_commentTitle"  size="20" onkeydown="if(event.keyCode==13) searchComment()"/>
		<a href="javascript:searchComment()" class="easyui-linkbutton" iconCls="icon-search" plain="true">搜索</a>
	</div>
</div>

<div id="dlg" class="easyui-dialog" style="width: 600px;height: 350px;padding: 10px 20px"
  closed="true" buttons="#dlg-buttons">
  <form id="fm" method="post">
  	<table cellspacing="8px;">
  		<tr>
  			<td valign="top">留言内容：</td>
  			<td colspan="4">
  				<textarea id="content" name="comment.content"  rows="4" cols="40"  readonly="readonly"></textarea>
  			</td>
  		</tr>
  		<tr>
  			<td valign="top">回复内容：</td>
  			<td colspan="4">
  				<textarea id="replyContent" name="comment.replyContent" rows="4" cols="40"  ></textarea>
  				
  				<input type="hidden" id="id" name="comment.id"/>
  				<input type="hidden" id="nickName" name="comment.nickName"/>
  				<input type="hidden" id="createTime" name="comment.createTime"/>
  			</td>
  		</tr>
  	</table>
  </form>
</div>

<div id="dlg-buttons">
	<a href="javascript:saveComment()" class="easyui-linkbutton" iconCls="icon-ok" >保存</a>
	<a href="javascript:closeCommentDialog()" class="easyui-linkbutton" iconCls="icon-cancel" >关闭</a>
</div>

</body>
</html>