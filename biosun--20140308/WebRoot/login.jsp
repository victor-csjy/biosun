<%@page contentType="text/html;charset=utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>Welcome to Biosun Technology Co., Ltd.</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8"><LINK 
href="css/style.css" type=text/css rel=stylesheet>
 <SCRIPT src="js/js.js" type=text/javascript></SCRIPT>

<SCRIPT language=JavaScript type=text/JavaScript>
<!--
function submit_on()
 {
 if (form1.id.value.length>8)
		{
			for (i=0; i<form1.id.value.length; i++)
			  if (form1.id.value.charAt(i)=="@")
					break;
			if (i==form1.id.value.length||i==0||i==(form1.id.value.length-1))
			{
			  alert("The ID E-Mail is wrong!");
			  form1.id.focus();
			  return false;
			 }	
		}
  else
       {
        alert("Please input the ID!");
		form1.id.focus();
		return false;

        }
if (form1.id.value.length>8)
		{
			for (i=0; i<form1.id.value.length; i++)
			  if (form1.id.value.charAt(i)==".")
					break;
			if (i==form1.id.value.length||i==0||i==(form1.id.value.length-1))
			{
			  alert("The ID E-Mail is wrong!");
			  form1.id.focus();
			  return false;
			 }	
		}
		
		
if(form1.password.value.length<6)
  {
    alert("Password:6+ letter or number!");
	form1.password.value="";
	form1.password.focus();	   
	return false;
  }				
 
}
//-->
</SCRIPT>
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

