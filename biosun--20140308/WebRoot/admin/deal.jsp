<%@page contentType="text/html;charset=utf-8"%>
<%@ page import="com.aokle.util.StrUtil"%>
<%@ page import="com.aokle.util.MathUtil"%>
<%@ page import="hk.com.biosun.model.UserInf"%>
<%@ page import="hk.com.biosun.service.UserInfService"%>
<%@page import="hk.com.biosun.util.ReqParamUtil"%>
<%@include file="session_admin.jsp"%>
<%
	String id = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
			.getParameter("id")));
	int trade_times = MathUtil.toInt(request
			.getParameter("trade_times"));
	String en_change = request.getParameter("en_change");
	UserInfService userInfService = new UserInfService();
	UserInf userInf = userInfService.getByPK(id);

	if (en_change != null) {
		int result = userInfService.updateTradeTimes(id, MathUtil
				.toInt(userInf.getIdGrage()), trade_times);
		if (result > 1) {
			userInf.setTradeTimes(trade_times);
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('Success!');javascript:history.back(-1);</SCRIPT>");
			return;
		} else {
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('Fail！');javascript:history.back(-1);</SCRIPT>");
			return;
		}
	}
%>
<html>
	<script language="javascript">
 function on_submit()
 {
 if(isNaN(document.form1.trade_times.value)&&document.form1.trade_times.value!="")
  {
    alert("Please input the  Integer!");
	form1.trade_times.value="";	
    document.form1.trade_times.focus();
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
.STYLE1 {
	color: #FF0000
}

.STYLE2 {
	font-size: 16px;
	font-weight: bold;
	color: #000000;
}
}
-->
</style>
	</head>
	<body>
		<div align="center">
			<br>
			<br>
			<table width="852" border="0" align="center" cellpadding="0"
				cellspacing="0">

				<tr>
					<td width="16" height="24">&nbsp;
						
					</td>
					<td width="122">&nbsp;
						
					</td>
					<td width="426">&nbsp;
						
					</td>
					<td width="60">&nbsp;
						
					</td>
					<td width="228">&nbsp;
						
					</td>
				</tr>
				<tr>
					<td height="36"></td>
					<td colspan="3" valign="top" class="STYLE2">
						会员管理——Deal Times
					</td>
					<td></td>
				</tr>
				<tr>
					<td height="71"></td>
					<td>&nbsp;
						
					</td>
					<td>&nbsp;
						
					</td>
					<td>&nbsp;
						
					</td>
					<td></td>
				</tr>
				<tr>
					<td height="54"></td>
					<td>&nbsp;
						
					</td>
					<td valign="top">
						<form name="form1" action="deal.jsp" method="POST"
							onSubmit="return on_submit()">
							<table width="100%" border="1" cellpadding="0" cellspacing="0"
								bordercolor="#000000" bordercolordark="#cad7f7">
								<tr>
									<td width="70" height="26" valign="middle">
										Deal Times:
									</td>
									<td width="350" valign="top">
										<input name="trade_times" type="text" id="trade_times"
											value="<%=userInf.getTradeTimes()%>" size="50">
									</td>
								</tr>
								<tr>
									<td height="27" colspan="2" align="center" valign="top">
										<span class="MainText"> <input name="id" type="hidden"
												id="id" value="<%=id%>" /> <input name="en_change"
												type="hidden" id="en_change" value="en_change" /> </span>
										<input name="submit" type="submit" value="确定" />
										&nbsp;&nbsp;&nbsp;
										<input name="reset" type="reset" value="取消" />
									</td>
								</tr>
							</table>
						</form>
					</td>
					<td>&nbsp;
						
					</td>
					<td></td>
				</tr>
				<tr>
					<td height="219"></td>
					<td>&nbsp;
						
					</td>
					<td>&nbsp;
						
					</td>
					<td>&nbsp;
						
					</td>
					<td></td>
				</tr>
			</table>
			<br>
			<br>
		</div>
	</body>
</html>