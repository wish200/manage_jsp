<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--addUser页面(弹出窗口)-->


<div class="user_info">
<%@include file="/newrisk/jsp/common/tempTaglibs.jsp"%>
<script type="text/javascript" src="${ctx }/newrisk/js/common/levCompany.js"></script>
<!--以下页面的js操作-->
<script type="text/javascript">
selectOption();
initCompany("2","comCode",'${ccDepartmentDto.comcode}');



$(".black_overlay").css("height",$(document).height());
//虚拟部门名称-校验规则
$('#depName').keyup(function(){
		  var value=$(this).val().replace(/[^\x00-\xff]/g, 'xx');
		  if(value.length>50){
			   alert("虚拟部门名称不能超过50个字符！");
			   var value=$(this).val();
			   $(this).val(value.substring(0,25));
		  }
 });
 //虚拟部门名称-校验是否存在
 $('#depName').blur(function(){
    var depName=$(this).val();
    var depName2='${ccDepartmentDto.depname}';
    if(depName!=''&&depName2!=depName){
		      $.ajax({
		            url :'${ctx}/sysconfig/depManage_exitsDep.do',
		            type : 'POST',
		            data :{
		               'searchDto.departMentName':depName
		            },
		            dataType : 'json',
		            error : function() {
		                alert('系统错误。请与管理员联系');
		            },
		            success :function(data){
		               if(data>0){
			              alert("虚拟部门名称已经存在！");
			              $('#depName').val('');
			           }
		            }
		        }); 
		   
       }
  });
<%--模拟下拉列表框--%>

