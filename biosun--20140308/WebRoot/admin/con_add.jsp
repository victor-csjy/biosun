<%@page contentType="text/html;charset=utf-8"%>
<%@ page import="com.aokle.util.StrUtil"%>
<%@ page import="hk.com.biosun.service.ConTableService"%>
<%@page import="hk.com.biosun.util.ReqParamUtil"%>
<%@ page import="com.aokle.util.MathUtil"%>
<%@ page import="hk.com.biosun.model.SupplyTable"%>
<%@ page import="hk.com.biosun.service.SupplyTableService"%>
<%@ page import="java.util.*"%>
<%@include file="session_admin.jsp"%>
<%
	int supply_id = MathUtil.toInt(request.getParameter("supply_id"));
	String con_name = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("con_name")));
	String con_zhw = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
			.getParameter("con_zhw")));
	String con_tel = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
			.getParameter("con_tel")));
	String con_fax = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
			.getParameter("con_fax")));
	String con_cell = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("con_cell")));
	String con_mail = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("con_mail")));
	String con_addr = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("con_addr")));
	String con_other = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("con_other")));
	String con_ms = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
			.getParameter("con_ms")));

	String Action = request.getParameter("Action");

	if (Action != null && Action.equals("change_set")
			&& !con_name.equals("")) {
		ConTableService conTableService = new ConTableService();
		int result = conTableService.add(supply_id, con_name, con_tel,
				con_fax, con_cell, con_ms, con_zhw, con_mail,
				con_other, con_addr);
		if (result > 0) {
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('操作成功!');javascript:history.back(-1);</SCRIPT>");
			return;
		} else {
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('操作失败！');javascript:history.back(-1);</SCRIPT>");
		}
	}
	SupplyTableService supplyTableService = new SupplyTableService();
	List<SupplyTable> supplyTableList = supplyTableService.getList();
	int supplyTableListSize = supplyTableList != null ? supplyTableList
			.size() : 0;
	SupplyTable supplyTable;

	if (supplyTableListSize < 1) {
		out
				.println("<SCRIPT LANGUAGE='JavaScript'>alert('还没有任何供应商！请先添加供应商');location.href='supply_add.jsp';</SCRIPT>");
		return;
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<script language="javascript">
 function on_submit()
 {
 if(form1.con_name.value=="")
  {
    alert("请输入联系人!");
	form1.con_name.value="";	
    document.form1.con_name.focus();
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

.STYLE3 {
	color: #FF0000
}
-->
</style>
	</head>
	<body>
		<div align="center">
			<br>
			<br>
			<table width="736" border="0" align="center" cellpadding="0"
				cellspacing="0">

				<tr>
					<td width="12" height="44">
						&nbsp;
					</td>
					<td width="724">
						&nbsp;
					</td>
				</tr>
				<tr>
					<td height="27">
						&nbsp;
					</td>
					<td valign="top">
						<span class="STYLE2"> 供应商管理——添加联系人资料</span>
					</td>
				</tr>
				<tr>
					<td height="26">
						&nbsp;
					</td>
					<td>
						&nbsp;
					</td>
				</tr>
				<tr>
					<td height="134">
						&nbsp;
					</td>
					<td valign="top">

						<form name="form1" method="POST" action="con_add.jsp"
							onSubmit="return on_submit()">
							<table width="100%" border="1" cellpadding="0" cellspacing="0"
								bordercolor="#000000" bordercolordark="#FFFFFF">


								<tr>
									<td width="107" height="27">
										供应商：
									</td>
									<td colspan="3">
										<select name="supply_id" id="supply_id">
											<%
												for (int i = 0; i < supplyTableListSize; i++) {
													supplyTable = supplyTableList.get(i);
											%>
											<option value="<%=supplyTable.getSupplyId()%>"><%=supplyTable.getSupplyName()%></option>
											<%
												}
											%>
										</select>
									</td>
								</tr>
								<tr>
									<td width="107" height="27">
										联系人：
									</td>
									<td>
										<input name="con_name" type="text" id="con_name" size="35">
										<span class="STYLE3"> *</span>
									</td>
									<td>
										职位：
									</td>
									<td>
										<input name="con_zhw" type="text" id="con_zhw" size="35">
									</td>
								</tr>
								<tr>
									<td height="27">
										电话：
									</td>
									<td>
										<input name="con_tel" type="text" id="con_tel" size="35">
									</td>
									<td>
										手机：
									</td>
									<td>
										<input name="con_cell" type="text" id="con_cell" size="35">
									</td>
								</tr>
								<tr>
									<td height="26">
										传真：
									</td>
									<td>
										<input name="con_fax" type="text" id="con_fax" size="35">
									</td>
									<td>
										电邮：
									</td>
									<td>
										<input name="con_mail" type="text" id="con_mail" size="35">
									</td>
								</tr>
								<tr>
									<td height="27">
										联系地址：
									</td>
									<td>
										<input name="con_addr" type="text" id="con_addr" size="35">
									</td>
									<td>
										Messager：
									</td>
									<td>
										<input name="con_ms" type="text" id="con_ms" size="35">
									</td>
								</tr>

								<tr>
									<td height="27" valign="middle">
										其它：
									</td>
									<td colspan="3">
										<input name="con_other" type="text" id="con_other" size="94">
									</td>
								</tr>

								<tr>
									<td height="27" colspan="4" align="center" valign="middle">
										<input name="B22" type="submit" class="button" id="B22"
											value="添加">
										<input name="Action" type="hidden" id="Action"
											value="change_set">
										&nbsp;
										<input name="B12" type="button" class="button" value="返回"
											onClick="javascript:history.back(-1)">
									</td>
								</tr>
							</table>
						</form>
					</td>
				</tr>
			</table>

			<br>
			<br>
		</div>
	</body>
</html>