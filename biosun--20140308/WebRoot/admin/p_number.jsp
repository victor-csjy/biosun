<%@page contentType="text/html;charset=utf-8"%>
<%@page import="hk.com.biosun.service.ArticleService"%>
<%@page import="hk.com.biosun.model.Article"%>
<%@page import="com.aokle.util.MathUtil"%>
<%
	int p_number = MathUtil.toInt(request.getParameter("p_number"));
	String Action = request.getParameter("Action");

	ArticleService articleService = new ArticleService();

	if (Action != null && Action.equals("change_set") && p_number > -1) {
		int result = articleService.updateProductNum(26, p_number);
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
	Article article = articleService.getByPK(26);
	if (article == null) {
		out
				.println("<SCRIPT LANGUAGE='JavaScript'>alert('Fail！');javascript:history.back(-1);</SCRIPT>");;
		return;
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
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

		<SCRIPT language=JavaScript type=text/JavaScript>
<!--
function on_submit()
 {

if(form1.p_number.value==""||isNaN(form1.p_number.value)||parseInt(form1.p_number.value)<0)
  {
    alert("Please input an integer !");
	form1.p_number.value="";	
    document.form1.p_number.focus();
	return false;
  }
 form1.p_number.value=parseInt(form1.p_number.value);  
 document.form1.submit(); 
}

//-->
</SCRIPT>


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
						<span class="STYLE2">系统管理——首页产品个数设定</span>
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
					<td height="58">
						&nbsp;
					</td>
					<td colspan="2" valign="top">

						<form name="form1" method="POST" action="p_number.jsp"
							onSubmit="return on_submit()">
							<table border="1" align=center cellpadding="1" cellspacing="1"
								bordercolor="#000000" bordercolordark="#cad7f7">


								<tr>
									<td width="311" height="26" valign="middle">
										&nbsp; 显示个数：
										<input name="p_number" type="text" id="p_number"
											value="<%=article.getBrowseTimes()%>">
									</td>

								</tr>

								<tr class="chinese">
									<td height="27" align="center" valign="middle">
										<p align="center">


											<input name="B2" type="submit" class="button" id="B2"
												value="修改">
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