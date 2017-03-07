<%@page contentType="text/html;charset=utf-8"%>
<%@ page import="com.aokle.util.StrUtil"%>
<%@ page import="com.aokle.util.MathUtil"%>
<%@ page import="hk.com.biosun.model.SupplyTable"%>
<%@ page import="hk.com.biosun.model.ConTable"%>
<%@ page import="hk.com.biosun.service.SupplyTableService"%>
<%@ page import="hk.com.biosun.service.ConTableService"%>
<%@page import="hk.com.biosun.util.ReqParamUtil"%>
<%@ page import="java.util.*"%>
<%@include file="session_admin.jsp"%>
<%
	int con_id_find = MathUtil.toInt(request
			.getParameter("con_id_find"));
	int supply_id = MathUtil.toInt(request.getParameter("supply_id"));
	int pageNo = MathUtil.toInt(request.getParameter("page"), 1);
	String supply_del = request.getParameter("supply_del");

	int con_id = MathUtil.toInt(request.getParameter("con_id"));
	String con_del = request.getParameter("con_del");

	String con_mail = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("con_mail")));
	String con_name = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("con_name")));
	String order_by = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("order_by")));

	String submit_all = request.getParameter("submit_all");

	SupplyTableService supplyTableService = new SupplyTableService();
	ConTableService conTableService = new ConTableService();
	if (con_del != null && con_del.equals("ok")) {
		int result = conTableService.delete(con_id);
		if (result > 0) {
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('删除成功!');</SCRIPT>");
		} else {
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('删除失败！');</SCRIPT>");
		}
	}

	List<Object> valuesList = new ArrayList<Object>();
	StringBuffer condSB = new StringBuffer();
	if (submit_all != null) {
		con_id_find = 0;
		supply_id = 0;
		con_mail = "";
		con_name = "";
	} else if (con_id_find > 0) {
		condSB.append(" AND con_id=?");
		valuesList.add(con_id_find);
	} else {
		if (supply_id > 0) {
			condSB.append(" AND supply_id=?");
			valuesList.add(supply_id);
		}
		if (!con_mail.equals("")) {
			condSB.append(" AND con_mail LIKE ?");
			valuesList.add("%" + con_mail + "%");
		}
		if (!con_name.equals("")) {
			condSB.append(" AND con_name LIKE ?");
			valuesList.add("%" + con_name + "%");
		}
	}
	if (condSB.length() > 4) {
		condSB.delete(0, 4);
		condSB.insert(0, "WHERE");
	}
	int recordCount = conTableService.getCount(condSB.toString(),
			valuesList);
	if (!order_by.equals("")) {
		condSB.append(" ORDER BY ");
		condSB.append(order_by);
	}
	int pageSize = MathUtil.toInt(request.getParameter("pageSize"),20);
	List<ConTable> conTableList = conTableService.getList(condSB
			.toString(), valuesList,pageSize,pageNo);
	int conTableListSize = conTableList != null
			? conTableList.size()
			: 0;
	ConTable conTable;
	int pageCount = (recordCount - 1) / pageSize + 1;

	List<SupplyTable> supplyTableList = supplyTableService.getList();
	int supplyTableListSize = supplyTableList != null ? supplyTableList
			.size() : 0;
	SupplyTable supplyTable = null;
	SupplyTable supplyTableTmp = null;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<script language="javascript">
 function on_submit()
 {
}
  </script>

	<SCRIPT language=javascript> 
