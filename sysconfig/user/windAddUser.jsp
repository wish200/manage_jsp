<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--addUser页面(弹出窗口)-->


<div class="user_info">
<%@include file="/jsp/common/tempTaglibs.jsp"%>
<script type="text/javascript" src="${ctx }/newrisk/js/common/userInit2.js"></script>
<!--以下页面的js操作-->
<script type="text/javascript">
$(".black_overlay").css("height",$(document).height());
initCompany("2",'${session.userLogin.comcode}');
// initDepartment();
// initDepPosition();
$('#username').keyup(function(){
	  var value=$(this).val().replace(/[^\x00-\xff]/g, 'xx');
	  if(value.length>128){
		   alert("人员名称不能超过128个字符！");
		    var value=$(this).val();
		    $(this).val('');
	  }
});

function haveUser(){
   var _usercode=$("#usercode").val();
   if(_usercode==""){
    alert("用户代码不能为空");
   }else{
        $.ajax({
                    url :'${ctx }/sysconfig/userManage_veriCode.do',
                    type : 'POST',
                    data :{
                      'searchDto.userCode':_usercode
                    },
                    dataType : 'json',
                    error : function() {
                        alert( '系统错误。请与管理员联系' );
                    },
                    success :function(data){
                      if(data>0){
                       alert("用户代码已经存在！");
                       $("#usercode").val("");
                      }
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
<%--确定按钮--%>
function Submit(){
	var ok=haveData("usercode","人员代码不能为空！")
		&&haveData("username","人员名称不能为空！")
		&&haveData("comcode","请选择机构！")
		&&haveData("newdepcode","请选择部门！")
		&&haveData("validstatus","请选择状态！")
		&&haveData("deppositioncode", "请选择岗位！")
		&&haveData("email","Email地址不能为空！")
	  	&&regEmail("email");
	if(ok){
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
                   <input id="usercode" name="ccUserDto.usercode"  onblur="haveUser();" type="text" maxlength="15"/>
                </span><span style="color:red">*</span>
            </li>
            <li>
            	<label>归属机构：</label>
                <div class="select select_1">
                	<span>请选择</span>
                	<input id="comcode" name="ccUserDto.comcode" type="hidden"/>
                    <dl id="comCode">
                    </dl>
                </div><span style="color:red">*</span> 
            </li>
            <li>
            	<label>人员名称：</label>
                <span class="input_1">
                <input id="username" name="ccUserDto.username" type="text" />
                </span><span style="color:red">*</span>
            </li>
            <li>
            	<label>归属部门：</label>
                <div class="select select_1">
                	<span>请选择</span>
                	<input id="newdepcode" name="ccUserDto.newdepcode" type="hidden"/>
                    <dl id="department">
                    </dl>
                </div> <span style="color:red">*</span>
            </li>
            <li>
            	<label>状态：</label>
                <div class="select select_1">
                	<span>请选择</span>
                	<input id="validstatus" name="ccUserDto.validstatus" type="hidden"/>
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
                	<input id="deppositioncode" name="ccUserDto.deppositioncode" type="hidden"/>
                    <dl id="depposition">
                    </dl>
                </div><span style="color:red">*</span> 
            </li>
            <li class="line">
            	<label>邮箱：</label>
                <span class="input_2">
                  <input id="email" name="ccUserDto.email" type="text" maxlength="40"/>
                </span><span style="color:red">*</span>
            </li>
        </ul>
        </form>
        <div class="button_div">
        	<a href="javascript:closeDiv()" class="return">取   消</a>
            <a href="javascript:Submit()" class="define">保   存</a>
        </div>
    </div>
    <div class="bottom"></div>
  </div>
