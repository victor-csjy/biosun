<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="com.aokle.util.StrUtil"%>
<%@page import="com.aokle.util.FileUtil"%>
<%@page import="hk.com.biosun.model.BigTable"%>
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
	int big_id = MathUtil.toInt(request.getParameter("big_id"));
	int small_id = MathUtil.toInt(request.getParameter("small_id"));

	String big_del = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
			.getParameter("big_del")));
	String small_del = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("small_del")));

	String class_select = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("class_select")));
	int big_class = MathUtil.toInt(request.getParameter("big_class"));

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
	BigTable bigTable;
	SmallTableService smallTableService = new SmallTableService();
	ProductsTableService productsTableService = new ProductsTableService();
	BigAndSmallTableService bigAndSmallTableService = new BigAndSmallTableService();
	BigAndSmallTable bigAndSmallTable;
	if (Action != null && Action.equals("change_set")&& !class_name.equals("")) {
		int result = 0;
		if (class_select.equals("0")) {
			result = bigTableService.add(class_code, class_name,
					order_id, class_show, content);
			//sql="insert into big_table (big_code,big_name,big_order,big_class_show,content) values('"+class_code+"','"+class_name+"','"+order_id+"','"+class_show+"','"+content+"')";

		} else if (class_select.equals("1") && big_class>0) {//添加小类
			//sql="insert into small_table (small_code,small_name,big_id,small_order,small_class_show,content) values('"+class_code+"','"+class_name+"',"+Integer.parseInt(big_class)+",'"+order_id+"','"+class_show+"','"+content+"')";
			result = smallTableService.add(class_code, class_name,
					big_class, order_id, class_show, content);
		}
		if (result > 0) {
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('操作成功!');</SCRIPT>");
		} else {
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('操作失败！');</SCRIPT>");
		}

		if (class_select.equals("0")) {
			bigTable = bigTableService.getByBigName(class_name);
			if (bigTable != null) {
				out
						.println("<SCRIPT LANGUAGE='JavaScript'>location.href='p_flash.jsp?big_id="
								+ bigTable.getBigId() + "';</SCRIPT>");
				return;
			}
		}
	}

	if (big_del.equals("ok") && big_id > 0) {//删除大类,同时删除产品，删除小类，Flash,删除评论，询单， 不会删除产品图片
		int result = bigTableService.deleteByPK(big_id);
		//sql="delete from products_table where big_id="+Integer.parseInt(big_id);
		//sql="delete from small_table where big_id="+Integer.parseInt(big_id);
		//删除flash
		//del_exp.del_f((String)request.getRealPath("/")+"flash/"+big_id);
		//sql="delete from big_table where big_id="+Integer.parseInt(big_id);
		//删除评论：
		//sql="delete from com_table where p_id NOT IN  (SELECT p_id FROM products_table)";
		//删除询单
		//sql="delete from buy_car where p_id NOT IN  (SELECT p_id FROM products_table)";
		//sql="delete from enquiry where en_id NOT IN  (SELECT en_id FROM buy_car)";
		if (result > 0) {
			//删除flash
			FileUtil.deleteFile(PathUtil.getRealPath() + "flash/"
					+ big_id);
			//删除小类
			smallTableService.deleteByBigId(big_id);
			//删除产品
			productsTableService.deleteByBigId(big_id);
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('操作成功!');</SCRIPT>");
		} else {
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('操作失败！');</SCRIPT>");
		}
	}

	if (small_del.equals("ok") && small_id > 0) {//删除小类，删除产品
		int result = smallTableService.deleteByPK(small_id);
		if (result > 0) {
			productsTableService.deleteBySmallId(small_id);
		}
		//删除评论：
		//sql = "delete from com_table where p_id NOT IN  (SELECT p_id FROM products_table)";
		//删除询单
		//sql = "delete from buy_car where p_id NOT IN  (SELECT p_id FROM products_table)";
		//sql = "delete from enquiry where en_id NOT IN  (SELECT en_id FROM buy_car)";

		if (result > 0) {
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('操作成功!');</SCRIPT>");
		} else {
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('操作失败！');</SCRIPT>");
		}
	}
	List<BigTable> bigTableList = bigTableService.getList();
	int bigTableListSize = bigTableList != null
			? bigTableList.size()
			: 0;
	int is_have=bigTableListSize;
	
	
	List<BigAndSmallTable> bigAndSmallTableList = bigAndSmallTableService
			.getList();
	int bigAndSmallTableListSize = bigAndSmallTableList != null
			? bigAndSmallTableList.size()
			: 0;
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

		<script language="javascript">  
  
  function del_big()
{
   if(confirm("确定要删除此大类以及该大类下的所有小类和产品!，并且不能恢复！"))
     return true;
   else
     return false;
	 
}
function del_small()
{
   if(confirm("确定要删除此小以及该小类下的所有产品!，并且不能恢复！"))
     return true;
   else
     return false;
	 
}

