<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@include file="/newrisk/jsp/common/tempTaglibs.jsp"%>
<link href="${ctx}/newrisk/style/zTreeStyle.css" rel="stylesheet" />
<!--邮件抄送人-->
<div>
<script type="text/javascript" src="${ctx }/newrisk/js/introduce/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="${ctx }/newrisk/js/introduce/jquery.ztree.excheck-3.5.js"></script>
<script type="text/javascript">
$(".black_overlay").css("height",$(document).height());
initTree();
//--关闭窗口
function closeDiv(){
    $('#popWindow').remove();
	$('.black_overlay').remove();
}
function onClick(event, treeId, treeNode){}	
//初始化树形结构
function initTree(){
	 var setting = {
	 			data: {
	 				simpleData: {
		 				enable: true
	 				}
	 			},
	            callback: {
					onClick: onClick
				}
	 		};
	   var department=$('input[name="department"]');
       var depName=$('input[name="depName"]');
       var userName=$('input[name="userName"]');
       var userCode=$('input[name="userCode"]');
       var zNodes=new Array();
       var temp="";
       for(var i=0;i<department.length;i++){
          if(temp.indexOf(department[i].value)!=-1){
          }else{
            var dataFather={id:department[i].value,pId:0,name:depName[i].value};
            zNodes.push(dataFather);
            temp+=department[i].value;
          }
	        var dataChild={id:userCode[i].value,pId:department[i].value,name:userName[i].value};
	        zNodes.push(dataChild);
       }
       $.fn.zTree.init($("#Dtree"), setting, zNodes);
}
//--搜索按钮
function searchBtn(){
	var setting = {
	 			data: {
	 				simpleData: {
		 				enable: true
	 				}
	 			},
	            callback: {
					onClick: onClick
				}
	     };
        var searchValue=$('#searchValue').val();
        var department=$('input[name="department"]');
        var depName=$('input[name="depName"]');
        var userName=$('input[name="userName"]');
        var userCode=$('input[name="userCode"]');
        var zNodes=new Array();
        var length=searchValue.length;
        if(length==0){
             initTree();
        }
	    for(var i=0;i<department.length;i++){
	          if(userName[i].value.lastIndexOf(searchValue)!=-1){
	                   var dataChild={id:userCode[i].value,pId:department[i].value,name:userName[i].value};
	      		       zNodes.push(dataChild);
	      		       var flag=true;
	      		       for(var j=0;j<zNodes.length;j++){
	      		           if(flag){
		      		           if(zNodes[j].id==department[i].value){
	                             flag=false;           	      		           
		      		           }
	      		           }
	      		       }
	      		       if(flag){
	      		           var dataFather={id:department[i].value,pId:0,name:depName[i].value,open:true};
	      		           zNodes.push(dataFather);
	      		       }
	          }
	    }
     	$.fn.zTree.init($("#Dtree"), setting, zNodes);
}
//--添加到右边
function addRight(){
          var zTree = $.fn.zTree.getZTreeObj("Dtree");
		  var nodes = zTree.getSelectedNodes();
		  var tempOption ="";
		  var c=0;
		  for (var i=0, l=nodes.length;i<l; i++) {
		      var flag=true;
		      if(nodes[i].pId!=null){//不是部门的时候加入
			      $("#cTreeDiv ul").find('li').each(function(){
				       if($(this).html().indexOf(nodes[i].name)!=-1){
				          flag=false;
				       }
			      });
			      if(flag){
			           tempOption+="<li  dep='"+nodes[i].pId+"' rid='"+nodes[i].id+"' value='"+nodes[i].name+"'><span>"+nodes[i].name+"</span><a onclick='deleteUser(this)'>关闭</a></li>";
			      };
		      }
		  }
	      if(tempOption!=""){
			  $('#cTreeDiv ul').append(tempOption);
		  }
}
//删除添加的人员
function deleteUser(date){
   $(date).parents('li').remove();
}
//清空所以人员
function clearUser(){
    $("#cTreeDiv ul").html("");
}
//确定添加人员
function queDing(){
    var selectRid=new Array();
    var selectDep=new Array();
    var selecvalue=new Array();
    $('#cTreeDiv ul li').each(function(){
        selecvalue.push($(this).attr('value'));
        selectRid.push($(this).attr('rid'));
        selectDep.push($(this).attr('dep'));
    });
    $('#Caddressee').val(selecvalue);
    $('#BCCid').val(selectRid); 
    $('#Depid').val(selectDep);
    closeDiv();
}
//
function Blurs(search){
    if(search.value==""){
         initTree();
    }
}


//修改状态下--
innertRight();
//右侧初始化
function innertRight(){
  var  _Caddressee=$.trim($("#Caddressee").val());
  if(_Caddressee!=''){
    var _bccId=$.trim($("#BCCid").val());
    var _depId=$.trim($("#Depid").val());
    var _bccIdArray=_bccId.split(',');
    var _depIdArray=_depId.split(',');
     var _CaddresseeArray=_Caddressee.split(',');
   
    var tempHtml="";
    for(var i=0;i<_bccIdArray.length;i++){
         tempHtml+="<li dep=' "+_depIdArray[i]+"' rid='"+_bccIdArray[i]+"'  value='"+_CaddresseeArray[i]+"'><span>"+_CaddresseeArray[i]+"</span><a onclick='deleteUser(this)'>关闭</a></li>";
    }
    $("#cTreeDivUser").append(tempHtml); 
  }
}



</script>
</div>

 <div class="searchpop_big">
  	<div class="con">
    	<div class="left">
        	<div class="search_inp">
                <label>名称搜索</label>
                <input id="searchValue" name="" onblur="Blurs(this)"  style="width:150px;" type="text" value="" />
                <a href="javascript:searchBtn()">搜索</a>
            </div>
            <div id="scroll_bd" class="tree">
                <div id="treeDiv" style="overflow-y:scroll;height:300px;">
			  	     <ul id="Dtree" style="overflow:hidden;white-space: nowrap;text-overflow: ellipsis;" class="ztree"></ul>
                </div>
            </div>
        </div>
        <div class="right">
        	<div class="tit">
            	<span>已选择人员</span>
                <a  onclick="clearUser()" style="cursor:pointer;" >清空</a>
            </div>
           <div id="cTreeDiv">
            <ul id="cTreeDivUser">
            </ul>
            </div> 
        </div>
        <div class="jt" onclick="addRight()" style="cursor:pointer;"></div>
        <div class="button_div">
        	<a class="return" href="javascript:closeDiv();">返　回</a>
            <a class="define" href="javascript:queDing();">确　定</a>
        </div>
    </div>
    <div class="bottom"></div>
  </div>
	<!-- 收件人数据(人员管理数据) -->
	 <s:iterator value="ccUserDtoList">
		  <input  name="department" type="hidden" value="${newdepcode}"/>
		  <input  name="depName" type="hidden"  value="${ccDepartmentBaseDto.depname}"/>
		  <input  name="userName" type="hidden"  value="${username}"/>
		  <input  name="userCode" type="hidden"  value="${usercode}"/>
	 </s:iterator>