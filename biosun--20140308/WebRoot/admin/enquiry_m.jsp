<%@page contentType="text/html;charset=utf-8"%>
<%@page import="com.aokle.util.StrUtil"%>
<%@page import="com.aokle.util.MathUtil"%>
<%@page import="hk.com.biosun.util.ReqParamUtil"%>
<%@page import="hk.com.biosun.util.SessionUtil"%>
<%@page import="hk.com.biosun.define.EnquiryAndBuyCart"%>
<%@page import="hk.com.biosun.service.EnquiryAndBuyCartService"%>
<%@page import="hk.com.biosun.service.EnquiryService"%>
<%@page import="hk.com.biosun.service.BuyCarService"%>
<%@page import="java.util.*"%>
<%@include file="session_admin.jsp"%>
<%
	String en_id = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
			.getParameter("en_id")));
	String en_id_find = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("en_id_find")));

	String user_id = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
			.getParameter("user_id")));
	String en_date = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
			.getParameter("en_date")));

	String p_model = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
			.getParameter("p_model")));

	String order_by = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("order_by")));
	int pageNo = MathUtil.toInt(ReqParamUtil.getReqParam(request
			.getParameter("page")), 1);

	String submit_all = request.getParameter("submit_all");
	String en_del = request.getParameter("en_del");

	EnquiryService enquiryService = new EnquiryService();
	EnquiryAndBuyCartService enquiryAndBuyCartService = new EnquiryAndBuyCartService();
	if (en_del != null && en_del.equals("ok")) {
		int result = enquiryService.delete(en_id);
		if (result > 0) {
			BuyCarService buyCarService = new BuyCarService();
			buyCarService.deleteByEnId(en_id);
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('Success!');</SCRIPT>");
		} else {
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('Fail！');</SCRIPT>");
		}
	}
	List<Object> valuesList = new ArrayList<Object>();
	StringBuffer condSB = new StringBuffer();
	if (submit_all != null) {
		en_id_find = "";
		user_id = "";
		order_by = "";
		en_date = "";
		p_model = "";
	} else {
		if (!en_id_find.equals("")) {
			condSB.append(" AND enquiry.en_id=?");
			valuesList.add(en_id_find);
		}
		if (!user_id.equals("")) {
			condSB.append(" AND enquiry.user_id LIKE ?");
			valuesList.add("%" + user_id + "%");
		}
		if (!en_date.equals("")) {
			condSB.append(" AND enquiry.en_date LIKE ?");
			valuesList.add("%" + en_date + "%");
		}
		if (!p_model.equals("")) {
			condSB.append(" AND buy_car.p_model=?");
			valuesList.add(p_model);
		}
	}
	
	if (condSB.length() > 4) {
		condSB.delete(0, 4);
		condSB.insert(0, "WHERE");
	}

	int recordCount = enquiryAndBuyCartService.getCount(condSB
			.toString(), valuesList);

	condSB.append(" ORDER BY ");
	if (!order_by.equals("")) {
		condSB.append(order_by + "  DESC");
	} else {
		condSB.append("enquiry.en_id DESC");
	}

	int pageSize = MathUtil.toInt(request.getParameter("pageSize"),20);
	List<EnquiryAndBuyCart> enquiryAndBuyCartList = enquiryAndBuyCartService
			.getList(condSB.toString(), valuesList, pageSize, pageNo);
	int enquiryAndBuyCartListSize = enquiryAndBuyCartList != null
			? enquiryAndBuyCartList.size()
			: 0;
	EnquiryAndBuyCart enquiryAndBuyCart;
	int pageCount = (recordCount - 1) / pageSize + 1;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<script language="javascript">
 function on_submit()
 {
 if(isNaN(document.form1.en_id_find.value)&&document.form1.en_id_find.value!="")
  {
    alert("Please input the  Integer!");
	form1.en_id_find.value="";	
    document.form1.en_id_find.focus();
	return false;
  }
}

