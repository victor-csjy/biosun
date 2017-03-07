<%@page contentType="text/html;charset=utf-8"%>
<%@page import="hk.com.biosun.util.SessionUtil"%>
<%@page import="com.aokle.util.DateUtil"%>
<%@page import="hk.com.biosun.model.Admin"%>
<%@include file="session_admin.jsp"%>
<%
	Admin admin = SessionUtil.getAdmin(request);
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
					<td width="863" height="137">
						&nbsp;
					</td>
				</tr>

				<tr>
					<td height="75" align="center" valign="middle">
						欢迎您
						<font color="#0000FF"><%=admin.getAdminName()%></font>
						<br>
						<br>
						<span class="STYLE1">您的身份是网站管理员，请点击左边栏目管理</span>
						<br>
						<br>
						当前时间:<%=DateUtil.formatDate(System.currentTimeMillis(), 2)%></td>
				</tr>
				<tr>
					<td height="235">
						&nbsp;
					</td>
				</tr>
			</table>
			<br>
			<br>
		</div>
	</body>
</html>