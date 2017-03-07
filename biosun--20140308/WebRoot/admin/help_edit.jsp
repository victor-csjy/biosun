<%@page contentType="text/html;charset=utf-8"%>
<%@page import="hk.com.biosun.model.Article"%>
<%@page import="java.util.*"%>
<%@page import="hk.com.biosun.service.ArticleService"%>
<%@page import="com.aokle.util.StrUtil"%>
<%@page import="hk.com.biosun.util.ReqParamUtil"%>
<%@include file="session_admin.jsp"%>
<%
	ArticleService articleService = new ArticleService();
	String Action = StrUtil.toHtmlTag(ReqParamUtil.getReqParam(request
	.getParameter("Action")));

	if ("change_set".equals(Action)) {
		String content = StrUtil.toHtmlTxt(ReqParamUtil
		.getReqParam(request.getParameter("content0")));
		List<Object> valuesList = new ArrayList<Object>();
		valuesList.add(content);
		valuesList.add(25);
		int result = articleService.update("content=?",
		"WHERE article_id=?", valuesList);

		if (result > 0) {
	out
			.println("<SCRIPT LANGUAGE='JavaScript'>alert('Success!');javascript:history.back(-1);</SCRIPT>");
	return;
		} else {
	out
			.println("<SCRIPT LANGUAGE='JavaScript'>alert('Fail！');javascript:history.back(-1);</SCRIPT>");
	return;
		}

	}
	Article article = articleService.getByPK(25);
	if (article == null) {
		out
		.println("<SCRIPT LANGUAGE='JavaScript'>alert('Fail！article_id=25 article==null');javascript:history.back(-1);</SCRIPT>");;
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
			<table width="811" border="0" align="center" cellpadding="0"
				cellspacing="0">

				<tr>
					<td width="13" height="44">
						&nbsp;
					</td>
					<td width="651">
						&nbsp;
					</td>
					<td width="147">
						&nbsp;
					</td>
				</tr>
				<tr>
					<td height="27">
						&nbsp;
					</td>
					<td valign="top">
						<span class="STYLE2">综合文章——系统帮助</span>
					</td>
					<td>
						&nbsp;
					</td>
				</tr>
				<tr>
					<td height="18">
						&nbsp;
					</td>
					<td>
						&nbsp;
					</td>
					<td>
						&nbsp;
					</td>
				</tr>
				<tr>
					<td height="511">
						&nbsp;
					</td>
					<td colspan="2" valign="top">

						<form name="form1" method="POST" action="help_edit.jsp"
							onSubmit="return on_submit()">
							<table width="90%" border="1" align=center cellpadding="1"
								cellspacing="1" bordercolor="#000000">

								<tr>
									<td height="26" valign="middle">
										&nbsp; 文章内容：
									</td>
								</tr>

								<tr class="chinese">
									<td height="454" valign="top">

										<input type="hidden" name=content0 " id="content0"
											value="<%=article.getContent()%>"/>
										<IFRAME ID="eWebEditor0"
											src="../ewebeditor/eWebEditor.jsp?id=content0&style=coolblue"
											frameborder="0" scrolling="no" width="790" height="450"></IFRAME>

									</td>
								</tr>
								<tr class="chinese">
									<td height="27" align="center" valign="middle">
										<p align="center">


											<input name="B2" type="Submit" class="button" id="B2"
												value="确定">
											<input name="Action" type="hidden" id="Action"
												value="change_set">
											&nbsp;
											<input name="B1" type="button" class="button" value="返回"
												onClick="location.href='index_face.jsp'">
										</p>
									</td>
								</tr>
							</table>
						</form>
				</tr>
			</table>
			<br>
			<br>
		</div>
	</body>
</html>