function del_con()
{
   if(confirm("确定要删除该询单的所有信息！"))
     return true;
   else
     return false;
	 
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
			<form name="form1" method="POST" action="enquiry_m.jsp"
					onSubmit="return on_submit()">
			<table width="2850" border="0" align="center" cellpadding="0"
				cellspacing="0">
				<tr>
					<td width="959" height="21" align="left">
						<span class="STYLE2"> Enquiry List</span>
					</td>
					<td width="1891">&nbsp;
						
					</td>
				</tr>
				<tr>
					<td height="9"></td>
					<td></td>
				</tr>
				<tr>
					<td height="30" valign="middle">
						&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
						&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;Enquiry ID
						<input name="en_id_find" type="text" id="en_id_find"
							value="<%=en_id_find%>" size="25" maxlength="150">
						&nbsp;&nbsp;User ID
						<input name="user_id" type="text" id="user_id"
							value="<%=user_id%>" size="30" maxlength="150">
						&nbsp;
					</td>
					<td></td>
				</tr>
				<tr>
					<td height="30" valign="middle">
						&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
						&nbsp;&nbsp; &nbsp;&nbsp; &nbsp; Enquiry Date :
						<input name="en_date" type="text" id="en_date"
							value="<%=en_date%>" size="25" maxlength="25">
						&nbsp;&nbsp;Product Moden :
						<input name="p_model" type="text" id="p_model"
							value="<%=p_model%>" size="25" maxlength="25">
					</td>
					<td>&nbsp;
						
					</td>
				</tr>



				<tr>
					<td height="30" align="center" valign="middle">
					<input name="pageSize" type="hidden" id="pageSize" value="<%=pageSize%>"/>
						<input name="submit_find" type="submit" id="submit_find"
							value="查  找">
						&nbsp;&nbsp;&nbsp;&nbsp;
						<input name="submit_all" type="submit" id="submit_all"
							value="显示全部">
						&nbsp;&nbsp;&nbsp;&nbsp;
					</td>
					<td>&nbsp;
						
					</td>
				</tr>
				
				<tr>
					<td height="191" colspan="2" valign="top">
						<table width="100%" border="1" cellpadding="0" cellspacing="0"
							bordercolor="#000000" bordercolordark="#FFFFFF">

							<tr class="bgcolor4">
								<td width="61" height="38" align="center">
									Item No.
								</td>
								<td width="98" align="center" valign="middle" class="bgcolor4">
									<a
										href="enquiry_m.jsp?pageSize=<%=pageSize%>&&page=<%=pageNo%>&&en_id_find=<%=en_id_find%>&&user_id=<%=user_id%>&&en_date=<%=en_date%>&&order_by=enquiry.en_id">
										Enquiry ID </a>
								</td>

								<TD width="134" align="center" vAlign=middle class="bgcolor4">
									<a
										href="enquiry_m.jsp?pageSize=<%=pageSize%>&&page=<%=pageNo%>&&en_id_find=<%=en_id_find%>&&user_id=<%=user_id%>&&en_date=<%=en_date%>&&order_by=enquiry.user_id">
										User ID </a>
								</TD>


								<TD width="425" align="center" vAlign=middle class="bgcolor4">
									Request Inf
								</TD>
								<TD width="160">
									<a
										href="enquiry_m.jsp?pageSize=<%=pageSize%>&&page=<%=pageNo%>&&en_id_find=<%=en_id_find%>&&user_id=<%=user_id%>&&en_date=<%=en_date%>&&order_by=order_s">
										Order Samples</a>
								</TD>
								<TD width="97" align="center" valign="middle">
									<a
										href="enquiry_m.jsp?pageSize=<%=pageSize%>&&page=<%=pageNo%>&&en_id_find=<%=en_id_find%>&&user_id=<%=user_id%>&&en_date=<%=en_date%>&&order_by=p_id_s">
										Model </a>
								</TD>
								<TD width="140" align="center" vAlign=middle class="bgcolor4">
									<a
										href="enquiry_m.jsp?pageSize=<%=pageSize%>&&page=<%=pageNo%>&&en_id_find=<%=en_id_find%>&&user_id=<%=user_id%>&&en_date=<%=en_date%>&&order_by=account_inf">
										Account Information </a>
								</TD>
								<TD width="97" align="center" vAlign=middle class="bgcolor4">
									<SPAN lang="EN-US"> <a
										href="enquiry_m.jsp?pageSize=<%=pageSize%>&&page=<%=pageNo%>&&en_id_find=<%=en_id_find%>&&user_id=<%=user_id%>&&en_date=<%=en_date%>&&order_by=account_num">
											Account Number </a> </SPAN>
								</TD>
								<TD width="277">
									Other Message
								</TD>
								<TD width="204" align="center" vAlign=middle>
									<a
										href="enquiry_m.jsp?pageSize=<%=pageSize%>&&page=<%=pageNo%>&&en_id_find=<%=en_id_find%>&&user_id=<%=user_id%>&&en_date=<%=en_date%>&&order_by=p_model">
										Products Model </a>
								</TD>
								<TD width="204" align="center" vAlign=middle class="bgcolor4">
									Product Name
								</TD>
								<TD width="201">
									<a
										href="enquiry_m.jsp?pageSize=<%=pageSize%>&&page=<%=pageNo%>&&en_id_find=<%=en_id_find%>&&user_id=<%=user_id%>&&en_date=<%=en_date%>&&order_by=p_count">Qty.(set)
									</a>
								</TD>



								<TD width="139">
									Product Image
								</TD>



								<td width="196">
									<a
										href="enquiry_m.jsp?pageSize=<%=pageSize%>&&page=<%=pageNo%>&&en_id_find=<%=en_id_find%>&&user_id=<%=user_id%>&&en_date=<%=en_date%>&&order_by=en_date">
										Enquiry Date</a>
								</td>
								<td width="281">
									<a
										href="enquiry_m.jsp?pageSize=<%=pageSize%>&&page=<%=pageNo%>&&en_id_find=<%=en_id_find%>&&user_id=<%=user_id%>&&en_date=<%=en_date%>&&order_by=en_status">Enquiry
										Status </a>
								</td>

								<TD width="102" align="center" vAlign=middle class="bgcolor4">
									<img src="../img/doing.jpg" width="102" height="23">
								</TD>
							</tr>
							<%
								for(int i=0;i<enquiryAndBuyCartListSize;i++){
									enquiryAndBuyCart=enquiryAndBuyCartList.get(i);
							%>
							<tr bgcolor="#f8f8f8" onMouseOver="this.bgColor='#FFFFFF'"
								onMouseOut="this.bgColor='#f8f8f8'">
								<td height="98" align="center" valign="middle"><%=i%></td>
								<td align="center" valign="middle">
									<a
										href="enquiry_m.jsp?pageSize=<%=pageSize%>&&en_id_find=<%=enquiryAndBuyCart.getEnId()%>"><%=enquiryAndBuyCart.getEnId()%></a>
								</td>
								<TD vAlign=center>
									<a
										href="user_inf.jsp?id_find=<%=enquiryAndBuyCart.getUserId()%>"><%=enquiryAndBuyCart.getUserId()%></a>
								<TD vAlign=center>
									&nbsp;<%=(enquiryAndBuyCart.getEnP()
								+ ","
								+ enquiryAndBuyCart.getMi()
								+ ","
								+ enquiryAndBuyCart.getDe()
								+ ","
								+ enquiryAndBuyCart.getInOk() + "," + enquiryAndBuyCart.getSa())%></TD>
								<TD align="center" valign="middle"><%=enquiryAndBuyCart.getOrderS()%></TD>
								<TD><%=enquiryAndBuyCart.getPIdS()%></TD>
								<TD vAlign=middle>
									&nbsp;<%=enquiryAndBuyCart.getAccountInf()%></TD>
								<TD vAlign=middle>
									&nbsp;<%=enquiryAndBuyCart.getAccountNum()%></TD>
								<TD><%=enquiryAndBuyCart.getOtMs()%></TD>
								<TD vAlign=middle>
									<a
										href="product.jsp?p_model=<%=enquiryAndBuyCart.getPModel()%>"><%=enquiryAndBuyCart.getPModel()%></a>
								</TD>
								<TD valign="middle"><%=enquiryAndBuyCart.getPName()%></TD>
								<TD align="center" valign="middle"><%=enquiryAndBuyCart.getPCount()%></TD>
								<TD align="center" valign="middle">
									<a href="show_pic.jsp?p_pic=<%=enquiryAndBuyCart.getPPic()%>"
										target="_blank"><%=enquiryAndBuyCart.getPPic()%>
									</a>
									<img src="../product/pic/small<%=enquiryAndBuyCart.getPPic()%>" width="96"
										height="78">
								</TD>
								<td><%=enquiryAndBuyCart.getEnDate()%></td>
								<td align="center" valign="middle">
									<a
										href="en_status.jsp?en_id=<%=enquiryAndBuyCart.getEnId()%>"><%=enquiryAndBuyCart.getEnStatus()%></a>
								</td>
								<TD align="center" vAlign=middle>
									<a
										href="enquiry_m.jsp?pageSize=<%=pageSize%>&&en_id=<%=enquiryAndBuyCart.getEnId()%>&&page=<%=pageNo%>user_id=<%=user_id%>&&en_date=<%=en_date%>&&order_by=<%=order_by%>&&en_del=ok"
										onClick="return del_con();">删除</a>
								</TD>
							</tr>

							<%
								}
								if (enquiryAndBuyCartListSize>0) {
							%>

							<tr>
								<td height="31" colspan="8" align="center" valign="middle">
									<div align="center">

										<%
											if (pageNo > 1) {
										%>
										<a
											href="enquiry_m.jsp?pageSize=<%=pageSize%>&&page=<%=(pageNo - 1)%>&&en_id_find=<%=en_id_find%>&&user_id=<%=user_id%>&&en_date=<%=en_date%>&&order_by=<%=order_by%>">上一页</a>&nbsp;&nbsp;
										<%
											}
												if (pageNo < pageCount) {
										%>
										<a
											href="enquiry_m.jsp?pageSize=<%=pageSize%>&&page=<%=(pageNo + 1)%>&&en_id_find=<%=en_id_find%>&&user_id=<%=user_id%>&&en_date=<%=en_date%>&&order_by=<%=order_by%>">下一页</a>
										<%
											}
										%>
										&nbsp;&nbsp;&nbsp;&nbsp;共
										<strong><%=pageCount%></strong>页
										<strong><%=recordCount%></strong>条记录 &nbsp;&nbsp;&nbsp;&nbsp;
										<SELECT name=pageSizeSelect id=pageSizeSelect onChange="location.href=this.options[this.selectedIndex].value;">
										<OPTION value=# selected><%=pageSize%></OPTION>												
<OPTION value=enquiry_m.jsp?pageSize=20&&page=<%=pageNo%>&&en_id_find=<%=en_id_find%>&&user_id=<%=user_id%>&&en_date=<%=en_date%>&&order_by=<%=order_by%>>20</OPTION>
<OPTION value=enquiry_m.jsp?pageSize=30&&page=<%=pageNo%>&&en_id_find=<%=en_id_find%>&&user_id=<%=user_id%>&&en_date=<%=en_date%>&&order_by=<%=order_by%>>30</OPTION>
<OPTION value=enquiry_m.jsp?pageSize=50&&page=<%=pageNo%>&&en_id_find=<%=en_id_find%>&&user_id=<%=user_id%>&&en_date=<%=en_date%>&&order_by=<%=order_by%>>50</OPTION>
<OPTION value=enquiry_m.jsp?pageSize=75&&page=<%=pageNo%>&&en_id_find=<%=en_id_find%>&&user_id=<%=user_id%>&&en_date=<%=en_date%>&&order_by=<%=order_by%>>75</OPTION>
<OPTION value=enquiry_m.jsp?pageSize=100&&page=<%=pageNo%>&&en_id_find=<%=en_id_find%>&&user_id=<%=user_id%>&&en_date=<%=en_date%>&&order_by=<%=order_by%>>100</OPTION>													
													
											</select>条/页&nbsp;&nbsp;
										<label>
											第
											<SELECT name=menu1
												onChange="javascript:location.href=this.options(this.selectedIndex).value;">
												<OPTION value=# selected><%=pageNo%></OPTION>

												<%
														int pageMin = pageNo - 20;
															pageMin = pageMin < 1 ? 1 : pageMin;
															int pageMax = pageNo + 20;
															pageMax = pageMax > pageCount ? pageCount : pageMax;
															if (pageMin > pageMax) {
																pageMin = pageMax;
															}
															for (int i = pageMin; i <= pageMax; i++) {
																if (i == pageNo)
																	continue;
													%>
<OPTION value=enquiry_m.jsp?pageSize=<%=pageSize%>&&page=<%=i%>&&en_id_find=<%=en_id_find%>&&user_id=<%=user_id%>&&en_date=<%=en_date%>&&order_by=<%=order_by%>><%=i%></OPTION>
												<%
													}
												%>
											</select>
										</label>
										页
									</div>
								</td>
								<td>&nbsp;
									
								</td>
								<td>&nbsp;
									
								</td>
								<td>&nbsp;
									
								</td>
								<td>&nbsp;
									
								</td>
								<td>&nbsp;
									
								</td>
								<td>&nbsp;
									
								</td>
								<td>&nbsp;
									
								</td>
								<td>&nbsp;
									
								</td>
							</tr>

							<%
								} else {
							%>
							<tr>
								<td height="22" colspan="8" align="center" valign="middle">
									<font color="#FF0000">No Record！
								</td>
								<td>&nbsp;
									
								</td>
								<td>&nbsp;
									
								</td>
								<td>&nbsp;
									
								</td>
								<td>&nbsp;
									
								</td>
								<td>&nbsp;
									
								</td>
								<td>&nbsp;
									
								</td>
								<td>&nbsp;
									
								</td>
								<td>&nbsp;
									
								</td>
							</tr>
							<%
								}
							%>
						</table>
					</td>
				</tr>
			</table>
			</form>
			<br>
			<br>
		</div>
	</body>
</html>