.STYLE29 {color: #FFFFFF; font-weight: bold; }
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
				<%@ include file="header.jsp"%>				</TD>
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
          <TD height=6 valign="top"></TD>
          <TD width="9"></TD>
        </TR></TBODY></TABLE>
      <TABLE cellSpacing=0 cellPadding=0 width=778 align=center border=0>
        
        <TBODY>
        <TR>
          <TD width=191 height="391" vAlign=top bgcolor="#E3E9F6"><table border="0" cellpadding="0" cellspacing="0" bgcolor="#E3E9F6">
            
            
            <tr>
              <td width="191" height="183" valign="top"><div align="center">
                <table width="191" border="0" cellpadding="0" cellspacing="0">
                  
                  
                  <tr>
                    <td width="191" height="183" align="center" valign="top"><table width="191" border="0" cellpadding="0" cellspacing="0">
                      
                      <tr>
                        <td height="33" colspan="3" background="img/about-1.gif"><table width="100%" border="0" cellpadding="0" cellspacing="5">
                          <tr>
                            <td width="9%">&nbsp;</td>
                          <td width="91%"><span class="STYLE29">Home</span></td>
                        </tr>
                          </table></td>
                  </tr>
                      <tr>
                        <td width="6" background="img/a3.jpg">&nbsp;</td>
                    <td width="179" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                      <tr>
                        <td>
                          <table width="100%" border="0" cellpadding="0" cellspacing="2" bgcolor="#FFFFFF">
                            
                            <tr>
                              <td width="169" height="18" valign="top" >&nbsp;&nbsp;&nbsp;<img src="img/pc-17a.gif" width="8" height="9" /><a href="index.jsp" class="STYLE26">Home</a></td>
                            </tr>
							
							
							 <tr>
                              <td height="18" valign="top"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="img/pc-17a.gif" width="8" height="9" /><a href="index.jsp" class="STYLE26">English</a></td>
                            </tr>
                            
				<tr>
                              <td height="18" valign="top"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="img/pc-17a.gif" width="8" height="9" /><a href="index_cn.jsp" class="STYLE26">中文版</a></td>
                            </tr>
					<tr>
                              <td height="18" valign="top"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="img/pc-17a.gif" width="8" height="9" /><a href="article.jsp?articleId=21&articleType=terms_of_use" class="STYLE26">Terms of Use</a></td>
                            </tr>		
									
					     <tr>
                              <td height="18" valign="top"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="img/pc-17a.gif" width="8" height="9" /><a href="reg.jsp" class="STYLE26">New User Sign Up</a></td>
                            </tr>
							<tr>
                              <td height="18" valign="top"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="img/pc-17a.gif" width="8" height="9" /><a href="login.jsp" class="STYLE26"><font color="#FF0000"  ><strong>Sign In</strong></font></a></td>
                            </tr>
							
							<tr>
                              <td height="18" valign="top"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="img/pc-17a.gif" width="8" height="9" /><a href="change_inf.jsp" class="STYLE26">Update Information</a></td>
                            </tr>
							<tr>
                              <td height="18" valign="top"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="img/pc-17a.gif" width="8" height="9" /><a href="find_password.jsp" class="STYLE26">Forget Password</a><a href="sitemap.jsp" class="STYLE26"></a></td>
                            </tr>
							<tr>
                              <td height="18" valign="top"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="img/pc-17a.gif" width="8" height="9" /><a href="sitemap.jsp" class="STYLE26">Sitemap</a></td>
                            </tr>
                          </table>                          </td>
                        </tr>
                      </table></td>
                    <td width="7" background="img/a3.jpg">&nbsp;</td>
                  </tr>
                      <tr>
                        <td colspan="3"><img src="img/about.gif" width="191" height="8"></td>
                  </tr>
                      
                            </table></td>
                          </tr>
                    </table>
                                  
            </div></td>
                  </tr>
            <tr>
              <td height="18" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
            </tr>
            <tr>
              <td height="17"><%@ include file="left.jsp"%></td>
            </tr>
          </table></TD>
          <TD width=592 rowspan="4" vAlign=top>
            <TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
              
              <TBODY>
              <TR>
                <TD colspan="3" valign="top"><div align="right">
                  <script language="javascript">
	if (AC_FL_RunContent == 0) {
	} else {
		AC_FL_RunContent(
			'codebase', 'http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0',
			'width', '580',
			'height', '133',
			'src', 'flash/home',
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
			'movie', 'flash/home',
			'salign', ''
			); //end AC code
	}
</script>
                </div></TD>
              </TR>
              <TR>
                <TD width="174" height="63">&nbsp;</TD>
                <TD width="352">&nbsp;</TD>
                <TD width="66">&nbsp;</TD>
                </TR>
              <TR>
                <TD height="134">&nbsp;</TD>
                <TD valign="top">
                <form  name="form1" action="login_do.jsp"   method="POST"  onSubmit="return submit_on()">
				  <table width="100%" border="0" cellpadding="0" cellspacing="0" >
				      <tr>
				        <td width="61" height="21" valign="top">
				          <strong> User ID<strong>: </strong></strong>                     </td>
                  <td colspan="4"><strong>
                    <input name="id" type="text" class="STYLE23" id="id" size="35" maxlength="150">
                    </strong></td>
                </tr>
				      <tr>
				        <td height="21"><div align="left"><strong> Password<strong>:</strong></strong></div></td>
                  <td colspan="4"><strong>
                    <input name="password" type="password" class="STYLE23" id="password" size="35" maxlength="50">
                    <input name="login" type="hidden" id="login" value="go_test">
                    </strong></td>
                </tr>
				      <tr>
				        <td height="6"></td>
                  <td width="146"></td>
                  <td width="57"></td>
                  <td width="5"></td>
                  <td width="83"></td>
                </tr>
				      <tr>
				        <td height="16" colspan="3" valign="top"><div align="right" class="STYLE23"> <a href="change_password.jsp" class="STYLE26" ></a>&nbsp;<a href="find_password.jsp" class="STYLE26" >Forget Password!</a></div></td>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                </tr>
				      <tr>
				        <td height="6"></td>
                  <td></td>
                  <td></td>
                  <td></td>
                  <td></td>
                </tr>
                <tr>
                  <td height="20" colspan="2" align="center" valign="top"><a href="reg.jsp"><img src="img/up1.jpg" width="120" height="20" border="0"></a></td>
                        <td colspan="2" valign="top">
                         
						  <input name="" type="image" src="img/in.gif" />				  </td>
                  <td>&nbsp;</td>
                </tr>
				      <tr>
				        <td height="0"></td>
                  <td></td>
                  <td></td>
                  <td></td>
                  <td></td>
                </tr>
                  </table></form></TD>
                <TD>&nbsp;</TD>
                </TR>
              <TR>
                <TD height="89">&nbsp;</TD>
                <TD>&nbsp;</TD>
                <TD>&nbsp;</TD>
                </TR>
              </TBODY></TABLE></TD>
        </TR>
        </TBODY></TABLE></TD></TR>
  </TBODY></TABLE>
<%@ include file="foot.jsp"%>
</BODY></HTML>