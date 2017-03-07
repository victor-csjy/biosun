<%@page contentType="text/html;charset=utf-8"%>
<%@page import="com.aokle.util.StrUtil"%>
<%@page import="hk.com.biosun.model.Article"%>
<%@page import="hk.com.biosun.service.ArticleService"%>
<%@page import="hk.com.biosun.define.ArticleTypeDef"%>
<%
ArticleService articleService=new ArticleService();
Article article=articleService.getByPKFront(27,"reg");
String flashName=ArticleTypeDef.getArticleTypeFlashName("reg");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML xmlns:asp xmlns:uc1><HEAD><TITLE>Welcome to Biosun Technology Co., Ltd.</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8"><LINK 
href="css/style.css" type=text/css rel=stylesheet>
<SCRIPT src="js/js.js" type=text/javascript></SCRIPT>

<script language="javascript">
 function chkitem(str)
{
	var strSource ="0123456789";
  var ch;
  var i;
  var temp;

  for (i=1;i<=(str.length-1);i++)
   {

    ch = str.charAt(i);
    temp = strSource.indexOf(ch);
    if (temp==-1)
    {
     return true;
    }
   }
  return false;
}
 
 function on_submit()
 { 
 var count=0;
 var i=0;
 if(form1.term_check[1].checked)
  {
    alert("You don't agree to the Terms!");   
	return false;
  }
 
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
if(form1.password2.value.length<6)
  {
    alert("Confirmation:6+ letter or number!");
	form1.password2.value="";
	form1.password2.focus();	   
	return false;
  }	  
 if(form1.password2.value!=form1.password.value)
  {
    alert("Password is wrong!");
	form1.password.value="";	
	form1.password2.value="";
	form1.password.focus();
	   
	return false;
  }	 
   
if(form1.question.value=="")
  {
    alert("Please input the Password question!");
	form1.question.value="";
	form1.question.focus();	   
	return false;
  }	
 
if(form1.answer.value=="")
  {
    alert("Please input the Password question Answer!");
	form1.answer.value="";
	form1.answer.focus();	   
	return false;
  }	

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

  if(form1.country_code.value.length<2||form1.country_code.value.length>5||chkitem(form1.country_code.value))
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
if(form1.tel.value.length<7||form1.tel.value.length>20)
  {
    alert("Please input  Tel!");
	form1.tel.value="";
	form1.tel.focus();	   
	return false;
  }	
  
   
 if(form1.f_ccode.value.length<2||form1.f_ccode.value.length>5||chkitem(form1.f_ccode.value))
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
if(form1.fax.value.length<7||form1.fax.value.length>20)
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

if(count>2)
  {
    alert("Choices number in Business Type should be no more than 3 items!");
   form1.im1.focus();		 
	return false;
  } 
  
   
if(form1.ot.checked&&form1.other.value=="")
  {
    alert("The other cann't be empty!");
   form1.other.focus();		 
	return false;
  }   

if(form1.in_check[0].checked&&form1.invoice.value=="")
  {
    alert("Please input the Invoice Number!");
   form1.invoice.focus();		 
	return false;
  }  

if(form1.in_check[1].checked)
  {
    form1.invoice.value==""
  } 
  
 
 if(form1.other_ms.value.length>10000)
   {
    alert("The Other message  is too long!");
   form1.other_ms.focus();		 
	return false;
  }   


}

