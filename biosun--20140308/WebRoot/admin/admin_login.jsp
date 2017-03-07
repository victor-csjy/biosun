<%@page contentType="text/html;charset=utf-8"%>
<%@page import="com.aokle.util.StrUtil"%>
<%@page import="com.aokle.util.MD5"%>
<%@page import="hk.com.biosun.util.ReqParamUtil"%>
<%@page import="com.aokle.util.IpUtil"%>
<%@page import="hk.com.biosun.util.SessionUtil"%>
<%@page import="hk.com.biosun.service.AdminService"%>
<%@page import="hk.com.biosun.service.AdminLogService"%>
<%@page import="hk.com.biosun.model.Admin"%>
<%@page import="hk.com.biosun.model.AdminLog"%>
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
	request.setCharacterEncoding("utf-8");

	String admin_id = StrUtil.toHtmlTag(ReqParamUtil.getReqParam(
			request.getParameter("admin_id")).replaceAll("\'", ""));
	String admin_password = StrUtil.toHtmlTag(ReqParamUtil.getReqParam(
			request.getParameter("admin_password")));

	String verifyCode = StrUtil.toHtmlTag(ReqParamUtil.getReqParam(
			request.getParameter("VerifyCode")).replaceAll("\'", ""));
	String Action = StrUtil.toHtmlTag(ReqParamUtil.getReqParam(request
			.getParameter("Action")));
	String pwd = MD5.encrypt(MD5.encrypt(admin_password) + "-biosun");

	if (Action.equalsIgnoreCase("login")) {
		if (!verifyCode.equals(SessionUtil.getVerifyCode(request))) {
			out
					.print("<script>alert('验证码错误！');location.href='admin_login.jsp?admin_id="
							+ admin_id + "'</script>");
			return;
		}
		AdminService adminService = new AdminService();
		Admin admin = adminService.getByPK(admin_id);
		if (admin == null) {
			out
					.print("<script>alert('不存在该管理员！');location.href='admin_login.jsp?admin_id="
							+ admin_id + "'</script>");
			return;
		} else if (admin.getAdminPw() == null
				|| admin.getAdminPw().equals("")
				|| !admin.getAdminPw().equals(pwd)) {
			AdminLogService adminLogService = new AdminLogService();
			AdminLog adminLog = new AdminLog();
			adminLog.setLoginIp(IpUtil.getIpAddrClient(request));
			adminLog.setLoginStatus("Fail");
			adminLogService.add(adminLog);
			out
					.print("<script>alert('密码错误！');location.href='admin_login.jsp?admin_id="
							+ admin_id + "'</script>");
			return;
		} else if (pwd.equals(admin.getAdminPw())) {
			AdminLogService adminLogService = new AdminLogService();
			AdminLog adminLog = new AdminLog();
			adminLog.setLoginIp(IpUtil.getIpAddrClient(request));
			adminLog.setLoginStatus("Success");
			adminLogService.add(adminLog);

			SessionUtil.setAdmin(request, admin);
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('登录成功!');location.href='admin_main.jsp';</SCRIPT>");
			return;
		}
	}
%>
<HTML>
	<script language="javascript">
 function on_submit()
 {
 var form1=document.forms["form1"];
 if(form1.admin_id.value=="")
  {
    alert("请输入管理员帐号!");
	form1.admin_id.value="";	
    document.form1.admin_id.focus();
	return false;
  }
  if(form1.admin_password.value.length<6)
  {
    alert("请输入正确的密码!");
	form1.admin_password.value="";
	document.form1.admin_password.focus();
	return false;
  }
   if(form1.VerifyCode.value ==""||form1.VerifyCode.value.length!=4)
  {
    alert("请输如正确的验证码!");
	form1.VerifyCode.value="";
	document.form1.VerifyCode.focus();
	return false;
  }
  
}
  </script>

	<HEAD>
		<title>管理员登录——博生科技有限公司</title>
		<link href="css/Style.css" rel="stylesheet" type="text/css">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	</HEAD>
	<body>
		<form name="form1" method="post" action="admin_login.jsp"
			onSubmit="return on_submit()">
			<TABLE width=968 border=0 align="center">
				<TBODY align="center">
					<TR>
						<TD width="193" height="75">
							&nbsp;
						</TD>
						<TD width="551">
							&nbsp;
						</TD>
						<TD width="210">
							&nbsp;
						</TD>
					</TR>




					<TR>
						<TD height="329">
							&nbsp;
						</TD>
						<TD align=center valign="middle">
							<TABLE border=0 cellPadding=0 cellSpacing=0 width=363>
								<TBODY>
									<TR>
										<TD>
											&nbsp;
										</TD>
									</TR>
								</TBODY>
							</TABLE>
							<TABLE border=0 cellPadding=0 cellSpacing=0 width=363>
								<TBODY>
									<TR>
										<TD>
											&nbsp;
										</TD>
									</TR>
								</TBODY>
							</TABLE>
							<TABLE background=imgz/dlbg.gif border=0 cellPadding=0
								cellSpacing=0 width=363>
								<TBODY>
									<TR>
										<TD height=114>
											<TABLE align=center border=1 bordercolor="#CCCCCC"
												cellPadding=2 cellSpacing=2 class=ybfont width="89%">

												<TBODY>

													<TR>
														<TD height=30 valign="middle">
															管理员
														</TD>
														<TD valign="top">
															<input name="admin_id" type="text" class=inuptCN
																id="userid" value="<%=admin_id%>" size="16"
																maxlength="20">
														</TD>
														<TD valign="middle">
															<font color="#FF0000"></font>
														</TD>
													</TR>
													<TR>
														<TD height=30 valign="middle">
															登录密码
														</TD>
														<TD colspan="2" valign="top">
															<input name="admin_password" type="password"
																class=inuptCN id="password2" size="16" maxlength="30">
														</TD>
													</TR>
													<TR>
														<TD height=30 valign="middle">
															验证码
														</TD>
														<TD valign="middle">
															<input name="VerifyCode" type="text" class=inuptCN
																id="password2" size="8" maxlength="4">
														</TD>
														<TD valign="middle">
															<img src="../VerifyCode.jsp" height="20">
														</TD>
													</TR>
													<TR>
														<TD height=30 colspan="3" align="center" valign="middle">
															<input name="Action" type="hidden" id="Action"
																value="login">
															<input type="submit" class="button" value="登 录">

															<input type="reset" class="button" value="重 置">
														</TD>
													</TR>
												</TBODY>
											</TABLE>
											<BR>
										</TD>
									</TR>
								</TBODY>
							</TABLE>
							<TABLE border=0 cellPadding=0 cellSpacing=0 width=363>
								<TBODY>
									<TR>
										<TD>
											&nbsp;
										</TD>
									</TR>
								</TBODY>
							</TABLE>
						</TD>

						<TD>
							&nbsp;
						</TD>
					</TR>
					<TR>
						<TD height="140">
							&nbsp;
						</TD>
						<TD>
							&nbsp;
						</TD>
						<TD>
							&nbsp;
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</FORM>
	</BODY>
</HTML>
