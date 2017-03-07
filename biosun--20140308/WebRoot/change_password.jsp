<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="com.aokle.util.StrUtil"%>
<%@page import="hk.com.biosun.model.Article"%>
<%@page import="hk.com.biosun.service.ArticleService"%>
<%@page import="hk.com.biosun.model.NewsType"%>
<%@page import="hk.com.biosun.service.NewsTypeService"%>
<%@page import="hk.com.biosun.model.UserInf"%>
<%@page import="hk.com.biosun.service.BigTableService"%>
<%@page import="hk.com.biosun.service.SmallTableService"%>
<%@page import="hk.com.biosun.service.NewsTableService"%>
<%@page import="hk.com.biosun.model.NewsTable"%>
<%
NewsTableService newsTableService=new NewsTableService();
List<NewsTable>  newsTableList=newsTableService.getListFront(-1,1,100,1);
int newsTableListSize=newsTableList!=null?newsTableList.size():0;
NewsTable newsTable;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>Welcome to Biosun Technology Co., Ltd.</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<LINK href="css/style.css" type=text/css rel=stylesheet>
<SCRIPT language=JavaScript type=text/JavaScript>
<!--
function f_p_on()
 {
 if (f_p.change_id.value.length>8)
		{
			for (i=0; i<f_p.change_id.value.length; i++)
			  if (f_p.change_id.value.charAt(i)=="@")
					break;
			if (i==f_p.change_id.value.length||i==0||i==(f_p.change_id.value.length-1))
			{
			  alert("The ID E-Mail is wrong!");
			  f_p.change_id.focus();
			  return false;
			 }	
		}
  else
       {
        alert("Please input the ID!");
		f_p.change_id.focus();
		return false;

        }
if (f_p.change_id.value.length>8)
		{
			for (i=0; i<f_p.change_id.value.length; i++)
			  if (f_p.change_id.value.charAt(i)==".")
					break;
			if (i==f_p.change_id.value.length||i==0||i==(f_p.change_id.value.length-1))
			{
			  alert("The ID E-Mail is wrong!");
			  f_p.change_id.focus();
			  return false;
			 }	
		}
if(f_p.old_pw.value.length<6)
  {
    alert("Password:6+ letter or number in the Old Password!");
	f_p.old_pw.value="";
	f_p.old_pw.focus();	   
	return false;
  }			
		
if(f_p.news1.value.length<6)
  {
    alert("Password:6+ letter or number in the News Password!");
	f_p.news1.value="";
	f_p.news1.focus();	   
	return false;
  }	
  		
if(f_p.news2.value.length<6)
  {
    alert("Password:6+ letter or number in the Confirmation!");
	f_p.news2.value="";
	f_p.news2.focus();	   
	return false;
  }	

if(f_p.news2.value!=f_p.news1.value)
  {
    alert("Password  is  wrong!");	
	f_p.news1.value="";
	f_p.news2.value="";
	f_p.news1.focus();	   
	return false;
  }	


		
   f_p.submit(); 
}

function f_on_reset()
{
f_p.reset();  
}
//-->
</SCRIPT>

