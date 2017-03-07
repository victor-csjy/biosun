<%@page contentType="text/html;charset=utf-8"%>
<%@ page import="com.aokle.util.StrUtil"%>
<%@ page import="com.aokle.util.MathUtil"%>
<%@ page import="hk.com.biosun.model.ComTable"%>
<%@ page import="hk.com.biosun.service.ComTableService"%>
<%@page import="hk.com.biosun.util.ReqParamUtil"%>
<%@ page import="java.util.*"%>
<%@include file="session_admin.jsp"%>
<%
	int com_id = MathUtil.toInt(request.getParameter("com_id"));
	int p_id = MathUtil.toInt(request.getParameter("p_id"));
	String com_date = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("com_date")));

	String p_model = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
			.getParameter("p_model")));
	String user_id = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
			.getParameter("user_id")));
	String order_by = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("order_by")));
	int pageNo = MathUtil.toInt(request.getParameter("page"), 1);
	String Action = request.getParameter("Action");
	String submit_find = request.getParameter("submit_find");
	String submit_all = request.getParameter("submit_all");
	String com_del = request.getParameter("com_del");

	ComTableService comTableService = new ComTableService();
	if (com_del != null && com_del.equals("ok") && com_id > 0) {
		int result = comTableService.deleteByPK(com_id);
		if (result > 0) {
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('删除成功!');</SCRIPT>");
		} else {
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('删除失败！');</SCRIPT>");
		}
	}
	List<Object> valuesList = new ArrayList<Object>();
	StringBuffer condSB = new StringBuffer();

	if (submit_all != null) {
		p_id = 0;
		com_date = "";
	} else {
		if (p_id > 0) {
			condSB.append(" AND p_id=?");
			valuesList.add(p_id);
		}
		if (!com_date.equals("")) {
			condSB.append(" AND com_date LIKE ?");
			valuesList.add("%" + com_date + "%");
		}
		if (!p_model.equals("")) {
			condSB.append(" AND p_model LIKE ?");
			valuesList.add("%" + p_model + "%");
		}
		if (!user_id.equals("")) {
			condSB.append(" AND user_id LIKE ?");
			valuesList.add("%" + user_id + "%");
		}
	}


if(condSB.length()>4){
	condSB.delete(0,4);
	condSB.insert(0,"WHERE");
}

	int recordCount = comTableService.getCount(condSB.toString(),
			valuesList);
	condSB.append(" ORDER BY ");
	if (!order_by.equals("")) {
		condSB.append(order_by + " DESC");
	} else {
		condSB.append("com_date DESC");
	}
	int pageSize = MathUtil.toInt(request.getParameter("pageSize"),20);
	List<ComTable> comTableList = comTableService.getList(condSB
			.toString(), valuesList, pageSize, pageNo);
	int comTableListSize = comTableList != null
			? comTableList.size()
			: 0;
	ComTable comTable;
	int pageCount = (recordCount - 1) / pageSize + 1;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<script language="javascript">
 function on_submit()
 {
 if(isNaN(document.form1.article_id.value)&&document.form1.article_id.value!="")
  {
    alert("请输入整数的文章ID!");
	form1.article_id.value="";	
    document.form1.article_id.focus();
	return false;
  }
}
  </script>
	<script language="javascript">  

