<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="hk.com.biosun.model.BigTable"%>
<%@page import="hk.com.biosun.model.SmallTable"%>
<%@page import="hk.com.biosun.service.BigTableService"%>
<%@page import="hk.com.biosun.service.SmallTableService"%>
<%@page import="hk.com.biosun.model.SupplyTable"%>
<%@page import="hk.com.biosun.model.ProductsTable"%>
<%@page import="hk.com.biosun.service.SupplyTableService"%>
<%@page import="com.aokle.util.MathUtil"%>
<%@page import="hk.com.biosun.service.ProductsTableService"%>
<%@include file="session_admin.jsp"%>
<%
	int p_id = MathUtil.toInt(request.getParameter("p_id"));

	ProductsTableService productsTableService = new ProductsTableService();
	ProductsTable productsTable = productsTableService.getByPK(p_id);
	if (productsTable == null) {
		out
				.println("<SCRIPT LANGUAGE='JavaScript'>alert('参数非法！');javascript:history.back(-1);</SCRIPT>");
		return;
	}

	BigTableService bigTableService = new BigTableService();
	BigTable bigTable;
	List<BigTable> bigTableList = bigTableService.getList();
	int bigTableListSize = bigTableList != null ? bigTableList.size()
			: 0;
	SmallTableService smallTableService = new SmallTableService();
	SmallTable smallTable;
	List<SmallTable> smallTableList = smallTableService.getList();
	int smallTableListSize = smallTableList != null ? smallTableList
			.size() : 0;
	SupplyTableService supplyTableService = new SupplyTableService();
	SupplyTable supplyTable;
	List<SupplyTable> supplyTableList = supplyTableService.getList();
	int supplyTableListSize = supplyTableList != null ? supplyTableList
			.size() : 0;
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
 window.open('UploadFileJsp.jsp?op=&business=adminUpload&fileType=file&webPath=product/ec/&inputId=ec1&fileName='+ecWordObj.value,'','status=no,scrollbars=no,top=200,left=310,width=420,height=165');
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
						<span class="STYLE2"> Products——修改产品</span>
					</td>


					<td width="147">&nbsp;
						
					</td>
				</tr>
				<tr>
					<td height="651">&nbsp;
						
					</td>
					<td colspan="2" valign="top">

						<form name="form1" method="POST" action="product_change_check.jsp"  onSubmit="return on_submit()">
							<table width="90%" border="1" align=center cellpadding="1"
								cellspacing="1" bordercolor="#000000" bordercolordark="#cad7f7">


								<tr>
									<td width="105" height="26" valign="middle" nowrap>
										&nbsp; 产品型号:									</td>
					  <td colspan="9" valign="top">
										<input name="p_model" type="text" id="p_model"
											value="<%=productsTable.getPModel()%>"
											size="35" maxlength="150">									</td>
									<td colspan="2" valign="top" nowrap>
										产品名称:									</td>
					  <td colspan="4" valign="top">
										<input name="p_name" type="text" id="p_name"
											value="<%=productsTable.getPName()%>"
											size="35" maxlength="150">									</td>
								</tr>
								<tr>
									<td height="29" valign="middle" nowrap>
										&nbsp; 大类:
									  <label></label>									</td>
							  <td colspan="3" valign="top">
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
										</select>
										<script language="JavaScript">
<!--
  form1.big_id.value="<%=productsTable.getBigId()%>"
