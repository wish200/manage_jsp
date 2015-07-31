<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<head>
<!--实体部门管理 添加、修改 页面 -->

<%@include file="/newrisk/jsp/common/temptaglibs2.jsp"%>
<script type="text/javascript" src="${ctx }/newrisk/resource/js/regexUtil.js"></script>
<script>
//添加实体部门信息
function ad_Sure(){
    var toDo=$('input[name="toDo"]').val();
    if(haveData("depName","实体部门名称不能为空")){
    	 if(toDo=='add'){
             $('#entityFrom').attr('action','${ctx}/sysconfig/depManage_add.do').submit();
        }else if(toDo=='update'){
        	 $('#entityFrom').attr('action','${ctx}/sysconfig/depManage_update.do').submit();
        }
	  }
}
</script>
</head>
<div id="popWindow" style="position:fixed; left:350px; top:100px; border:1px solid #999;width:430px;height:280px;background:#fff;z-index:99999;">
	  <!--做什么操作-->
	  <input name="toDo" type="hidden" value="${searchDto.doing }"/>
	<div style="padding-left:0px;text-align:left">
	<form  id="entityFrom"  action="" method="post" >
		<table class="tabBasic" width="100%" height="70%" cellpadding="0"
                cellspacing="0">
                <tr class="title"> <td colspan="4" >添加实体部门</td> </tr>
			    <tr>
			     <td style="width:120px;"><h1 align="right">实体部门名称 ：</h1></td>
			     <td> 
			        <input  name="ccDepartmentDto.newdepcode"  type="hidden" value="${ccDepartmentDto.newdepcode }">
			        <input id="depName"  name="ccDepartmentDto.depname" style="float:left"  type="text" value="${ccDepartmentDto.depname}">
			     </td>
				</tr>
				<tr>
				 <td style="width:120px;"><h1 align="right">部门类型 ：</h1> </td>
                 <td>
                        <select name="ccDepartmentDto.depkindcode" style="float:left" id="depKindCode" >
                            <option value="D1000011Y">产品线部门</option>
                            <option value="D2000011Y">渠道部门</option>
                            <option value="D3000011Y">理赔事业部</option>
                            <option value="D4000011Y">再保险部</option>
                            <option value="D5000011Y">资金运营部部</option>
                            <option value="D6000011Y">其他支持服务部门</option>
                            <option value="D7000021Y">总裁室</option>
                        </select>
                 </td>
                </tr>
				 <tr align="center">
				 <td style="width:120px;"><h1 align="right">状态 ：</h1> </td>
                 <td> 
                        <select name="ccDepartmentDto.validstate" style="float:left;width:80px;" id="validState" >
                            <option value="1" <s:if test="%{ccDepartmentDto.validstate ==1}"> selected="selected" </s:if>>使用</option>
                            <option value="0"  <s:if test="%{ccDepartmentDto.validstate ==0}"> selected="selected" </s:if>>停用</option>
                        </select>
                 </td>
                </tr>
                <!--实体部门标志-->
                 <input name="ccDepartmentDto.depcatg" type="hidden" value="0"/>
		</table>
		</form>
	</div>
	<div class="dBtn" style="margin-top:25px;">
	    <input onclick="ad_Sure()"  id="fanHui" type="button" class="btnDete" value="确&nbsp;定" />
		<input onclick="fanHui()"  id="fanHui" type="button" class="btnDete" value="返&nbsp;回" />
	</div>
</div>