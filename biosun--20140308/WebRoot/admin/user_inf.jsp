<%@page contentType="text/html;charset=utf-8"%>
<%@page import="com.aokle.util.StrUtil"%>
<%@page import="com.aokle.util.MathUtil"%>
<%@page import="hk.com.biosun.util.ReqParamUtil"%>
<%@page import="hk.com.biosun.util.SessionUtil"%>
<%@page import="hk.com.biosun.service.UserInfService"%>
<%@page import="hk.com.biosun.model.UserInf"%>
<%@page import="hk.com.biosun.service.EnquiryService"%>
<%@page import="hk.com.biosun.service.BuyCarService"%>
<%@page import="java.util.*"%>
<%@include file="session_admin.jsp"%>
<%
	String id = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
			.getParameter("id")));
	String id_find = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
			.getParameter("id_find")));

	String company = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
			.getParameter("company")));
	String country_code = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("country_code")));
	String person = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
			.getParameter("person")));
	String invoice = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
			.getParameter("invoice")));

	String order_by = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("order_by")));
	int pageNo = MathUtil.toInt(ReqParamUtil.getReqParam(request
			.getParameter("page")),1);

	String submit_all = request.getParameter("submit_all");
	String user_del = request.getParameter("user_del");

	UserInfService userInfService = new UserInfService();
	if (user_del != null && user_del.equals("ok")) {
		int result = userInfService.delete(id);
		if (result > 0) {
			//删除询单  
			EnquiryService enquiryService = new EnquiryService();
			enquiryService.deleteByUserId(id);
			BuyCarService buyCarService = new BuyCarService();
			buyCarService.deleteByUserId(id);
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
		id_find = "";
		company = "";
		order_by = "";
		country_code = "";
	} else {
		if (id_find != null && !"".equals(id_find)) {
			condSB.append(" AND id LIKE ?");
			valuesList.add("%" + id_find + "%");
		}
		if (company != null && !"".equals(company)) {
			condSB.append(" AND company LIKE ?");
			valuesList.add("%" + company + "%");
		}
		if (country_code != null && !"".equals(country_code)) {
			condSB.append(" AND country_code LIKE ?");
			valuesList.add("%" + country_code + "%");
		}
	}
	if (condSB.length() > 4) {
		condSB.delete(0, 4);
		condSB.insert(0, "WHERE");
	}
	int recordCount = userInfService.getCount(condSB.toString(),
			valuesList);
			
	if (order_by.equals("person")) {
		condSB.append(" ORDER BY ");
		condSB.append(order_by);
	} else if (!order_by.equals("")) {
		condSB.append(" ORDER BY ");
		condSB.append(order_by + " DESC");
	}

    int pageSize = MathUtil.toInt(request.getParameter("pageSize"),20);
	List<UserInf> userInfList = userInfService.getList(condSB
			.toString(), valuesList,pageSize,pageNo);
	int userInfListSize = userInfList != null ? userInfList.size() : 0;
	UserInf userInf;
	
	int pageCount = (recordCount - 1) / pageSize + 1;
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<script language="javascript">
 function on_submit()
 {
 if(isNaN(document.form1.country_code.value)&&document.form1.country_code.value!="")
  {
    alert("Please input the  Integer!");
	form1.country_code.value="";	
    document.form1.country_code.focus();
	return false;
  }
}
 
//删除一条信息
function del()
{
   if(confirm("确定要删除该会员以及该会员的询单？并且不能恢复！"))
     return true;
   else
     return false;
	 
}

</SCRIPT>
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
			<form name="form1" method="POST" action="user_inf.jsp">
				<table width="3800" border="0" align="center" cellpadding="0"
					cellspacing="0">
					<tr>
						<td height="21" colspan="2" align="left">
							<span class="STYLE2"> 会员管理</span>
						</td>
						<td width="2821">&nbsp;
							
						</td>
						<td width="20">&nbsp;
							
						</td>
					</tr>
					<tr>
						<td width="924" height="9"></td>
						<td width="35"></td>
						<td></td>
						<td></td>
					</tr>

					<tr>
						<td height="55" colspan="2" align="center" valign="middle">
							<p>
								User ID
								<input name="id_find" type="text" id="id_find"
									value="<%=id_find%>" size="10" maxlength="150">
								&nbsp;&nbsp;Company
								<input name="company" type="text" id="company"
									value="<%=company%>" size="30" maxlength="150">
								&nbsp;&nbsp;Country Code:
								<input name="country_code" type="text" id="country_code"
									value="<%=country_code%>" size="19" maxlength="25">
							</p>
							<p>
								&nbsp;Contact person:
								<input name="person" type="text" id="person" value="<%=person%>"
									size="19" maxlength="25">
								&nbsp;&nbsp;Invoice Number:
								<input name="invoice" type="text" id="invoice"
									value="<%=invoice%>" size="19" maxlength="25">
							</p>
						</td>
						<td></td>
						<td></td>
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
						<td>&nbsp;
							
						</td>
						<td>&nbsp;
							
						</td>
					</tr>
					<tr>
						<td height="153" colspan="3" valign="top">
							<table width="100%" border="1" cellpadding="0" cellspacing="0"
								bordercolor="#000000" bordercolordark="#FFFFFF">

								<tr class="bgcolor4">
									<td width="20" height="38" align="center">
										Item No.
									</td>
									<td width="5%" align="center" valign="middle" class="bgcolor4">
										User ID
									</td>

									<TD width="3%" vAlign=center class="bgcolor4">
										PassWord
									</TD>



									<TD width="4%" vAlign=center class="bgcolor4">
										answer
									</TD>
									<TD width="2%">
										<a
											href="user_inf.jsp?pageSize=<%=pageSize%>&&page=<%=pageNo%>&&id_find=<%=id_find%>&&company=<%=company%>&&country_code=<%=country_code%>&&order_by=send">
											send </a>
									</TD>
									<TD width="3%">
										<a
											href="user_inf.jsp?pageSize=<%=pageSize%>&&page=<%=pageNo%>&&id_find=<%=id_find%>&&company=<%=company%>&&country_code=<%=country_code%>&&order_by=sex">Sex
										</a>
									</TD>
									<TD width="3%" align="center" vAlign=middle class="bgcolor4">
										<a
											href="user_inf.jsp?pageSize=<%=pageSize%>&&page=<%=pageNo%>&&id_find=<%=id_find%>&&company=<%=company%>&&country_code=<%=country_code%>&&order_by=person">Contact
											person</a>
									</TD>
									<TD width="3%" align="center" vAlign=middle class="bgcolor4">
										<a
											href="user_inf.jsp?pageSize=<%=pageSize%>&&page=<%=pageNo%>&&id_find=<%=id_find%>&&company=<%=company%>&&country_code=<%=country_code%>&&order_by=job_title">
											Job title</a>
									</TD>
									<TD width="5%">
										<a
											href="user_inf.jsp?pageSize=<%=pageSize%>&&page=<%=pageNo%>&&id_find=<%=id_find%>&&company=<%=company%>&&country_code=<%=country_code%>&&order_by=company">
											Company</a>
									</TD>
									<TD width="4%" align="center" vAlign=middle>
										<a
											href="user_inf.jsp?pageSize=<%=pageSize%>&&page=<%=pageNo%>&&id_find=<%=id_find%>&&company=<%=company%>&&country_code=<%=country_code%>&&order_by=country_code">Tel</a>
									</TD>
									<TD width="4%" align="center" vAlign=middle class="bgcolor4">
										Fax
									</TD>
									<TD width="5%">
										<a
											href="user_inf.jsp?pageSize=<%=pageSize%>&&page=<%=pageNo%>&&id_find=<%=id_find%>&&company=<%=company%>&&country_code=<%=country_code%>&&order_by=email">Email</a>
									</TD>
									<td width="5%">
										<a
											href="user_inf.jsp?pageSize=<%=pageSize%>&&page=<%=pageNo%>&&id_find=<%=id_find%>&&company=<%=company%>&&country_code=<%=country_code%>&&order_by=ms">Messenger</a>
									</td>
									<td width="5%">
										Website
									</td>
									<td width="8%">
										<a
											href="user_inf.jsp?pageSize=<%=pageSize%>&&page=<%=pageNo%>&&id_find=<%=id_find%>&&company=<%=company%>&&country_code=<%=country_code%>&&order_by=mailing_address">
											Mailing address</a>
									</td>
									<td width="5%">
										Business Type
									</td>
									<TD width="4%">
										Invoice Number
									</TD>
									<TD width="5%">
										Other message
									</TD>
									<TD width="85">
										<a
											href="user_inf.jsp?pageSize=<%=pageSize%>&&page=<%=pageNo%>&&id_find=<%=id_find%>&&company=<%=company%>&&country_code=<%=country_code%>&&order_by=login_times">Login
											times</a>
									</TD>

									<TD width="39">
										<a
											href="user_inf.jsp?pageSize=<%=pageSize%>&&page=<%=pageNo%>&&id_find=<%=id_find%>&&company=<%=company%>&&country_code=<%=country_code%>&&order_by=id_grage">Comments
											Times</a>
									</TD>
									<TD width="87">
										<a
											href="user_inf.jsp?pageSize=<%=pageSize%>&&page=<%=pageNo%>&&id_find=<%=id_find%>&&company=<%=company%>&&country_code=<%=country_code%>&&order_by=en_times">Enquiry
											times</a>
									</TD>
									<TD width="80">
										<a
											href="user_inf.jsp?pageSize=<%=pageSize%>&&page=<%=pageNo%>&&id_find=<%=id_find%>&&company=<%=company%>&&country_code=<%=country_code%>&&order_by=trade_times">Deal
											times</a>
									</TD>
									<TD width="39">
										<a
											href="user_inf.jsp?pageSize=<%=pageSize%>&&page=<%=pageNo%>&&id_find=<%=id_find%>&&company=<%=company%>&&country_code=<%=country_code%>&&order_by=id_grage">Rank</a>
									</TD>
									<TD width="4%">
										<a
											href="user_inf.jsp?pageSize=<%=pageSize%>&&page=<%=pageNo%>&&id_find=<%=id_find%>&&company=<%=company%>&&country_code=<%=country_code%>&&order_by=reg_date">Sign-up
											Date</a>
									</TD>
									<TD width="7%">
										Login Record
									</TD>
									<TD width="2%" align="center" vAlign=middle class="bgcolor4">
										<img src="../img/doing.jpg" width="102" height="23">
									</TD>
								</tr>
								<%
									for(int i=0;i<userInfListSize;i++){
										userInf=userInfList.get(i);
								%>

								<tr bgcolor="#f8f8f8" onMouseOver="this.bgColor='#FFFFFF'"
									onMouseOut="this.bgColor='#f8f8f8'">
									<td height="42" align="center" valign="middle"><%=(pageNo-1)*pageSize+i+1%></td>
									<td align="center" valign="middle"><%=userInf.getId()%></td>

									<TD vAlign=center>
										&nbsp;<%=userInf.getPassword()%>
									<TD vAlign=center>
										&nbsp;<%=userInf.getAnswer()%>
									</TD>
									<TD>
										<%
											if ("1".equals(userInf.getSend()))
													out.print("YES");
												else
													out.print("NO");
										%>
									</TD>
									<TD>
										<%
											if ("1".equals(userInf.getSex()))
													out.print("man");
												else
													out.print("Female");
										%>
									</TD>
									<TD vAlign=middle>
										&nbsp;<%=userInf.getPerson()%></TD>
									<TD vAlign=middle>
										&nbsp;<%=userInf.getJobTitle()%></TD>
									<TD><%=userInf.getCompany()%></TD>
									<TD vAlign=middle>
										&nbsp;<%=userInf.getCountryCode()%>-<%=userInf.getAreaCode()%>-<%=userInf.getTel()%></TD>
									<TD valign="middle">
										&nbsp;<%=userInf.getFCcode()%>-<%=userInf.getFAcode()%>-<%=userInf.getFax()%>
									</TD>
									<TD><%=userInf.getEmail()%></TD>
									<td><%=userInf.getMs()%></td>
									<td>
										<a
											href="<%=userInf.getWebsite()%>"><%=userInf.getWebsite()%></a>
									</td>
									<td><%=userInf.getMailingAddress()%>,City:
										<%=userInf.getACity()%>,State:<%=userInf.getAState()%>
										,Zip:<%=userInf.getAZip()%>
										,Country:<%=userInf.getACountry()%>
									</td>
									<td><%=userInf.getDi()%>,
										<%=userInf.getMa()%>,
										<%=userInf.getEn()%>,
										<%=userInf.getIm1()%>,
										<%=userInf.getIm2()%>,
										<%=userInf.getRe()%>,
										<%=userInf.getBu()%>,
										<%=userInf.getBr()%>,
										<%=userInf.getPr()%>,
										<%=userInf.getOt()%>
									</td>
									<TD><%=userInf.getInvoice()%></TD>
									<TD><%=userInf.getOtherMs()%></TD>
									<TD align="center" valign="middle"><%=userInf.getLoginTimes()%></TD>
									<TD align="center" valign="middle">
										<a
											href="com.jsp?user_id=<%=userInf.getId()%>"><%=userInf.getUsercomTimes()%></a>
									</TD>

									<TD align="center" valign="middle">
										<a
											href="enquiry_m.jsp?user_id=<%=userInf.getId()%>"><%=userInf.getEnTimes()%></a>
									</TD>
									<TD align="center" valign="middle">
										<a
											href="deal.jsp?id=<%=userInf.getId()%>"><%=userInf.getTradeTimes()%></a>
									</TD>

									<TD align="center" valign="middle"><%=userInf.getIdGrage()%></TD>

									<TD><%=userInf.getRegDate()%></TD>
									<TD><%=userInf.getLoginLog()%></TD>
									<TD align="center" vAlign=middle>
										<a href="user_inf.jsp?pageSize=<%=pageSize%>&&id=<%=userInf.getId()%>&&page=<%=pageNo%>company=<%=company%>&&country_code=<%=country_code%>&&order_by=<%=order_by%>&&person=<%=person%>&&invoice=<%=invoice%>&&user_del=ok" onClick="return del();">删除</a>
									</TD>

								</tr>

								<%
									}
									if (userInfListSize>0) {
								%>

								<tr>
									<td height="31" colspan="10" align="center" valign="middle">
										<div align="center">

											<%
												if (pageNo > 1) {
											%>
											<a
												href="user_inf.jsp?pageSize=<%=pageSize%>&&page=<%=(pageNo - 1)%>&&id_find=<%=id_find%>&&company=<%=company%>&&country_code=<%=country_code%>&&order_by=<%=order_by%>&&person=<%=person%>&&invoice=<%=invoice%>">上一页</a>&nbsp;&nbsp;
											<%
												}
													if (pageNo < pageCount) {
											%>
											<a
												href="user_inf.jsp?pageSize=<%=pageSize%>&&page=<%=(pageNo + 1)%>&&id_find=<%=id_find%>&&company=<%=company%>&&country_code=<%=country_code%>&&order_by=<%=order_by%>&&person=<%=person%>&&invoice=<%=invoice%>">下一页</a>
											<%
												}
											%>
											&nbsp;&nbsp;&nbsp;&nbsp;共
											<strong><%=pageCount%></strong>页
											<strong><%=recordCount%></strong>条记录 &nbsp;&nbsp;&nbsp;&nbsp;
											<SELECT name=pageSizeSelect id=pageSizeSelect onChange="location.href=this.options[this.selectedIndex].value;">
										<OPTION value=# selected><%=pageSize%></OPTION>												
<OPTION value=user_inf.jsp?pageSize=20&&page=<%=pageNo%>&&id_find=<%=id_find%>&&company=<%=company%>&&country_code=<%=country_code%>&&order_by=<%=order_by%>&&person=<%=person%>&&invoice=<%=invoice%>>20</OPTION>
<OPTION value=user_inf.jsp?pageSize=30&&page=<%=pageNo%>&&id_find=<%=id_find%>&&company=<%=company%>&&country_code=<%=country_code%>&&order_by=<%=order_by%>&&person=<%=person%>&&invoice=<%=invoice%>>30</OPTION>
<OPTION value=user_inf.jsp?pageSize=50&&page=<%=pageNo%>&&id_find=<%=id_find%>&&company=<%=company%>&&country_code=<%=country_code%>&&order_by=<%=order_by%>&&person=<%=person%>&&invoice=<%=invoice%>>50</OPTION>
<OPTION value=user_inf.jsp?pageSize=75&&page=<%=pageNo%>&&id_find=<%=id_find%>&&company=<%=company%>&&country_code=<%=country_code%>&&order_by=<%=order_by%>&&person=<%=person%>&&invoice=<%=invoice%>>75</OPTION>
<OPTION value=user_inf.jsp?pageSize=100&&page=<%=pageNo%>&&id_find=<%=id_find%>&&company=<%=company%>&&country_code=<%=country_code%>&&order_by=<%=order_by%>&&person=<%=person%>&&invoice=<%=invoice%>>100</OPTION>
								
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
<OPTION value=user_inf.jsp?pageSize=<%=pageSize%>&&page=<%=i%>&&id_find=<%=id_find%>&&company=<%=company%>&&country_code=<%=country_code%>&&order_by=<%=order_by%>&&person=<%=person%>&&invoice=<%=invoice%>><%=i%></OPTION>
													<%
														}
													%>
												</select>
											</label>
											页
										</div>
									</td>
									<td width="122">&nbsp;
										
									</td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td>&nbsp;
										
									</td>
									<td>&nbsp;
										
									</td>
								</tr>

								<%
									} else {
								%>
								<tr>
									<td height="22" colspan="10" align="center" valign="middle">
										<font color="#FF0000">No Record！ 
									</td>
									<td>&nbsp;
										
									</td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
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
						<td>&nbsp;
							
						</td>
					</tr>
					<tr>
						<td height="434">&nbsp;
							
						</td>
						<td>&nbsp;
							
						</td>
						<td>&nbsp;
							
						</td>
						<td>&nbsp;
							
						</td>
					</tr>
				</table>
				</form>
				<br>
				<br>
		</div>
	</body>
</html>