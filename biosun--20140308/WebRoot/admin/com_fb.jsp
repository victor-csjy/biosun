<%@page contentType="text/html;charset=utf-8"%>
<%@page import="com.aokle.util.StrUtil"%>
<%@page import="com.aokle.util.MathUtil"%>
<%@page import="hk.com.biosun.util.ReqParamUtil"%>
<%@page import="hk.com.biosun.util.SessionUtil"%>
<%@page import="hk.com.biosun.service.ComTableService"%>
<%@page import="hk.com.biosun.model.ComTable"%>
<%@include file="session_admin.jsp"%>
<%
	int com_id = MathUtil.toInt(request.getParameter("com_id"));
	String status_fb = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("status_fb")));
	String en_change = request.getParameter("en_change");
	ComTableService comTableService = new ComTableService();
	if (en_change != null) {
		int result = comTableService.updateStatusFb(com_id, status_fb);
		if (result > 0) {
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('Success!');javascript:history.go(-2);</SCRIPT>");
			return;
		} else {
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('Fail！');javascript:history.back(-1);</SCRIPT>");
			return;
		}
	}
	ComTable comTable = comTableService.getByPK(com_id);
	if (comTable == null) {
		out
				.println("<SCRIPT LANGUAGE='JavaScript'>alert('Paramenter Error！');location.href='index_face.jsp';</SCRIPT>");
		return;
	}
%>
<html>
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
					<td width="23" height="24">
						&nbsp;
					</td>
					<td width="432">
						&nbsp;
					</td>
					<td width="342">
						&nbsp;
					</td>
					<td width="55">
						&nbsp;
					</td>
				</tr>
				<tr>
					<td height="29"></td>
					<td valign="top" class="STYLE2">
						Products——Comment Status
					</td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td height="3"></td>
					<td></td>
					<td></td>
					<td></td>
				</tr>

				<tr>
					<td height="208"></td>
					<td colspan="2" valign="top">
						<form name="form1" action="com_fb.jsp" method="POST">
							<table width="100%" border="1" cellpadding="0" cellspacing="0"
								bordercolor="#000000" bordercolordark="#cad7f7">
								<tr>
									<td width="111" height="179" valign="middle" nowrap>
										Comment Status：
									</td>
									<td width="657" valign="top">
										<textarea name="status_fb" cols="100" rows="15" id="status_fb"
											wrap="hard">
			  <%=comTable.getStatusFb()%></textarea>
									</td>
								</tr>
								<tr>
									<td height="27" colspan="2" align="center" valign="top">
										<span class="MainText"> <input name="com_id"
												type="hidden" id="com_id" value="<%=com_id%>"> <input
												name="en_change" type="hidden" id="en_change"
												value="en_change"> </span>
										<input name="submit" type="submit" value="确定">
										&nbsp;&nbsp;&nbsp;
										<input name="reset" type="reset" value="取消">
									</td>
								</tr>

							</table>
						</form>
					</td>
					<td>
						&nbsp;
					</td>
				</tr>
				<tr>
					<td height="114"></td>
					<td>
						&nbsp;
					</td>
					<td>
						&nbsp;
					</td>
					<td></td>
				</tr>

			</table>
			<br>
			<br>
		</div>
	</body>
</html>