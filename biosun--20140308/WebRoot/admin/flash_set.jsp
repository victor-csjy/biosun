<%@page contentType="text/html;charset=utf-8"%>
<%@include file="session_admin.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<script language="javascript">
 function on_submit_bak()
 {

   if(form1.FILE1.value!=""&&(form1.FILE1.value.indexOf(".swf") == -1))
  {
    alert("请在选择.swf的Flash格式文件到Home中!");
	return false;
  }
   if(form1.FILE2.value!=""&&(form1.FILE2.value.indexOf(".swf") == -1))
  {
    alert("请在选择.swf的Flash格式文件到About Us中!");
	
	return false;
  }
   if(form1.FILE3.value!=""&&(form1.FILE3.value.indexOf(".swf") == -1))
  {
    alert("请在选择.swf的Flash格式文件到Events中!");
	
	return false;
  }
   if(form1.FILE4.value!=""&&(form1.FILE4.value.indexOf(".swf") == -1))
  {
    alert("请在选择.swf的Flash格式文件到Products中!");
	
	return false;
  }
   if(form1.FILE5.value!=""&&(form1.FILE5.value.indexOf(".swf") == -1))
  {
    alert("请在选择.swf的Flash格式文件到Sale and Market中!");
	
	return false;
  }
   if(form1.FILE6.value!=""&&(form1.FILE6.value.indexOf(".swf") == -1))
  {
    alert("请在选择.swf的Flash格式文件到Service中!");
	
	return false;
  }
  if(form1.FILE7.value!=""&&(form1.FILE7.value.indexOf(".swf") == -1))
  {
    alert("请在选择.swf的Flash格式文件到Careers中!");
	
	return false;
  }
  if(form1.FILE8.value!=""&&(form1.FILE8.value.indexOf(".swf") == -1))
  {
    alert("请在选择.swf的Flash格式文件到Contact中!");
	
	return false;
  }
  if(form1.FILE1.value==""||form1.FILE2.value==""||form1.FILE3.value==""||form1.FILE4.value==""||form1.FILE5.value==""||form1.FILE6.value==""||form1.FILE7.value==""||form1.FILE8.value==""){
    alert("请在选择.swf的Flash格式文件到Contact中!");
	return false;
  }
 }
 
 function on_submit(type) {
   var formObj=document.forms["form_"+type];
   if(formObj.inputFile.value==""||(formObj.inputFile.value.indexOf(".swf") == -1)){
     alert("请在选择.swf的Flash格式文件到"+type+"中!");
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
<body >
<div align="center">
<br><br>
  <table  width="811" border="0" align="center" cellpadding="0" cellspacing="0" >
    
    <tr >
      <td width="13" height="28"  >&nbsp;</td>
      <td width="505"  >&nbsp;</td>
      <td width="293"  >&nbsp;</td>
    </tr>
    <tr >
      <td height="26"  >&nbsp;</td>
      <td valign="top"  ><span class="STYLE2">
                    系统管理——Flash管理</span></td>
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
	       
		            	
	  
        <table  class=bgcolor4 width="100%" border="1" align=center cellpadding="1" cellspacing="1"   bordercolor="#000000" bordercolordark="#cad7f7" >
          
	   
		
		<tr >
            <td height="26" colspan="2"  > &nbsp;Flash 的最佳最佳长宽(单位：象素)： 580*133 </td>
          </tr> 
		  
		  
          <tr >
            <td width="154" height="26"  >&nbsp;Home：</td>
            <td width="631"  >
			<form name="form_home" method="POST" enctype="multipart/form-data" action="UploadFileJsp.jsp?op=upload&business=flashSet&fileType=flash&fileName=home&webPath=flash/" onSubmit="return on_submit('home')" ><input name="inputFile" TYPE="file" size="50" >
<input name="buttonUpload" type="submit" class="button" value="上传">&nbsp;<input name="buttonBack" type="button" class="button" value="返回" onClick="location.href='index_face.jsp'"></form></td>
          </tr>      
	       
	<tr >
            <td height="28" valign="middle"  >&nbsp;About Us： </td>
            <td valign="middle"  ><form name="form_about_us" method="POST" enctype="multipart/form-data" action="UploadFileJsp.jsp?op=upload&business=flashSet&fileName=about_us&webPath=flash/"  onSubmit="return on_submit('about_us')" ><input name="inputFile" TYPE="file" size="50" >
<input name="buttonUpload" type="submit" class="button" value="上传">&nbsp;<input name="buttonBack" type="button" class="button" value="返回" onClick="location.href='index_face.jsp'"></form></td>
	</tr>
	<tr >
            <td height="28" valign="middle"  >&nbsp;Events： </td>
            <td valign="middle"  ><form name="form_events" method="POST" enctype="multipart/form-data" action="UploadFileJsp.jsp?op=upload&business=flashSet&fileName=events&webPath=flash/"  onSubmit="return on_submit('events')" ><input name="inputFile" TYPE="file" size="50" >
<input name="buttonUpload" type="submit" class="button" value="上传">&nbsp;<input name="buttonBack" type="button" class="button" value="返回" onClick="location.href='index_face.jsp'"></form></td>
	</tr>
	<tr >
            <td height="28" valign="middle"  >&nbsp;Products： </td>
            <td valign="middle"  ><form name="form_products" method="POST" enctype="multipart/form-data" action="UploadFileJsp.jsp?op=upload&business=flashSet&fileName=products&webPath=flash/"  onSubmit="return on_submit('products')" ><input name="inputFile" TYPE="file" size="50" >
<input name="buttonUpload" type="submit" class="button" value="上传">&nbsp;<input name="buttonBack" type="button" class="button" value="返回" onClick="location.href='index_face.jsp'"></form></td>
	</tr>
	<tr >
            <td height="28" valign="middle"  >&nbsp;Sale and Market： </td>
            <td valign="middle"  ><form name="form_sale_and_market" method="POST" enctype="multipart/form-data" action="UploadFileJsp.jsp?op=upload&business=flashSet&fileName=sale_and_market&webPath=flash/" onSubmit="return on_submit('sale_and_market')" ><input name="inputFile" TYPE="file" size="50" >
<input name="buttonUpload" type="submit" class="button" value="上传">&nbsp;<input name="buttonBack" type="button" class="button" value="返回" onClick="location.href='index_face.jsp'"></form></td>
	</tr>
	<tr >
            <td height="28" valign="middle"  >&nbsp;Service：</td>
            <td valign="middle"  ><form name="form_service" method="POST" enctype="multipart/form-data" action="UploadFileJsp.jsp?op=upload&business=flashSet&fileName=service&webPath=flash/" onSubmit="return on_submit('service')" ><input name="inputFile" TYPE="file" size="50" >
<input name="buttonUpload" type="submit" class="button" value="上传">&nbsp;<input name="buttonBack" type="button" class="button" value="返回" onClick="location.href='index_face.jsp'"></form></td>
    </tr>
	
	<tr >
            <td height="26" valign="middle"  >&nbsp;Careers： </td>
            <td valign="middle"  ><form name="form_careers" method="POST" enctype="multipart/form-data" action="UploadFileJsp.jsp?op=upload&business=flashSet&fileName=careers&webPath=flash/"  onSubmit="return on_submit('careers')" ><input name="inputFile" TYPE="file" size="50" >
<input name="buttonUpload" type="submit" class="button" value="上传">&nbsp;<input name="buttonBack" type="button" class="button" value="返回" onClick="location.href='index_face.jsp'"></form></td>
	</tr>
	<tr >
            <td height="26" valign="middle"  >&nbsp;Contact： </td>
            <td valign="middle"  ><form name="form_contact" method="POST" enctype="multipart/form-data" action="UploadFileJsp.jsp?op=upload&business=flashSet&fileName=contact&webPath=flash/" onSubmit="return on_submit('contact')" ><input name="inputFile" TYPE="file" size="50" >
<input name="buttonUpload" type="submit" class="button" value="上传">&nbsp;<input name="buttonBack" type="button" class="button" value="返回" onClick="location.href='index_face.jsp'"></form></td>
	</tr>
   </table></td>
    </tr>
	  </table>
<br>
</div>
</body>
</html>