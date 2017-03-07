<%@page contentType="text/html;charset=utf-8"%>
<%@ page import="com.aokle.util.StrUtil"%>
<%@ page import="com.aokle.util.MathUtil"%>
<%@ page import="hk.com.biosun.model.NewsType"%>
<%@ page import="hk.com.biosun.model.NewsTable"%>
<%@ page import="hk.com.biosun.service.NewsTableService"%>
<%@ page import="hk.com.biosun.service.NewsTypeService"%>
<%@page import="hk.com.biosun.util.ReqParamUtil"%>
<%@ page import="java.util.*"%>
<%
	int news_id = MathUtil.toInt(request.getParameter("news_id"));
	int news_type = MathUtil.toInt(request.getParameter("news_type"));
	String news_title = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("news_title")));
	String news_date = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("news_date")));

	String is_show = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
			.getParameter("is_show")));
	String is_roll = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
			.getParameter("is_roll")));

	String order_id = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("order_id")));
	String content = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
			.getParameter("content0")));

	String Action = request.getParameter("Action");
	NewsTableService newsTableService = new NewsTableService();

	if (Action != null && Action.equals("change_set")
			&& !content.equals("")) {

		int result = newsTableService.update(news_id, news_title,
				content, news_type, news_date, is_show, is_roll,
				order_id);
		if (result > 0) {
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('操作成功!');javascript:history.back(-1);</SCRIPT>");
			return;
		} else {
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('操作失败！');javascript:history.back(-1);</SCRIPT>");
		}
	}
	NewsTable newsTable = newsTableService.getByPK(news_id);
	if (newsTable == null) {
		out
				.println("<SCRIPT LANGUAGE='JavaScript'>alert('参数非法！');location.href='news_type.jsp';</SCRIPT>");
		return;
	}

	NewsTypeService newsTypeService = new NewsTypeService();
	List<NewsType> newsTypeList = newsTypeService.getList();
	int newsTypeListSize = newsTypeList != null
			? newsTypeList.size()
			: 0;
	NewsType newsTypeTmp;
	if (newsTypeListSize < 1) {
		out
				.println("<SCRIPT LANGUAGE='JavaScript'>alert('你必须先添加类别才能添加文章！');location.href='news_type.jsp';</SCRIPT>");
		return;
	}
	NewsType newsType = newsTypeService
			.getByPK(newsTable.getNewsType());
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<script language="javascript">
 function on_submit()
 {
 if(form1.news_title.value=="")
  {
    alert("请输入标题!");
	form1.news_title.value="";	
    document.form1.news_title.focus();
	return false;
  }
  if(form1.news_date.value=="")
  {
    alert("请输入发布日期!");
	form1.news_date.value="";	
    document.form1.news_date.focus();
	return false;
  }
  
   if(form1.order_id.value==""||isNaN(form1.order_id.value))
  {
    alert("请输入一个整数的排序号!");
	form1.order_id.value="";	
    document.form1.order_id.focus();
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
			<form name="form1" method="POST" action="news_change.jsp"
				onSubmit="return on_submit()">
				<table width="811" border="0" align="center" cellpadding="0"
					cellspacing="0">
					<tr>
						<td width="13" height="27">
							&nbsp;
						</td>
						<td width="651" valign="top">
							<span class="STYLE2">Events——<%=newsType != null ? StrUtil.toHtmlTag(newsType
					.getNewsName()) : ""%></span>
						</td>
						<td width="147">
							&nbsp;
						</td>
					</tr>
					<tr>
						<td height="24">
							&nbsp;
						</td>
						<td>
						<td>
					</tr>
					<tr>
						<td height="679">
							&nbsp;
						</td>
						<td colspan="2" valign="top">

							<table width="90%" border="1" align=center cellpadding="1"
								cellspacing="1" bordercolor="#000000" bordercolordark="#cad7f7">


								<tr>
									<td width="157" height="26" valign="middle">
										&nbsp; 标题：
									</td>
									<td width="628" valign="top">
										<input name="news_title" type="text" id="news_title"
											value="<%=newsTable.getNewsTitle()%>" size="60"
											maxlength="150">
									</td>
								</tr>
								<tr>
									<td height="26" valign="middle">
										&nbsp; 类型：
										<label></label>
									</td>
									<td valign="top">

										<select name="news_type" id="news_type">
											<%
												for (int i = 0; i < newsTypeListSize; i++) {
													newsTypeTmp = newsTypeList.get(i);
											%>
											<option value="<%=newsTypeTmp.getNewsType()%>"
												<%if(newsTypeTmp.getNewsType()==news_type)out.print("selected");%>>
												<%=newsTypeTmp.getNewsName()%></option>
											<%
												}
											%>
										</select>
									</td>
								</tr>
								<tr>
									<td height="26" valign="middle">
										&nbsp; 发布日期：
									</td>
									<td valign="top">
										<input name="news_date" type="text" id="news_date"
											value="<%=newsTable.getNewsDate()%>" size="25"
											maxlength="150">
									</td>
								</tr>
								<tr>
									<td height="26" valign="middle">
										&nbsp; 是否显示：
										<label></label>
									</td>
									<td valign="top">
										<label>
											<input name="is_show" type="radio" value="1"
												<%if("1".equals(newsTable.getIsShow()))out.print("checked");%>>
											是 &nbsp;&nbsp;
											<input type="radio" name="is_show" value="0"
												<%if("0".equals(newsTable.getIsShow()))out.print("checked");%>>
											否
										</label>
									</td>
								</tr>


								<tr>
									<td height="26" valign="middle">
										&nbsp; 是否显示在滚动区：
										<label></label>
									</td>
									<td valign="top">
										<label>
											<input name="is_roll" type="radio" value="1"
												<%if("1".equals(newsTable.getIsRoll()))out.print("checked");%>>
											是 &nbsp;&nbsp;
											<input name="is_roll" type="radio" value="0"
												<%if("0".equals(newsTable.getIsRoll()))out.print("checked");%>>
											否
										</label>
									</td>
								</tr>






								<tr>
									<td height="26" valign="middle">
										&nbsp; 排序号：
									</td>
									<td valign="top">
										<input name="order_id" type="text" id="order_id"
											value="<%=newsTable.getOrderId()%>" size="10" maxlength="150">
									</td>
								</tr>



								<tr>
									<td height="26" colspan="2" valign="middle">
										&nbsp; 内容：
									</td>
								</tr>

								<tr class="chinese">
									<td height="454" colspan="2" valign="top">
										<div align="center">
											<input type="hidden" name=content0 " id="content0"
												value="<%=newsTable.getContent()%>" />
											<iframe ID="eWebEditor0"
												src="../ewebeditor/eWebEditor.jsp?id=content0&style=CoolBlue"
												frameborder="0" scrolling="no" width="790" height="450"></iframe>

										</div>
									</td>
								</tr>
								<tr class="chinese">
									<td height="26" colspan="2" align="center" valign="middle">
										<p align="center">
											<input name="news_id" type="hidden" id="news_id"
												value="<%=news_id%>">
											<input name="Action" type="hidden" id="Action"
												value="change_set">
											<input name="B2" type="submit" class="button" id="B2"
												value="修改">
											&nbsp;
											<input name="B1" type="button" class="button" value="返回"
												onClick="javascript:history.back(-1)">
										</p>
									</td>
							</table>
					</tr>
					<tr>
						<td height="69">
							&nbsp;
						</td>
						<td>
						<td>
					</tr>
				</table>
			</form>
			<br>
			<br>
		</div>
	</body>
</html>