<%--确定按钮--%>
function Submit(){
    var toDo='${searchDto.doing}';//做什么操作
    var ok=haveData("depName","虚拟部门名称不能为空！")&&haveData("depkindCode","请选择部门类型！")&&haveData("validstate","请选择状态！");
    var url,messs;
    if(ok){
    if(toDo=='add'){
         url="${ctx}/sysconfig/depManage_addVir.do";
         messs="添加虚拟部门成功";
    }else if(toDo=='update'){
    	 url="${ctx}/sysconfig/depManage_updateVir.do";
    	 messs="修改虚拟部门成功";
    }
    $("#depForm").ajaxSubmit({
        type : 'post',  
        url : url,  
        error: function(XmlHttpRequest, textStatus, errorThrown){  
             alert( "系统错误");  
        },
        success: function(data){
       	    alert(messs);
        	$("#content").html(data);
        	$('#popWindow').remove();
        	$('.black_overlay').remove();	
        }
    });
   }
}
<%--窗口关闭--%>
function closeDiv(){
	 $('#popWindow').remove();
	 $('.black_overlay').remove();	
}
</script>

  	<div class="title">
  	<s:if test="%{searchDto.doing=='add'}">新增</s:if><s:else>编辑</s:else>虚拟部门<a href="javascript:closeDiv()" title="关闭" class="close"></a></div>
    <div class="con">
        <form id="depForm" action="" method="post">
    	<ul>
    	    <li>
    	        <label>归属机构：</label>
                <div class="select select_1">
                    <span>请选择</span>
                    
                    <input id="comcode" name="ccUserDto.comcode" value="<s:property value="ccDepartmentDto.comCode " />" type="hidden"/>
                    <dl id="comCode">
                        
                    </dl>
                </div><span style="color:red">*</span> 
            </li>
        	<li>
        	   <label>机构名称：</label>
                <span class="input_1">
                   <input name="ccDepartmentDto.newdepcode"  type="hidden" value="${ccDepartmentDto.newdepcode }">
                   <input id="depName" name="ccDepartmentDto.depname" value="${ccDepartmentDto.depname}" type="text" />
                </span><span style="color:red">*</span>
            </li>
            <li>
            	<label>部门类型：</label>
                <div class="select select_1">
                <s:if test="%{ccDepartmentDto.depkindcode=='D1000011Y'}">
                    <span>产品线部门</span>
                	<input id="depkindCode" value="D1000011Y" name="ccDepartmentDto.depkindcode" type="hidden"/>
                </s:if>
                <s:elseif test="%{ccDepartmentDto.depkindcode=='D2000011Y'}">
                <span>渠道部门</span>
                	<input id="depkindCode" value="D2000011Y" name="ccDepartmentDto.depkindcode" type="hidden"/>
                </s:elseif>
                 <s:elseif test="%{ccDepartmentDto.depkindcode=='D3000011Y'}">
                <span>理赔事业部</span>
                	<input id="depkindCode" value="D3000011Y" name="ccDepartmentDto.depkindcode" type="hidden"/>
                </s:elseif>
                 <s:elseif test="%{ccDepartmentDto.depkindcode=='D4000011Y'}">
                <span>再保险部</span>
                	<input id="depkindCode" value="D4000011Y" name="ccDepartmentDto.depkindcode" type="hidden"/>
                </s:elseif>
                 <s:elseif test="%{ccDepartmentDto.depkindcode=='D5000011Y'}">
                <span>资金运营部部</span>
                	<input id="depkindCode" value="D5000011Y" name="ccDepartmentDto.depkindcode" type="hidden"/>
                </s:elseif>
                 <s:elseif test="%{ccDepartmentDto.depkindcode=='D6000011Y'}">
                <span>其他支持服务部门</span>
                	<input id="depkindCode" value="D6000011Y" name="ccDepartmentDto.depkindcode" type="hidden"/>
                </s:elseif>
                 <s:elseif test="%{ccDepartmentDto.depkindcode=='D7000021Y'}">
                <span>总裁室</span>
                	<input id="depkindCode" value="D7000021Y" name="ccDepartmentDto.depkindcode" type="hidden"/>
                </s:elseif>
                <s:else>
                 <span>请选择</span>
                	<input id="depkindCode" value="" name="ccDepartmentDto.depkindcode" type="hidden"/>
                </s:else>
                    <dl>
                        <dd value="">请选择</dd>
                    	<dd value="D1000011Y">产品线部门</dd>
                        <dd value="D2000011Y">渠道部门</dd>
                        <dd value="D3000011Y">理赔事业部</dd>
                        <dd value="D4000011Y">再保险部</dd>
                        <dd value="D5000011Y">资金运营部部</dd>
                        <dd value="D6000011Y">其他支持服务部门</dd>
                        <dd value="D7000021Y">总裁室</dd>
                    </dl>
                </div><span style="color:red">*</span>
            </li>
            <li>
            	<label>状态 ：</label>
                <div class="select select_1">
                <s:if test="%{ccDepartmentDto.validstate==1}">
                <span>使用</span>
                	<input id="validstate" value="1" name="ccDepartmentDto.validstate" type="hidden"/>
                </s:if>
                <s:elseif test="%{ccDepartmentDto.validstate==0}">
                <span>停用</span>
                	<input id="validstate" value="0" name="ccDepartmentDto.validstate" type="hidden"/>
                </s:elseif>
                <s:else>
                   <span>请选择</span>
                	<input id="validstate" value="" name="ccDepartmentDto.validstate" type="hidden"/>
                </s:else>
                    <dl>
                        <dd value="">请选择</dd>
                    	<dd value="1">使用</dd>
                        <dd value="0">停用</dd>
                    </dl>
                </div><span style="color:red">*</span> 
            </li>
        </ul>
        <input name="ccDepartmentDto.depcatg" type="hidden" value="0"/>
        </form>
        <div class="button_div">
            <s:if test="%{searchDto.doing=='add'}">
            <a href="javascript:closeDiv()" class="return">取　消</a>
            <a href="javascript:Submit()" class="define">保　存</a>
            </s:if>
            <s:else>
            <a href="javascript:closeDiv()" class="return">返　回</a>
            <a href="javascript:Submit()" class="define">确　定</a>
            </s:else>
        </div>
    </div>
    <div class="bottom"></div>
  </div>
