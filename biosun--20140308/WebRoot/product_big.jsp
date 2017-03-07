<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="com.aokle.util.StrUtil"%>
<%@page import="com.aokle.util.DateUtil"%>
<%@page import="hk.com.biosun.model.Article"%>
<%@page import="hk.com.biosun.service.ArticleService"%>
<%@page import="hk.com.biosun.model.NewsType"%>
<%@page import="hk.com.biosun.service.NewsTypeService"%>
<%@page import="hk.com.biosun.model.BigTable"%>
<%@page import="hk.com.biosun.service.BigTableService"%>
<%@page import="hk.com.biosun.model.SmallTable"%>
<%@page import="hk.com.biosun.service.SmallTableService"%>
<%@page import="com.aokle.util.MathUtil"%>
<%
int bigId=MathUtil.toInt(request.getParameter("big_id"));
BigTableService bigTableService=new BigTableService();
BigTable bigTable=bigTableService.getByPKFront(bigId);
if(bigTable==null){
    out.println("<SCRIPT LANGUAGE='JavaScript'>alert('Parameter Error！');location.href='products.jsp';</SCRIPT>");
    return; 
}
List<BigTable> bigTableList=bigTableService.getListFront();
int bigTableListSize=bigTableList!=null?bigTableList.size():0;
BigTable bigTableTmp;

