<%@page contentType="text/html;charset=utf-8"%>
<%@page import="com.aokle.util.MathUtil"%>
<%@include file="session_admin.jsp"%>
<%
int big_id=MathUtil.toInt(request.getParameter("big_id"));
if(big_id<1){
   out.println("<SCRIPT LANGUAGE='JavaScript'>alert('参数非法!');javascript:history.back(-1);</SCRIPT>");
   return;
}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<script language="javascript">
 function on_submit()
 {

   if((form1.flashName.value.indexOf(".swf") == -1))
  {
    alert("请在选择.swf的Flash格式文件!");   
	return false;
  }  
  
 }
  </script>
  
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<link href="css/Style.css" rel="stylesheet" type="text/css">

<style type="text/css">
<!--
.STYLE2 {
	font-size: 16px;
	font-weight: bold;
	color: #000000;
}
-->
</style>
</head>
<body>
<div align="center">
<br><br>
  <table class=bgcolor4 width="811" border="0" align="center" cellpadding="0" cellspacing="0" >
    
    <tr >
      <td width="13" height="28"  >&nbsp;</td>
      <td width="505"  >&nbsp;</td>
      <td width="293"  >&nbsp;</td>
    </tr>
    <tr >
      <td height="26"  >&nbsp;</td>
      <td valign="top"  ><span class="STYLE2">
                    Products——Flash</span></td>
      <td  >&nbsp;</td>
    </tr>
    <tr >
      <td height="34"  >&nbsp;</td>
      <td  >&nbsp;</td>
      <td  >&nbsp;</td>
    </tr>
    <tr >
      <td height="171"  >&nbsp;</td>
      <td colspan="2" valign="top"  >  
	                  	
	  <form name="form1" method="POST" action="p_flash_do.jsp" onSubmit="return on_submit()" >
		
        <table width="100%" border="1" align=center cellpadding="1" cellspacing="1"   bordercolor="#000000" bordercolordark="#cad7f7" >
          
	    
          <tr >
            <td width="154" height="26"  >&nbsp;上传Flash：</td>
            <td width="631"  > <input name="flashName" type="text" id="flashName" size="40" maxlength="200">
			 <input type="button" name="up_pic" value="上传..."  onClick="window.open('UploadFileJsp.jsp?op=&business=adminUpload&fileType=file&webPath=flash/&inputId=flashName&fileName=<%=big_id%>','','status=no,scrollbars=no,top=200,left=310,width=420,height=165')">
			            
            &nbsp;Flash 的最佳最佳长宽(单位：象素)： 580*133 &nbsp;&nbsp;&nbsp;</td>
          </tr> 
		 <tr >
            <td height="27" colspan="2" align="center" valign="middle"  >
             <input name="B1" type="submit" class="button" id="B8" value="上传">&nbsp;&nbsp;&nbsp;<input name="B2" type="button" class="button" value="返回" onClick="location.href='index_face.jsp'">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
	</tr>
                  </table> </form> </td>
    </tr>
    
	  </table>
  
<br><br>
</div>
</body>
</html>