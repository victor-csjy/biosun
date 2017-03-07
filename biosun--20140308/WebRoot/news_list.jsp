<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="com.aokle.util.StrUtil"%>
<%@page import="com.aokle.util.MathUtil"%>
<%@page import="hk.com.biosun.model.Article"%>
<%@page import="hk.com.biosun.service.ArticleService"%>
<%@page import="hk.com.biosun.model.NewsType"%>
<%@page import="hk.com.biosun.service.NewsTypeService"%>
<%@page import="hk.com.biosun.model.BigTable"%>
<%@page import="hk.com.biosun.service.BigTableService"%>
<%@page import="hk.com.biosun.service.SmallTableService"%>
<%@page import="hk.com.biosun.service.NewsTableService"%>
<%@page import="hk.com.biosun.model.NewsTable"%>
<%
int newsTypeId=MathUtil.toInt(request.getParameter("news_type"));
int pageNo=MathUtil.toInt(request.getParameter("page"),1);
int pageSize=15;
NewsTypeService newsTypeService=new NewsTypeService();
NewsType  newsType=newsTypeService.getByPK(newsTypeId);
if(newsType==null){
   out.println("<SCRIPT LANGUAGE='JavaScript'>alert('Parameter Error！');location.href='index.jsp';</SCRIPT>");
   return; 
}
NewsTableService newsTableService=new NewsTableService();
int recordCount=newsTableService.getCountFront(newsTypeId);
int pageCount=(recordCount-1)/pageSize+1;
if(pageNo>pageCount){
   pageNo=pageCount;
}
List<NewsTable> newsTableList=newsTableService.getListFront(newsTypeId,pageSize,pageNo);
int newsTableListSize=newsTableList!=null?newsTableList.size():0;
NewsTable newsTable;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<TITLE>Welcome to Biosun Technology Co., Ltd.</TITLE>
		<META http-equiv=Content-Type content="text/html; charset=utf-8">
		<LINK href="css/style.css" type=text/css rel=stylesheet>
		<SCRIPT src="js/js.js" type=text/javascript></SCRIPT>

<style type="text/css">
<!--
.STYLE11 {
	color: #838383
}

body {
	background-color: #FFFFFF;
}

.STYLE12 {
	color: #FFFFFF
}

.STYLE13 {
	font-size: 12px;
	color: #333333;
}

.STYLE14 {
	color: #000000
}

.STYLE15 {
	color: #003366
}

.STYLE23 {
	font-family: "Times New Roman", Times, serif;
	font-size: 9pt;
}

.STYLE24 {
	color: #666666;
	font-weight: bold;
}

.STYLE26 {
	font-family: "Times New Roman", Times, serif;
	font-size: 9pt;
	color: #000000;
}

.STYLE27 {
	color: #73B549;
	font-weight: bold;
}

.STYLE29 {
	color: #FFFFFF;
	font-weight: bold;
}

.STYLE30 {
	font-size: 12px
}

.STYLE8 {
	font-size: 12px;
	color: #666666;
	font-weight: bold;
}

.STYLE31 {
	color: #666666;
}

.STYLE33 {
	font-size: 16px
}

.STYLE34 {
	color: #999999
}
-->
</style>
	</HEAD>
	<BODY>
		<TABLE width=778 border=0 align=center cellPadding=0 cellSpacing=0
			bgcolor="#FFFFFF">
			
			<TBODY>
				<TR>
					<TD width="839" height="16" valign="top"><%@ include
							file="header.jsp"%></TD>
				</TR>
				<TR>
					<TD>
						<TABLE cellSpacing=0 cellPadding=0 width=778 align=center border=0>
							<TBODY>
								<TR>
									<TD height=6></TD>
								</TR>
							</TBODY>
						</TABLE>
						<TABLE cellSpacing=0 cellPadding=0 width=778 align=center border=0>
							
							<TBODY>
								<TR>
									<TD width="191" vAlign=top bgcolor="#E3E9F6">
									<%@ include file="news_inc.jsp"%>
									<%@ include file="left.jsp"%></TD>
									<TD vAlign=top>
										<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
											
											<TBODY>
												<TR>
													<TD>
														<div align="right">
															<script language="javascript">
	if (AC_FL_RunContent == 0) {
	} else {
		AC_FL_RunContent(
			'codebase', 'http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0',
			'width', '580',
			'height', '133',
			'src', 'flash/events',
			'quality', 'high',
			'pluginspage', 'https://www.macromedia.com/go/getflashplayer',
			'align', 'middle',
			'play', 'true',
			'loop', 'true',
			'scale', 'showall',
			'wmode', 'transparent',
			'devicefont', 'false',
			'id', 'home_main',
			'name', 'home_main',
			'menu', 'true',
			'allowScriptAccess','sameDomain',
			'movie', 'flash/events',
			'salign', ''
			); //end AC code
	}
