<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--虚拟部门配置页面(弹出窗口)-->


<%@include file="/newrisk/jsp/common/tempTaglibs.jsp"%>
<link href="${ctx}/newrisk/style/zTreeStyle.css" rel="stylesheet" />
<script type="text/javascript" src="${ctx }/newrisk/js/introduce/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="${ctx }/newrisk/js/introduce/jquery.ztree.excheck-3.5.js"></script>
<!--以下页面的js操作-->
<script type="text/javascript">
$(".black_overlay").css("height",$(document).height());
<%--窗口关闭--%>
function closeDiv(){
	 $('#popWindow').remove();
	 $('.black_overlay').remove();	
}
initTree();
var doing='${searchDto.doing}';
if(doing=='check'){
        $('#sure').remove();
		var treeObj = $.fn.zTree.getZTreeObj("Dtree");
		var nodes = treeObj.getCheckedNodes(true);
		var sNode=new Array();
		for (var i=0;i<nodes.length;i++) {
	        var data={id:nodes[i].id,pId:nodes[i].pId,name:nodes[i].name};
	        sNode.push(data);
		}
		var setting = {
			   check: {
			        enable: false
		        },
		        data: {
					simpleData: {
						enable: true
					}
				}
		};
	$.fn.zTree.init($("#Dtree"), setting, sNode);
}
//点击确定
function cds_Sure(){
	var treeObj = $.fn.zTree.getZTreeObj("Dtree");
	var nodes=treeObj.getCheckedNodes(true);
	var temp="";
	for(var i=0;i<nodes.length;i++){
		if(nodes[i].children==null){
			temp+=nodes[i].id+",";
		 }
	}
	var virtualdepartment="${searchDto.newDepCode}";
	var entitydepartment=temp.substring(0,temp.length-1);
	var data={
	        'cdDepVir2EntDto.virtualdepartment': virtualdepartment,
        	'cdDepVir2EntDto.entitydepartment': entitydepartment
	};
	asy_Ajax("${ctx}/sysconfig/depManage_configureFictiDep.do",data,'html',function(data){
	     alert('配置成功');
	   	 closeDiv();
	});
}
function initTree(){
	   var setting = {
			   check: {
			        enable: true
		        },
	 			data: {
	 				simpleData: {
		 				enable: true
	 				}
	 			}
	    };
	   var zNodes=new Array();
	   var newdepcode=$('input[name="newdepcode"]');
	   var depname=$('input[name="depname"]');
	   var checked=$('input[name="checked"]');
	    for(var i=0,l=newdepcode.length;i<l;i++){
	         if(checked[i].value==1){
	     	    var dataFather={id:newdepcode[i].value,pId:0,name:depname[i].value, checked:true};
	         }else{
	         	var dataFather={id:newdepcode[i].value,pId:0,name:depname[i].value, checked:false};
	         }
	        zNodes.push(dataFather);
	    }
	    var Father={id:0,pId:0,name:'实体部门',open:true};
	    zNodes.push(Father);
		var zTreeObj  = $.fn.zTree.init($("#Dtree"), setting, zNodes);
		//处理子项加载默认选中，该子项的父项也选中
		var nodes = zTreeObj.getCheckedNodes();
		for (var i = 0, l = nodes.length; i < l; i++) {
			 zTreeObj.checkNode(nodes[i], true, true);
		 }
  }
</script>

  <div class="tree popdiv" >
  <div class="title" style="width:271px;margin-left:7px;">虚拟部门配置<a href="javascript:closeDiv()" title="关闭" class="close"></a></div>
  	<div class="con" style="height:300px;">
  	     <div style="overflow-y:scroll;height:240px;">
  	     <ul id="Dtree" class="ztree"></ul>
  	     </div>
        <a  id="sure" href="javascript:cds_Sure()" class="define">确&nbsp;定</a>
    </div>
    <div class="bottom"></div>
  </div>
         <!--部门代码-->
	    <input type="hidden" id="newDepCode" value="${searchDto.newDepCode }">
	    <!--部门List-->
	    <s:iterator value="ccDepartmentDtos"  var="ccDepartmentDto">
			      <input name="depname" type="hidden" value="<s:property value="#ccDepartmentDto.depname"/>"/>
			      <input name="newdepcode" type="hidden" value="<s:property value="#ccDepartmentDto.newdepcode"/>"/>
			      <input name="checked" type="hidden" value="<s:property value="#ccDepartmentDto.checked"/>"/>
	   </s:iterator>