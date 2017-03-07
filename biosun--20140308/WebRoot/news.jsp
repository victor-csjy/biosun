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
NewsType newsType;
NewsTypeService newsTypeService=new NewsTypeService();
List<NewsType> newsTypeList=newsTypeService.getList();
int newsTypeListSize=newsTypeList!=null?newsTypeList.size():0;

if(newsTypeListSize<1){ 
    out.println("<SCRIPT LANGUAGE='JavaScript'>alert('No Class！');location.href='index.jsp';</SCRIPT>");
    return; 
}

NewsTableService  newsTableService=new NewsTableService();
NewsTable newsTable;
List<NewsTable> newsTableList;
int newsTableListSize=0;

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML xmlns:asp xmlns:uc1><HEAD><TITLE>Welcome to Biosun Technology Co., Ltd.</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8"><LINK 
href="css/style.css" type=text/css rel=stylesheet>
 <SCRIPT src="js/js.js" type=text/javascript></SCRIPT>
<script>
function showsubmenu(sid)
{
	whichEl = document.getElementById("submenu" + sid);
	menuTitle = document.getElementById("menuTitle" + sid);
	change_bg = document.getElementById("change_bg" + sid);
	
	if (whichEl.style.display == "none")
	{
	whichEl.style.display="block";
	change_bg.background="img/arrow.jpg";
	}
	else
	{
	whichEl.style.display="none";
	change_bg.background="img/plus.jpg";
	}
}
</script>