function show_div(bYes) {
	if(bYes)
	{	
		div_big.style.display="";
	}
	else div_big.style.display="none";
}
</SCRIPT>
	</head>
	<body>
		<div align="center">
			<br>
			<br>
			<table width="1300" border="0" align="center" cellpadding="0"
				cellspacing="0">
				<tr>
					<td width="7" height="44">
						&nbsp;
					</td>
					<td width="7">
						&nbsp;
					</td>
					<td width="761">
						&nbsp;
					</td>
					<td width="123"></td>
					<td width="203"></td>
					<td width="199"></td>
				</tr>
				<tr>
					<td height="27">
						&nbsp;
					</td>
					<td colspan="2">
						<span class="STYLE2"> Products——类别管理 </span>
					</td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td height="27">
						&nbsp;
					</td>
					<td>
						&nbsp;
					</td>
					<td>
						&nbsp;
					</td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td height="27" colspan="4" valign="top">
						<span class="STYLE3">注意：删除类别时，会把该类别的所有产品都删除！</span>
					</td>
					<td>
						&nbsp;
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
					<td colspan="3" valign="top">
						<table width="112%" border="1" cellpadding="0" cellspacing="0"
							bordercolor="#000000" bordercolordark="#FFFFFF">

							<tr>
								<td width="51" height="26" align="center">
									ID_1
								</td>


								<td width="120" align="center">
									大类编码
								</td>



								<td width="159">
									大类名称
								</td>
								<td width="59">
									显示序号
								</td>
								<td width="62" align="center" valign="middle">
									是否显示
								</td>
								<td width="129" align="center" valign="top">
									操作
								</td>
								<td width="60" align="center">
									ID_2
								</td>

								<td width="84" align="center">
									小类编码
								</td>
								<td width="141">
									<span class="bgcolor4">&nbsp;小类名称</span>
								</td>
								<td width="61" align="center">
									<span class="bgcolor4">显示序号</span>
								</td>
								<td width="57" align="center" valign="middle">
									是否显示
								</td>
								<td width="78" align="center" valign="top">
									操作
								</td>
							</tr>
							<%
								for (int i = 0; i < bigAndSmallTableListSize; i++) {
									bigAndSmallTable = bigAndSmallTableList.get(i);
							%>
							<tr bgcolor="#f8f8f8" onMouseOver="this.bgColor='#FFFFFF'"
								onMouseOut="this.bgColor='#f8f8f8'">
								<td height="26" align="center">
									[<%=bigAndSmallTable.getBigId()%>]
								</td>
								<td align="center"><%=bigAndSmallTable.getBigCode()%></td>
								<td><%=bigAndSmallTable.getBigName()%></td>
								<td><%=bigAndSmallTable.getBigOrder()%></td>

								<td align="center" valign="middle">
									<%
										if ("1".equals(bigAndSmallTable.getBigClassShow()))
												out.print("显示");
											else
												out.print("隐藏");
									%>
								</td>
								<td align="center" valign="middle">
									<a href="p_flash.jsp?big_id=<%=bigAndSmallTable.getBigId()%>"
										target="_self">修改Flash</a>

									<a
										href="class_change.jsp?big_id=<%=bigAndSmallTable.getBigId()%>"
										target="_self"> 修改</a>
									<a
										href="product_class.jsp?big_id=<%=bigAndSmallTable.getBigId()%>&&big_del=ok"
										onClick="return del_big();">删除</a>
								</td>
								<%
									if (!"".equals(bigAndSmallTable.getSmallName())) {
								%>
								<td align="center" valign="middle">
									<%=bigAndSmallTable.getSmallId()%>
								</td>

								<td>
									&nbsp;<%=bigAndSmallTable.getSmallCode()%></td>
								<td>
									&nbsp;<%=bigAndSmallTable.getSmallName()%></td>
								<td>
									&nbsp;<%=bigAndSmallTable.getSmallOrder()%></td>
								<td align="center" valign="middle">
									<%
										if ("1".equals(bigAndSmallTable.getSmallClassShow()))
													out.print("显示");
												else
													out.print("隐藏");
									%>
								</td>
								<td align="center" valign="middle">


									<a
										href="class_change.jsp?big_id=<%=bigAndSmallTable.getBigId()%>&&small_id=<%=bigAndSmallTable.getSmallId()%>"
										target="_self">修改</a>
									<a
										href="product_class.jsp?big_id=<%=bigAndSmallTable.getBigId()%>&&small_id=<%=bigAndSmallTable.getSmallId()%>&&small_del=ok"
										onClick="return del_small();">删除</a>
								</td>
							</tr>

							<%
								}
								}
								if (bigAndSmallTableListSize > 0) {
							%>
							<tr>
								<td height="26" colspan="12" align="center" valign="middle">
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
					<td height="31">
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
					<td>
						&nbsp;
					</td>
					<td>
						&nbsp;
					</td>
				</tr>
				<tr>
					<td height="433">
						&nbsp;
					</td>
					<td>
						&nbsp;
					</td>
					<td>
						<form name="form1" method="POST" action="product_class.jsp"
							onSubmit="return on_submit()">
							<table width="100%" border="1" cellpadding="0" cellspacing="0"
								bordercolor="#000000" bordercolordark="#FFFFFF">
								<tr>
									<td width="138" height="26">
										类别
									</td>
									<td width="129">
										<label>
											<input name="class_select" type="radio" value="0" checked
												onClick="show_div(false)">
											大类
											<div id="div_small" <%if(is_have==0){%> style="display: none"
												<%}%>>
												<input type="radio" name="class_select" value="1"
													onClick="show_div(true)">
												小类
											</div>

										</label>
									</td>

									<td width="305">
										<div id="div_big" style="display: none">
											<label>
												所属大类
												<select name="big_class" id="big_class"
													<% if(is_have==0)out.print("disabled"); %>>
													<%
														for (int i = 0; i < bigTableListSize; i++) {
															bigTable = bigTableList.get(i);
													%>
													<option value="<%=bigTable.getBigId()%>"><%=bigTable.getBigName()%></option>
													<%
														}
													%>
												</select>
											</label>
										</div>
									</td>
								</tr>
								<tr>
									<td height="26">
										类别编码
									</td>
									<td colspan="2">
										<input name="class_code" type="text" id="class_code" size="35"
											maxlength="150">
										<span class="STYLE3">* </span>
									</td>
								</tr>
								<tr>
									<td height="26">
										类别名称
									</td>
									<td colspan="2">
										<input name="class_name" type="text" id="class_name" size="35"
											maxlength="150">
										<span class="STYLE3">* </span>
									</td>
								</tr>
								<tr>
									<td height="25">
										显示序号
									</td>
									<td colspan="2">
										<input name="order_id" type="text" id="order_id" value="0"
											size="10" maxlength="150">
									</td>
								</tr>

								<tr>
									<td height="25">
										是否显示
									</td>
									<td colspan="2">
										<input name="class_show" type="radio" value="1" checked>
										显示 &nbsp;&nbsp;&nbsp;
										<input type="radio" name="class_show" value="0">
										隐藏
									</td>
								</tr>


								<tr>
									<td height="25" colspan="3" valign="top">
										类别简介
									</td>
								</tr>

								<tr>
									<td height="25" colspan="3" valign="top">
										<input type="hidden" name=content0 " id="content0" value="" />
										<iframe ID="eWebEditor0"
											src="../ewebeditor/eWebEditor.jsp?id=content0&style=CoolBlue"
											frameborder="0" scrolling="no" width="790" height="450"></iframe>
									</td>
								</tr>
								<tr>
									<td height="29" colspan="3" align="center" valign="middle">
										<input name="B2" type="submit" class="button" id="B2"
											value="添加">
										<input name="Action" type="hidden" id="Action"
											value="change_set">
										&nbsp;
										<input name="B1" type="button" class="button" value="返回"
											onClick="javascript:history.back(-1)">
									</td>
								</tr>
							</table>
						</form>
					</td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td height="193">
						&nbsp;
					</td>
					<td>
						&nbsp;
					</td>
					<td>
						&nbsp;
					</td>
					<td></td>
					<td></td>
					<td></td>
				</tr>
			</table>
			<br>
			<br>
		</div>
	</body>
</html>