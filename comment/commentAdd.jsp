<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--系统公告-新增 -->

<div><!--存放js-->
<%@include file="/jsp/common/tempTaglibs.jsp"%>
<script type="text/javascript" src="${ctx}/resource/js/WdatePicker.js"></script>
<script type="text/javascript" src="${ctx}/js/introduce/ajaxfileupload.js"></script>
<script type="text/javascript" src="${ctx}/js/common/app.js"></script>
<script type="text/javascript">
Date.prototype.pattern=function(fmt) {           
    var o = {           
    "M+" : this.getMonth()+1, //月份           
    "d+" : this.getDate(), //日           
    "h+" : this.getHours()%12 == 0 ? 12 : this.getHours()%12, //小时           
    "H+" : this.getHours(), //小时           
    "m+" : this.getMinutes(), //分           
    "s+" : this.getSeconds(), //秒           
    "q+" : Math.floor((this.getMonth()+3)/3), //季度           
    "S" : this.getMilliseconds() //毫秒           
    };           
    var week = {           
    "0" : "/u65e5",           
    "1" : "/u4e00",           
    "2" : "/u4e8c",           
    "3" : "/u4e09",           
    "4" : "/u56db",           
    "5" : "/u4e94",           
    "6" : "/u516d"          
    };           
    if(/(y+)/.test(fmt)){           
        fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));           
    }           
    if(/(E+)/.test(fmt)){           
        fmt=fmt.replace(RegExp.$1, ((RegExp.$1.length>1) ? (RegExp.$1.length>2 ? "/u661f/u671f" : "/u5468") : "")+week[this.getDay()+""]);           
    }           
    for(var k in o){           
        if(new RegExp("("+ k +")").test(fmt)){           
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));           
        }           
    }           
    return fmt;           
};

//--确定按钮
function keep(){
	var ok=haveData("concernednickname", "评论用户昵称不能为空！")
	if(ok){
			  $("#commentForm").ajaxSubmit({
			          type : 'post',  
			          url : '${ctx}/comment/comment_add.do',  
			          error: function(XmlHttpRequest, textStatus, errorThrown){  
			               alert( "系统错误");  
			          },
			          success: function(data){
			               alert("保存成功");
			               publicURL="${ctx}/comment/comment_getList.do";
			               $("#commentForm").find('input,select,textarea').attr('disabled',true);
			               $('input[name="appCommentBaseDto.commentid"]').val(data);
			               $('#cancleBtn').hide();
			               $('#keepBtn').hide();
			               $('#returnBtn').show();
			               $('#subBtn').show();
			          }
			  });
    }
}
//--提交按钮
function submit(){
	 $("#commentForm").find('input,select,textarea').attr('disabled',false);
	 $("#commentForm").ajaxSubmit({
         type : 'post',  
         url : '${ctx}/comment/comment_send.do',  
         error: function(XmlHttpRequest, textStatus, errorThrown){  
              alert("系统错误");  
         },
         success: function(data){
              alert("提交成功");
              returnc();
         }
     });
}
//--取消按钮
function cancel(){
	if(confirm("取消不保存本次操作")){
		asy_Ajax(publicURL,{},'html',function(data){
			 $("#content").html(data);
		});
	}
}
//--返回按钮
function returnc(){
	asy_Ajax(publicURL,{},'html',function(data){
		 $("#content").html(data);
	});
}
 
 
 function changeuser(e){
    	var userid1 = e.value;
    	if(userid1==''){
    		alert("用户id不能为空");
    		return;
    	}
    	$.ajax({
			          type : 'post',  
			          url : '${ctx}/comment/comment_changeuser.do', 
			          data:{concerneduserid:userid1},
			          error: function(XmlHttpRequest, textStatus, errorThrown){  
			               alert( "获取用户信息错误");  
			          },
			          success: function(data){ 
			          		
			               //$("#huibenForm").find('input,select,textarea').attr('disabled',true);
			               $('input[name="appCommentBaseDto.concernednickname"]').val(data.concernednickname);
			               $('input[name="appCommentBaseDto.concerneduserpic"]').val(data.concerneduserpic);
			               $('#userpicimg').attr('src','${ctx}'+data.concerneduserpic)
			               $('#filespan1').show();
			          }
			  });
    }

