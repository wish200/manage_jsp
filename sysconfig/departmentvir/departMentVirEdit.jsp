<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--addUser页面(弹出窗口)-->


<div class="user_info">
<%@include file="/newrisk/jsp/common/tempTaglibs.jsp"%>
<!--以下页面的js操作-->
<script type="text/javascript">
$(".black_overlay").css("height",$(document).height());
<%--模拟下拉列表框--%>
selectOption();
<%--确定按钮--%>
function Submit(){
	$("#addUserForm").ajaxSubmit({
        type : 'post',  
        url : '${ctx }/sysconfig/userManage_addUser.do',  
        error: function(XmlHttpRequest, textStatus, errorThrown){  
             alert( "系统错误");  
        },
        success: function(data){
        	$("#content").html(data);
        	$('#popWindow').remove();
        	$('.black_overlay').remove();	
        }
    });
	
}
<%--窗口关闭--%>
function closeDiv(){
	 $('#popWindow').remove();
	 $('.black_overlay').remove();	
}
</script>

  	<div class="title">新增用户信息<a href="javascript:closeDiv()" title="关闭" class="close"></a></div>
    <div class="con">
        <form id="addUserForm" action="" method="post">
    	<ul>
        	<li>
            	<label>人员代码：</label>
                <span class="input_1">
                   <input name="ccUserDto.usercode" type="text" />
                </span>
            </li>
            <li>
            	<label>归属机构：</label>
                <div class="select select_1">
                	<span>请选择</span>
                	<input name="ccUserDto.comcode" type="text"/>
                    <dl>
                    	<dd value="001">总公司</dd>
                        <dd value="002">分公司</dd>
                        <dd value="003">下属公司</dd>
                    </dl>
                </div> 
            </li>
            <li>
            	<label>人员名称：</label>
                <span class="input_1">
                <input name="ccUserDto.username" type="text" />
                </span>
            </li>
            <li>
            	<label>归属部门：</label>
                <div class="select select_1">
                	<span>请选择</span>
                	<input name="ccUserDto.newdepcode" type="text"/>
                    <dl>
                    	<dd value="0001">车辆保险部</dd>
                        <dd value="0001">风险识</dd>
                        <dd>下属公司</dd>
                    </dl>
                </div> 
            </li>
            <li>
            	<label>状态：</label>
                <div class="select select_1">
                	<span>请选择</span>
                	<input name="ccUserDto.validstatus" type="text"/>
                    <dl>
                    	<dd value="1">使用</dd>
                        <dd value="0">停用</dd>
                    </dl>
                </div> 
            </li>
            <li>
            	<label>部门岗位：</label>
                <div class="select select_1">
                	<span>请选择</span>
                	<input name="ccUserDto.deppositioncode" type="text"/>
                    <dl>
                    	<dd value="0001">车辆保险部</dd>
                        <dd value="0001">风险识</dd>
                        <dd value="0001">下属公司</dd>
                    </dl>
                </div> 
            </li>
            <li class="line">
            	<label>邮箱：</label>
                <span class="input_2">
                  <input name="ccUserDto.email" type="text" />
                </span>
            </li>
        </ul>
        </form>
        <div class="button_div">
        	<a href="javascript:closeDiv()" class="return">返　回</a>
            <a href="javascript:Submit()" class="define">确　定</a>
        </div>
    </div>
    <div class="bottom"></div>
  </div>
