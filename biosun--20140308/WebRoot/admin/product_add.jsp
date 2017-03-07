<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="hk.com.biosun.model.BigTable"%>
<%@page import="hk.com.biosun.model.SmallTable"%>
<%@page import="hk.com.biosun.service.BigTableService"%>
<%@page import="hk.com.biosun.service.SmallTableService"%>
<%@page import="com.aokle.util.DateUtil"%>
<%@page import="hk.com.biosun.model.SupplyTable"%>
<%@page import="hk.com.biosun.service.SupplyTableService"%>
<%@include file="session_admin.jsp"%>
<%
BigTableService bigTableService=new BigTableService();
BigTable bigTable;
List<BigTable> bigTableList = bigTableService.getList();
int bigTableListSize = bigTableList != null
			? bigTableList.size()
			: 0;
SmallTableService smallTableService=new SmallTableService();
SmallTable smallTable;
List<SmallTable> smallTableList = smallTableService.getList();
int smallTableListSize = smallTableList != null
			? smallTableList.size()
			: 0;
SupplyTableService supplyTableService=new SupplyTableService();
SupplyTable supplyTable;
List<SupplyTable> supplyTableList=supplyTableService.getList();
int supplyTableListSize=supplyTableList!=null?supplyTableList.size():0;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<script language="javascript">
function openUploadWin(ecName){
 if(ecName==""){
   return ;
 }
 var ecWordObj=document.getElementById(ecName+"_word");
 if(ecWordObj&&ecWordObj.value==""){
     alert("请输入附件的名称！");
     ecWordObj.focus();
	 return false;
 }
 window.open('UploadFileJsp.jsp?op=&business=adminUpload&fileType=file&webPath=product/ec/&inputId='+ecName+'&fileName='+ecWordObj.value,'','status=no,scrollbars=no,top=200,left=310,width=420,height=165');
}

 function on_submit()
 {
 if(form1.p_model.value=="")
  {
    alert("请输入标题!");
	form1.p_model.value="";	
    document.form1.p_model.focus();
	return false;
  }
  if(form1.p_name.value=="")
  {
    alert("请输入发布日期!");
	form1.p_name.value="";	
    document.form1.p_name.focus();
	return false;
  }
  
  
   if(form1.big_id.value=="0")
  {
    alert("请选择一个大类!");
	
    document.form1.big_id.focus();
	return false;
  }
   if(form1.small_id.value=="0")
  {
    alert("请选择一个小类!");	
    document.form1.small_id.focus();
	return false;
  }
  
  
  
   if(form1.public_price.value==""||isNaN(form1.public_price.value))
  {
    alert("请输入一个有效的public price!");
	form1.public_price.value="";	
    document.form1.public_price.focus();
	return false;
  }  
  
  
  
  
   if(form1.bs_price.value==""||isNaN(form1.bs_price.value))
  {
    alert("请输入一个有效的Biosun市场价!");
	form1.bs_price.value="";	
    document.form1.bs_price.focus();
	return false;
  }  
   if(form1.bs_cg_price.value==""||isNaN(form1.bs_cg_price.value))
  {
    alert("请输入一个有效的采购成本!");
	form1.bs_cg_price.value="";	
    document.form1.bs_cg_price.focus();
	return false;
  } 
  
   if(form1.supply_id.value==""||isNaN(form1.supply_id.value))
  {
    alert("请选择一个供应商!");
	form1.supply_id.value="";	
    document.form1.supply_id.focus();
	return false;
  }  
  if(form1.browse.value==""||isNaN(form1.browse.value))
  {
    alert("浏览次数为整形!");
	form1.browse.value="";	
    document.form1.browse.focus();
	return false;
  }  
  if(form1.ask_times.value==""||isNaN(form1.ask_times.value))
  {
    alert("询单次数为整形!");
	form1.ask_times.value="";	
    document.form1.ask_times.focus();
	return false;
  }  
 
  if(form1.com_times.value==""||isNaN(form1.com_times.value))
  {
    alert("评论次数为整形!");
	form1.com_times.value="";	
    document.form1.com_times.focus();
	return false;
  }
  if(form1.order_id.value==""||isNaN(form1.order_id.value))
  {
    alert("显示顺序为整形!");
	form1.order_id.value="";	
    document.form1.order_id.focus();
	return false;
  }   
   if(form1.p_date.value=="")
  {
    alert("请输入发布日期!");
	form1.p_date.value="";	
    document.form1.p_date.focus();
	return false;
  }  
      
 if(form1.p_pic.value!=""&&(form1.p_pic.value.indexOf(".jpg") == -1)&&(form1.p_pic.value.indexOf(".jpeg") == -1)&&(form1.p_pic.value.indexOf(".bmp") == -1)&&(form1.p_pic.value.indexOf(".gif") == -1)&&(form1.p_pic.value.indexOf(".png") == -1))
  {
    alert("请选择jpg,jpeg,bmp,gif,png的图象文件!");
	form1.p_pic.value="";	
    document.form1.p_pic.focus();
	return false;
  }
}

