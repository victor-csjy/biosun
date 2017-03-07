<%@page contentType="text/html;charset=utf-8"%>
<%@page import="hk.com.biosun.util.SessionUtil"%>
<%@page import="hk.com.biosun.util.ReqParamUtil"%>
<%@page import="com.aokle.util.StrUtil"%>
<%@page import="hk.com.biosun.service.MailTableService"%>
<%@page import="hk.com.biosun.model.MailTable"%>
<%@include file="session_admin.jsp"%>
<%
	String mail_service = StrUtil.toHtmlTxt(request
			.getParameter("mail_service"));
	String mail_address = StrUtil.toHtmlTxt(request
			.getParameter("mail_address"));
	String mail_user = StrUtil.toHtmlTxt(request
			.getParameter("mail_user"));
	String mail_pw = StrUtil.toHtmlTxt(request.getParameter("mail_pw"));
	String website = StrUtil.toHtmlTxt(request.getParameter("website"));
	String mailPrefix = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("mailPrefix")));
	String mailSuffix = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("mailSuffix")));

	String submit = request.getParameter("submit");
	MailTableService mailTableService = new MailTableService();
	
	if (submit != null) {
		int result = mailTableService.update("1", mail_service,
				mail_address, mail_user, mail_pw, website, mailPrefix,
				mailSuffix);

		if (result > 0) {
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('Success!');location.href='index_face.jsp';</SCRIPT>");
			return;
		} else {
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('Fail！');javascript:history.back(-1);</SCRIPT>");
			return;
		}

	}
	MailTable mailTable = mailTableService.getByPK("1");
	if (mailTable == null) {
		out
				.println("<SCRIPT LANGUAGE='JavaScript'>alert('No Data！');index_face.jsp;</SCRIPT>");
		return;
	}
%>
<html>
	<script language="javascript">
 function on_submit()
 {
 if(form1.mail_service.value=="")
  {
    alert("请输入邮件发送服务器!");
	form1.mail_service.value="";
	document.form1.mail_service.focus();
	return false;
  }

 
   if (form1.mail_address.value.length!= 0)
		{
			for (i=0; i<form1.mail_address.value.length; i++)
			  if (form1.mail_address.value.charAt(i)=="@")
					break;
			if (i==form1.mail_address.value.length)
			{
			  alert("非法发件人邮件地址！");
			  form1.mail_address.value="";
			  form1.mail_address.focus();
			  return false;
			 }	
			}
  else
       {
        alert("请输入发件人邮件地址！");
		form1.mail_address.value="";
		form1.mail_address.focus();
		return false;

        }

if(form1.mail_user.value=="")
  {
    alert("请输入发件人邮件用户名!");
	form1.mail_user.value="";
	document.form1.mail_user.focus();
	return false;
  }
  
if(form1.mail_pw.value=="")
  {
    alert("请输入发件人邮件密码!");
	form1.mail_pw.value="";
	document.form1.mail_pw.focus();
	return false;
  }	
  
  if(form1.website.value=="")
  {
    alert("Please input the WebSite!");
	form1.website.value="";
	document.form1.website.focus();
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
					<td width="162" height="24">&nbsp;
						
					</td>
					<td width="86">&nbsp;
						
					</td>
					<td width="431">&nbsp;
						
					</td>
					<td width="217">&nbsp;
						
					</td>
				</tr>
				<tr>
					<td height="29">&nbsp;
						
					</td>
					<td>&nbsp;
						
					</td>
					<td valign="top">
						<span class="STYLE2">系统管理——邮箱设置</span>
					</td>
					<td>&nbsp;
						
					</td>
				</tr>



				<tr>
					<td height="152">&nbsp;
						
					</td>
					<td colspan="2" valign="top">


						<form name="form1" action="mail_set.jsp" method="POST"
							onSubmit="return on_submit()">
							<table width="300" border="1" align="center" cellpadding="2"
								cellspacing="2" bordercolor="#000000" bordercolordark="#cad7f7">


								<tr>
									<td width="30%" height="26" valign="middle" nowrap>
										邮件发送服务器：
									</td>
									<td width="197" valign="top">
										<input name="mail_service" type="text" id="mail_service"
											value="<%=mailTable.getMailService()%>" size="20"
											maxlength="100">
										&nbsp;&nbsp;
									</td>
								</tr>

								<tr>
									<td height="26" valign="middle" nowrap>
										发件人邮件地址：
									</td>
									<td valign="top">
										<input name="mail_address" type="text" id="mail_address"
											value="<%=mailTable.getMailAddress()%>" size="20"
											maxlength="150">
									</td>
								</tr>


								<tr>
									<td height="26" valign="middle" nowrap>
										发件人邮件用户名：
									</td>
									<td valign="top">
										<input name="mail_user" type="text" id="mail_user"
											value="<%=mailTable.getMailUser()%>" size="20"
											maxlength="150">
										&nbsp;
									</td>
								</tr>
								<tr>
									<td height="26" valign="middle" nowrap>
										发件人邮件密码：
									</td>
									<td valign="top">
										<input name="mail_pw" type="password" id="mail_pw"
											value="<%=mailTable.getMailPw()%>" size="20" maxlength="150">
										&nbsp;
									</td>
								</tr>
								<tr>
									<td height="26" valign="middle" nowrap>
										<strong>Website</strong>：
									</td>
									<td valign="top">
										<input name="website" type="text" id="website"
											value="<%=mailTable.getWebsite()%>" size="20" maxlength="150">
										&nbsp;
									</td>
								</tr>


<tr>
									<td height="26" valign="middle" nowrap>
										<strong>邮件内容前缀</strong>：
									</td>
									<td valign="top">
                                        <input type="hidden" name=mailPrefix id="mailPrefix"   value="<%=mailTable.getMailPrefix()%>"/>
<iframe ID="eWebEditor0" src="../ewebeditor/eWebEditor.jsp?id=mailPrefix&style=CoolBlue" frameborder="0" scrolling="no" width="790" height="200"></iframe>

</td>
								</tr>
								
								
								<tr>
									<td height="26" valign="middle" nowrap>
										<strong>邮件内容后缀</strong>：
									</td>
									<td valign="top">
										
                                        <input type="hidden" name=mailSuffix  id="mailSuffix" value="<%=mailTable.getMailSuffix()%>"/>
<iframe ID="eWebEditor1" src="../ewebeditor/eWebEditor.jsp?id=mailSuffix&style=CoolBlue" frameborder="0" scrolling="no" width="790" height="200"></iframe>

										&nbsp;
									</td>
								</tr>
								

								<tr>
									<td height="26" colspan="2" align="center" valign="top">
										<input name="submit" type="submit" value="确定">
										&nbsp;&nbsp;&nbsp;
										<input name="reset" type="reset" value="取消">
									</td>
								</tr>
							</table>
						</form>
					</td>
					<td>&nbsp;
						
					</td>
				</tr>
				<tr>
					<td height="150">&nbsp;
						
					</td>
					<td>&nbsp;
						
					</td>
					<td>&nbsp;
						
					</td>
					<td>&nbsp;
						
					</td>
				</tr>
			</table>
			<br>
			<br>
		</div>
	</body>
</html>