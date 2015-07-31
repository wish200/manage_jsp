<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--editUser页面(弹出窗口)-->


<div class="user_info">
<%@include file="/jsp/common/tempTaglibs.jsp"%>
<script type="text/javascript" src="${ctx }/newrisk/js/common/userInit2.js"></script>
<!--以下页面的js操作-->
<script type="text/javascript">
$(".black_overlay").css("height",$(document).height());
initCompany("2","${ccUserDto.comcode}","${ccUserDto.newdepcode}","${ccUserDto.deppositioncode}");
// initDepartment("${ccUserDto.newdepcode}");
// initDepPosition("${ccUserDto.deppositioncode}");

$('#username').keyup(function(){
	  var value=$(this).val().replace(/[^\x00-\xff]/g, 'xx');
	  if(value.length>128){
		   alert("人员名称不能超过128个字符！");
		    var value=$(this).val();
		    $(this).val('');
	  }
});
<%--确定按钮--%>
function Esubmit(){
	 var ok=haveData("username","人员名称不能为空！")
	  			&&haveData("comcode","请选择机构！")
	  			&&haveData("newdepcode","请选择部门！")
	  			&&haveData("validstatus","请选择状态！")
	  			&&haveData("deppositioncode", "请选择岗位！")
	  			&&haveData("email","Email地址不能为空！")
	  		  	&&regEmail("email");
	 if(ok){
		$("#editUserForm").ajaxSubmit({
	        type : 'post',  
	        url : '${ctx }/sysconfig/userManage_updateUser.do',  
	        error: function(XmlHttpRequest, textStatus, errorThrown){  
	             alert( "系统错误");  
	        },
	        success: function(result){
	        	$("#content").html(result);
	        	$('#popWindow').remove();
	        	$('.black_overlay').remove();	
	        }
	    });
	 }
}
<%--状态点击下拉--%>
$("#validstatus").parent('div').find('span').click(function(){
	var thisinput=$(this);
	var thisInputvar=$(this).next("input");
	var thisul=$(this).parent().find("dl");
	if(thisul.css("display")=="none"){
		if(thisul.height()>150){thisul.css({height:"100"+"px","overflow-y":"scroll"});};
		thisul.fadeIn("100");
		thisul.parent().css("z-index","9999");
		thisul.hover(function(){},function(){thisul.fadeOut("100");thisul.parent().css("z-index","2");});
		thisinput.parent().hover(function(){},function(){thisul.fadeOut("100");thisul.parent().css("z-index","2");});
		thisul.find("dd").click(function(){
			thisinput.text($(this).text());
			thisInputvar.val($(this).attr('value'));
			thisul.fadeOut("100");
			});
		}
	else{
		thisul.fadeOut("fast");
		}
});
<%--窗口关闭--%>
function closeDiv(){
	 $('#popWindow').remove();
	 $('.black_overlay').remove();	
}
</script>

  	<div class="title">编辑用户信息<a href="javascript:closeDiv()" title="关闭" class="close"></a></div>
    <div class="con">
        <form id="editUserForm" action="" method="post">
    	<ul>
        	<li><input name="ccUserDto.usercode" type="hidden" value="${ccUserDto.usercode }" >
            	<label>人员代码：</label>
                <span class="input_1">
                    ${ccUserDto.usercode}
                </span>
            </li>
            <li>
            	<label>归属机构：</label>
                <div class="select select_1">
                	<span>请选择</span>
                	<input id="comcode" name="ccUserDto.comcode" value="${ccUserDto.comcode }" type="hidden"/>
                    <dl id="comCode">
                    </dl>
                </div><span style="color:red">*</span> 
            </li>
            <li>
            	<label>人员名称：</label>
                <span class="input_1">
                <input id="username" name="ccUserDto.username" value="${ccUserDto.username}" type="text" />
                </span><span style="color:red">*</span>
            </li>
            <li>
            	<label>归属部门：</label>
                <div class="select select_1">
                	<span>请选择</span>
                	<input id="newdepcode" name="ccUserDto.newdepcode" value="${ccUserDto.newdepcode }" type="hidden"/>
                    <dl id="department">
                    </dl>
                </div><span style="color:red">*</span> 
            </li>
            <li>
            	<label>状态：</label>
                <div class="select select_1">
                	<s:if test="%{ccUserDto.validstatus==1}">
                    <span>使用</span>
                    <input id="validstatus" name="ccUserDto.validstatus" value="1" type="hidden"/>
                    </s:if>
                    <s:elseif test="%{ccUserDto.validstatus==0}">
                    <span>停用</span>
                    <input id="validstatus" name="ccUserDto.validstatus" value="0" type="hidden"/>
                    </s:elseif>
                    <s:else>
                    <span>请选择</span>
                    <input id="validstatus" name="ccUserDto.validstatus" value="" type="hidden"/>
                    </s:else>
                    <dl id="validstatus">
                    	<dd value="1">使用</dd>
                        <dd value="0">停用</dd>
                    </dl>
                </div><span style="color:red">*</span> 
            </li>
            <li>
            	<label>部门岗位：</label>
                <div class="select select_1">
                	<span>请选择</span>
                	<input id="deppositioncode" name="ccUserDto.deppositioncode" value="${ccUserDto.deppositioncode}" type="hidden"/>
                    <dl id="depposition">
                    </dl>
                </div><span style="color:red">*</span> 
            </li>
            <li class="line">
            	<label>邮箱：</label>
                <span class="input_2">
                  <input id="email" name="ccUserDto.email" value="${ccUserDto.email }" type="text" maxlength="40"/>
                </span><span style="color:red">*</span>
            </li>
        </ul>
        </form>
        <div class="button_div">
        	<a href="javascript:closeDiv()" class="return">返　回</a>
            <a href="javascript:Esubmit()" class="define">确　定</a>
        </div>
    </div>
    <div class="bottom"></div>
  </div>