var onecount;
onecount=0;
subcat = new Array();
<%
int count = 0;
String sName="";

for(int i=0;i<smallTableListSize;i++){
    smallTable=smallTableList.get(i);
    sName=smallTable.getSmallCode()+"——"+smallTable.getSmallName();
%>
subcat[<%=count%>] = new Array("<%=sName%>","<%=smallTable.getBigId()%>","<%=smallTable.getSmallId()%>");//产生数组
<%
        count = count + 1;
}
%>
onecount=<%=count%>;

function changelocation(id)
    {
    document.form1.small_id.length = 0; 

    var id=id;
    var i;
    document.form1.small_id.options[0] = new Option('请选择','');
    for (i=0;i < onecount; i++)
        {
            if (subcat[i][1] == id)
            { 
         document.form1.small_id.options[document.form1.small_id.length] = new Option(subcat[i][0], subcat[i][2]);
            }        
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
			<br>
			<br>
			<table width="811" border="0" align="center" cellpadding="0"
				cellspacing="0">

				<tr>
					<td width="13" height="27">&nbsp;
						
					</td>
					<td width="651" valign="top">
						<span class="STYLE2"> Products——添加产品</span>
					</td>


					<td width="147">&nbsp;
						
					</td>
				</tr>
				<tr>
					<td height="651">&nbsp;
						
					</td>
					<td colspan="2" valign="top">

						<form name="form1" method="POST" action="product_add_check.jsp" onSubmit="return on_submit()">
							<table width="90%" border="1" align=center cellpadding="1"
								cellspacing="1" bordercolor="#000000" bordercolordark="#cad7f7">


								<tr>
									<td width="100" height="26" valign="middle" nowrap>
										&nbsp; 产品型号:									</td>
									<td width="170" colspan="8" valign="top">
										<input name="p_model" type="text" id="p_model" value="BS-"
											size="35">									</td>
									<td width="87" colspan="2" valign="top" nowrap>
										产品名称:									</td>
					  <td width="133" colspan="4" valign="top">
										<input name="p_name" type="text" id="p_name" size="35"
											maxlength="150">									</td>
								</tr>
								<tr>
									<td height="28" valign="middle" nowrap>
										&nbsp; 大类:
								  <label></label>									</td>
							  <td colspan="2" valign="top">
										<select name="big_id"
											onChange="changelocation(document.form1.big_id.options[document.form1.big_id.selectedIndex].value)"
											size="1">
											<option value="0">
												请选择											</option>
											<%
												String bName ="";
												for(int i=0;i<bigTableListSize;i++){
												    bigTable=bigTableList.get(i);
													bName = bigTable.getBigCode()+"——"+bigTable.getBigName();
											%>
											<option value="<%=bigTable.getBigId()%>"><%=bName%></option>
											<%
												}
											%>
										</select>									</td>
									<td colspan="3" nowrap>
										小类:									</td>
					  <td colspan="5" valign="top">
										<select name="small_id">
											<option value="0">
												请选择											</option>
										</select>									</td>
									<td colspan="2" nowrap>
										小类内权重:									</td>
					  <td colspan="2" valign="top">
										<input name="small_strong" type="text" id="small_strong">									</td>
								</tr>
								<tr>
									<td height="26" valign="middle" nowrap>
										&nbsp; 产品图片:									</td>
						    <td colspan="14" valign="top">
                                    
                                      <p>
                                        <input name="p_pic" type="text" id="p_pic" size="40"
                                   maxlength="200">
                                        <input type="button" name="up_pic" value="图片上传..."
                   onClick="window.open('UploadFileJsp.jsp?op=&business=adminUpload&fileType=image&webPath=product/pic/&inputId=p_pic','','status=no,scrollbars=no,top=200,left=310,width=420,height=165')">
                                        <br>
                                        <span
                class="admin_alert">*</span>最佳像素和比例：宽x高=318*227 和 宽:高=7 : 5(图片类型jpg,jpeg,bmp,gif,png)<br>
                                        <span class="admin_alert">注意:可以直接输入已有图片地址URL,图片类型.jpg.jpeg.bmp.gif.png</span>                             </p>                                     </td>
							  </tr>

								<tr>
									<td height="26" valign="middle" nowrap>
										&nbsp;&nbsp;关键字:									</td>
					  <td colspan="14" valign="top">
										<input name="key_word" type="text" id="key_word" size="100"
											maxlength="150">									</td>
								</tr>



								<tr>
									<td height="26" colspan="15" valign="middle">
										&nbsp; Applications:									</td>
								</tr>

								<tr class="chinese">
									<td height="204" colspan="15" valign="top">
										<div align="center">
<input type="hidden" name=content0 " id="content0" value=""/>
<iframe ID="eWebEditor0" src="../ewebeditor/eWebEditor.jsp?id=content0&style=CoolBlue" frameborder="0" scrolling="no" width="790" height="200"></iframe>
										</div>									</td>
								</tr>


								<tr>
									<td height="26" colspan="15" valign="middle">
										&nbsp; 描述1									</td>
								</tr>



								<tr class="chinese">
									<td height="254" colspan="15" valign="top">
										<div align="center">
                                        
<input type="hidden" name=content1 " id="content1" value=""/>
<iframe ID="eWebEditor1" src="../ewebeditor/eWebEditor.jsp?id=content1&style=CoolBlue" frameborder="0" scrolling="no" width="790" height="250"></iframe>
										</div>									</td>
								</tr>


								<tr>
									<td height="26" colspan="15" valign="middle">
										&nbsp; 描述2									</td>
								</tr>

								<tr class="chinese">
									<td height="254" colspan="15" valign="top">
										<div align="center">
<input type="hidden" name=content2 " id="content2" value=""/>
<iframe ID="eWebEditor2" src="../ewebeditor/eWebEditor.jsp?id=content2&style=CoolBlue" frameborder="0" scrolling="no" width="790" height="250"></iframe>
										</div>									</td>
								</tr>


								<tr>
									<td height="26" colspan="15" valign="middle">
										&nbsp; Standard Configuration:									</td>
								</tr>

								<tr class="chinese">
									<td height="204" colspan="15" valign="top">
										<div align="center">
<input type="hidden" name=content3 " id="content3" value=""/>
<iframe ID="eWebEditor3" src="../ewebeditor/eWebEditor.jsp?id=content3&style=CoolBlue" frameborder="0" scrolling="no" width="790" height="200"></iframe>
										</div>									</td>
								</tr>
								<tr>
									<td height="26" colspan="15" valign="middle">
										&nbsp; Optional Configurations:									</td>
								</tr>

								<tr class="chinese">
									<td height="204" colspan="15" valign="top">
										<div align="center">
<input type="hidden" name=content4 " id="content4" value=""/>
<iframe ID="eWebEditor4" src="../ewebeditor/eWebEditor.jsp?id=content4&style=CoolBlue" frameborder="0" scrolling="no" width="790" height="200"></iframe>
										</div>									</td>
								</tr>

								<tr>
									<td height="26" colspan="15" valign="middle">
										&nbsp; Specification:									</td>
								</tr>

								<tr class="chinese">
									<td height="254" colspan="15" valign="top">
										<div align="center">

										<input type="hidden" name=content5 " id="content5" value=""/>
<iframe ID="eWebEditor5" src="../ewebeditor/eWebEditor.jsp?id=content5&style=CoolBlue" frameborder="0" scrolling="no" width="790" height="250"></iframe>
										</div>									</td>
								</tr>

								<tr class="chinese">
									<td height="26" valign="top" nowrap>
										&nbsp; 附件1名称:									</td>
					  <td colspan="8" valign="top">
										<input name="ec1_word" type="text" id="ec1_word" size="35"
											maxlength="150">
						<br>
										名称不要与其它产品的附件名称一样否则会被覆盖掉</td>
									<td colspan="2" valign="top" nowrap>
										上传附件:									</td>
					  <td colspan="4" valign="top" nowrap>
						<input name="ec1" type="text" id="ec1" size="40"  maxlength="200"/>
                        <input type="button" name="ec1_upload" value="文件上传..." onClick="javascript:openUploadWin('ec1')"/></td>
							  </tr>
								<tr class="chinese">
									<td height="26" valign="top" nowrap>
										&nbsp; 附件2名称:									</td>
					  <td colspan="8" valign="top">
										<input name="ec2_word" type="text" id="ec2_word" size="35"
											maxlength="150">
										<br>
										名称不要与其它产品的附件名称一样否则会被覆盖掉 </td>
									<td colspan="2" valign="top" nowrap>
										上传附件:									</td>
					  <td colspan="4" valign="top" nowrap>
						<input name="ec2" type="text" id="ec2" size="40"  maxlength="200"/>
                                  <input type="button" name="ec2_upload" value="文件上传..." onClick="javascript:openUploadWin('ec2')"/></td>
							  </tr>
								<tr class="chinese">
									<td  valign="top" nowrap>
										&nbsp;&nbsp;Public Price:									</td>
					  <td colspan="3" valign="top">
										<input name="public_price" type="text" id="title22" size="20"
											maxlength="150">									</td>
									<td colspan="3" valign="top" nowrap>
										Deal Price:									</td>
					  <td colspan="4" valign="top">
										<input name="bs_price" type="text" id="bs_price" size="20"
											maxlength="150">									</td>
									<td colspan="2" valign="top" nowrap>
										<span class="bgcolor4">Bioson Cost</span>:									</td>
					  <td colspan="2" valign="top">
										<input name="bs_cg_price" type="text" id="bs_cg_price"
											size="20">									</td>
								</tr>

								<tr class="chinese">
									<td height="28" valign="top" nowrap>
										&nbsp;&nbsp;供应商:									</td>
					  <td colspan="8" valign="top">



										<select name="supply_id" id="supply_id">
											<option value="">
												请选择											</option>
											<%
												for(int i=0;i<supplyTableListSize;i++){
												   supplyTable=supplyTableList.get(i);
											%>
											<option value="<%=supplyTable.getSupplyId()%>"><%=supplyTable.getSupplyName()%></option>
											<%
												}
											%>
										</select>									</td>
									<td colspan="2" valign="top" nowrap>
										供应商型号:									</td>
					  <td colspan="4" valign="top">
										<input name="supply_model" type="text" id="supply_model"
											size="30">									</td>
								</tr>
								<tr class="chinese">
									<td height="31" valign="top" nowrap>
										&nbsp;&nbsp;
										<span class="bgcolor4">对应名称</span>:									</td>
					  <td colspan="8" valign="top">
										<input name="model_name" type="text" id="title22" size="35"
											maxlength="150">									</td>
									<td colspan="2" valign="top" nowrap>
										其它:									</td>
					  <td colspan="4" valign="top">
										<textarea name="other" cols="35" rows="2" wrap="hard"
											id="other"></textarea>									</td>
								</tr>

								<tr class="chinese">
									<td height="26" valign="top" nowrap>
										&nbsp;&nbsp;浏览次数:									</td>
					  <td colspan="2" valign="top">
										<input name="browse" type="text" id="title22" value="0"
											size="20" maxlength="150">									</td>
									<td colspan="4" valign="top" nowrap>
										询单次数									</td>
					  <td colspan="4" valign="top">
										<input name="ask_times" type="text" id="title26" value="0"
											size="20" maxlength="150">									</td>
									<td colspan="2" valign="top" nowrap>
										评论次数:									</td>
					  <td colspan="2" valign="top">
										<input name="com_times" type="text" id="com_times" value="0"
											size="20">									</td>
								</tr>

								<tr class="chinese">
									<td height="27" valign="top" nowrap>
										&nbsp;&nbsp;显示序号:									</td>
					  <td width="100" valign="top">
										<input name="order_id" type="text" id="title22" value="1"
											size="15" maxlength="150">									</td>
									<td colspan="3" valign="top" nowrap>
										是否显示									</td>
					  <td colspan="3" valign="top" nowrap>
		<input name="is_show" type="radio" value="1" checked>
										YES
										<input name="is_show" type="radio" value="0">
										NO									</td>
							  <td colspan="2" valign="top" nowrap>
										首页序号:									</td>
					  <td colspan="2" valign="top">
										<input name="index_order" type="text" id="index_order"
											value="99" size="10" maxlength="150">									</td>
									<td colspan="2" valign="top" nowrap>
										发布日期:									</td>
					  <td width="129" valign="top">
										<input name="p_date" type="text" id="p_date"
											value="<%=DateUtil.formatDate(System.currentTimeMillis(),2)%>" size="20" maxlength="19">									</td>
								</tr>
								<tr class="chinese">
									<td height="27" colspan="15" align="center" valign="middle">
										<p align="center">
											<input name="B2" type="submit" class="button" id="B2"
												value="确定">
											<input name="Action" type="hidden" id="Action"
												value="change_set">
											&nbsp;
											<input name="B1" type="button" class="button" value="返回"
												onClick="javascript:history.back(-1)">
										</p>									</td>
															</table>
					  </form>
				</tr>
			</table>
			<br>
			<br>
		</div>
	</body>
</html>