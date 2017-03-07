<%@page contentType="text/html;charset=utf-8"%>
<%@page import="hk.com.biosun.service.AdminService"%>
<%@page import="hk.com.biosun.model.Admin"%>
<%@page import="com.aokle.util.StrUtil"%>
<%@page import="hk.com.biosun.util.SessionUtil"%>
<%@include file="session_admin.jsp"%>
<%
	Admin admin = SessionUtil.getAdmin(request);
	if (admin == null) {
		out
				.println("<SCRIPT LANGUAGE='JavaScript'>alert('请重新登陆！');location.href='admin_login.jsp';</SCRIPT>");
		return;
	}

	String old_pw = StrUtil.toHtmlTxt(request.getParameter("old_pw"));
	String news_pw = StrUtil.toHtmlTxt(request.getParameter("news_pw"));
	String submit = request.getParameter("submit");
	if (submit != null) {
		AdminService adminService = new AdminService();
		int result = adminService.updatePassWord(admin.getAdminName(),
				news_pw, old_pw);
		if (result > 0) {
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('修改密码成功!');location.href='index_face.jsp';</SCRIPT>");
			return;
		} else {
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('修改失败！');location.href='change_pw.jsp';</SCRIPT>");
			return;
		}

	}
%>
<html>
	<script language="javascript">
 function on_submit()
 {
 if(form1.old_pw.value.length<6||form1.news_pw.value.length<6||form1.news_pw2.value.length<6)
  {
    alert("请输入不少于6位的密码!");
	form1.old_pw.value="";
	form1.news_pw.value="";
	form1.news_pw2.value="";
    document.form1.old_pw.focus();
	return false;
  }
  if(form1.news_pw.value != form1.news_pw2.value)
  {
    alert("两次输入的密码不一致!");
	form1.news_pw.value="";
	form1.news_pw2.value="";
    document.form1.news_pw.focus();
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
	<body>
		<div align="center">
			<br>
			<br>
			<table width="90%" border="0" align="center" cellpadding="0"
				cellspacing="0">

				<tr>
					<td width="240" height="24">
						&nbsp;
					</td>
					<td width="323">
						&nbsp;
					</td>
					<td width="92">
						&nbsp;
					</td>
					<td width="208">
						&nbsp;
					</td>
				</tr>
				<tr>
					<td height="29">
						&nbsp;
					</td>
					<td colspan="2" valign="top">
						<span class="STYLE2">系统管理——修改密码</span>
					</td>
					<td>
						&nbsp;
					</td>
				</tr>



				<tr>
					<td height="152">
						&nbsp;
					</td>
					<td valign="top">


						<form name="form1" action="change_pw.jsp" method="POST"
							onSubmit="return on_submit()">
							<table width="300" border="1" align="center" cellpadding="2"
								cellspacing="2" bordercolor="#000000" bordercolordark="#cad7f7">
								<tr>
									<td height="26" colspan="2" align="center" valign="middle">
										<span class="STYLE1">密码至少6位&nbsp;&nbsp;&nbsp;</span>
									</td>
								</tr>

								<tr>
									<td width="83" height="26" valign="middle" nowrap>
										旧密码：
									</td>
									<td width="197" valign="top">
										<input name="old_pw" type="password" id="old_pw" size="20"
											maxlength="30">
										&nbsp;&nbsp;
									</td>
								</tr>

								<tr>
									<td height="26" valign="middle" nowrap>
										新密码：
									</td>
									<td valign="top">
										<input name="news_pw" type="password" id="news_pw" size="20"
											maxlength="100">
									</td>
								</tr>


								<tr>
									<td height="26" valign="middle" nowrap>
										确认新密码：
									</td>
									<td valign="top">
										<input name="news_pw2" type="password" id="news_pw2" size="20"
											maxlength="10">
										&nbsp;
									</td>
								</tr>


								<tr>
									<td height="26" colspan="2" align="center" valign="top">
										<input name="submit" type="submit" value="修改">
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
					<td>
						&nbsp;
					</td>
				</tr>
				<tr>
					<td height="150">
						&nbsp;
					</td>
					<td>
						&nbsp;
					</td>
					<td>
						&nbsp;
					</td>
					<td>
						&nbsp;
					</td>
				</tr>
			</table>
			<br>
			<br>
		</div>
	</body>
</html>