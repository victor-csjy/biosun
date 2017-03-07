<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="com.aokle.util.StrUtil"%>
<%@page import="com.aokle.util.FileUtil"%>
<%@page import="hk.com.biosun.model.BigTable"%>
<%@page import="hk.com.biosun.model.SmallTable"%>
<%@page import="hk.com.biosun.service.BigTableService"%>
<%@page import="hk.com.biosun.define.BigAndSmallTable"%>
<%@page import="hk.com.biosun.service.SmallTableService"%>
<%@page import="com.aokle.util.MathUtil"%>
<%@page import="hk.com.biosun.service.ProductsTableService"%>
<%@page import="hk.com.biosun.service.BigAndSmallTableService"%>
<%@page import="hk.com.biosun.util.ReqParamUtil"%>
<%@page import="com.aokle.util.PathUtil"%>
<%@include file="session_admin.jsp"%>
<%
	int big_id_orient = MathUtil.toInt(request.getParameter("big_id"));
	int big_id_news = MathUtil.toInt(request.getParameter("big_class"));
	int small_id = MathUtil.toInt(request.getParameter("small_id"));
	String class_code = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("class_code")));
	String class_name = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("class_name")));
	String order_id = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("order_id")));
	String class_show = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("class_show")));
	String content = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
			.getParameter("content0")));

	String Action = request.getParameter("Action");

	BigTableService bigTableService = new BigTableService();
	SmallTableService smallTableService = new SmallTableService();
	ProductsTableService productsTableService = new ProductsTableService();

    BigTable bigTableTmp = null;
	BigTable bigTable = null;
	SmallTable smallTable = null;
	if (Action != null && Action.equals("change_set")
			&& !class_name.equals("")) {
		int result = 0;
		//是大类修改！
		if (small_id < 1) { //先修改改大类下的小类显示属性
			//先修改大类
			result = bigTableService.updateByPk(big_id_orient,
					class_code, class_name, content, order_id,
					class_show);
			if (result > 0&&"0".equals(class_show)) {
				smallTableService.updateSmallClassShowByBigId(
						big_id_orient, class_show);
			}
		} else if (big_id_orient == big_id_news) {//修改小类，但不移动大类！
			result = smallTableService.updateByPk(small_id,
					big_id_orient, class_code, class_name, content,
					order_id, class_show);
		} else if (big_id_orient != big_id_news) {//移动到别的大类！
			result = smallTableService.updateByPk(small_id,
					big_id_news, class_code, class_name, content,
					order_id, class_show);
			if (result > 0) {
				productsTableService.updateClass(big_id_news, small_id,
						big_id_news, small_id);
			}
		}
		if (result > 0) {
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('操作成功!');location.href='product_class.jsp';</SCRIPT>");
			return;
		} else {
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('操作失败！编码重复！');location.href='product_class.jsp';</SCRIPT>");
		}
	}

	//修改大类！
	if (small_id < 1) {
		bigTable = bigTableService.getByPK(big_id_orient);
		if (bigTable == null) {
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('非法参数！');javascript:history.back(-1);</SCRIPT>");
			;
			return;
		}
	} else {//修改小类
		smallTable = smallTableService.getByPK(small_id);
		if (smallTable == null) {
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('非法参数！');javascript:history.back(-1);</SCRIPT>");
			;
			return;
		}
	}

	List<BigTable> bigTableList = bigTableService.getList();
	int bigTableListSize = bigTableList != null ? bigTableList.size()
			: 0;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<script language="javascript">
 function on_submit()
 {
 
 if(form1.class_code.value=="")
  {
    alert("请输入类别编码!");
	form1.class_code.value="";	
    document.form1.class_code.focus();
	return false;
  }
  
  
 if(form1.class_name.value=="")
  {
    alert("请输入名称!");
	form1.class_name.value="";	
    document.form1.class_name.focus();
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
	</head>
	<body>
		<div align="center">
			<br>
			<br>
			<table width="736" border="0" align="center" cellpadding="0"
				cellspacing="0">

				<tr>
					<td width="12" height="44">
						&nbsp;
					</td>
					<td width="724">
						&nbsp;
					</td>
				</tr>
				<tr>
					<td height="27">
						&nbsp;
					</td>
					<td valign="top">
						<span class="STYLE2">Products——类别管理</span>
					</td>


				</tr>
				<tr>
					<td height="20">
						&nbsp;
					</td>
					<td>
						&nbsp;
					</td>
				</tr>

				<tr>
					<td height="196">
						&nbsp;
					</td>
					<td>
                      <form name="form1" method="POST" action="class_change.jsp" onSubmit="return on_submit()">
						<table width="100%" border="1" cellpadding="0" cellspacing="0"
							bordercolor="#000000" bordercolordark="#FFFFFF">
							<tr>
								<td width="139" height="26">
									类别
								</td>
								<td width="59" align="center" valign="middle">
									<%
										if (small_id<1)
											out.print("大类");
										else
											out.print("小类");
									%>
								</td>

								<td width="518" valign="middle">

									<div id="div_big" <%if(small_id<1){%>
										style="display: none" <%}%>>
										<label>
											所属大类
											<select name="big_class" id="big_class">
												<%
													for(int i=0;i<bigTableListSize;i++) {
													  bigTableTmp=bigTableList.get(i);
												%>
												<option value="<%=bigTableTmp.getBigId()%>"
													<%if(bigTableTmp.getBigId()==big_id_orient)out.print("selected");%>>
													<%=bigTableTmp.getBigName()%></option>
												<%
													}
												%>
											</select>
											你可以移动到其它大类
										</label>
									</div>
								</td>
							</tr>



							<tr>
								<td height="26">
									类别编码
								</td>
								<td colspan="2">
									<input name="class_code" type="text" id="class_code"
										value="<%=bigTable!=null?bigTable.getBigCode():smallTable.getSmallCode()%>"
										size="35" maxlength="150">
									<span class="STYLE3">* </span>
								</td>
							</tr>



							<tr>
								<td height="26">
									类别名称
								</td>
								<td colspan="2">
									<input name="class_name" type="text" id="class_name"
										value="<%=bigTable!=null?bigTable.getBigName():smallTable.getSmallName()%>"
										size="35" maxlength="150">
									<span class="STYLE3">* </span>
								</td>
							</tr>
							<tr>
								<td height="25">
									显示序号
								</td>
								<td colspan="2">
									<input name="order_id" type="text" id="order_id"
										value="<%=bigTable!=null?bigTable.getBigOrder():smallTable.getSmallOrder()%>" size="10" maxlength="150">
								</td>
							</tr>
							<tr>
								<td height="25">
									是否显示
								</td>
								<td colspan="2">
									<input name="class_show" type="radio" value="1"
										<%=(bigTable!=null?bigTable.getBigClassShow():smallTable.getSmallClassShow()).equals("1") ? "checked" : ""%>>
									显示 &nbsp;&nbsp;&nbsp;
									<input type="radio" name="class_show" value="0"
										<%=(bigTable!=null?bigTable.getBigClassShow():smallTable.getSmallClassShow()).equals("0") ? "checked" : ""%>>
									隐藏
								</td>
							</tr>
							<tr>
								<td height="25" colspan="3" valign="middle">
									类别简介
								</td>
							</tr>
							<tr>
								<td height="25" colspan="3" valign="top">
								 <input type="hidden" name=content0 " id="content0" value="<%=bigTable!=null?bigTable.getContent():smallTable.getContent()%>"/>
	                             <iframe ID="eWebEditor0" src="../ewebeditor/eWebEditor.jsp?id=content0&style=CoolBlue" frameborder="0" scrolling="no" width="758" height="250"></iframe>
								</td>
							</tr>
							<tr>
								<td height="29" colspan="3" align="center" valign="middle">

									<input name="big_id" type="hidden" id="big_id_orient"
										value="<%=big_id_orient%>">
									<input name="small_id" type="hidden" id="small_id"
										value="<%=small_id%>">

									<input name="B2" type="submit" class="button" id="B2"
										value="修改">
									<input name="Action" type="hidden" id="Action"
										value="change_set">
									&nbsp;
									<input name="B1" type="button" class="button" value="返回"
										onClick="location.href='product_class.jsp'">
								</td>
							</tr>
						</table>
						</form>
					</td>
				</tr>
			</table>
			<br>
			<br>
		</div>
	</body>
</html>