<%@page contentType="text/html;charset=utf-8"%>
<%@page import="hk.com.biosun.model.UserInf"%>
<%@page import="hk.com.biosun.util.SessionUtil"%>
<%
UserInf  userInfSes=SessionUtil.getUserInf(request);
if(userInfSes==null){ 
   out.println("<SCRIPT LANGUAGE='JavaScript'>alert('Please Sign in！');location.href='login.jsp';</SCRIPT>");
   return; 
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE>Welcome to Biosun Technology Co., Ltd.</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<LINK 
href="css/style.css" type=text/css rel=stylesheet>
<SCRIPT src="js/js.js" type=text/javascript></SCRIPT>
<script language="javascript">
 function on_submit()
 { 
 var count=0;
 var i=0;
 
if(form1.person.value.length<3)
  {
    alert("Please input the Contact person!");
	form1.person.value="";
	form1.person.focus();	   
	return false;
  }
  
  if(form1.company.value.length<5)
  {
    alert("Please input  Company!");
	form1.company.value="";
	form1.company.focus();	   
	return false;
  }		

  if(form1.country_code.value.length<2||form1.country_code.value.length>5||isNaN(form1.country_code.value))
  {
    alert("Please input Tel Country Code!");
	form1.country_code.value="";
	form1.country_code.focus();	   
	return false;
  }	 

if(form1.area_code.value.length<2||form1.area_code.value.length>6||isNaN(form1.area_code.value))
  {
    alert("Please input Tel Area Code!");
	form1.area_code.value="";
	form1.area_code.focus();	   
	return false;
  }	
if(form1.tel.value.length<7||form1.tel.value.length>20||isNaN(form1.tel.value))
  {
    alert("Please input  Tel!");
	form1.tel.value="";
	form1.tel.focus();	   
	return false;
  }	
  
   
 if(form1.f_ccode.value.length<2||form1.f_ccode.value.length>5||isNaN(form1.f_ccode.value))
  {
    alert("Please input Fax Country Code!");
	form1.f_ccode.value="";
	form1.f_ccode.focus();	   
	return false;
  }	 


if(form1.f_ccode.value!=form1.country_code.value)
  {
    alert("The Tel's Country Code most equal the Fax'  Country Code!");
	form1.f_ccode.value="";
	form1.country_code.value="";
	form1.country_code.focus();	   
	return false;
  }	 
  
  
  
  
  
  
if(form1.f_acode.value.length<2||form1.f_acode.value.length>6||isNaN(form1.f_acode.value))
  {
    alert("Please input Fax Area Code!");
	form1.f_acode.value="";
	form1.f_acode.focus();	   
	return false;
  }	
if(form1.fax.value.length<7||form1.fax.value.length>20||isNaN(form1.fax.value))
  {
    alert("Please input  Fax!");
	form1.fax.value="";
	form1.fax.focus();	   
	return false;
  }	 


if (form1.email.value.length>8)
		{
			for (i=0; i<form1.email.value.length; i++)
			  if (form1.email.value.charAt(i)=="@")
					break;
			if (i==form1.email.value.length||i==0||i==(form1.email.value.length-1))
			{
			  alert("The  E-Mail is wrong!");
			  form1.email.focus();
			  return false;
			 }	
		}
  else
       {
        alert("Please input the email!");
		form1.email.focus();
		return false;

        }
if (form1.email.value.length>8)
		{
			for (i=0; i<form1.email.value.length; i++)
			  if (form1.email.value.charAt(i)==".")
					break;
					
			if (i==form1.email.value.length||i==0||i==(form1.email.value.length-1))
			{
			  alert("The  E-Mail is wrong!");
			  form1.email.focus();
			  return false;
			 }	
		}

if(form1.mailing_address.value.length<5)
  {
    alert("Please input  Mailing address!");
	form1.mailing_address.value="";
	form1.mailing_address.focus();	   
	return false;
  }	

if(form1.a_city.value=="")
  {
    alert("Please input  City !");
	form1.a_city.value="";
	form1.a_city.focus();	   
	return false;
  }
 if(form1.a_state.value=="")
  {
    alert("Please input  State !");
	form1.a_state.value="";
	form1.a_state.focus();	   
	return false;
  }
  
 if(form1.a_zip.value=="")
  {
    alert("Please input  Zip !");
	form1.a_zip.value="";
	form1.a_zip.focus();	   
	return false;
  }   	
if(form1.a_country.value=="")
  {
    alert("Please input  Country !");
	form1.a_country.value="";
	form1.a_country.focus();	   
	return false;
  }  
  
  

  
if(form1.im1.checked)
  {
    count++;
  }
if(form1.im2.checked)
  {
    count++;
  } 
  
  if(form1.re.checked)
  {
    count++;
  }  
 if(form1.bu.checked)
  {
    count++;
  }
 if(form1.br.checked)
  {
    count++;
  }  
if(form1.pr.checked)
  {
    count++;
  }
if(form1.ot.checked)
  {
    count++;
  }  

if(count>3||count<1)
  {
    alert("The maximum is 3 and the least is 1 !");
   form1.di.focus();		 
	return false;
  } 
  
   
if(form1.ot.checked&&form1.other.value=="")
  {
    alert("The other cann't be empty!");
   form1.other.focus();		 
	return false;
  }
      
   
}

function on_reset()
 { 
  
 form1.reset();  
  
}



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


		
  
}

