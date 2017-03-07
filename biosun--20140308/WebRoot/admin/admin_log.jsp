<%@page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.List"%>
<%@page import="com.aokle.util.MathUtil"%>
<%@page import="com.aokle.util.StrUtil"%>
<%@page import="hk.com.biosun.service.AdminLogService"%>
<%@page import="hk.com.biosun.model.AdminLog"%>
<%@include file="session_admin.jsp"%>
<%
	long id = MathUtil.toInt(request.getParameter("id"));
	String com_del = StrUtil.toHtmlTxt(request.getParameter("com_del"));
	int pageNo = MathUtil.toInt(request.getParameter("page"), 1);
	AdminLogService adminLogService = new AdminLogService();
	if (com_del.equalsIgnoreCase("ok")) {
		if (adminLogService.delete(id) > 0) {
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('删除成功!');</SCRIPT>");

		} else {
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('删除失败！');</SCRIPT>");
		}
	}

	AdminLog adminLog;
	int pageSize = MathUtil.toInt(request.getParameter("pageSize"),20);
	List<AdminLog> adminLogList = adminLogService.getList(pageNo,pageSize);
	int adminLogListSize = adminLogList != null
			? adminLogList.size()
			: 0;
	int recordCount = adminLogService.getCount();
	int pageCount = (recordCount - 1) / pageSize + 1;
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

		<script language="javascript">  

function del_cf()
{
   if(confirm("确定要删除!，并且不能恢复！"))
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
			<table width="977" border="0" align="center" cellpadding="0"
				cellspacing="0">


				<tr>
					<td width="40" height="171">&nbsp;
						
					</td>
					<td width="682" align="left" valign="top">
						<TABLE width="98%" border=0 align="center" cellPadding=0
							cellSpacing=0>


							<tr bgcolor="">
								<td height="21" colspan="2" align="left" valign="top">
									<span class="STYLE2"> 系统管理——登陆日志</span>
								</td>
								<td width="14"></td>
							</tr>
							<tr bgcolor="">
								<td width="661" height="39">&nbsp;
									
								</td>
								<td width="7">&nbsp;
									
								</td>
								<td></td>
							</tr>
							<tr bgcolor="">
								<td height="111" valign="top">



									<table width="100%" border="1" cellpadding="0" cellspacing="0"
										bordercolor="#000000" bordercolordark="#FFFFFF">

										<tr class="bgcolor4">

											<TD width="120" height="26" align="center">
												登录情况
											</TD>
											<TD width="181" align="center" vAlign=middle>
												IP
											</TD>
											<TD width="197" align="center" vAlign=center class="bgcolor4">
												登录时间
											</TD>


											<TD width="137" align="center" vAlign=middle class="bgcolor4">
												操作
											</TD>
										</tr>
										<%
											for (int i = 0; i < adminLogListSize; i++) {
												adminLog = adminLogList.get(i);
										%>

										<tr bgcolor="#f8f8f8" onMouseOver="this.bgColor='#FFFFFF'"
											onMouseOut="this.bgColor='#f8f8f8'">
											<TD height="26" align="center"><%=adminLog.getLoginStatus()%></TD>

											<TD align="center" vAlign=middle><%=adminLog.getLoginIp()%></TD>

											<TD align="center" vAlign=center>
												&nbsp;
												<%=adminLog.getLoginDate()%>
											</TD>

											<TD align="center" vAlign=middle>
												<a
													href="admin_log.jsp?pageSize=<%=pageSize%>&&page=<%=pageNo%>&&com_del=ok&&id=<%=adminLog.getId()%>"
													onClick="return del_cf();">删除</a>
											</TD>
										</tr>

										<%
											}
											if (adminLogListSize > 0) {
										%>

										<tr>
											<td height="31" colspan="4" align="center" valign="middle">
												<div align="center">

													<%
														if (pageNo > 1) {
													%>
													<a href="admin_log.jsp?pageSize=<%=pageSize%>&&page=<%=(pageNo - 1)%>">上一页</a>&nbsp;&nbsp;
													<%
														}
															if (pageNo < pageCount) {
													%>
													<a href="admin_log.jsp?pageSize=<%=pageSize%>&&page=<%=(pageNo + 1)%>">下一页</a>
													<%
														}
													%>
													&nbsp;&nbsp;&nbsp;&nbsp;共
													<strong><%=pageCount%></strong>页
													<strong><%=recordCount%></strong>条记录
													&nbsp;&nbsp;&nbsp;&nbsp;
													<SELECT name=pageSizeSelect id=pageSizeSelect onChange="location.href=this.options[this.selectedIndex].value;">
										<OPTION value=# selected><%=pageSize%></OPTION>												
<OPTION value=admin_log.jsp?pageSize=20&&page=<%=pageNo%>>20</OPTION>	
<OPTION value=admin_log.jsp?pageSize=30&&page=<%=pageNo%>>30</OPTION>
<OPTION value=admin_log.jsp?pageSize=50&&page=<%=pageNo%>>50</OPTION>
<OPTION value=admin_log.jsp?pageSize=75&&page=<%=pageNo%>>75</OPTION>
<OPTION value=admin_log.jsp?pageSize=100&&page=<%=pageNo%>>100</OPTION>												
													
											</select> 条/页&nbsp;&nbsp;
													<label>
														第
														<SELECT name=menu1  onChange="location.href=this.options[this.selectedIndex].value;">
															<OPTION value=# selected><%=pageNo%></OPTION>

															<%
																int pageMin=pageNo-20;
																pageMin=pageMin<1?1:pageMin;
																int pageMax=pageNo+20;
																pageMax=pageMax>pageCount?pageCount:pageMax;
																if(pageMin>pageMax){
																   pageMin=pageMax;
																}
																for (int i = pageMin; i <= pageMax; i++) {
																		if (i == pageNo)
																			continue;
															%>
															<OPTION value=admin_log.jsp?pageSize=<%=pageSize%>&&page=<%=i%>><%=i%></OPTION>
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
											<td height="22" colspan="4" align="center" valign="middle">
												<font color="#FF0000">没有日志！
											</td>
										</tr>
										<tr>
											<td height="4"></td>
											<td></td>
											<td></td>
											<td></td>
										</tr>





										<%
											}
										%>
									</table>
								</td>


								<td>&nbsp;
									
								</td>
								<td></td>
							</tr>




						</TABLE>
					</td>
					<td width="255">&nbsp;
						
					</td>
				</tr>
				<tr>
					<td height="169">&nbsp;
						
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