<META content="MSHTML 6.00.3790.2541" name=GENERATOR>
<style type="text/css">
<!--
.STYLE11 {color: #838383}
body {
	background-color: #FFFFFF;
}
.STYLE12 {color: #FFFFFF}
.STYLE13 {font-size: 12px; color: #333333; }
.STYLE14 {color: #000000}
.STYLE15 {color: #003366}
.STYLE23 {font-family: "Times New Roman", Times, serif; font-size: 9pt; }
.STYLE24 {
	color: #666666;
	font-weight: bold;
}
.STYLE26 {font-family: "Times New Roman", Times, serif; font-size: 9pt; color: #000000; }
.STYLE27 {
	color: #73B549;
	font-weight: bold;
}
.STYLE29 {color: #FFFFFF; font-weight: bold; }
.STYLE30 {font-size: 12px}
.STYLE8 {	font-size: 12px;
	color: #666666;
	font-weight: bold;
}
.STYLE31 {color: #666666; }
.STYLE33 {font-size: 16px}
.STYLE34 {color: #999999}
-->
</style>
</HEAD>
<BODY>
  






 
<TABLE width=778 border=0 align=center cellPadding=0 cellSpacing=0 bgcolor="#FFFFFF">
  <TBODY>
  <TR>
    <TD>
     

      <TABLE cellSpacing=0 cellPadding=0 width=778 align=center border=0>
        <TBODY>
        <TR>
          <TD><TABLE cellSpacing=0 cellPadding=0 width=778 align=center 
border=0>
            <TBODY>
              <TR>
                <TD width=778  valign="bottom"><%@ include file="header.jsp"%></TD>
              </TR>
            </TBODY>
          </TABLE></TD>
          </TR>
        </TBODY></TABLE></TD></TR>
  <TR>
    <TD>
      <TABLE cellSpacing=0 cellPadding=0 width=778 align=center border=0>
        <TBODY>
        <TR>
          <TD height=6><IMG height=1 
      width=1></TD>
        </TR></TBODY></TABLE>
      <TABLE cellSpacing=0 cellPadding=0 width=778 align=center border=0>
        
        <TBODY>
        <TR>
          <TD width=191 vAlign=top bgcolor="#E3E9F6"><%@ include file="news_inc.jsp"%>
            <%@ include file="left.jsp"%></TD>
          <TD width=605 rowspan="3" vAlign=top>
            <TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
              <TBODY>
              <TR>
                <TD><div align="right"><script language="javascript">
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
                </div></TD>
              </TR>
              <TR>
                <TD class=MainText vAlign=top>&nbsp;</TD>
              </TR>
              <TR>
                <TD class=MainText vAlign=top><table width="580" border="0" align="right" cellpadding="0" cellspacing="3">
                  
                  <tr>
                    <td width="3%" height="16"><div align="left"><img src="img/dian.gif" width="15" height="15"></div></td>
                    <td width="64" valign="top"><span class="STYLE27">Events</span></td>
                    <td width="482" align="right" valign="top"><span class="STYLE34">You are here</span> <STRONG>:</STRONG><a href="index.jsp" class="STYLE26">Home</a>--<span class="STYLE30"><a href="news.jsp" class="STYLE26">Events</a></span></td>
                  </tr>
                </table></TD>
              </TR>
              <TR>
                <TD class=MainText vAlign=top><div align="right"><img src="img/pc-16.gif" width="580" height="3"></div></TD>
              </TR>
              
              <TR>
                <TD height=5 valign="top"><table width="550" border="0" align="right" cellpadding="8" cellspacing="0">
                  <tbody>
                    <tr>
                      <td class="hanggao">
					  <%
						for(int i=0;i<newsTypeListSize;i++){
						  newsType=newsTypeList.get(i);
						%>
						     
                      
                          <table cellspacing="5" cellpadding="0" width="560" border="0">
                            <tbody>
                              <tr>
                                <td></td>
                                <td></td>
                              </tr>
                              
							  
							  <tr id="menuTitle<%=i%>" onClick="showsubmenu(<%=i%>)" style="cursor:pointer;">
							  
                                <td id="change_bg<%=i%>" valign="center"  width="17" height="18" background="img/arrow.jpg"></td>
						
                                <td style="FONT-SIZE: 10pt"><b>
								<%=StrUtil.toHtmlTag(newsType.getNewsName())%></b></td>
                                <td width="56"><div align="center">
<a 
 href="news_list.jsp?news_type=<%=newsType.getNewsType()%>">
<img  height="13" src="img/more.gif" width="53" 
                        border="0" /></a></div></td>
                              </tr>
							  
                              <tr>
                                <td bgcolor="#73B549" colspan="3"><img height="1" src="" 
                        width="1" /></td>
                              </tr>
                            </tbody>
                          </table>
						  
						<div id="submenu<%=i%>" style="DISPLAY: yes"> 
						  
                        <table cellspacing="0" cellpadding="0" width="500" align="center" 
                  border="0">
                            <tbody>
                            
			 <%
			 
			 newsTableList=newsTableService.getListFront(newsType.getNewsType(),10,1);
			 newsTableListSize=newsTableList!=null?newsTableList.size():0;
			 for(int j=0;j<newsTableListSize;j++){
			     newsTable=newsTableList.get(j);
			 %>
			           <tr>
                                <td width="500" height="30"><a href="news_show.jsp?news_type=<%=newsTable.getNewsType()%>&&news_id=<%=newsTable.getNewsId()%>" class="STYLE26">&nbsp;&nbsp;&nbsp;&nbsp;·
                              <%=StrUtil.fomatStr(StrUtil.toHtmlTag(newsTable.getNewsTitle()),70)%>
                                </a>&nbsp;&nbsp;[<%=DateUtil.getDateStr(newsTable.getNewsDate())%>]</td>
                              </tr>
                              <tr>
                                <td height="1" background="img/line_03.gif"></td>
                              </tr>
						<%}%>	  
                            </tbody>
                          </table>
						</div>  
				<% }%></td>
                    </tr>
                  </tbody>
				  
                </table></TD>
              </TR>
              </TBODY></TABLE></TD>
        </TR>
          </TBODY></TABLE></TD></TR>
  </TBODY></TABLE>
<%@ include file="foot.jsp"%></BODY></HTML>