function f_on_reset()
{
f_p.reset();  
}
  </script>
<style type="text/css">
<!--
body {
	background-color: #FFFFFF;
}
.STYLE23 {font-family: "Times New Roman", Times, serif; font-size: 9pt; }
.STYLE27 {
	color: #73B549;
	font-weight: bold;
}
.STYLE37 {font-size: 9pt}
.STYLE42 {font-size: 9pt; font-weight: bold; }
.STYLE44 {font-family: "Times New Roman", Times, serif}
.STYLE26 {font-family: "Times New Roman", Times, serif; font-size: 9pt; color: #000000; }
.STYLE34 {color: #999999}
.STYLE29 {color: #FFFFFF; font-weight: bold; }
-->
</style>
</HEAD>
<BODY>
<TABLE width=778 border=0 align=center cellPadding=0 cellSpacing=0 bgcolor="#FFFFFF">
  <TBODY>
    <TR>
      <TD width="779" height="16" valign="top"><%@ include file="header.jsp"%></TD>
    </TR>
    <TR>
      <TD height="881" valign="top"><TABLE cellSpacing=0 cellPadding=0 width=778 align=center border=0>
          <TBODY>
            <TR>
              <TD height=6><IMG height=1 
      width=1></TD>
            </TR>
          </TBODY>
        </TABLE>
        <TABLE cellSpacing=0 cellPadding=0 width=778 align=center border=0>
          <TBODY>
            <TR>
              <TD width=191 height="36" vAlign=top bgcolor="#E3E9F6"><table width="191" border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td width="191" height="201" valign="top"><table border="0" cellpadding="0" cellspacing="0" bgcolor="#E3E9F6">
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
                                              <td><table width="100%" border="0" cellpadding="0" cellspacing="2" bgcolor="#FFFFFF">
                                                  <tr>
                                                    <td width="169" height="18" valign="top" >&nbsp;&nbsp;&nbsp;<img src="img/pc-17a.gif" width="8" height="9" /><a href="index.jsp" class="STYLE26">Home</a></td>
                                                  </tr>
                                                  <tr>
                                                    <td height="18" valign="top">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="img/pc-17a.gif" width="8" height="9" /><a href="index.jsp" class="STYLE26">English</a></td>
                                                  </tr>
                                                  <tr>
                                                    <td height="18" valign="top">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="img/pc-17a.gif" width="8" height="9" /><a href="index_cn.jsp" class="STYLE26">中文版</a></td>
                                                  </tr>
                                                  <tr>
                                                    <td height="18" valign="top">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="img/pc-17a.gif" width="8" height="9" /><a href="article.jsp?articleId=21&articleType=terms_of_use" class="STYLE26">Terms of Use</a></td>
                                                  </tr>
                                                  <tr>
                                                    <td height="18" valign="top">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="img/pc-17a.gif" width="8" height="9" /><a href="reg.jsp" class="STYLE26">New User Sign Up</a></td>
                                                  </tr>
                                                  <tr>
                                                    <td height="18" valign="top">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="img/pc-17a.gif" width="8" height="9" /><a href="login.jsp" class="STYLE26">Sign In</a></td>
                                                  </tr>
                                                  <tr>
                                                    <td height="18" valign="top">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="img/pc-17a.gif" width="8" height="9" /><a href="change_inf.jsp" class="STYLE26"><font color="#FF0000"  ><strong>Update Information</strong></font></a></td>
                                                  </tr>
                                                  <tr>
                                                    <td height="18" valign="top">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="img/pc-17a.gif" width="8" height="9" /><a href="find_password.jsp" class="STYLE26">Forget Password</a><a href="sitemap.jsp" class="STYLE26"></a></td>
                                                  </tr>
                                                  <tr>
                                                    <td height="18" valign="top">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="img/pc-17a.gif" width="8" height="9" /><a href="sitemap.jsp" class="STYLE26">Sitemap</a></td>
                                                  </tr>
                                                </table></td>
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
                      </table></td>
                  </tr>
                  <tr>
                    <td height="17"><%@ include file="left.jsp"%></td>
                  </tr>
                </table></TD>
              <TD width="587" rowspan="2" vAlign=top><table cellspacing=0 cellpadding=0 width="100%" border=0>
                  <tbody>
                    <tr>
                      <td><div align="right">
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
                        </div></td>
                    </tr>
                    <tr>
                      <td class=MainText valign=top>&nbsp;</td>
                    </tr>
                    <tr>
                      <td class=MainText valign=top><table width="580" border="0" align="right" cellpadding="0" cellspacing="3">
                          <tr>
                            <td width="3%" height="30"><div align="left"><img src="img/dian.gif" width="15" height="15"></div></td>
                            <td width="191"><span class="STYLE27">Update Information</span></td>
                            <td width="368" align="right"><span class="STYLE34">You are here</span> <STRONG>:</STRONG><a href="index.jsp" class="STYLE26">Home</a>--<a href="#"  class="STYLE26">Update Information</a> </td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr>
                      <td class=MainText valign=top><div align="right"><img src="img/pc-16.gif" width="580" height="3"></div></td>
                    </tr>
                    <tr>
                      <td height="50"><form  name="f_p" action="pw_do.jsp"   method="POST"  onSubmit="return f_p_on()">
                          <table width="580" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                              <td width="48" height="21">&nbsp;</td>
                              <TD width="69">&nbsp;</TD>
                              <TD width="94">&nbsp;</TD>
                              <TD width="240">&nbsp;</TD>
                              <TD width="106">&nbsp;</TD>
                            </tr>
                            <tr>
                              <td width="48" height="21">&nbsp;</td>
                              <TD colspan="2" align="left" valign="top"><strong>User ID<strong>: </strong></strong></TD>
                              <TD colspan="2" align="left" valign="top"><strong>
                                <input name="change_id" type="text" class="STYLE23" id="change_id" value="<% if(userInfSes!=null)out.print(userInfSes.getId()); %>" size="25" maxlength="150">
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
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                              <td></td>
                              <td></td>
                            </tr>
                            <tr>
                              <td height="27"></td>
                              <td>&nbsp;</td>
                              <TD colspan="2" align="center" valign="top"><input name="change_pw" type="hidden" id="change_pw" value="change_ok">
                                <img src="img/s1.gif" width="96" height="24" style="CURSOR:pointer;" 
                        onClick="javascript:f_on_reset()"> &nbsp;&nbsp;&nbsp;
                                <input name="" type="image" src="img/s.gif" />
                              </TD>
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
                          <div align="right"></div>
                        </form></td>
                    </tr>
                    <tr>
                      <td height=659 valign="top"><form  name="form1" action="change_inf_do.jsp"   method="POST"  onSubmit="return on_submit()">
                          <table width="580" border=0 align="right" cellpadding=0 cellspacing=5>
                            <tr>
                              <td height="90" colspan=3 valign="top">Note: Biosun would like to occasionally send you
                                information about special offerings, products and services. Please
                                indicate below whether you would like to receive these updates.
                                <table  border=0 cellspacing=0 cellpadding=0>
                                  <tr>
                                    <td><INPUT name="send" TYPE="CHECKBOX" id="send" value="1" <%if(userInfSes.getSend().equals("1"))out.print("checked");%>>
                                    </td>
                                    <td><p><b >Yes, please have Biosun send me updates via e-mail.</td>
                                  </tr>
                                </table></td>
                            </tr>
                            <tr>
                              <td height="35" colspan=3 valign="top">Member Information:</td>
                            </tr>
                            <tr class="STYLE37">
                              <td width="99">&nbsp;</td>
                              <td colspan="2">Mr.
                                <INPUT name="sex" TYPE="RADIO" value="1" <%if("1".equals(userInfSes.getSex()))out.print("checked");%>>
                                Ms.
                                <INPUT name="sex" TYPE="RADIO" value="0"  <%if("0".equals(userInfSes.getSex()))out.print("checked");%>>
                                <script language="JavaScript">
                                 <!--
                               form1.sex.value="<%=userInfSes.getSex()%>"
                                     //-->
                               </script>
                              </td>
                            </tr>
                            <tr class="STYLE37">
                              <td>Contact person:</td>
                              <td colspan="2"><INPUT name="person" TYPE="TEXT" id="person"  value="<%=userInfSes.getPerson()%>" maxlength="40">
                                &nbsp;**&nbsp;</td>
                            </tr>
                            <tr class="STYLE37">
                              <td>Job title:</td>
                              <td colspan="2" ><INPUT name="job_title" TYPE="TEXT" id="job_title" value="<%=userInfSes.getJobTitle()%>" maxlength="150">
                              </td>
                            </tr>
                            <tr class="STYLE37">
                              <td>Company:</td>
                              <td colspan="2" ><INPUT name="company" TYPE="TEXT" id="company" value="<%=userInfSes.getCompany()%>" maxlength="200">
                                &nbsp;** </td>
                            </tr>
                            <tr class="STYLE37">
                              <td >Tel:</td>
                              <td colspan="2" ><table  border=0 cellpadding=0>
                                  <tr>
                                    <td class="STYLE44">Country<br>
                                      Code</td>
                                    <td class="STYLE44"><INPUT name="country_code" TYPE="TEXT" id="country_code" value="<%=userInfSes.getCountryCode()%>" size="8" maxlength="5">
                                    </td>
                                    <td class="STYLE44">Area<br>
                                      Code</td>
                                    <td class="STYLE44"><INPUT name="area_code" TYPE="TEXT" id="area_code" value="<%=userInfSes.getAreaCode()%>" size="8" maxlength="4">
                                    </td>
                                    <td class="STYLE44">-</td>
                                    <td class="STYLE44"><INPUT name="tel" TYPE="TEXT" id="tel" value="<%=userInfSes.getTel()%>" size="15" maxlength="20">
                                      &nbsp;** </td>
                                  </tr>
                                </table></td>
                            </tr>
                            <tr>
                              <td class="STYLE37" >Fax:</td>
                              <td colspan="2" class="STYLE23" ><table  border=0 cellpadding=0>
                                  <tr>
                                    <td>Country<br>
                                      Code</td>
                                    <td><INPUT name="f_ccode" TYPE="TEXT" id="f_ccode" value="<%=userInfSes.getFCcode()%>" size="8" maxlength="5">
                                    </td>
                                    <td>Area<br>
                                      Code</td>
                                    <td><INPUT name="f_acode" TYPE="TEXT" id="f_acode" value="<%=userInfSes.getFAcode()%>" size="8" maxlength="4">
                                    </td>
                                    <td >-</td>
                                    <td><INPUT name="fax" TYPE="TEXT" id="fax" value="<%=userInfSes.getFax()%>" size="15" maxlength="20">
                                      &nbsp;** </td>
                                  </tr>
                                </table></td>
                            </tr>
                            <tr>
                              <td class="STYLE37" >Email:</td>
                              <td colspan="2" class="STYLE37" ><INPUT name="email" TYPE="TEXT" id="email" value="<%=userInfSes.getEmail()%>" maxlength="150">
                                &nbsp;** </td>
                            </tr>
                            <tr>
                              <td class="STYLE23" >Messenger:</td>
                              <td colspan="2" class="STYLE37" ><INPUT name="ms" TYPE="TEXT" id="ms" value="<%=userInfSes.getMs()%>" maxlength="100">
                                (MSN,Skype or Yahoo prefered!) </td>
                            </tr>
                            <tr class="STYLE37">
                              <td >Website:</td>
                              <td colspan="2" ><INPUT name="website" TYPE="TEXT" id="website" value="<%=userInfSes.getWebsite()%>" maxlength="150">
                              </td>
                            </tr>
                            <tr style='mso-yfti-irow:9'>
                              <td class="STYLE37" ><p align=left>Mailing address:</td>
                              <td colspan="2" class="STYLE37" ><INPUT name="mailing_address" TYPE="TEXT" id="mailing_address" value="<%=userInfSes.getMailingAddress()%>" maxlength="200">
                                ** </td>
                            </tr>
                            <tr>
                              <td class="STYLE37" >City:</td>
                              <td colspan="2" class="STYLE37" ><INPUT name="a_city" TYPE="TEXT" id="a_city" value="<%=userInfSes.getACity()%>" maxlength="100">
                                ** <span class="STYLE37">State:</span>
                                <INPUT name="a_state" TYPE="TEXT" id="a_state" value="<%=userInfSes.getAState()%>" size="18" maxlength="100">
                                **</td>
                            </tr>
                            <tr>
                              <td class="STYLE37" >Zip:</td>
                              <td colspan="2" class="STYLE37" ><INPUT name="a_zip" TYPE="TEXT" id="a_zip" value="<%=userInfSes.getAZip()%>" maxlength="100">
                                ** Country:
                                <INPUT name="a_country" TYPE="TEXT" id="a_country" value="<%=userInfSes.getACountry()%>" size="16" maxlength="100">
                                **</td>
                            </tr>
                            <tr>
                              <td valign=top class="STYLE23" >&nbsp;</td>
                              <td colspan="2" class="STYLE23" ><input name="di" type="radio" value="distributor" 
							<%if(!"".equals(userInfSes.getDi()))out.print("checked");%>>
                                distributor
                                <input name="di" type="radio" value="manufacturer" 
							<%if(!"".equals(userInfSes.getMa()))out.print("checked");%>>
                                manufacturer
                                <input name="di" type="radio" value="end user" 
							<%if(!"".equals(userInfSes.getEn()))out.print("checked");%>>
                                end user <br>
                                <INPUT name="im1" TYPE="CHECKBOX" id="im1" value="importer/exporter"
								  <%if(!"".equals(userInfSes.getIm1()))out.print("checked");%>	>
                                importer/exporter<br>
                                <INPUT name="im2" TYPE="CHECKBOX" id="im2" value="importer"
								  <%if(!"".equals(userInfSes.getIm2()))out.print("checked");%>	>
                                importer<br>
                                <INPUT name="re" TYPE="CHECKBOX" id="re" value="retailer"
								  <%if(!"".equals(userInfSes.getRe()))out.print("checked");%>	>
                                retailer<br>
                                <INPUT name="bu" TYPE="CHECKBOX" id="bu" value="buying agent"
								  <%if(!"".equals(userInfSes.getBu()))out.print("checked");%>>
                                buying agent<br>
                                <INPUT name="br" TYPE="CHECKBOX" id="br" value="broker"
								  <%if(!"".equals(userInfSes.getBr()))out.print("checked");%>>
                                broker<br>
                                <INPUT name="pr" TYPE="CHECKBOX" id="pr" value="promotion house"
								  <%if(!"".equals(userInfSes.getPr()))out.print("checked");%>>
                                promotion house<br>
                                <span>
                                <INPUT name="ot" TYPE="CHECKBOX" id="ot" value="others"
								  <%if(!"".equals(userInfSes.getOt()))out.print("checked");%> >
                                </span>others
                                &nbsp;&nbsp;<span>
                                <INPUT name="other" TYPE="TEXT" id="other" 
 value="<%if(!"".equals(userInfSes.getOt()))out.print(userInfSes.getOt().replaceAll("others:",""));%>" maxlength="194">
                              </td>
                            </tr>
                            <tr>
                              <td height="14" colspan=3 valign="top"></td>
                            </tr>
                            <tr>
                              <td height="27" colspan=2 align="center" valign="top"><input name="change_yes" type="hidden" id="change_yes" value="change_yes">
                                <img src="img/s1.gif" width="96" height="24" style="CURSOR:pointer;" 
                        onClick="javascript:on_reset()"> <span> &nbsp;&nbsp;&nbsp;
                                <input name="" type="image" src="img/s.gif" />
                                </span></td>
                              <td width="1">&nbsp;</td>
                            </tr>
                            <tr>
                              <td height="3"></td>
                              <td width="460"></td>
                              <td></td>
                            </tr>
                          </table>
                        </form></td>
                    </tr>
                  </tbody>
                </table></TD>
            </TR>
          </TBODY>
        </TABLE></TD>
    </TR>
  </TBODY>
</TABLE>
<%@ include file="foot.jsp"%>
</BODY>
</HTML>