function del_cf()
{
   if(confirm("确定要删除!，并且不能恢复！"))
     return true;
   else
     return false;
	 
}
</SCRIPT>
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
			<form name="form1" method="post" action="com.jsp"
				onSubmit="return on_submit()">
				<table width="2500" border="0" align="center" cellpadding="0"
					cellspacing="0">
					<tr>
						<td width="28" height="289">&nbsp;
							
						</td>
						<td width="2472" align="left" valign="top">
							<TABLE width="98%" border=0 align="center" cellPadding=0
								cellSpacing=0>
								<tr bgcolor="">
									<td height="21" colspan="3" align="left" valign="top">
										<span class="STYLE2"> Products——产品评论</span>
									</td>
									<td width="167"></td>
									<td width="1501"></td>
									<td width="16"></td>
								</tr>
								<tr bgcolor="">
									<td width="7" height="9"></td>
									<td width="635"></td>
									<td width="97"></td>
									<td></td>
									<td></td>
									<td></td>
								</tr>
								<tr bgcolor="">
									<td height="30"></td>
									<td colspan="3" align="left" valign="middle">
										产品ID
										<input name="p_id" type="text" id="p_id"
											value="<%=p_id > 0 ? String.valueOf(p_id) : ""%>" size="30"
											maxlength="150">
										&nbsp;产品型号
										<input name="p_model" type="text" id="p_model"
											value="<%=p_model%>" size="19" maxlength="25">
										&nbsp;User ID

										<input name="user_id" type="text" id="user_id"
											value="<%=user_id%>" size="19" maxlength="25">
										评论时间
										<input name="com_date" type="text" id="com_date"
											value="<%=com_date%>" size="19" maxlength="25">
									</td>
									<td></td>
									<td></td>
								</tr>
								<tr bgcolor="">
									<td height="30"></td>
									<td align="center" valign="middle">
									    <input name="pageSize" type="hidden" id="pageSize" value="<%=pageSize%>"/>
										<input name="submit_find" type="submit" id="submit_find"
											value="查  找">
										&nbsp;&nbsp;&nbsp;&nbsp;
										<input name="submit_all" type="submit" id="submit_all"
											value="显示全部">
										&nbsp;&nbsp;&nbsp;&nbsp;
									</td>
									<td>&nbsp;
										
									</td>
									<td>&nbsp;
										
									</td>
									<td></td>
									<td></td>
								</tr>

								<tr bgcolor="">
									<td height="178">&nbsp;
										
									</td>
									<td colspan="4" valign="top">
										<table width="100%" border="1" cellpadding="0" cellspacing="0"
											bordercolor="#000000" bordercolordark="#FFFFFF">
											<tr class="bgcolor4">
												<td width="69" height="38" align="center" valign="middle"
													class="bgcolor4">
													Item No.
												</td>
												<td width="93" align="center" valign="middle"
													class="bgcolor4">
													<a
														href="com.jsp?pageSize=<%=pageSize%>&&p_model=<%=p_model%>&&user_id=<%=user_id%>&&p_id=<%=p_id%>&&page=<%=pageNo%>&&com_date =<%=com_date%>&&order_by=com_table.p_id">产品ID</a>
												</td>
												<TD width="189" align="center" vAlign=middle>
													<a
														href="com.jsp?pageSize=<%=pageSize%>&&p_model=<%=p_model%>&&user_id=<%=user_id%>&&p_id=<%=p_id%>&&page=<%=pageNo%>&&com_date =<%=com_date%>&&order_by=p_model">
														产品型号</a>
												</TD>
												<TD width="189" align="center" vAlign=center
													class="bgcolor4">
													产品名称
												</TD>
												<TD width="117" align="center" vAlign=center
													class="bgcolor4">
													Image
												</TD>
												<TD width="45%" align="center" vAlign=middle
													class="bgcolor4">
													评论内容
												</TD>
												<TD width="165" align="center" vAlign=middle>
													<a
														href="com.jsp?pageSize=<%=pageSize%>&&p_model=<%=p_model%>&&user_id=<%=user_id%>&&p_id=<%=p_id%>&&page=<%=pageNo%>&&com_date =<%=com_date%>&&order_by=com_date">评论时间</a>
												</TD>
												<TD width="69" align="center" vAlign=middle>
													<a
														href="com.jsp?pageSize=<%=pageSize%>&&p_model=<%=p_model%>&&user_id=<%=user_id%>&&p_id=<%=p_id%>&&page=<%=pageNo%>&&com_date =<%=com_date%>&&order_by=need_fb">Need
														Feedback</a>
												</TD>
												<TD width="237" align="center" vAlign=middle>
													<a
														href="com.jsp?pageSize=<%=pageSize%>&&p_model=<%=p_model%>&&user_id=<%=user_id%>&&p_id=<%=p_id%>&&page=<%=pageNo%>&&com_date =<%=com_date%>&&order_by=status_fb">Feedback
														Status</a>
												</TD>
												<TD width="141" align="center" vAlign=middle>
													<a
														href="com.jsp?pageSize=<%=pageSize%>&&p_model=<%=p_model%>&&user_id=<%=user_id%>&&p_id=<%=p_id%>&&page=<%=pageNo%>&&com_date =<%=com_date%>&&order_by=user_id">User
														ID</a>
												</TD>
												<TD width="5%" align="center" vAlign=middle class="bgcolor4">
													<img src="../img/doing.jpg" width="102" height="23">
												</TD>
											</tr>
											<%
												for (int i = 0; i < comTableListSize; i++) {
													comTable = comTableList.get(i);
											%>

											<tr bgcolor="#f8f8f8" onMouseOver="this.bgColor='#FFFFFF'"
												onMouseOut="this.bgColor='#f8f8f8'">
												<td height="100" align="center" valign="middle"><%=i + 1%></td>

												<td align="center" valign="middle">
													[<%=comTable.getPId()%>]
												</td>
												<TD align="left" vAlign=middle>
													&nbsp;
													<a href="product.jsp?p_model=<%=comTable.getPModel()%>"
														target="_blank"><%=comTable.getPModel()%></a>
												</TD>
												<TD vAlign=center>
													&nbsp;
													<%=comTable.getPName()%>
												</TD>

												<TD align="center" vAlign=middle>
													&nbsp;
													<a href="show_pic.jsp?p_pic=<%=comTable.getPPic()%>"
														target="_blank"><%=comTable.getPPic()%> </a>
													<img src="../product/pic/small<%=comTable.getPPic()%>"
														width="96" height="78">
												</TD>
												<TD vAlign=middle>
													&nbsp;
													<%=comTable.getComContent()%></TD>
												<TD vAlign=middle>
													&nbsp;<%=comTable.getComDate()%>
												</TD>

												<TD align="center" vAlign=middle>
													&nbsp;<%=comTable.getNeedFb()%>
												</TD>
												<TD align="center" vAlign=middle>
													&nbsp;
													<a href="com_fb.jsp?com_id=<%=comTable.getComId()%>"><%=comTable.getStatusFb()%>
													</a>
												</TD>

												<TD vAlign=middle>
													&nbsp;
													<a href="user_inf.jsp?id_find=<%=comTable.getUserId()%>"
														target="_blank"><%=comTable.getUserId()%></a>
												</TD>


												<TD align="center" vAlign=middle>
													<a
														href="com.jsp?pageSize=<%=pageSize%>&&p_model=<%=p_model%>&&user_id=<%=user_id%>&&p_id=<%=p_id%>&&page=<%=pageNo%>&&com_date =<%=com_date%>&&com_del=ok&&com_id=<%=comTable.getComId()%>"
														onClick="return del_cf();">删除</a>
												</TD>
											</tr>

											<%
												}
												if (comTableListSize > 0) {
											%>

											<tr>
												<td height="31" colspan="11" align="center" valign="middle">
													<div align="center">

														<%
															if (pageNo > 1) {
														%>
														<a
															href="com.jsp?pageSize=<%=pageSize%>&&p_model=<%=p_model%>&&user_id=<%=user_id%>&&p_id=<%=p_id%>&&page=<%=(pageNo - 1)%>&&com_date =<%=com_date%>&&order_by=<%=order_by%>">上一页</a>&nbsp;&nbsp;
														<%
															}
																if (pageNo < pageCount) {
														%>
														<a
															href="com.jsp?pageSize=<%=pageSize%>&&p_model=<%=p_model%>&&user_id=<%=user_id%>&&p_id=<%=p_id%>&&page=<%=(pageNo + 1)%>&&com_date =<%=com_date%>&&order_by=<%=order_by%>">下一页</a>
														<%
															}
														%>
														&nbsp;&nbsp;&nbsp;&nbsp;共
														<strong><%=pageCount%></strong>页
														<strong><%=recordCount%></strong>条记录
														&nbsp;&nbsp;&nbsp;&nbsp;
														<SELECT name=pageSizeSelect id=pageSizeSelect onChange="location.href=this.options[this.selectedIndex].value;">
										<OPTION value=# selected><%=pageSize%></OPTION>
                                        <OPTION value=com.jsp?pageSize=20&&p_model=<%=p_model%>&&user_id=<%=user_id%>&&p_id=<%=p_id%>&&page=<%=pageNo%>&&com_date=<%=com_date%>&&order_by=<%=order_by%>>20</OPTION>
                                        <OPTION value=com.jsp?pageSize=30&&p_model=<%=p_model%>&&user_id=<%=user_id%>&&p_id=<%=p_id%>&&page=<%=pageNo%>&&com_date=<%=com_date%>&&order_by=<%=order_by%>>30</OPTION>
                                         <OPTION value=com.jsp?pageSize=50&&p_model=<%=p_model%>&&user_id=<%=user_id%>&&p_id=<%=p_id%>&&page=<%=pageNo%>&&com_date=<%=com_date%>&&order_by=<%=order_by%>>50</OPTION>
                                         <OPTION value=com.jsp?pageSize=75&&p_model=<%=p_model%>&&user_id=<%=user_id%>&&p_id=<%=p_id%>&&page=<%=pageNo%>&&com_date=<%=com_date%>&&order_by=<%=order_by%>>75</OPTION>
                                         <OPTION value=com.jsp?pageSize=100&&p_model=<%=p_model%>&&user_id=<%=user_id%>&&p_id=<%=p_id%>&&page=<%=pageNo%>&&com_date=<%=com_date%>&&order_by=<%=order_by%>>100</OPTION>
                                        </select> 条/页&nbsp;&nbsp;
														<label>
															第
															<SELECT name=menu1
																onChange="location.href=this.options[this.selectedIndex].value;">
																<OPTION value=# selected><%=pageNo%></OPTION>

																<%
																	int pageMin = pageNo - 20;
																		pageMin = pageMin < 1 ? 1 : pageMin;
																		int pageMax = pageNo + 20;
																		pageMax = pageMax > pageCount ? pageCount : pageMax;
																		if (pageMin > pageMax) {
																			pageMin = pageMax;
																		}
																		for (int i = pageMin; i <= pageMax; i++) {
																			if (i == pageNo)
																				continue;
																%>
<OPTION value=com.jsp?pageSize=<%=pageSize%>&&p_model=<%=p_model%>&&user_id=<%=user_id%>&&p_id=<%=p_id%>&&page=<%=i%>&&com_date=<%=com_date%>&&order_by=<%=order_by%>><%=i%></OPTION>
																<%
																	}
																%>
															</select>
														</label>
														页
													</div>
												</td>
											</tr>
											<%
												} else {
											%>
											<tr>
												<td height="22" colspan="11" align="center" valign="middle">
													<font color="#FF0000">没有评论！ 
												</td>
											</tr>
											<%
												}
											%>
										</table>
									</td>
									<td>&nbsp;
										
									</td>
								</tr>
								<tr bgcolor="">
									<td height="21">&nbsp;
										
									</td>
									<td>&nbsp;
										
									</td>
									<td>&nbsp;
										
									</td>
									<td>&nbsp;
										
									</td>
									<td></td>
									<td></td>
								</tr>
							</TABLE>
						</td>
					</tr>
					<tr>
						<td height="51">&nbsp;
							
						</td>
						<td>&nbsp;
							
						</td>
					</tr>
				</table>
			</form>
			<br>
			<br>
		</div>
	</body>
</html>