</script>
														</div>
													</TD>
												</TR>
												<TR>
													<TD class=MainText vAlign=top>&nbsp;
														
													</TD>
												</TR>
												<TR>
													<TD class=MainText vAlign=top>
														<table width="580" border="0" align="right"
															cellpadding="0" cellspacing="3">
															<tr>
																<td width="3%">
																	<div align="left">
																		<img src="img/dian.gif" width="15" height="15">
																	</div>
																</td>
																<td width="26%">
																	<span class="STYLE27">Events</span>
																</td>
																<td width="71%">
																	<div align="right">
																		<a href="/" class="STYLE14"></a>
																		<DIV align="right">
																			<span class="STYLE34">You are here</span>
																			<STRONG>:</STRONG><a href="index.jsp" class="STYLE26">Home</a>--
																			<span class="STYLE30"><a href="news.jsp"
																				class="STYLE26">Events</a>
																			</span>--
																			<span class="STYLE34"> <a href="#"
																				class="STYLE26"><%=StrUtil.toHtmlTag(newsType.getNewsName())%></a>
																			</span>
																		</DIV>
																	</div>
																</td>
															</tr>
														</table>
													</TD>
												</TR>
												<TR>
													<TD class=MainText vAlign=top>
														<div align="right">
															<img src="img/pc-16.gif" width="580" height="3">
														</div>
													</TD>
												</TR>

												<TR>
													<TD height=5 valign="top">
														<table width="98%" border="0" align="center"
															cellpadding="0" cellspacing="5">
															<tr>
																<td>
																	<table width="530" border="0" align="center"
																		cellpadding="0" cellspacing="8">
																		
																		<tr>
																			<td width="608" height="5" valign="top">
																				<strong><%=StrUtil.toHtmlTag(newsType.getNewsName())%></strong>
																			</td>
																		</tr>
																		<tr>
																			<td bgcolor="#73B549" colspan="3">
																				<img height="1" src="" width="1" />
																			</td>
																		</tr>
<%  
for(int i=0;i<newsTableListSize;i++){
  newsTable=newsTableList.get(i);
%>
																		<tr>
																			<td colspan="2">
																				<span class="STYLE30"><a
																					href="news_show.jsp?news_type=<%=newsTable.getNewsType()%>&&news_id=<%=newsTable.getNewsId()%>"
																					class="STYLE26">· <%=StrUtil.fomatStr(StrUtil.toHtmlTag(newsTable.getNewsTitle()),70)%>
																				</a>&nbsp;&nbsp;[<%=DateUtil.getDateStr(newsTable.getNewsDate())%>]</span>
																			</td>
																		</tr>
																		<tr>
																			<td height="1" background="img/line_03.gif"></td>
																		</tr>
																		<%} %>
																		<tr>
																			<td height="31" colspan="8" align="center"
																				valign="middle">
																				<div align="center">
																					Page
																					<strong><%=pageNo%></strong>/<%=pageCount%>
																					(<%=recordCount%>
																					<%if(recordCount<2)out.print("record");
			    else out.print("records");%>)&nbsp;&nbsp;
																					<% if(recordCount>pageSize){%>
                                                                                    |<a
																						href="news_list.jsp?page=1&&news_type=<%=newsTypeId%>"
																						class="STYLE26">&lt;&lt;&nbsp;First</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

																					<a
																						href="news_list.jsp?page=<%=(pageNo-1)%>&&news_type=<%=newsTypeId%>"
																						class="STYLE26">&lt;&nbsp;Previous</a>&nbsp;&nbsp;&nbsp;&nbsp;

																					<a
																						href="news_list.jsp?page=<%=(pageNo+1)%>&&news_type=<%=newsTypeId%>"
																						class="STYLE26">Next&nbsp;&gt;</a>
																					&nbsp;&nbsp;&nbsp;&nbsp;

																					<a
																						href="news_list.jsp?page=<%=pageCount%>&&news_type=<%=newsTypeId%>"
																						class="STYLE26">Last&nbsp;&gt;&gt;</a>|
                                                                                        <%}%>
																				</div>
																			</td>
																		</tr>

																	</table>
																</td>
															</tr>
														</table>
													</TD>
												</TR>
											</TBODY>
										</TABLE>
									</TD>
								</TR>
							</TBODY>
						</TABLE>
					</TD>
				</TR>
			</TBODY>
		</TABLE>
		<%@ include file="foot.jsp"%>
	</BODY>
</HTML>