<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page trimDirectiveWhitespaces="true" %> 
<%@include file="/jsp/common/tempTaglibs.jsp"%>
<!--主页面--任务和公告页面-->
<div>
 <!--任务和公告js-->
<script type="text/javascript">
/*任务公告切换*/
$(function(){
     //--总裁只有公告显示.
	 var deppositioncode="${session.userLogin.ccDepPositionBaseDto.deppositioncode}";
	 //if(deppositioncode=='DP0000001'||deppositioncode=='DP0000002'||deppositioncode=='DP0000003'){
	    $("#task").hide();
	    $("#notice").css("width","98%");
	    $("#content").css("margin-left","30px");
	    $(".header").css("margin-left","30px");
	// }
});

function getAjaxUrl(url){
     closePopWind();
    asy_Ajax(url,"",'html',function(data){
        $("#content").html(data);
    });
}
//转向任务页面
function Handle(url,parm1,taskparam1,parm2,taskparam2){
    ajaxUrl="${ctx}"+url+parm1+taskparam1+parm2+taskparam2;
    asy_Ajax(ajaxUrl,"",'html',function(data){
        $("#content").html(data);
    });
}
</script >

</div>
<div class="index_top">
<!--任务内容-->
<div>
<div id="task" class="task_notice" style="width:48%;position:relative;float:left">
	<ul class="title">
	           <li class="task_tit" ><a style="cursor:pointer">任务</a></li>
               <li class="more">
               <a href="javascript:getAjaxUrl('${ctx }/sysconfig/mytask_list.do');"  
               style="cursor:pointer"  title="更多">更多&gt;&gt;</a></li>
     </ul>
     <ul class="task task_con">
            <s:iterator value="ccTaskDtoList" var="ccTaskDto" status="stats" begin="0"
                     end="%{ccTaskDtoList.size>3?2:ccTaskDtoList.size-1}">
                 <li 
                    <s:if test="#stats.index==2">class="no_margin handle" </s:if>
                  >
                         <div> ${taskcontent }<s:if test="#ccTaskDto.taskstatus==0">
                              <a href="javascript:Handle('${ccTaskModuleBaseDto.moduleurl }',
                                  '${ccTaskModuleBaseDto.moduleparm1 }','${taskparam1 }',
                                  '${ccTaskModuleBaseDto.moduleparm2 }','${taskparam2 }'
                                  )"  >(<span>未处理</span>)
                               </a>
                          </s:if>
                           <s:else>
                               (<span>已处理</span>)
                           </s:else>
                         </div> 
                       <p><s:property value="#ccTaskDto.ccTaskModuleBaseDto.modulename" /></p>
                       <p><s:date name="#ccTaskDto.createtime" format="yyyy-MM-dd"/></p>
                   </li>
            </s:iterator>        
      </ul>
</div>
<!--公告内容-->
<div id="notice" class="task_notice" style="width:48%;position:relative;float:left">
	<ul class="title">
	  <li class=" notice_tit" ><a style="cursor:pointer" >公告</a></li>
	  <li class="more">
               <a href="javascript:getAjaxUrl('${ctx}/sysconfig/sysPosMan_getSystrmPoseList.do?searchDto.returnUrl=/common/login_login.do');"  
               style="cursor:pointer"  title="更多">更多&gt;&gt;</a></li>
     </ul>
     <ul class="task task_con">
               <s:iterator value="ccSystemPostBaseDtos" var="ccSystemPostBaseDto" status="stats"  begin="0"
                     end="%{ccSystemPostBaseDtos.size>3?2:ccSystemPostBaseDtos.size-1}" >
                     <li <s:if test="#stats.index==2">class="no_margin handle" </s:if>  >
                        <div><a href="javascript:getAjaxUrl('${ctx}/sysconfig/sysPosMan_check.do?searchDto.doing=check&searchDto.systemcode=<s:property value="#ccSystemPostBaseDto.systemcode" />&searchDto.returnUrl=/common/login_login.do') ">
                        <s:property value="#ccSystemPostBaseDto.postdesc" />
                        </a>
                        </div>
                        
                       <p>系统公告</p>
                       <p><s:date name="#ccSystemPostBaseDto.startdate" format="yyyy-MM-dd"/></p>
                   </li>
                </s:iterator>
      </ul>
</div>

</div>
</div>