//删除一条信息
function del_con()
{
   if(confirm("确定要删除该联系人资料!，并且不能恢复！"))
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
			<form name="form1" method="POST" action="con_list.jsp"
				onSubmit="return on_submit()">
				<table border="0" align="center" cellpadding="0" cellspacing="0">
					<tr>
						<td width="8" height="22">&nbsp;
							
						</td>
						<td width="8">&nbsp;
							
						</td>
						<td width="9">&nbsp;
							
						</td>
						<td colspan="2">&nbsp;
							
						</td>
						<td width="8"></td>
					</tr>
					<tr>
						<td height="32">&nbsp;
							
						</td>
						<td>&nbsp;
							
						</td>
						<td colspan="3" align="left" valign="top">
							<span class="STYLE2"> 供应商管理——供应商联系人信息 </span>
						</td>
						<td></td>
					</tr>
					<tr>
						<td height="51">&nbsp;
							
						</td>
						<td>&nbsp;
							
						</td>
						<td>&nbsp;
							
						</td>
						<td colspan="2">&nbsp;
							
						</td>
						<td></td>
					</tr>

					<tr>
						<td height="31">&nbsp;
							
						</td>
						<td>&nbsp;
							
						</td>
						<td>&nbsp;
							
						</td>
						<td colspan="2" valign="top">
							<span class="bgcolor4">供应商</span>
							<select name="supply_id" id="supply_id">
								<option value="0">
									全部
								</option>
								<%
									for (int i = 0; i < supplyTableListSize; i++) {
										supplyTableTmp = supplyTableList.get(i);
										if (supplyTableTmp.getSupplyId() == supply_id) {
											supplyTable = supplyTableTmp;
										}
								%>
								<option value="<%=supplyTableTmp.getSupplyId()%>"><%=supplyTableTmp.getSupplyName()%></option>
								<%
									}
								%>
							</select>
							<script>
										form1.supply_id.value=<%=supply_id%>
										</script>
							&nbsp;&nbsp;电邮
							<input name="con_mail" type="text" id="con_mail"
								value="<%=con_mail%>" size="19" maxlength="25">
							&nbsp; &nbsp;&nbsp;联系人
							<input name="con_name" type="text" id="con_name"
								value="<%=con_name%>" size="19" maxlength="25">
							&nbsp;&nbsp;
							<input name="pageSize" type="hidden" id="pageSize" value="<%=pageSize%>"/>
							<input name="submit_find" type="submit" id="submit_find"
								value="查  找">
							&nbsp;&nbsp;&nbsp;&nbsp;
							<input name="submit_all" type="submit" id="submit_all"
								value="显示全部">
							&nbsp;
						</td>
						<td></td>
					</tr>
					<tr>
						<td height="20">&nbsp;
							
						</td>
						<td>&nbsp;
							
						</td>
						<td>&nbsp;
							
						</td>
						<td width="748">&nbsp;
							
						</td>
						<td width="214"></td>
						<td></td>
					</tr>
					<tr>
						<td height="107">&nbsp;
							
						</td>
						<td colspan="4" valign="top">
							<table width="100%" border="1" cellpadding="0" cellspacing="0"
								bordercolor="#000000" bordercolordark="#FFFFFF">
								<tr>
									<td nowrap="nowrap" width="48" height="26" align="center"
										valign="middle" class="bgcolor4">
										Item No.
									</td>
									<TD nowrap="nowrap" width="65" vAlign=center class="bgcolor4">
										<a
											href="con_list.jsp?pageSize=<%=pageSize%>&&supply_id=<%=supply_id%>&&con_mail=<%=con_mail%>&&con_name=<%=con_name%>&&page=<%=pageNo%>&&order_by=supply_id">供应商名称</a>
									</TD>
									<TD nowrap="nowrap" width="52" class="bgcolor4">
										网址
									</TD>
									<TD nowrap="nowrap" width="51" class="bgcolor4">
										公司地址
									</TD>
									<TD nowrap="nowrap" width="48">
										公司电话
									</TD>
									<TD nowrap="nowrap" width="59" class="bgcolor4">
										公司传真
									</TD>
									<TD nowrap="nowrap" width="39" class="bgcolor4">
										<a
											href="con_list.jsp?pageSize=<%=pageSize%>&&supply_id=<%=supply_id%>&&con_mail=<%=con_mail%>&&con_name=<%=con_name%>&&page=<%=pageNo%>&&order_by=con_name">联系人</a>
									</TD>
									<TD nowrap="nowrap" width="41" class="bgcolor4">
										<a
											href="con_list.jsp?pageSize=<%=pageSize%>&&supply_id=<%=supply_id%>&&con_mail=<%=con_mail%>&&con_name=<%=con_name%>&&page=<%=pageNo%>&&order_by=con_zhw">职位</a>
									</TD>
									<TD nowrap="nowrap" width="44">
										电话
									</TD>
									<TD nowrap="nowrap" width="63" class="bgcolor4">
										传真
									</TD>
									<TD width="72" nowrap="nowrap" vwidth="47">
										电邮
									</TD>
									<TD nowrap="nowrap" width="95">
										Messager
									</TD>
									<TD nowrap="nowrap" width="97" class="bgcolor4">
										<a
											href="con_list.jsp?pageSize=<%=pageSize%>&&supply_id=<%=supply_id%>&&con_mail=<%=con_mail%>&&con_name=<%=con_name%>&&page=<%=pageNo%>&&order_by=con_addr">联系地址</a>
									</TD>

									<TD nowrap="nowrap" width="71">
										其它
									</TD>
									<TD nowrap="nowrap" width="102" align="center" vAlign=middle
										class="bgcolor4">
										<img src="../img/doing.jpg" width="102" height="23">
									</TD>
								</tr>

								<%
									for (int i = 0; i < conTableListSize; i++) {
										conTable = conTableList.get(i);
										if (supplyTable == null) {
											supplyTableTmp = supplyTableService.getByPK(conTable
													.getSupplyId());
										}
								%>
								<tr bgcolor="#f8f8f8" onMouseOver="this.bgColor='#FFFFFF'"
									onMouseOut="this.bgColor='#f8f8f8'">
									<td height="40" align="center" valign="middle"><%=i + 1%></td>
									<%
										if (supplyTableTmp != null) {
									%>
									<TD nowrap="nowrap" align="left" vAlign=middle>
										<a
											href="supply_change.jsp?supply_id=<%=supplyTableTmp.getSupplyId()%>"
											target="_self"><%=supplyTableTmp.getSupplyId()%></a>
									</TD>
									<TD nowrap="nowrap" vAlign=middle>
										<a href="<%=supplyTableTmp.getSupplyHttp()%>" target="_blank"><%=supplyTableTmp.getSupplyHttp()%></a>
									</TD>
									<TD nowrap="nowrap" vAlign=middle><%=supplyTable.getSupplyAddr()%></TD>
									<TD nowrap="nowrap" vAlign=middle><%=supplyTable.getSupplyTel()%></TD>
									<TD nowrap="nowrap" vAlign=middle><%=supplyTable.getSupplyFax()%></TD>
									<%
										}
									%>
									<TD align="left" vAlign=middle>
										<a href="con_change.jsp?con_id=<%=conTable.getConId()%>"
											target="_self"><%=conTable.getConName()%></a>
									</TD>
									<TD nowrap="nowrap" vAlign=middle><%=conTable.getConZhw()%></TD>
									<TD nowrap="nowrap" vAlign=middle><%=conTable.getConTel()%></TD>
									<TD nowrap="nowrap" vAlign=middle><%=conTable.getConFax()%></TD>
									<TD nowrap="nowrap" vAlign=middle><%=conTable.getConMail()%></TD>
									<TD nowrap="nowrap" vAlign=middle><%=conTable.getConMs()%></TD>
									<TD nowrap="nowrap" vAlign=middle><%=conTable.getConAddr()%></TD>
									<TD nowrap="nowrap"><%=conTable.getConOther()%></TD>
									<TD nowrap="nowrap" align="center" vAlign=middle>
										<a href="con_change.jsp?con_id=<%=conTable.getConId()%>"
											target="_self">修改</a>
										<a
											href="con_list.jsp?pageSize=<%=pageSize%>&&con_id=<%=conTable.getConId()%>&&page=<%=pageNo%>&&con_del=ok&&supply_id=<%=supply_id%>&&con_mail=<%=con_mail%>"
											onClick="return del_con();">删除</a>
									</TD>
								</tr>
								<%
									}
									if (conTableListSize > 0) {
								%>
								<tr>
									<td height="31" colspan="15" align="center" valign="middle">
										<div align="center">

											<%
												if (pageNo > 1) {
											%>
											<a
												href="con_list.jsp?pageSize=<%=pageSize%>&&page=<%=(pageNo - 1)%>&&supply_id=<%=supply_id%>&&con_mail=<%=con_mail%>">上一页</a>&nbsp;&nbsp;
											<%
												}
													if (pageNo < pageCount) {
											%>
											<a
												href="con_list.jsp?pageSize=<%=pageSize%>&&page=<%=(pageNo + 1)%>&&supply_id=<%=supply_id%>&&con_mail=<%=con_mail%>">下一页</a>
											<%
												}
											%>
											&nbsp;&nbsp;&nbsp;&nbsp;共
											<strong><%=pageCount%></strong>页
											<strong><%=recordCount%></strong>条记录 &nbsp;&nbsp;&nbsp;&nbsp;
											<SELECT name=pageSizeSelect id=pageSizeSelect onChange="location.href=this.options[this.selectedIndex].value;">
										<OPTION value=# selected><%=pageSize%></OPTION>												
<OPTION value=con_list.jsp?pageSize=20&&page=<%=pageNo%>&&supply_id=<%=supply_id%>&&con_mail=<%=con_mail%>>20</OPTION>
<OPTION value=con_list.jsp?pageSize=30&&page=<%=pageNo%>&&supply_id=<%=supply_id%>&&con_mail=<%=con_mail%>>30</OPTION>
<OPTION value=con_list.jsp?pageSize=50&&page=<%=pageNo%>&&supply_id=<%=supply_id%>&&con_mail=<%=con_mail%>>50</OPTION>
<OPTION value=con_list.jsp?pageSize=75&&page=<%=pageNo%>&&supply_id=<%=supply_id%>&&con_mail=<%=con_mail%>>75</OPTION>
<OPTION value=con_list.jsp?pageSize=100&&page=<%=pageNo%>&&supply_id=<%=supply_id%>&&con_mail=<%=con_mail%>>100</OPTION>
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
													<OPTION value=con_list.jsp?pageSize=<%=pageSize%>&&page=<%=i%>&&supply_id=<%=supply_id%>&&con_mail=<%=con_mail%>><%=i%></OPTION>
													<%
														}
													%>
												</select>
											</label>
											页
										</div>
									</td>
								</tr>
								<%
									} else {
								%>
								<tr>
									<td height="22" colspan="15" align="center" valign="middle">
										<font color="#FF0000">没有记录！
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