//-->
              </script>									</td>
									<td colspan="4" nowrap>
										小类:									</td>
					  <td colspan="4" valign="top">
										<select name="small_id">
											<option value="0">
												请选择											</option>
											<%
												smallTable=smallTableService.getByPK(productsTable.getSmallId());
												if(smallTable!=null){
											%>
											<option value="<%=smallTable.getSmallId()%>" selected>
												<%=(smallTable.getSmallCode() + "——" + smallTable.getSmallName())%></option>
											<%
												}
											%>
										</select>									</td>
									<td colspan="2" nowrap>
										小类内权重:									</td>
					  <td colspan="2" valign="top">
										<input name="small_strong" type="text" id="small_strong"
											value="<%=productsTable.getSmallStrong()%>">									</td>
								</tr>
								<tr>
									<td height="26" valign="middle" nowrap>
										&nbsp; 产品图片:									</td>
					  <td colspan="14" valign="top">
										<input name="p_pic" type="text" id="p_pic" size="40"
                                   maxlength="200">
                                        <input type="button" name="up_pic" value="图片上传..."
                   onClick="window.open('UploadFileJsp.jsp?op=&business=adminUpload&fileType=image&webPath=product/pic/&inputId=p_pic','','status=no,scrollbars=no,top=200,left=310,width=420,height=165')">
                                        
										<br>
						当前图片：<%=productsTable.getPPic()%><br>
										不上传就空着<br>
                                        <span
                class="admin_alert">*</span>最佳像素和比例：宽x高=318*227 和 宽:高=7 : 5(图片类型jpg,jpeg,bmp,gif,png)<br>
                                        <span class="admin_alert">注意:可以直接输入已有图片地址URL,图片类型.jpg.jpeg.bmp.gif.png</span>								  </td>
								<td valign="top"><img src="../product/pic/small<%=productsTable.getPPic()%>" width="96" height="78" border="0"></td>
								</tr>

								<tr>
									<td height="26" valign="middle" nowrap>
										&nbsp;&nbsp;关键字:									</td>
					  <td colspan="15" valign="top">
										<input name="key_word" type="text" id="key_word"
											value="<%=productsTable.getKeyWord()%>"
											size="100" maxlength="150">									</td>
								</tr>

								<tr>
									<td height="26" colspan="16" valign="middle">
										&nbsp; Applications:									</td>
								</tr>

								<tr class="chinese">
									<td height="204" colspan="16" valign="top">
										<div align="center">

											<input type="hidden" name=content0 " id="content0" value="<%=productsTable.getApp()%>"/>
<iframe ID="eWebEditor0" src="../ewebeditor/eWebEditor.jsp?id=content0&style=CoolBlue" frameborder="0" scrolling="no" width="790" height="200"></iframe>
										</div>									</td>
								</tr>


								<tr>
									<td height="26" colspan="16" valign="middle">
										&nbsp; 描述1									</td>
								</tr>



								<tr class="chinese">
									<td height="254" colspan="16" valign="top">
										<div align="center">
<input type="hidden" name=content1 " id="content1" value="<%=productsTable.getDetail1()%>"/>
<iframe ID="eWebEditor1" src="../ewebeditor/eWebEditor.jsp?id=content1&style=CoolBlue" frameborder="0" scrolling="no" width="790" height="250"></iframe>
										</div>									</td>
								</tr>


								<tr>
									<td height="26" colspan="16" valign="middle">
										&nbsp; 描述2									</td>
								</tr>

								<tr class="chinese">
									<td height="254" colspan="16" valign="top">
										<div align="center">

											<input type="hidden" name=content2 " id="content2" value="<%=productsTable.getDetail2()%>"/>
<iframe ID="eWebEditor2" src="../ewebeditor/eWebEditor.jsp?id=content2&style=CoolBlue" frameborder="0" scrolling="no" width="790" height="250"></iframe>
										</div>									</td>
								</tr>


								<tr>
									<td height="26" colspan="16" valign="middle">
										&nbsp; Standard Configuration:									</td>
								</tr>

								<tr class="chinese">
									<td height="204" colspan="16" valign="top">
										<div align="center">
<input type="hidden" name=content3 " id="content3" value="<%=productsTable.getSc()%>"/>
<iframe ID="eWebEditor3" src="../ewebeditor/eWebEditor.jsp?id=content3&style=CoolBlue" frameborder="0" scrolling="no" width="790" height="200"></iframe>
										</div>									</td>
								</tr>
								<tr>
									<td height="26" colspan="16" valign="middle">
										&nbsp; Optional Configurations:									</td>
								</tr>

								<tr class="chinese">
									<td height="204" colspan="16" valign="top">
										<div align="center">
