<%@page contentType="text/html;charset=utf-8"%>
<%@ page import="hk.com.biosun.model.NewsType"%>
<%@ page import="hk.com.biosun.service.NewsTypeService"%>
<%@ page import="com.aokle.util.StrUtil"%>
<%@ page import="com.aokle.util.MathUtil"%>
<%@ page import="hk.com.biosun.util.ReqParamUtil"%>
<%@include file="session_admin.jsp"%>
<%
	int news_type = MathUtil.toInt(request.getParameter("news_type"));
	String news_name = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("news_name")));
	String order_id = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("order_id")));

	String Action = request.getParameter("Action");

	NewsTypeService newsTypeService = new NewsTypeService();
	if (Action != null && Action.equals("change_set")
			&& !news_name.equals("")) {
		int result = newsTypeService.update(news_type, news_name,
				order_id);
		if (result > 0) {
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('操作成功!');javascript:history.back(-1);</SCRIPT>");
		} else {
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('操作失败！');javascript:history.back(-1);</SCRIPT>");
		}
	}

	NewsType newsTypeObj = newsTypeService.getByPK(news_type);

	if (newsTypeObj == null) {
		out
				.println("<SCRIPT LANGUAGE='JavaScript'>alert('参数非法！');javascript:history.back(-1);</SCRIPT>");
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

.STYLE3 {
	color: #FF0000
}
-->
</style>

		<script language="javascript">
 function on_submit()
 {
 if(form1.news_name.value=="")
  {
    alert("请输入名称!");
	form1.news_name.value="";	
    document.form1.news_name.focus();
	return false;
  }
  
  if(form1.order_id.value==""||isNaN(form1.order_id.value))
  {
    alert("请输入整数的显示序号！");
	form1.order_id.value="";	
    document.form1.order_id.focus();
	return false;
  }
 }
  </script>
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
					<td width="71">
						&nbsp;
					</td>
					<td width="580">
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
					<td colspan="2">
						<span class="STYLE2"> Events——类别管理 </span>
					</td>


					<td>
						&nbsp;
					</td>
				</tr>
				<tr>
					<td height="63">
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
				<tr>
					<td height="82">
						&nbsp;
					</td>
					<td>
						&nbsp;
					</td>
					<td valign="top">
						<form name="form1" method="POST" action="news_type_change.jsp"
							onSubmit="return on_submit()">
							<table width="100%" border="1" cellpadding="0" cellspacing="0"
								bordercolor="#000000" bordercolordark="#FFFFFF">


								<tr>
									<td width="139" height="26">
										类别名称
									</td>
									<td width="441">
										<input name="news_name" type="text" id="news_name"
											value="<%=newsTypeObj.getNewsName()%>" size="35"
											maxlength="150">
									</td>
								</tr>
								<tr>
									<td height="25">
										显示序号
									</td>
									<td>
										<input name="order_id" type="text" id="order_id"
											value="<%=newsTypeObj.getOrderId()%>" size="10"
											maxlength="150">
									</td>
								</tr>
								<tr>
									<td height="29" colspan="2" align="center" valign="middle">
										<input name="B2" type="submit" class="button" id="B2"
											value="修改">
										<input name="Action" type="hidden" id="Action"
											value="change_set">
										<input name="news_type" type="hidden" id="news_type"
											value="<%=news_type%>">

										&nbsp;
										<input name="B1" type="button" class="button" value="返回"
											onClick="javascript:history.back(-1)">
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
					<td height="238">
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