<META content="MSHTML 6.00.3790.2541" name=GENERATOR>
<style type="text/css">
<!--
.STYLE6 {
	color: #878a8e;
	font-size: 12;
}
.STYLE9 {font-size: 12px}
.STYLE11 {color: #838383}
body {
	background-color: #FFFFFF;
}
.STYLE12 {color: #FFFFFF}
.STYLE13 {font-size: 12px; color: #333333; }
.STYLE14 {color: #000000}
.STYLE15 {color: #003366}
.STYLE16 {
	font-size: 16pt;
	font-weight: bold;
	color: #878a8e;
	font-family: "Times New Roman", Times, serif;
}
.STYLE20 {font-family: "Times New Roman", Times, serif; font-size: 14px; }
.STYLE23 {font-family: "Times New Roman", Times, serif; font-size: 9pt; }
.STYLE24 {
	color: #666666;
	font-weight: bold;
}

.STYLE26 {font-family: "Times New Roman", Times, serif; font-size: 9pt; color: #000000; }
.STYLE30 {font-size: 12px}
.STYLE31 {	color: #FFFFFF;
	font-size: 14px;
	font-weight: bold;
}
-->
</style>
</HEAD>
<BODY>
  






 
<TABLE width=778 border=0 align=center cellPadding=0 cellSpacing=0 bgcolor="#FFFFFF">
  <TBODY>
  <TR>
    <TD><TABLE cellSpacing=0 cellPadding=0 width=778 align=center border=0>
        <TBODY>
        <TR>
          <TD><TABLE cellSpacing=0 cellPadding=0 width=778 align=center 
border=0>
            <TBODY>
              <TR>
                <TD width=778  valign="bottom">
				
				<%@ include file="header.jsp"%>
				</TD>
              </TR>
              <TR>
                <TD width=778 bgColor=#ffffff height=6></TD>
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
          <TD height=12></TD></TR></TBODY></TABLE>
      <TABLE cellSpacing=0 cellPadding=0 width=778 align=center border=0>
        
        <TBODY>
        <TR>
          <TD width=191 height="221" vAlign=top bgcolor="#E3E9F6"><table width="191" border="0" cellpadding="0" cellspacing="0">
            
            
            <tr>
              <td height="195" valign="top"><div align="center">
                <table border="0" cellpadding="0" cellspacing="0">
                  
                  
                  <tr>
                    <td height="193" valign="top"><table width="100%" height="16" border="0" cellpadding="0" cellspacing="0">
                      
                      <tr>
                        <td><table width="191" border="0" cellpadding="0" cellspacing="0">
                          <tr>
                            <td width="191" height="33" background="img/about-1.gif"><div align="right">
                              <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                  <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
                                    <tr>
                                      <td width="29%"><div align="right" class="STYLE31">News</div></td>
                                      <td width="68%"><div align="right"><span class="STYLE12"><img src="img/07.jpg" width="18" height="16"><a href="news.jsp">more...&nbsp;</a>&nbsp;&nbsp;&nbsp;</span></div></td>
                                    </tr>
                                  </table></td>
                                </tr>
                                </table>
                                          </div></td>
                                      </tr>
                          <tr>
                            <td height="130" background="img/a3.jpg"><table width="94%" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
                              <tr>
                                <td height="130" valign="top" bgcolor="#FFFFFF"><MARQUEE id=news onmouseover=news.stop() 
                              onmouseout=news.start() scrollAmount=2 
                              direction=up width="100%" height=168>
                                  <table width="100%" border="0" cellpadding="0" cellspacing="5">
                                    <%
                                       for(int i=0;i<newsTableListSize;i++){
                                        newsTable=newsTableList.get(i);
                                        %>									
                                    <tr>
                                      <td colspan="2"><span class="STYLE30"><a href="news_show.jsp?news_type=<%=newsTable.getNewsType()%>&&news_id=<%=newsTable.getNewsId()%>" class="STYLE26">·
<%=StrUtil.fomatStr(StrUtil.toHtmlTag(newsTable.getNewsTitle()),25)%></a></span></td>
                            </tr>
                                    <%}%>    
                                    </table>
                                                </MARQUEE></td>
                                            </tr>
                              </table></td>
                                      </tr>
                          <tr>
                            <td><img src="img/about.gif" width="191" height="8"></td>
                                      </tr>
                          </table></td>
                                </tr>
                      
                      
                                          </table>                        </td>
                          </tr>
                    </table>
                              
              </div></td>
                  </tr>
            <tr>
              <td height="26"><%@ include file="left.jsp"%></td>
            </tr>
            
            
          </table></TD>
          <TD rowspan="3" vAlign=top>
            <TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
              
              <TBODY>
              <TR>
                <TD height="133" colspan="3"><div align="right">
                  <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0" width="580" height="133">
                    <param name="movie" value="img/flash.swf">
                    <param name="quality" value="high">
                    <param name="wmode" value="transparent">
                    <embed src="img/flash.swf" width="580" height="133" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" wmode="transparent"></embed>
                  </object>
                </div></TD>
              </TR>
              <TR>
                <TD width="43" height=17>&nbsp;</TD>
                <TD width="510">&nbsp;</TD>
                <TD width="21">&nbsp;</TD>
              </TR>
              <TR>
                <TD height=30 colspan="3" valign="top"><table width="580" border="0" align="right" cellpadding="0" cellspacing="0">
                  
                  
                    <tr>
                      <td width="3%" height="30"><div align="left"><img src="img/dian.gif" width="15" height="15"></div></td>
                      <td width="191"><span class="STYLE27">Change Password</span></td>
                      <td width="368" align="right">
                          <span class="STYLE34">You are here</span> <STRONG>:</STRONG><a href="index.jsp" class="STYLE26">Home</a>--<a href="#"  class="STYLE26">Change Password</a> </td>
                      </tr>
                </table>                </TD>
              </TR>
              <TR>
                <TD height=3 colspan="3" valign="top"><div align="right"><img src="img/pc-16.gif" width="580" height="3"></div></TD>
                </TR>
              <TR>
                <TD height=43>&nbsp;</TD>
                <TD>&nbsp;</TD>
                <TD>&nbsp;</TD>
              </TR>
              <TR>
                <TD height=107>&nbsp;</TD>
                <TD valign="top">
				
				
				 <form  name="f_p" action="pw_do.jsp"   method="POST"  >  
				  <table width="100%" border="0" cellpadding="0" cellspacing="0">
				    
				    <tr>
				      <td width="48" height="21">&nbsp;</td>
				        <TD colspan="2" align="left" valign="top"><strong>User ID<strong>: </strong></strong></TD>
                      <TD colspan="2" align="left" valign="top"><strong>
                        <input name="change_id" type="text" class="STYLE23" id="change_id" 
value="<% if(session.getAttribute("user_mail")!=null)out.print((String)session.getAttribute("user_mail")); %>" size="25" maxlength="150">
                        </strong></TD>
                      </tr>
				    <tr>
				      <td height="22"></td>
				      <td colspan="2" valign="top"><strong>Old Password <strong>: </strong></strong></td>
				      <td colspan="2" valign="top"><strong>
				        <input name="old_pw" type="password" class="STYLE23" id="old_pw" size="25" maxlength="150">
				        </strong>(6+ letter or number!)</td>
				      </tr>
					
					
					<tr>
				      <td height="22"></td>
				      <td colspan="2" valign="top"><strong>News Password <strong>: </strong></strong></td>
				      <td colspan="2" valign="top"><strong>
				        <input name="news1" type="password" class="STYLE23" id="news1" size="25" maxlength="150">
				        </strong>(6+ letter or number!)</td>
				      </tr>
					
					
					
					
					<tr>
				      <td height="22"></td>
				      <td colspan="2" valign="top"><strong><SPAN lang="EN-US">Confirmation</SPAN><strong>: </strong></strong></td>
				      <td colspan="2" valign="top"><strong>
				        <input name="news2" type="password" class="STYLE23" id="news2" size="25" maxlength="150">
				        </strong>(6+ letter or number!)</td>
				      </tr>
					
					
					
				    <tr>
				      <td height="23"></td>
				      <td width="62">&nbsp;</td>
				      <td width="84">&nbsp;</td>
				      <td width="220"></td>
				      <td width="96"></td>
				      </tr>
				    <tr>
				      <td height="27"></td>
				      <td>&nbsp;</td>
				      <TD colspan="2" align="center" valign="top">
                            <input name="change_pw" type="hidden" id="change_pw" value="change_ok">
                            <img src="img/s1.gif" width="96" height="24" style="CURSOR:pointer;" 
                        onClick="javascript:f_on_reset()"> &nbsp;&nbsp;&nbsp;
                            
                            <img src="img/s.gif" width="96" height="24" style="CURSOR:pointer;" 
                        onClick="javascript:f_p_on()"> </TD>
                          <td></td>
				      </tr>
				    <tr>
				      <td height="14"></td>
				      <td>&nbsp;</td>
				      <td>&nbsp;</td>
				      <td></td>
				      <td></td>
				      </tr>
				      </table>
					  </form>					  </TD>
                <TD>&nbsp;</TD>
              </TR>
              </TBODY></TABLE></TD>
        </TR>
        </TBODY></TABLE></TD></TR>
  </TBODY></TABLE>
<%@ include file="foot.jsp"%>
</BODY></HTML>