function on_reset()
 { 
  
 form1.reset();  
  
}
</script>
<style type="text/css">
<!--
.STYLE37 {font-size: 12}
.STYLE38 {font-size: 18px}
-->
</style>
</HEAD>
<BODY>
  <TABLE width=778 border=0 align=center cellPadding=0 cellSpacing=0 bgcolor="#FFFFFF">
    
  <TBODY>
  <TR>
    <TD width="778" height="16" valign="top"><%@ include file="header.jsp"%></TD>
  </TR>
  <TR>
    <TD >
      <TABLE cellSpacing=0 cellPadding=0 width=778 align=center border=0>
        <TBODY>
        <TR>
          <TD height=6></TD>
        </TR></TBODY></TABLE>
      <TABLE cellSpacing=0 cellPadding=0 width=778 align=center border=0>
        <TBODY>
        <TR>
          <TD width="191" vAlign=top bgcolor="#E3E9F6"><table width="191" border="0" cellpadding="0" cellspacing="0">
            
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
                    <td><table width="179" border="0" cellpadding="0" cellspacing="2" bgcolor="#FFFFFF">
                            
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
                              <td height="18" valign="top"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="img/pc-17a.gif" width="8" height="9" /><a href="reg.jsp" class="STYLE26"><font color="#FF0000"  ><strong>New User Sign Up</strong></font></a></td>
                            </tr>
							
							
							<tr>
                              <td height="18" valign="top"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="img/pc-17a.gif" width="8" height="9" /><a href="login.jsp" class="STYLE26">Sign In</a></td>
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
                          </table></td>
                  </tr>
              </table></td>
              <td width="6" background="img/a3.jpg">&nbsp;</td>
            </tr>
            <tr>
              <td colspan="3"><img src="img/about.gif" width="191" height="8"></td>
            </tr>
          </table>
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
            
            <tr>
              <td width="191" height="18" valign="top">&nbsp;</td>
            </tr>
            <tr>
              <td height="18" valign="top"><%@ include file="left.jsp"%></td>
            </tr>
          </table></TD>
          <TD width="592" rowspan="2" vAlign=top><div align="right">
		  	  <form  name="form1" action="reg_do.jsp"   method="POST"  onSubmit="return submit_on()">

            <table width="580" border=0 align="right" cellpadding=0 cellspacing=0>
              
              <tbody>
                <tr>
                  <td height="133" colspan="3"><div align="right"><script language="javascript">
	if (AC_FL_RunContent == 0) {
	} else {
		AC_FL_RunContent(
			'codebase', 'http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0',
			'width', '580',
			'height', '133',
			'src', 'flash/<%=flashName%>',
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
			'movie', 'flash/<%=flashName%>',
			'salign', ''
			); //end AC code
	}
</script>
                  </div></td>
                </tr>
                <tr>
                  <td width="25" height="16" valign=top class=MainText>&nbsp;</td>
                  <td width="519" valign=top class=MainText>&nbsp;</td>
                  <td width="37" valign=top class=MainText>&nbsp;</td>
                </tr>
                <tr>
                  <td height="36" colspan="3" valign=top class=MainText><table width="580" border="0" align="right" cellpadding="0" cellspacing="3">
                      
                      <tr>
                        <td width="3%" height="30"><div align="left"><img src="img/dian.gif" width="15" height="15"></div></td>
                        <td width="191"><span class="STYLE27">User Registration</span></td>
                        <td width="368" align="right"><span class="STYLE34">You are here</span> <STRONG>:</STRONG><a href="index.jsp" class="STYLE26">Home</a>--<a href="#"  class="STYLE26">User Registration</a> </td>
                      </tr>
                  </table></td>
                </tr>
                <tr>
                  <td height="3" colspan="3" valign=top class=MainText><div align="right"><img src="img/pc-16.gif" width="580" height="3"></div></td>
                </tr>
                <tr>
                  <td height="16" colspan="3" valign=top class=MainText><div align="right"></div></td>
                </tr>
                <tr>
                  <td height="16" valign=top class=MainText>&nbsp;</td>
                  <td valign=top class=MainText>&nbsp;</td>
                  <td valign=top class=MainText>&nbsp;</td>
                </tr>
                <tr>
                  <td height="19" colspan="3" valign=top><table width="100%" border="0" cellpadding="0" cellspacing="0">
                      <tr>
                        <td><strong>Before you make below registration, please read and agree below Terms of User: </strong></td>
                      </tr>
                  </table></td>
                </tr>
                <tr>
                  <td height="107" colspan="3" valign=top align="center"><table width="90%" border="1" cellpadding="0" cellspacing="0" >
                      
                      <tr>
                        <td width="540" height="107" align="center" valign=top><div style="width:520px;height:107;overflow:scroll"><%=article!=null?StrUtil.toHtmlTag(article.getContent()):"Read Error!!!"%></div></td>
                      </tr>
                  </table></td>
                </tr>
                <tr>
                  <td height="16">&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td height="58">&nbsp;</td>
                  <td valign=top class=MainText><table  border=0 cellspacing=0 cellpadding=0>
                      <tr >
                        <td width="24" height="20" valign="top">
                            <input name="term_check" type="radio" value="1" checked>
                            </td>
                        <td width="488" valign="top">Yes, I have read it and I agree to be a
                          registered user of Biosun services</td>
                      </tr>
                      <tr>
                        <td height="20" valign="top"><input type="radio" name="term_check" value="0"></td>
                        <td valign="top">No, I don't agree and will give up
                          registrating as a user of Biosun services.</td>
                      </tr>
                      <tr>
                        <td height="18" colspan="2" valign="top">&nbsp;</td>
                      </tr>
                  </table></td>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td height="16">&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr>
                  <td  colspan="3" valign="top"><table width="100%" border=0 align="right" cellpadding=0 cellspacing=0 
     >
                      
					  <tr >
                        <td colspan=2>&nbsp;&nbsp;(** means required field.) </td>
                        <td>&nbsp;</td>
                      </tr>
					  
					    <tr >
                                  <td width="37%" 

