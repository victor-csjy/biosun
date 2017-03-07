<%@page contentType="text/html;charset=utf-8"%>
<%@ page import="com.aokle.util.StrUtil"%>
<%@ page import="hk.com.biosun.service.SupplyTableService"%>
<%@ page import="hk.com.biosun.model.SupplyTable"%>
<%@page import="hk.com.biosun.util.ReqParamUtil"%>
<%@ page import="com.aokle.util.MathUtil"%>
<%@include file="session_admin.jsp"%>
<%
	int supply_id = MathUtil.toInt(request.getParameter("supply_id"));
	String supply_name = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("supply_name")));
	String supply_http = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("supply_http")));
	String supply_man = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("supply_man")));
	String supply_zhw = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("supply_zhw")));
	String supply_tel = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("supply_tel")));
	String supply_fax = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("supply_fax")));
	String supply_mail = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("supply_mail")));
	String supply_addr = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("supply_addr")));
	String supply_other = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("supply_other")));
	String supply_date = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("supply_date")));

	String Action = request.getParameter("Action");
	SupplyTableService supplyTableService = new SupplyTableService();

	if (Action != null && Action.equals("change_set")
			&& !supply_name.equals("") && supply_id > 0) {
		int result = supplyTableService.update(supply_id, supply_name,
				supply_http, supply_man, supply_zhw, supply_tel,
				supply_fax, supply_mail, supply_addr, supply_other,
				supply_date);
		if (result > 0) {
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('操作成功!');javascript:history.back(-1);</SCRIPT>");
			return;
		} else {
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('操作失败！');javascript:history.back(-1);</SCRIPT>");
		}
	}

	SupplyTable supplyTable = supplyTableService.getByPK(supply_id);
	if (supplyTable == null) {
		out
				.println("<SCRIPT LANGUAGE='JavaScript'>alert('非法参数！');javascript:history.back(-1);</SCRIPT>");;
		return;
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<script language="javascript">
 function on_submit()
 {
 if(form1.supply_name.value=="")
  {
    alert("请输入供应商名称!");
	form1.supply_name.value="";	
    document.form1.supply_name.focus();
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
						<span class="STYLE2"> 供应商管理——修改供应商资料</span>
					</td>
				</tr>
				<tr>
					<td height="20">
						&nbsp;
					</td>
					<td>
						&nbsp;
					</td>
				</tr>
				<tr>
					<td height="144">
						&nbsp;
					</td>
					<td valign="top">

						<form name="form1" method="POST" action="supply_change.jsp"
							onSubmit="return on_submit()">
							<table width="100%" border="1" cellpadding="0" cellspacing="0"
								bordercolor="#000000" bordercolordark="#FFFFFF">
								<td width="244"></td>
								<td width="107"></td>
								<td width="258"></td>
								<tr>
									<td height="26" valign="middle">
										&nbsp; 供应商名称：
									</td>
									<td colspan="3">
										<input name="supply_name" type="text" id="supply_name"
											value="<%=supplyTable.getSupplyName()%>" size="60"
											maxlength="150">
										<span class="STYLE3"> *</span>
									</td>
								</tr>
								<tr>
									<td height="1"></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<tr>
									<td height="26" valign="middle">
										&nbsp; 网址：
										<label></label>
									</td>
									<td>
										<input name="supply_http" type="text" id="supply_http"
											value="<%=supplyTable.getSupplyHttp()%>" size="35"
											maxlength="150">
									</td>
									<td>
										&nbsp; 公司地址：
									</td>
									<td>
										<input name="supply_addr" type="text" id="supply_addr"
											value="<%=supplyTable.getSupplyAddr()%>" size="35"
											maxlength="150">
									</td>
								</tr>
								<tr>
									<td height="1"></td>
									<td></td>
									<td rowspan="2">
										&nbsp; 公司传真：
										<label></label>
									</td>
									<td rowspan="2">
										<input name="supply_fax" type="text" id="supply_fax"
											value="<%=supplyTable.getSupplyFax()%>" size="35"
											maxlength="150">
									</td>
								</tr>
								<tr>
									<td height="26" valign="middle">
										&nbsp; 公司电话：
									</td>
									<td>
										<input name="supply_tel" type="text" id="supply_tel"
											value="<%=supplyTable.getSupplyTel()%>" size="35"
											maxlength="150">
									</td>
								</tr>
								<tr>
									<td height="1"></td>
									<td></td>
									<td rowspan="2">
										&nbsp; 日期：
									</td>
									<td rowspan="2">
										<input name="supply_date" type="text" id="supply_date"
											value="<%=supplyTable.getSupplyDate()%>" size="35"
											maxlength="25">
									</td>
								</tr>
								<tr>
									<td height="27" valign="middle">
										<label>
											&nbsp; 备注：
										</label>
									</td>
									<td>
										<input name="supply_other" type="text" id="supply_other"
											value="<%=supplyTable.getSupplyOther()%>" size="35"
											maxlength="200">
									</td>
								</tr>

								<tr>
									<td height="27" colspan="4" align="center" valign="middle">
										<p align="center">
											<input name="supply_id" type="hidden" id="supply_id"
												value="<%=supply_id%>">

											<input name="B2" type="submit" class="button" id="B2"
												value="修改">
											<input name="Action" type="hidden" id="Action"
												value="change_set">
											&nbsp;
											<input name="B1" type="button" class="button" value="返回"
												onClick="javascript:history.back(-1)">
										</p>
									</td>
								</tr>
								<tr>
									<td height="2" valign="top">
									<td></td>
									<td></td>
									<td></td>
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