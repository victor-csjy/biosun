<%@page contentType="text/html;charset=utf-8"%>
<%@page import="hk.com.biosun.model.BigTable"%>
<%@page import="hk.com.biosun.model.SmallTable"%>
<%@page import="hk.com.biosun.service.BigTableService"%>
<%@page import="hk.com.biosun.service.SmallTableService"%>
<%
BigTableService bigTableService=new BigTableService();
BigTable bigTable;
List<BigTable> bigTableList=bigTableService.getListFront();
int bigTableListSize=bigTableList!=null?bigTableList.size():0;

SmallTableService smallTableService=new SmallTableService();
SmallTable smallTable;
List<SmallTable> smallTableList=null;
int smallTableListSize=0;
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
                                        
                                        <% for(int i=0;i<bigTableListSize;i++){
                                              bigTable=bigTableList.get(i);
                                        %>	
                                        
                                        <table width="100%" border="0" cellpadding="0" cellspacing="2">
                                          <tr>
                                            <td width="18%"><div align="center"><img src="img/pc-14.gif" width="14" height="15">&nbsp;&nbsp;</div></td>
                                            <td width="82%"><a href="product_big.jsp?big_id=<%=bigTable.getBigId()%>" class="STYLE26"><%=bigTable.getBigName()%></a></td>
                                          </tr>
                                          <tr>
                                            <td colspan="2"><img src="img/0-1.gif" width="170" height="11"></td>
                                          </tr>
                                          </table>
								      <%}%>                                                               </td>
                                    </tr>
                                    </table></td>
                                  <td width="6" background="img/a3.jpg">&nbsp;</td>
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
			'src', 'flash/products',
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
			'movie', 'flash/products',
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
                    <td width="14%"><span class="STYLE27">Products</span></td>
                    <td width="471" valign="top"><div align="right"><span class="STYLE34">You are here</span> <STRONG>:</STRONG><a href="index.jsp" class="STYLE26">Home</a>--<span class="STYLE30"><a href="products.jsp" class="STYLE26">Products</a></span></div></td>
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
                                        <% for(int i=0;i<bigTableListSize;i++){
                                              bigTable=bigTableList.get(i);
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
								<%=bigTable.getBigName()%></b></td>
                                <td width="56"><div align="center">
<a href="product_big.jsp?big_id=<%=bigTable.getBigId()%>">

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
              smallTableList=smallTableService.getListFront(bigTable.getBigId());
              smallTableListSize=smallTableList!=null?smallTableList.size():0;
              for(int j=0;j<smallTableListSize;j++){
                  smallTable=smallTableList.get(j);
			 %>
			           <tr>
                                <td class="wordtext" width="30" height="30"><img height="23" 
                        src="img/lo1.gif" width="26" /></td>
                                <td><a 
                        href="product_list.jsp?big_id=<%=smallTable.getBigId()%>&&small_id=<%=smallTable.getSmallId()%>" class="STYLE26">
						<%=smallTable.getSmallName()%></a></td>
                              </tr>
                              <tr>
                                <td background="img/line_03.gif" colspan="2"><img 
                        height="1" src="img/line_03.gif" width="3" /></td>
                              </tr>
						<%}%>	  
                            </tbody>
                          </table>
						</div>  
				<%}%>                     </td>
                    </tr>
                  </tbody>
                </table></TD>
              </TR>
              </TBODY></TABLE></TD>
  </TR></TBODY></TABLE></TD></TR></TBODY></TABLE>
<%@ include file="foot.jsp"%>
</BODY></HTML>