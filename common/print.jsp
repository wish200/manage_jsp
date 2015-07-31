<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!--打印预览、下载Excel-->
<script type="text/javascript" src="${ctx}/newrisk/resource/js/LodopFuncs.js"></script>
<script type="text/javascript">
function OnePrint(divObject){
    LODOP=getLodop();
    CreateOneFormPage(divObject);
	LODOP.PREVIEW();
}
//创建一个打印预览区域
function CreateOneFormPage(divObject){
        var style="<link href='${ctx}/newrisk/resource/styles/layout.css' rel='stylesheet' />";//引用css样式
        var printHtml;//打印预览页面
        if(typeof(divObject)=='string'){
          printHtml=style+document.getElementById(divObject).innerHTML;
        }else{
          printHtml=style+divObject.html();
        }
        LODOP.SET_PRINT_PAGESIZE(1,3200,3200,"");
        LODOP.SET_PRINT_MODE("PRINT_PAGE_PERCENT","Auto-Width");
		LODOP.SET_PRINT_TEXT_STYLE(1,"宋体",18,1,0,0,1);
		LODOP.SET_PRINT_STYLE("Stretch",'0');
		LODOP.ADD_PRINT_HTML(5,5,"100%","100%",printHtml); 
		
};
//(js导出Excel)
function tableToExcel(tname) {
        var printHtml;//下载页面
        if(typeof(tname)=='string'){
          printHtml=document.getElementById(tname).innerHTML;
        }else{
          printHtml=tname.html();
        }
        
		  if(confirm('是否要导出到excel？')!=0)
		  { 
		   window.clipboardData.setData("Text",printHtml);
		   try
		   {
		    ExApp = new ActiveXObject("Excel.Application");
		    var ExWBk = ExApp.workbooks.add();
		    var ExWSh = ExWBk.worksheets(1);
		    ExApp.DisplayAlerts = false;
		    ExApp.visible = true;
		   }  
		   catch(e)
		   {
		    alert("导出没有成功！1.您的电脑没有安装Microsoft Excel软件！2.请设置Internet选项自定义级别，对没有标记安全级别的  ActiveX控件进行提示。");
		    return ;
		   } 
		    ExWBk.worksheets(1).Paste;
		   }else
		   { 
		   return;
		  }
// 		  window.close(); 
}
</script>
<div id="data"></div>