<%@page contentType="text/html;charset=utf-8"%>
<%@ page import="hk.com.biosun.model.NewsType"%>
<%@ page import="hk.com.biosun.service.NewsTypeService"%>
<%@ page import="com.aokle.util.StrUtil"%>
<%@ page import="com.aokle.util.MathUtil"%>
<%@ page import="hk.com.biosun.util.ReqParamUtil"%>
<%@ page import="java.util.*"%>
<%
	int news_type = MathUtil.toInt(request.getParameter("news_type"));
	String news_name = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("news_name")));
	String order_id = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("order_id")));

	String del_news = request.getParameter("del_news");
	String Action = request.getParameter("Action");

	NewsTypeService newsTypeService = new NewsTypeService();
	if (Action != null && Action.equals("change_set")
			&& !news_name.equals("")) {
		//sql="insert into news_type (news_name,order_id) "+"values('"+news_name+"','"+order_id+"')";
		int result = newsTypeService.add(news_name, order_id);
		if (result > 0) {
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('操作成功!');</SCRIPT>");
		} else {
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('操作失败！');</SCRIPT>");
		}
	}

	if (del_news != null && del_news.equals("ok")) {
		int result = newsTypeService.delete(news_type);
		if (result > 0) {
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('操作成功!');</SCRIPT>");
		} else {
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('操作失败！');</SCRIPT>");
		}
	}
	NewsType newsType;
	List<NewsType> newsTypeList = newsTypeService.getList();
	int newsTypeListSize = newsTypeList!=null?newsTypeList.size():0;
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


		<script language="javascript">  

function del_cf()
{
   if(confirm("确定要删除该类别与该类别下的所有Events!，并且不能恢复！"))
     return true;
   else
     return false;
	 
}

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
					<td height="54">
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
					<td height="27">
						&nbsp;
					</td>
					<td>
						&nbsp;
					</td>
					<td valign="top">
						<span class="STYLE3">注意：删除类别时，会把该类别的所有文章都删除！</span>
					</td>
					<td>
						&nbsp;
					</td>
				</tr>


				<tr>
					<td height="80">
						&nbsp;
					</td>
					<td>
						&nbsp;
					</td>
					<td valign="top">
						<table width="100%" border="1" cellpadding="0" cellspacing="0"
							bordercolor="#000000" bordercolordark="#FFFFFF">

							<tr>
								<td width="107" height="26" align="center">
									ID
								</td>
								<td width="275">
									<span class="bgcolor4">&nbsp;类别名称</span>
								</td>
								<td width="79" align="center">
									<span class="bgcolor4">显示序号</span>
								</td>
								<td width="109" align="center">
									操作
								</td>
							</tr>

							<%
								for (int i = 0; i < newsTypeListSize; i++) {
									newsType = newsTypeList.get(i);
							%>
							<tr>
								<td height="26" align="center">
									[<%=newsType.getNewsType()%>]
								</td>
								<td>
									&nbsp;<%=StrUtil.toHtmlTag(newsType.getNewsName())%></td>
								<td>
									&nbsp;<%=StrUtil.toHtmlTag(newsType.getOrderId())%></td>
								<td align="center">
									<a
										href="news_type_change.jsp?news_type=<%=newsType.getNewsType()%>"
										target="_self">修改</a>
									<a
										href="news_type.jsp?news_type=<%=newsType.getNewsType()%>&&del_news=ok"
										onClick="return del_cf();">删除</a>
								</td>
							</tr>
							<%
								}
								if (newsTypeListSize < 1) {
							%>
							<tr>
								<td height="26" colspan="4" align="center" valign="middle">
									没有记录
								</td>
							</tr>

							<%
								}
							%>
						</table>
					</td>
					<td>
						&nbsp;
					</td>
				</tr>
				<tr>
					<td height="53">
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

						<form name="form1" method="POST" action="news_type.jsp"
							onSubmit="return on_submit()">
							<table width="100%" border="1" cellpadding="0" cellspacing="0"
								bordercolor="#000000" bordercolordark="#FFFFFF">


								<tr>
									<td width="139" height="26">
										类别名称
									</td>
									<td width="441">
										<input name="news_name" type="text" id="news_name" size="35"
											maxlength="150">
									</td>
								</tr>
								<tr>
									<td height="25">
										显示序号
									</td>
									<td>
										<input name="order_id" type="text" id="order_id" size="10"
											maxlength="150">
									</td>
								</tr>
								<tr>
									<td height="29" colspan="2" align="center" valign="middle">
										<input name="B2" type="submit" class="button" id="B2"
											value="添加">
										<input name="Action" type="hidden" id="Action"
											value="change_set">
										&nbsp;
										<input name="B1" type="button" class="button" value="返回"
											onClick="location.href='index_face.jsp'">
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
					<td height="144">
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