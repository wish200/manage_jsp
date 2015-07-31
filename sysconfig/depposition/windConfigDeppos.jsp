<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--配置岗位页面(弹出窗口)-->


<%@include file="/jsp/common/tempTaglibs.jsp"%>
<link href="${ctx}/newrisk/style/zTreeStyle.css" rel="stylesheet" />
<script type="text/javascript" src="${ctx }/newrisk/js/introduce/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="${ctx }/newrisk/js/introduce/jquery.ztree.excheck-3.5.js"></script>
<!--以下页面的js操作-->
<script type="text/javascript">
$(".black_overlay").css("height",$(document).height());
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
<%--窗口关闭--%>
function closeDiv(){
	 $('#popWindow').remove();
	 $('.black_overlay').remove();	
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
	   var menuid=$('input[name="menuid"]');
	   var menuname=$('input[name="menuname"]');
	   var parentmenuid=$('input[name="parentmenuid"]');
	   var checked=$('input[name="checked"]');
	   var havesubmenu=$('input[name="havesubmenu"]');
	   var temp="";
	   var dataFather ="";
       for(var i=0,l=menuid.length;i<l;i++){
	        if(checked[i].value==1){
	              if(havesubmenu[i].value==0){
	                 dataFather={id:menuid[i].value,pId:parentmenuid[i].value,name:menuname[i].value, checked:true};
	              }else{
	                 dataFather={id:menuid[i].value,pId:parentmenuid[i].value,name:menuname[i].value};
	              }
	        } else{
	            	dataFather={id:menuid[i].value,pId:parentmenuid[i].value,name:menuname[i].value};
	        }
	                zNodes.push(dataFather);
       }
       var zTreeObj  = $.fn.zTree.init($("#Dtree"), setting, zNodes);
       //处理子项加载默认选中，该子项的父项也选中
	   var nodes = zTreeObj.getCheckedNodes();
	   for (var i = 0, l = nodes.length; i < l; i++) {
			 zTreeObj.checkNode(nodes[i], true, true);
	   }
<%--	   var noSelectNode = zTreeObj.getCheckedNodes(false);--%>
<%--	   if(noSelectNode.length==0){--%>
<%--	      $('#allCheck').attr('checked',true);--%>
<%--	      $('#allCheck').val('0');--%>
<%--	   }--%>
	    
 }
//点击配置
function cds_Sure(){
	var treeObj = $.fn.zTree.getZTreeObj("Dtree");
	var nodes=treeObj.getCheckedNodes(true);
	var temp="";
	for(var i=0;i<nodes.length;i++){
			temp+=nodes[i].id+",";
	}
	var deppositioncode='${searchDto.depPositionCode }';
	var menuid=temp.substring(0,temp.length-1);
	$.ajax({
        url :'${ctx}/sysconfig/depPosMan_configure.do',
        type : 'POST',
        data :{
        	'ccPositionMenuDto.deppositioncode': deppositioncode,
        	'ccPositionMenuDto.menuid': menuid
              },
        dataType : 'html',
        error : function(){
            alert('系统错误。请与管理员联系');
        },
        success :function(data){
        	alert('配置成功');
        	closeDiv();
        }
    }); 
    
   
  
}
</script>

  <div class="tree popdiv" >
  <div class="title" style="width:271px;margin-left:7px;">部门岗位配置<a href="javascript:closeDiv()" title="关闭" class="close"></a></div>
  	<div class="con" style="height:300px;">
  	     <div style="overflow-y:scroll;height:240px;">
  	     <ul id="Dtree" class="ztree"></ul>
  	     </div>
        <a  id="sure" href="javascript:cds_Sure()" class="define">确&nbsp;定</a>
    </div>
    <div class="bottom"></div>
  </div>
 <!--菜单List -->
	   <s:iterator value="ccMenuDtoList"  var="ccMenuDto">
			      <input name="menuname" type="hidden" value="${ccMenuDto.menuname }"/>
			      <input name="menuid" type="hidden" value="${ccMenuDto.menuid }"/>
			      <input name="parentmenuid" type="hidden" value="${ccMenuDto.parentmenuid }"/>
			      <input name="checked" type="hidden" value="${ccMenuDto.checked }"/>
			      <input name="havesubmenu" type="hidden" value="${ccMenuDto.havesubmenu }"/>
	   </s:iterator>