height="50">&nbsp;&nbsp;<strong>Member ID</strong><br>
                                    

&nbsp;&nbsp;(Only&nbsp;valid&nbsp;email&nbsp;is&nbsp;acceptable!):</td>
                                  <td width="63%"><INPUT name="id" 

TYPE="TEXT" id="id" size="25" maxlength="150">
                                      &nbsp;**</td>
                                </tr>
                                <tr>
                                  <td width="37%" 

height="50"><strong>&nbsp;&nbsp;Password </strong><br>
                                  &nbsp;&nbsp;(6+ letter or number!):</td>
                                  <td width="63%"><INPUT name="password" 

TYPE="password" id="password" size="25" maxlength="120">
                                     **</td>
                                </tr>
                                <tr>
                                  <td width="37%" 

height="26"><strong>&nbsp;&nbsp;Confirmation</strong></td>
                                  <td width="63%"><INPUT name="password2" 

TYPE="password" id="password2" size="25"></td>
                                </tr>
                                <tr>
                                  <td width="37%" 

height="50"><strong>&nbsp;&nbsp;Password
                                    question</strong><br>
                                  &nbsp;&nbsp;(In Case You Forget Password!):</td>
                                  <td width="63%"><INPUT name="question" 

TYPE="TEXT" id="question" size="25" maxlength="100">
								  **</td>
                                </tr>
                                <tr>
                                  <td width="37%" 

height="26"><strong>&nbsp;&nbsp;Answer</strong>:</td>
                                  <td width="63%"><INPUT name="answer" 

TYPE="TEXT" id="answer" size="25" maxlength="100">
								  **		

						  </td>
                                </tr>
                                <tr>
                                  <td width="100%" height="60" colspan=2 

><strong>&nbsp;&nbsp;Note: Biosun would like to occasionally send you
                                    information about special offerings, 

products and &nbsp;&nbsp;services. Please
                                    indicate below whether you would like 

to receive these updates. </strong>
                                    <table width="535"  border=0 

cellpadding=0 cellspacing=0
         >
                                        <tr>
                                          <td width="30" height="30">&nbsp;&nbsp;
                                          <INPUT name="send" 

TYPE="CHECKBOX" id="send" value="1"></td>
                                          <td width="288"><strong>Yes, please have 

