<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--配置险种页面(弹出窗口)-->


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
//点击配置
function cds_Sure(){
	var treeObj = $.fn.zTree.getZTreeObj("Dtree");
	var nodes=treeObj.getCheckedNodes(true);
	var temp="";
	for(var i=0;i<nodes.length;i++){
		if(nodes[i].children==null){
		  temp+=nodes[i].id+",";
		}
	}
	var newDepCode='${searchDto.newDepCode }';
	var classcode=temp.substring(0,temp.length-1);
	var data={
        	'cdDepRiskDto.department': newDepCode,
        	'cdDepRiskDto.classcode': classcode
    };
	asy_Ajax("${ctx}/sysconfig/depManage_configureClass.do",data,'html',function(result){
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
	   var classcode=$('input[name="classcode"]');
	   var classname=$('input[name="classname"]');
	   var fathercode=$('input[name="fathercode"]');
	   var levelcode=$('input[name="levelcode"]');
	   var checked=$('input[name="checked"]'); 
	    for(var i=0;i<classcode.length;i++){
	          if(checked[i].value==1){
	        	 var dataFather={id:classcode[i].value,pId:fathercode[i].value,name:classname[i].value, checked:true,open:true};
	          }else{
	        	 var dataFather={id:classcode[i].value,pId:fathercode[i].value,name:classname[i].value, checked:false,open:true};
	          }
	          zNodes.push(dataFather);
	     }
		var zTreeObj  = $.fn.zTree.init($("#Dtree"), setting, zNodes);
		 var noSelectNode = zTreeObj.getCheckedNodes(false);
	   if(noSelectNode.length==0){
	      $('#allCheck').attr('checked',true);
	      $('#allCheck').val('0');
	   }
		//处理子项加载默认选中，该子项的父项也选中
		var nodes = zTreeObj.getCheckedNodes();
		for (var i = 0, l = nodes.length; i < l; i++) {
			 zTreeObj.checkNode(nodes[i], true, true);
		}
 }
</script>

  <div class="tree popdiv" >
  <div class="title" style="width:271px;margin-left:7px;">险种配置<a href="javascript:closeDiv()" title="关闭" class="close"></a></div>
  	<div class="con" style="height:300px;">
  	     <div style="overflow-y:scroll;height:240px;">
  	     <ul id="Dtree" class="ztree"></ul>
  	     </div>
        <a  id="sure" href="javascript:cds_Sure()" class="define">确&nbsp;定</a>
    </div>
    <div class="bottom"></div>
  </div>
            <!-- 险种List -->
			<s:iterator value="cdClassDtos" var="cdClassDto">
					<input name="classcode" type="hidden" value="${cdClassDto.classcode }" />
					<input name="classname" type="hidden" value="${cdClassDto.classname }" />
					<input name="fathercode" type="hidden" value="${cdClassDto.fathercode }" />
					<input name="levelcode" type="hidden" value="${cdClassDto.levelcode }" />
					<input name="checked" type="hidden" value="${cdClassDto.checked }" />
			</s:iterator>