SmallTableService smallTableService=new SmallTableService();
SmallTable smallTable;
List<SmallTable> smallTableList=smallTableService.getListFront(bigId);
int smallTableListSize=smallTableList!=null?smallTableList.size():0;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML xmlns:asp xmlns:uc1><HEAD><TITLE>Welcome to Biosun Technology Co., Ltd.</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8"><LINK 
href="css/style.css" type=text/css rel=stylesheet>
 <SCRIPT src="js/js.js" type=text/javascript></SCRIPT>
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
          <TD width="778" height="16" valign="top"><%@ include file="header.jsp"%></TD>
        </TR>
        </TBODY></TABLE></TD></TR>
  <TR>
    <TD>
      <TABLE cellSpacing=0 cellPadding=0 width=778 align=center border=0>
        <TBODY>
        <TR>
          <TD height=6></TD>
        </TR></TBODY></TABLE>
      <TABLE cellSpacing=0 cellPadding=0 width=778 align=center border=0>
        <TBODY>
        <TR>
          <TD width=191 vAlign=top bgcolor="#E3E9F6"><table border="0" cellpadding="0" cellspacing="0">
            
            
            <tr>
              <td height="125" valign="top"><div align="center">
                <table border="0" cellpadding="0" cellspacing="0">
                  
                  
                  <tr>
                    <td height="112" valign="top"><table width="100%" height="16" border="0" cellpadding="0" cellspacing="0">
                      
                      <tr>
                        <td><table width="191" border="0" cellpadding="0" cellspacing="0">
                          <tr>
                            <td height="33" colspan="3" background="img/about-1.gif"><table width="100%" border="0" cellpadding="0" cellspacing="5">
                              <tr>
                                <td width="9%">&nbsp;</td>
                                      <td width="91%"><span class="STYLE29">Products </span></td>
                                    </tr>
                              </table></td>
                                </tr>
                          <tr>
                            <td width="6" background="img/a3.jpg">&nbsp;</td>
                                  <td width="179" valign="top"><table width="179" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
                                    <tr>
                                      <td>
                                        
                                        <%
                                        for(int i=0;i<bigTableListSize;i++){
                                           bigTableTmp=bigTableList.get(i);
                                        %>                                        
                                        <table width="100%" border="0" cellpadding="0" cellspacing="2">
                                          <tr>
                                            <td width="18%"><div align="center"><img src="img/pc-14.gif" width="14" height="15">&nbsp;&nbsp;</div></td>
                                            <td width="82%"><a href="product_big.jsp?big_id=<%=bigTableTmp.getBigId()%>" class="STYLE26">
											
										
	<%if(bigTableTmp.getBigId()== bigId){%>
	<font color="#FF0000"  >
	<strong><%=StrUtil.toHtmlTag(bigTableTmp.getBigName())%></strong></font>	
	<%}
	else {%><%=StrUtil.toHtmlTag(bigTableTmp.getBigName())%><%}%>
	
	
	
		
											
											</a></td>
                                          </tr>
                                          <tr>
                                            <td colspan="2"><img src="img/0-1.gif" width="170" height="11"></td>
                                          </tr>
                                          </table>
										  
								        <%}%>                                                          </td>
                                    </tr>
                                    </table></td>
                                  <td width="7" background="img/a3.jpg">&nbsp;</td>
                                </tr>
                          <tr>
                            <td colspan="3"><img src="img/about.gif" width="191" height="8"></td>
                                </tr>
                          </table></td>
                            </tr>
                      
                      

                        </table></td>
                      </tr>
					  <tr>
                    <td height="9" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                        </tr>
					  <tr>
					    <td height="9" valign="top"><%@ include file="left.jsp"%></td>
					    </tr>
                    </table>
                    
            </div></td>
            </tr>
          </table>            </TD>
          <TD vAlign=top width=592>
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
			'src', 'flash/<%=bigId%>',
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
			'movie', 'flash/<%=bigId%>',
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
                    <td width="16" height="18"><div align="left"><img src="img/dian.gif" width="15" height="15"></div></td>
                    <td width="168" valign="top"><span class="STYLE27"><%=StrUtil.toHtmlTag(bigTable.getBigName())%></span></td>
                    <td width="384" valign="top"><div align="right"><span class="STYLE34">You are here</span> <STRONG>:</STRONG><a href="index.jsp" class="STYLE26">Home</a>--<span class="STYLE30"><a href="products.jsp" class="STYLE26">Products</a></span>
                      --<span class="STYLE30"><a href="#" class="STYLE26">
                        <%=StrUtil.toHtmlTag(bigTable.getBigName())%></a></span> </div></td>
                    </tr>
                </table></TD>
              </TR>
              <TR>
                <TD class=MainText vAlign=top><div align="right"><img src="img/pc-16.gif" width="580" height="3"></div></TD>
              </TR>
              <TR>
                <TD class=MainText vAlign=top>&nbsp;</TD>
              </TR>
              <TR>
                <TD height=5 valign="top"><table width="550" border="0" align="right" cellpadding="8" cellspacing="0">
                  <tbody>
                    <tr>
                      <td class="hanggao">
                          
						 <%if(!"".equals(StrUtil.toHtmlTag(bigTable.getContent()))){%> 
						  <table cellspacing="0" cellpadding="0" width="560" border="0">
                            
                            <tbody>
                              
                              <tr>
                                <td width="10" height="18">&nbsp;</td>
                                <td colspan="2" valign="top" style="FONT-SIZE: 10pt"><b>
								Brief Introduction</b></td>
                                <td width="60">&nbsp;</td>
                                <td width="20">&nbsp;</td>
                              </tr>
                              
							  
                              <tr>
                                <td height="1" colspan="5" bgcolor="#73B549"><img height="1" src="" 
                        width="1" /></td>
                              </tr>
							  
							 <tr>
                                <td colspan="2" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
							   <td  colspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                                 <tr>
                                   <td>&nbsp;</td>
                                 </tr>
                                 <tr>
                                   <td><%=StrUtil.toHtmlTag(bigTable.getContent())%></td>
                                 </tr>
                                 <tr>
                                   <td>&nbsp;</td>
                                 </tr>
                               </table>							   </td>
							   <td valign="top" ><!--DWLayoutEmptyCell-->&nbsp;</td>
							   </tr>
							 
							 <tr>
							   <td height="0"></td>
							   <td width="10"></td>
							   <td width="460"></td>
							   <td></td>
							   <td></td>
							 </tr>
							  
							  
							  <tr>							  </tr>
                            </tbody>
                          </table>
						  
						<%}%>
						
						<table cellspacing="0" cellpadding="0" width="560" border="0">
                            
                            <tbody>
                              <tr>
                                <td width="10" height="18">&nbsp;</td>
                                <td width="470" valign="top" style="FONT-SIZE: 10pt"><b>
								<%=StrUtil.toHtmlTag(bigTable.getBigName())%></b></td>
                                <td width="80">&nbsp;</td>
                              </tr>
                                                            
                              
							  
                              <tr>
                                <td height="1" colspan="5" bgcolor="#73B549"><img height="1" src="" 
                        width="1" /></td>
                              </tr>
                            </tbody>
                          </table>
						  
						  
						  
                        <table cellspacing="0" cellpadding="0" width="521" align="center" 
                  border="0">
                            <tbody>
                            
<%
for(int i=0;i<smallTableListSize;i++){
   smallTable=smallTableList.get(i);
%>
			           <tr>
                                <td class="wordtext" width="30" height="30"><img height="23" 
                        src="img/lo1.gif" width="26" /></td>
                                <td width="484"><a 
                        href="product_list.jsp?big_id=<%=smallTable.getBigId()%>&&small_id=<%=smallTable.getSmallId()%>" class="STYLE26">
						<%=StrUtil.toHtmlTag(smallTable.getSmallName())%></a></td>
                              </tr>
                              <tr>
                                <td background="img/line_03.gif" colspan="2"><img 
                        height="1" src="img/line_03.gif" width="3" /></td>
                              </tr>
						<%}%>	  
                            </tbody>
                          </table>                     </td>
                    </tr>
                  </tbody>
                </table></TD>
              </TR>
              </TBODY></TABLE></TD>
        </TR></TBODY></TABLE></TD></TR>
  </TBODY></TABLE>
<%@ include file="foot.jsp"%>
</BODY></HTML>