Biosun send me updates via
                                            e-mail.</strong></td>
                                        </tr>
                                    </table>                             

      </td>
                                </tr>
                                <tr>
                                  <td width="37%" >&nbsp;</td>
                                  <td width="63%" >&nbsp;</td>
                                </tr>
                      <tr >
                        <td colspan=2><span class="STYLE38">&nbsp;&nbsp;Member Information:&nbsp;</span></td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr class="STYLE37" >
                        <td width="151">&nbsp;</td>
                        <td width="401"><strong>Mr.</strong>
                          <INPUT name="sex" TYPE="RADIO" value="1" checked>
                          <strong>                          Ms.                          </strong>
                          <INPUT name="sex" TYPE="RADIO" value="0">                         </td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr class="STYLE37" >
                        <td height="26"><strong>&nbsp;&nbsp;Contact person:</strong></td>
                        <td><INPUT name="person" TYPE="TEXT" id="person" maxlength="40">
                          &nbsp;&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr class="STYLE37">
                        <td height="26"><strong>&nbsp;&nbsp;Job title:</strong></td>
                        <td><INPUT name="job_title" TYPE="TEXT" id="job_title" maxlength="150">
                           </td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr class="STYLE37" style='mso-yfti-irow:4'>
                        <td height="26"><strong>&nbsp;&nbsp;Company:</strong></td>
                        <td><INPUT name="company" TYPE="TEXT" id="company" maxlength="200">
                          &nbsp;**</td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr class="STYLE37">
                        <td><strong>&nbsp;&nbsp;Tel:</strong></td>
                        <td><table  border=0 cellpadding=0 >
                            <tr >
                              <td class="STYLE44" ><strong>Country<br>
                                Code</strong></td>
                              <td class="STYLE44" ><INPUT name="country_code" TYPE="TEXT" id="country_code" value="+" size="8" maxlength="5"></td>
                              <td class="STYLE44" ><strong>Area<br>
                                Code</strong></td>
                              <td class="STYLE44"><INPUT name="area_code" TYPE="TEXT" id="area_code" size="8" maxlength="4"></td>
                              <td class="STYLE44">-</td>
                              <td class="STYLE44" >
                                  <INPUT name="tel" TYPE="TEXT" id="tel" size="15" maxlength="20">
                                &nbsp;**
                                </td>
                            </tr>
                          </table>
                            </td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td><strong>&nbsp;&nbsp;Fax:</strong></td>
                        <td><table  border=0 cellpadding=0 >
                            <tr>
                              <td><strong>Country<br>
                                Code</strong></td>
                              <td><INPUT name="f_ccode" TYPE="TEXT" id="f_ccode" value="+" size="8" maxlength="5">
                                 </td>
                              <td><strong>Area<br>
                                Code</strong></td>
                              <td><INPUT name="f_acode" TYPE="TEXT" id="f_acode" size="8" maxlength="4">
                                 </td>
                              <td >-</td>
                              <td><INPUT name="fax" TYPE="TEXT" id="fax" size="15" maxlength="20">
                                &nbsp;**</td>
                            </tr>
                          </table>
                           </td>
                        <td width="21">&nbsp;</td>
                      </tr>
                      <tr>
                        <td height="26" ><strong>&nbsp;&nbsp;Email:</strong></td>
                        <td><INPUT name="email" TYPE="TEXT" id="email" maxlength="150">
                          &nbsp;**
                         </td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td height="26" ><strong>&nbsp;&nbsp;Messenger:&nbsp;&nbsp;</strong></td>
                        <td >(MSN,Skype or Yahoo prefered!)
                        </td>
                        <td rowspan="2"></td>
                      </tr>
                      <tr >
                        <td height="26"><strong>&nbsp;&nbsp;Website:</strong></td>
                        <td><INPUT name="website" TYPE="TEXT" id="website" maxlength="150">
                        </td>
                      </tr>
                      <tr>
                        <td height="26"><strong>&nbsp;&nbsp;Mailing
                          address:</strong></td>
                        <td><INPUT name="mailing_address" TYPE="TEXT" id="mailing_address" maxlength="200">
                          **</td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td height="26"><strong>&nbsp;&nbsp;City:</strong></td>
                        <td class="STYLE37"><INPUT name="a_city" TYPE="TEXT" id="a_city" maxlength="100">
						** <strong>State:</strong>
                              <INPUT name="a_state" TYPE="TEXT" id="a_state" size="18" maxlength="100">
                           **</td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td height="26"><strong>&nbsp;&nbsp;Zip:</strong></td>
                        <td><INPUT name="a_zip" TYPE="TEXT" id="a_zip" maxlength="100">
						**
						<INPUT name="a_country" TYPE="TEXT" id="a_country" size="16" maxlength="100"></td>
                        <td>&nbsp;</td>
                       </tr>
                      <tr>
                        <td height="26" class="STYLE38">&nbsp;&nbsp;Business Type:</td>
                       
                        <td rowspan="2" class="STYLE23"><input name="di" type="radio" value="distributor" checked>
                           <strong>distributor</strong>
                           <input type="radio" name="di" value="manufacturer">
                           <strong>                              manufacturer</strong>
							  <input type="radio" name="di" value="end user">
							  <strong>end user</strong> <br>
                              <INPUT name="im1" TYPE="CHECKBOX" id="im1" value="importer/exporter">
                              <strong>                                importer/exporter</strong><br>
                                <INPUT name="im2" TYPE="CHECKBOX" id="im2" value="importer">
                                <strong>                                importer</strong><br>
                                <INPUT name="re" TYPE="CHECKBOX" id="re" value="retailer">
                                <strong>                                retailer</strong><br>
                                <INPUT name="bu" TYPE="CHECKBOX" id="bu" value="buying agent">
                                <strong>                                buying agent</strong><br>
                                <INPUT name="br" TYPE="CHECKBOX" id="br" value="broker">
                                <strong>broker</strong><br>
                                <INPUT name="pr" TYPE="CHECKBOX" id="pr" value="promotion house">
                                <strong>promotion house</strong><br>
                               
                                  <INPUT name="ot" TYPE="CHECKBOX" id="ot" value="others">
                                  <strong> others</strong>                                &nbsp;&nbsp;
                                              <INPUT name="other" TYPE="TEXT" id="other" maxlength="194">
                                </td> <td rowspan="2">&nbsp;</td>
                     </tr>
                      <tr>
                        <td height="180">&nbsp;</td>
                      </tr>
                      <tr>
                        <td colspan="2" class="STYLE37"></td>
                        <td rowspan="2">&nbsp;</td>
                      </tr>
                      <tr class="STYLE37" >
                        <td colspan="2">
                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                              <tr>
                                <td width="41%" height="26" class="STYLE44"><strong>&nbsp;&nbsp;Dealed With Biosun Before?</strong></td>
                                <td width="59%" class="STYLE44"><input name="in_check" type="radio" value="1">
                                  <strong>YES</strong>
								  <input name="in_check" type="radio" value="0" checked>
                                  <strong>NO</strong> ** &nbsp;</td>
                              </tr>
                            </table>
                          <table width="100%" border="0" cellpadding="0" cellspacing="0">
                              <tr>
                                <td width="41%" height="50" class="STYLE44"><strong>&nbsp;&nbsp;If yes,
                                  please fill in the Invoice Number &nbsp;&nbsp;(Biosun opened to you): </strong></td>
                                <td width="59%" class="STYLE44"><INPUT name="invoice" TYPE="TEXT" id="invoice" maxlength="100">
                                  </td>
                              </tr>
                            </table>
                         </td>
                      </tr>
                      <tr>
                        <td colspan=2 class="STYLE23"><table  border=0 cellspacing=0 cellpadding=0
       >
                            <tr >
                              <td width=1>&nbsp;</td>
                              <td width=460 height="50" ><strong>&nbsp;&nbsp;Other message
                                  (Brief introduction of your business, your cooperation intention etc,
                                  &nbsp;&nbsp;below 10KB. ):</strong></td>
                            </tr>
                            <tr>
                              <td width=1 >&nbsp;</td>
                              <td width=460 ><TEXTAREA name="other_ms" cols="70" rows="8" id="other_ms"></TEXTAREA></td>
                            </tr>
                          </table>
                           &nbsp;
                          <table width="524"  border=0 cellpadding=0 cellspacing=0 >
                              <tr>
                                <td align="center"><input name="reg_go" type="hidden" id="reg_go" value="ok">
                                    <img src="img/s1.gif" width="96" height="24" style="CURSOR:pointer;" 
                        onClick="javascript:on_reset()"> &nbsp;&nbsp;&nbsp;
                                    <input name="Input" type="image" src="img/s.gif" />
                                  </td>
                              </tr>
                          </table></td>
                        <td>&nbsp;</td>
                      </tr>
                  </table></td>
                </tr>
              </tbody>
            </table>
			</form>          </div></TD>
        </TR>
        </TBODY></TABLE></TD></TR>
</TBODY></TABLE>
  
  <%@ include file="foot.jsp"%>
</BODY></HTML>