</script>
</div>

<div class="base_con">
              <div class="risk_form">
                <div class="form_tit">
                  <table>
                    <tr>
                      <th>&nbsp;&nbsp;评论信息</th>
                    </tr>
                  </table>
                </div>
          <form id="commentForm" method="post">  
                  <!--新生成的公告代码-->
				  <input id="commentid" name="appCommentBaseDto.commentid" value="" type="hidden" />  
                <table class="school_task ostyle">
                  
                  <tr>
                    <th>评论用户：</th>
                    <td>
		               <input id="concerneduserid" name="appCommentBaseDto.concerneduserid" type="text" onchange="changeuser(this)"/>
		               <span style="color:red">*</span>
                    </td>
                    <th>用户昵称：</th>
                    <td>
		               <input id="concernednickname" name="appCommentBaseDto.concernednickname" type="text"/>
		               <span style="color:red">*</span>
                    </td>
                  </tr>
                  <tr>
                     <th>用户头像地址：</th>
                     <td colspan="3">
                     <input id="concerneduserpic" type="text"  style="width:80%;"  readonly="readonly" name="appCommentBaseDto.concerneduserpic"/>
                     </td>
                  </tr>
                  <tr>
                     <th>用户头像图片：</th>
                     <td colspan="3">
	                    <span id='filespan1' style="display:none">
	                    <img id="userpicimg" hspace='2' vspace='2' border='1' align='middle' height='100' width='100'  src="${appCommentBaseDto.concerneduserpic }"   onclick="selectForward(this)"/>
	                    </span>
                     </td>
                  </tr> 


                  <tr>
                    <th>业务ID：</th>
                    <td>
		               <input id="busiid" name="appCommentBaseDto.busiid" type="text"/>
		               <span style="color:red">*</span>
                    </td>
                    <th>模块：</th>
                    <td>
                    	<select id="modular" class="selector" name="appCommentBaseDto.modular">
                    	<option value="1">看图说话</option>
                    	<option value="2" >听听画画</option>
                    	<option value="3" >有效</option>
                    	</select>
	                   <span style="color:red">*</span>
                    
                    </td>
                  </tr>
                  <tr>
                    <th>评论时间：</th>
                    <td>
		               <input id="commenttime" name="appCommentBaseDto.commenttime" type="text"/>
		               <span style="color:red">*</span>
                    </td>
                    <th>状态：</th>
                    <td>
                    	<select id="commentstatus" class="selector" name="appCommentBaseDto.commentstatus">
                    	<option value="1">有效</option>
                    	<option value="0" >无效</option>
                    	</select>
	                   <span style="color:red">*</span>
                    
                    </td>
                  </tr>
                  <tr class="height_70">
                    <th>评论内容：</th>
                    <td colspan="3"><textarea style="height:300px;position:relative;float:left" id="commenttext" name="appCommentBaseDto.commenttext"></textarea>
                    <span style="color:red;position:relative;float:left">*</span>
                    </td>
                  </tr>
                </table>
           </form>     
                  <div class="manual_button">
                        <a id="cancleBtn" href="javascript:cancel()" class="cancel">取&nbsp;&nbsp;消</a>
                        <a id="keepBtn" href="javascript:keep()" class="save">保&nbsp;&nbsp;存</a>
                        <a id="returnBtn" style="display:none" href="javascript:returnc()" class="cancel">返&nbsp;&nbsp;回</a>
                        <a id="subBtn" style="display:none" href="javascript:submit()" class="save">发&nbsp;&nbsp;布</a>
                  </div>
                </div>
            </div>
