<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!--系统公告信息-查看 -->

<div><!--存放js-->
<%@include file="/jsp/common/tempTaglibs.jsp"%>
<script type="text/javascript">
$("#flowerForm").find('input,select,textarea').attr('disabled',true);
//--发布按钮
function keep(){
	  $("#flowerForm").find('input,select,textarea').attr('disabled',false);
	  $("#flowerForm").ajaxSubmit({
	          type : 'post',  
	          url : '${ctx}/flower/flower_send.do',  
	          error: function(XmlHttpRequest, textStatus, errorThrown){  
	               alert( "系统错误");  
	          },
	          success: function(data){
	               alert("发布成功");
	               asy_Ajax("${ctx}/flower/flower_getList.do",{},'html',function(data){
	          		 $("#content").html(data);
	               });
	          }
	  });
}
//--返回按钮
function returnc(){
	   if(typeof(publicURL)=='undefined'){
		  history.go(0);
	   }else{
			asy_Ajax(encodeURI(publicURL),{},'html',function(data){
				 $("#content").html(data);
			});
	   }
}



		
		
$("#modular").val("${appFlowerBaseDto.modular }");
</script>
</div>

<div class="base_con">
              <div class="risk_form">
                <div class="form_tit">
                  <table>
                    <tr>
                      <th>&nbsp;&nbsp;小红花信息</th>
                    </tr>
                  </table>
                </div>
          <form id="flowerForm" method="post">    
            <!--新生成的公告代码-->
				    <input id="id" name="appFlowerBaseDto.busiid"  value="${appFlowerBaseDto.busiid }" type="hidden" />
				    <input id="id" name="appFlowerBaseDto.modular"  value="${appFlowerBaseDto.modular }" type="hidden" />
                <table class="school_task">
                
                <tr>
                    <th>评论用户：</th>
                    <td>
		                ${appFlowerBaseDto.userid}
                    </td>
                    <th>用户昵称：</th>
                    <td>
                    	${appFlowerBaseDto.nickname	}
                    </td>
                  </tr>
                  <tr>
                    <th>业务ID：</th>
                    <td>
                    	${appFlowerBaseDto.busiid	}
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
                    <th>发布时间：</th>
                    <td>
                    	${appFlowerBaseDto.commentime	}
                    </td>
                    <th>小红花数量：</th>
                    <td>
                   	 ${appFlowerBaseDto.flowercnt	}
                    </td>
                  </tr>
                  
                   
                </table>
           </form>     
                  <div class="manual_button">
                        <a id="returnBtn" href="javascript:returnc()" class="cancel">返&nbsp;&nbsp;回</a>
                        <s:if test="%{searchDto.doing=='publish'}">
                        <a id="keepBtn" href="javascript:keep()" class="save" >发&nbsp;&nbsp;布</a>
                        </s:if>
                  </div>
                </div>
            </div>