<input type="hidden" name=content4 " id="content4" value="<%=productsTable.getOc()%>"/>
<iframe ID="eWebEditor4" src="../ewebeditor/eWebEditor.jsp?id=content4&style=CoolBlue" frameborder="0" scrolling="no" width="790" height="200"></iframe>
										</div>									</td>
								</tr>

								<tr>
									<td height="26" colspan="16" valign="middle">
										&nbsp; Specification:									</td>
								</tr>

								<tr class="chinese">
									<td height="204" colspan="16" valign="top">
										<div align="center">
<input type="hidden" name=content5 " id="content5" value="<%=productsTable.getSp()%>"/>
<iframe ID="eWebEditor5" src="../ewebeditor/eWebEditor.jsp?id=content5&style=CoolBlue" frameborder="0" scrolling="no" width="790" height="250"></iframe>
										</div>									</td>
								</tr>

								<tr class="chinese">
									<td height="26" valign="top" nowrap>
										&nbsp; 附件1名称:									</td>
					  <td colspan="9" valign="top">
										<input name="ec1_word" type="text" id="ec1_word"
											value="<%=productsTable.getEc1Word()%>"
											size="35" maxlength="150">									</td>
									<td colspan="2" valign="top" nowrap>
										上传附件:									</td>
					  <td colspan="4" valign="top" nowrap>
						<input name="ec1" type="text" id="ec1" size="20"  maxlength="200"/>
                        <input type="button" name="ec1_upload" value="文件上传..." onClick="javascript:openUploadWin('ec1')"/>
                        <br>									
                        不上传就空着<br>
                        <a href="../product/ec/<%=productsTable.getEc1()%>">当前附件：<%=productsTable.getEc1()%></a></td>
							  </tr>
								<tr class="chinese">
									<td height="26" valign="top" nowrap>
										&nbsp; 附件2名称:									</td>
					  <td colspan="9" valign="top">
										<input name="ec2_word" type="text" id="ec2_word"
											value="<%=productsTable.getEc2Word()%>"
											size="35" maxlength="150">									</td>
									<td colspan="2" valign="top" nowrap>
										上传附件:									</td>
					  <td colspan="4" valign="top" nowrap>
			  <input name="ec2" type="text" id="ec2" size="20"  maxlength="200"/>
            <input type="button" name="ec2_upload" value="文件上传..." onClick="javascript:openUploadWin('ec2')"/>
            <br>
            不上传就空着									<br><a href="../product/ec/<%=productsTable.getEc2()%>">当前附件：<%=productsTable.getEc2()%></a></td>
							  </tr>
								<tr class="chinese">
									<td valign="top" nowrap>
										&nbsp;&nbsp;Public Price:									</td>
<td colspan="3" valign="top">
										<input name="public_price" type="text" id="title22"
											value="<%=MathUtil.formatFloat(productsTable.getPublicPrice())%>" size="20"
											maxlength="150">									</td>
									<td colspan="2" valign="top" nowrap>
										Deal Price:									</td>
					  <td colspan="6" valign="top">
										<input name="bs_price" type="text" id="bs_price"
											value="<%=MathUtil.formatFloat(productsTable.getBsPrice())%>" size="20"
											maxlength="150">									</td>
									<td colspan="2" valign="top" nowrap>
										<span class="bgcolor4">Bioson Cost</span>:									</td>
					  <td colspan="2" valign="top">
										<input name="bs_cg_price" type="text" id="bs_cg_price"
											value="<%=MathUtil.formatFloat(productsTable.getBsCgPrice())%>" size="20">									</td>
								</tr>

								<tr class="chinese">
									<td height="28" valign="top" nowrap>
										&nbsp;&nbsp;供应商:									</td>
					  <td colspan="9" valign="top">
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
											<script language="JavaScript">
<!--
  form1.supply_id.value="<%=productsTable.getSupplyId()%>"
