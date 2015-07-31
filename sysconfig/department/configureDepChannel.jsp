<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<head>
<!--配置渠道 -->
<%@include file="/newrisk/jsp/common/temptaglibs2.jsp"%>
<link href="${ctx }/newrisk/resource/styles/zTreeStyle.css" rel="stylesheet" />
<script type="text/javascript" src="${ctx }/newrisk/resource/js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="${ctx }/newrisk/resource/js/jquery.ztree.excheck-3.5.js"></script>
<script type="text/javascript">
$(function(){
    //初始化树型菜单
    initTree();
   //全选
    $("#allCheck").click(function(){
      if($(this).val()=='1'){
          var treeObj = $.fn.zTree.getZTreeObj("Dtree");
          treeObj.checkAllNodes(true);
          $(this).val('0');
      }else{
	      var treeObj = $.fn.zTree.getZTreeObj("Dtree");
	      treeObj.checkAllNodes(false);
	       $(this).val('1');
      }
    });
    var doing='${searchDto.doing}';
    if(doing!=null&&doing!=''){
        var treeObj = $.fn.zTree.getZTreeObj("Dtree");
		var nodes = treeObj.getCheckedNodes(true);
		var sNode=new Array();
		for (var i=0;i<nodes.length;i++) {
		if(nodes[i].pId==null){
		   nodes[i].pId=-1;
		}
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
});
var flag={"nullV":true};
//点击配置
function cdc_Sure(){
    var ok=flag.nullV;
    if(!ok){
       return false;
    }
	var treeObj = $.fn.zTree.getZTreeObj("Dtree");
	var nodes=treeObj.getCheckedNodes(true);
	var temp="";
	for(var i=0;i<nodes.length;i++){
		if(nodes[i].children==null){
			temp+=nodes[i].id+",";
		 }
	}
	var department=$('#newDepCode').val();
	var channelcode=temp.substring(0,temp.length-1);
	$.ajax({
        url :'${ctx}/sysconfig/depManage_configureChannel.do',
        type : 'POST',
        data :{
        	'ccDepChannelDto.department': department,
        	'ccDepChannelDto.channelcode': channelcode
              },
        dataType : 'html',
        error : function(){
            alert('系统错误。请与管理员联系');
        },
        success :function(data){
        	alert('配置成功！');
        	$("#popWindow").detach();
        	$(".black_overlay").hide();
        }
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
	   var channelcode=$('input[name="channelcode"]');
	   var channelname=$('input[name="channelname"]');
	   var fathercode=$('input[name="fathercode"]');
	   var levelcode=$('input[name="levelcode"]');
	   var checked=$('input[name="checked"]');
	   var temp="";
	   var Father={id:0,pId:0,name:'渠道名称',open:true};
	       zNodes.push(Father);
	    for(var i=0;i<channelcode.length;i++){
	        if(checked[i].value==1){
	        	 var dataFather={id:channelcode[i].value,pId:0,name:channelname[i].value,checked:true};
	          }else{
	        	 var dataFather={id:channelcode[i].value,pId:0,name:channelname[i].value,checked:false};
	                }
	              zNodes.push(dataFather);
	     }
	    //初始化
		var zTreeObj  = $.fn.zTree.init($("#Dtree"), setting, zNodes);
		//处理子项加载默认选中，该子项的父项也选中
		var nodes = zTreeObj.getCheckedNodes();
		for (var i = 0, l = nodes.length; i < l; i++) {
			 zTreeObj.checkNode(nodes[i], true, true);
		}
		var noSelectNode = zTreeObj.getCheckedNodes(false);
	    if(noSelectNode.length==0){
	      $('#allCheck').attr('checked',true);
	      $('#allCheck').val('0');
	    }
 }
//搜索
function onSearch(){
	 var SearchValue=$('#Search-content').val();
	 var length=SearchValue.length;//搜索输入的长度
	 var zNodes=new Array();
	 var temp="";
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
	  if(SearchValue==""){
	     initTree();
	     flag.nullV=true;
	  }else{
		      for(var i=0;i<channelcode.length;i++){
		         if(channelname[i].value.lastIndexOf(SearchValue)!=-1){
		              var dataFather={id:channelcode[i].value,pId:0,name:channelname[i].value};
		         	  zNodes.push(dataFather);
		         }
	          }
	          if(zNodes.length!=0){
		          var Father={id:0,pId:0,name:'渠道名称', checked:true,open:true};
			      zNodes.push(Father);
			      flag.nullV=true;
	          }else{
	              flag.nullV=false;
	          }
	          $.fn.zTree.init($("#Dtree"), setting, zNodes);
	  }  
}
//输入搜索
function Focus(search){
    if(search.value=="输入字段名搜索"){
		search.value="";
	}
}
function Blurs(search){
	if(search.value==""){
		 initTree();
	}
}
</script>
</head>
<div id="popWindow" style="position:fixed; left:420px; top:60px; border:1px solid #999;width:310px;height:390px;background:#fff;z-index:99999;">
	<div style="padding-left:10px;padding-top:10px;">
		<table class="tabBasic">
			<tr>
			    <s:if test="%{searchDto.doing!='check'}">
				<td>渠道名称：</td>
				<td>
				<input id="Search-content" onFocus="Focus(this)" onblur="Blurs(this)" style="border:1px solid #999; width:168px;height:25px;" type="text" value="输入字段名搜索" />
                    <a onclick="onSearch()"><img src="${ctx}/newrisk/images/search.gif" width="30" height="30" alt="搜索" /></a>
				<!--部门代码-->
				<input type="hidden" id="newDepCode" value="${searchDto.newDepCode }">
				</td>
				</s:if>
			</tr>
			
			<!-- 渠道List -->
			<s:iterator value="cdChannelDtos"  var="cdChannelDto">
			      <input name="channelcode" type="hidden" value="<s:property value="#cdChannelDto.channelcode"/>"/>
			      <input name="channelname" type="hidden" value="<s:property value="#cdChannelDto.channelname"/>"/>
			      <input name="fathercode" type="hidden" value="<s:property value="#cdChannelDto.fathercode"/>"/>
			      <input name="levelcode" type="hidden" value="<s:property value="#cdChannelDto.levelcode"/>"/>
			      <input name="checked" type="hidden" value="<s:property value="#cdChannelDto.checked"/>"/>
			</s:iterator>
			
		</table>
	</div>
	<div style="border:1px solid #999;width:300px;height:250px;float:left;margin-top:10px;margin-left:1px;background:white;overflow-y:auto;">
		全选：<input id="allCheck"  style="bottom:0px;"  type="checkbox" value="1" />
		<ul id="Dtree" class="ztree">
		</ul>
	</div>
	<s:if test="%{searchDto.doing!='check'}">
	<div id="Div" class="dBtn" style="clear:both;text-align:left;margin-left:15px;">
	    <input  onclick="cdc_Sure()"  id="chSure" type="button" class="btnDete" value="确&nbsp;定" />
		<input  onclick="fanHui()"  id="fanHui" type="button" class="btnDete" value="返&nbsp;回" />
	</div>
	</s:if>
	<s:else>
	<div id="checkDiv" class="dBtn" style="clear:both;margin-left:15px;">
		<input  onclick="fanHui()"  id="fanHui" type="button" class="btnDete" value="返&nbsp;回" />
	</div>
	</s:else>
</div>