//-->
</script>
										</select>									</td>
									<td colspan="2" valign="top" nowrap>
										供应商型号:									</td>
					  <td colspan="4" valign="top">
										<input name="supply_model" type="text" id="supply_model"
											value="<%=productsTable.getSupplyModel()%>"
											size="30">									</td>
								</tr>
								<tr class="chinese">
									<td height="31" valign="top" nowrap>
										&nbsp;&nbsp;
										<span class="bgcolor4">对应名称</span>:									</td>
					  <td colspan="9" valign="top">
										<input name="model_name" type="text" id="title22"
											value="<%=productsTable.getModelName()%>"
											size="35" maxlength="150">									</td>
									<td colspan="2" valign="top" nowrap>
										其它:									</td>
					  <td colspan="4" valign="top">
										<textarea name="other" cols="35" rows="2" wrap="hard"
											id="other"><%=productsTable.getOther()%></textarea>									</td>
								</tr>

								<tr class="chinese">
									<td height="26" valign="top" nowrap>
										&nbsp;&nbsp;浏览次数:									</td>
					  <td colspan="2" valign="top">
										<input name="browse" type="text" id="title22"
											value="<%=productsTable.getBrowse()%>" size="20" maxlength="150">									</td>
									<td colspan="4" valign="top" nowrap>
										询单次数									</td>
					  <td colspan="5" valign="top">
										<input name="ask_times" type="text" id="title26"
											value="<%=productsTable.getAskTimes()%>" size="20" maxlength="150">									</td>
									<td colspan="2" valign="top" nowrap>
										评论次数:									</td>
					  <td colspan="2" valign="top">
										<input name="com_times" type="text" id="com_times"
											value="<%=productsTable.getComTimes()%>" size="20">									</td>
								</tr>

								<tr class="chinese">
									<td height="27" valign="top" nowrap>
										&nbsp;&nbsp;显示序号:									</td>
					  <td width="102" valign="top">
									<input name="order_id" type="text" id="title22"
											value="<%=productsTable.getOrderId()%>" size="15" maxlength="150">									</td>
									<td colspan="3" valign="top" nowrap>
										是否显示:									</td>
					  <td colspan="4" valign="top" nowrap>
		<input name="is_show" type="radio" value="1"
											<%if("1".equals(productsTable.getIsShow()))out.print("checked");%>>
										YES
										<input name="is_show" type="radio" value="0"
											<%if("0".equals(productsTable.getIsShow()))out.print("checked");%>>
										NO									</td>
							  <td colspan="2" valign="top" nowrap>
										首页序号:									</td>
					  <td colspan="2" valign="top">
										<input name="index_order" type="text" id="index_order"
											value="<%=productsTable.getIndexOrder()%>" size="15"
											maxlength="150">									</td>
									<td colspan="2" valign="top" nowrap>
										发布日期:									</td>
					  <td width="114" valign="top">
									<input name="p_date" type="text" id="p_date"
											value="<%=productsTable.getPDate()%>"
											size="19" maxlength="19">									</td>
								</tr>



								<tr class="chinese">
									<td height="27" colspan="16" align="center" valign="middle">
										<p align="center">
											<input name="p_id" type="hidden" id="p_id" value="<%=p_id%>">
											<input name="p_pic_session" type="hidden" id="p_pic_session"
												value="<%=productsTable.getPPic()%>">
											<input name="ec_1_session" type="hidden" id="ec_1_session"
												value="<%=productsTable.getEc1()%>">
											<input name="ec_2_session" type="hidden" id="ec_2_session"
												value="<%=productsTable.getEc2()%>"/>

											<input name="B2" type="submit" class="button" id="B2"
												value="修改">
											<input name="Action" type="hidden" id="Action"
												value="change_set">
											&nbsp;
											<input name="B1" type="button" class="button" value="返回"
												onClick="javascript:history.back(-1)">
										</p>									</td>
								<tr>
									<td height="5"></td>
									<td></td>
									<td width="35"></td>
									<td width="1"></td>
									<td width="26"></td>
									<td width="41"></td>
									<td width="1"></td>
									<td width="2"></td>
									<td width="48"></td>
									<td width="4"></td>
									<td width="69"></td>
									<td width="15"></td>
									<td width="80"></td>
									<td width="1"></td>
									<td width="91"></td>
									<td></td>
								</tr>
							</table>
					  </form>
				</tr>
			</table>

			<br>
			<br>
		</div>
	</body>
</html>