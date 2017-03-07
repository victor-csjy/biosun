<%@page contentType="text/html;charset=utf-8"%>
<%@page import="hk.com.biosun.util.SessionUtil"%>
<%@page import="hk.com.biosun.service.CartService"%>
<%@page import="hk.com.biosun.define.ProductCart"%>
<%@page import="hk.com.biosun.model.ProductsTable"%>
<%
if(SessionUtil.getUserInf(request)==null){ 
  out.println("<SCRIPT LANGUAGE='JavaScript'>alert('You must Sign in before send the enquiry!');location.href='login.jsp';</SCRIPT>");      
  return;
}
CartService cartService = SessionUtil.getCartService(request);
if (cartService == null) {
	out.println("<SCRIPT LANGUAGE='JavaScript'>alert('System Error!Please try it again later!');location.href='products.jsp';</SCRIPT>");
	return;
}
ProductCart productCart;
List<ProductsTable> productsList=cartService.getListProductsTable();
int productsListSize=productsList!=null?productsList.size():0;
if(productsListSize<1){
      out.println("<SCRIPT LANGUAGE='JavaScript'>alert('Your Enquiry Basket Is Empty!');javascript:history.back(-1);</SCRIPT>");
      return;
}	
ProductsTable productsTable;
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
 if(form1.order_s.checked)
  {
    if(form1.p_id_s.value==""){alert("Please type in item no.!");
	                           form1.p_id_s.focus();
	                           return false;
	                           }   
	if(form1.account_inf[3].checked&&form1.other_txt.value=="")
	                          {alert("Please input your courier account information!");
							  form1.other_txt.value=="";
	                           form1.other_txt.focus();
	                           return false;
	                           } 
  }
   
}

function on_reset(){ 
 form1.reset();  
}
</script>
<style type="text/css">
<!--
body {
	background-color: #FFFFFF;
}
.STYLE27 {
	color: #73B549;
	font-weight: bold;
}
.STYLE26 {font-family: "Times New Roman", Times, serif; font-size: 9pt; color: #000000; }
.STYLE29 {color: #FFFFFF; font-weight: bold; }
.STYLE36 {
	font-size: 12pt;
	font-weight: bold;
}
-->
</style>
</HEAD>
<body>
<TABLE width=778 border=0 align=center cellPadding=0 cellSpacing=0 bgcolor="#FFFFFF">
  <TBODY>
    <TR>
      <TD width="778" height="16" valign="top"><%@ include file="header.jsp"%></TD>
    </TR>
    <TR>
      <TD><TABLE cellSpacing=0 cellPadding=0 width=778 align=center border=0>
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
              <TD width=191 height="1065" valign="top" bgcolor="#E3E9F6"><table border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td width="191" height="31" colspan="2" valign="top"><table width="191" border="0" cellpadding="0" cellspacing="0">
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
                                      <td height="18" valign="top">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="img/pc-17a.gif" width="8" height="9" /><a href="sitemap.jsp" class="STYLE26">Sitemap</a></td>
                                    </tr>
                                    <tr>
                                      <td height="18" valign="top">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="img/pc-17a.gif" width="8" height="9" /> <a href="article.jsp?articleId=21&articleType=terms_of_use" class="STYLE26">Terms of Use</a></td>
                                    </tr>
                                    <tr>
                                      <td height="18" valign="top">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="img/pc-17a.gif" width="8" height="9" /> <a href="reg.jsp" class="STYLE26">New User Sign Up</a></td>
                                    </tr>
                                    <tr>
                                      <td height="18" valign="top">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="img/pc-17a.gif" width="8" height="9" /> <a href="login.jsp" class="STYLE26">Sign In</a></td>
                                    </tr>
                                    <tr>
                                      <td height="18" valign="top">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="img/pc-17a.gif" width="8" height="9" /> <a href="change_inf.jsp" class="STYLE26">Update Info</a></td>
                                    </tr>
                                  </table></td>
                              </tr>
                            </table></td>
                          <td width="7" background="img/a3.jpg">&nbsp;</td>
                        </tr>
                        <tr>
                          <td colspan="3"><img src="img/about.gif" width="191" height="8"></td>
                        </tr>
                      </table>
                      <table width="100%" border="0" cellpadding="0" cellspacing="0">
                        <tr>
                          <td width="191" height="18" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                        </tr>
                        <tr>
                          <td height="18" valign="top"><%@ include file="left.jsp"%></td>
                        </tr>
                      </table></td>
                  </tr>
                </table></TD>
              <TD rowspan="3" vAlign=top><table cellspacing=0 cellpadding=0 width="100%" border=0>
                  <tbody>
                    <tr>
                      <td width=""><div align="right">
                          <script language="javascript">
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
                        </div></td>
                    </tr>
                    <tr>
                      <td class=MainText valign=top>&nbsp;</td>
                    </tr>
                    <tr>
                      <td class=MainText valign=top><table width="580" border="0" align="right" cellpadding="0" cellspacing="3">
                          <tr>
                            <td width="3%" height="16"><div align="left"><img src="img/dian.gif" width="15" height="15"></div></td>
                            <td width="17%"><span class="STYLE27">Enquiry Details</span></td>
                            <td width="449" valign="top"><div align="right">
                                <div align="right"><span class="STYLE34">You are here</span> <STRONG>:</STRONG><a href="index.jsp" class="STYLE26">Home</a>--<a href="#"  class="STYLE26">Enquiry Details</a> </div>
                              </div></td>
                          </tr>
                        </table></td>
                    </tr>
                    <tr>
                      <td class=MainText valign=top><div align="right"><img src="img/pc-16.gif" width="580" height="3"></div></td>
                    </tr>
                    <tr>
                      <td class=MainText valign=top><div align="right"></div></td>
                    </tr>
                    <tr>
                      <td class=MainText valign=top>&nbsp;</td>
                    </tr>
                  
                    <tr>
                      <td valign=top class=MsoNormal STYLE36>
					  
					  <form  name="form1" action="equiry_do.jsp"   method="POST" onSubmit="return on_submit()">
					  <table width="100%" border="0" cellpadding="0" cellspacing="0">
                       
					    <tr>
                          <td><table width="459" border=0 align="center" cellpadding=0 cellspacing=0 >
                              <tr>
                                <td><span class="STYLE36">1. I am interested in - </span></td>
                              </tr>
                              <tr>
                                <td height="16"></td>
                              </tr>
                            </table>
                            <br/>
                            <table width="80%" border=1 align="center" cellpadding=0 cellspacing=0   bordercolordark="#FFFFFF"  bordercolor="#B2C0EF">
                              <tr >
                                <td align="center" valign="middle" width="8%">Item No.</td>
                                <td align="center" valign="middle" width="35%">Model</td>
                                <td align="center" valign="middle" >Product Name</td>
                                <td width="8%" align="center" valign="middle">Qty.(set)</td>
                              </tr>
                              <% 
for(int i=0;i<productsListSize;i++) {
   productsTable=productsList.get(i);
   productCart=cartService.getProductCart(productsTable.getPId());
   if(productCart==null){
		continue;
   }					 
						  %>
                              <tr >
                                <td align="center" valign="middle"><%=i%></td>
                                <td>&nbsp;<%=StrUtil.toHtmlTag(productsTable.getPModel())%></td>
                                <td >&nbsp; <%=StrUtil.toHtmlTag(productsTable.getPName())%> </td>
                                <td align="center" valign="middle" ><%=productCart.getPCount()%></td>
                              </tr>
                              <%}
%>
                            </table>
                            <br/>
                            <table border=0 align="center" cellpadding=0>
                              <tr>
                                <td>&nbsp;</td>
                                <td>Please send me the following information:<br>
                                  <input name="en_p" type="radio" value="EXW Prices" checked>
                                  EXW Prices<br>
                                  <input type="radio" name="en_p" value="FOB Prices">
                                  FOB Prices<br>
                                  <INPUT name="mi" TYPE="CHECKBOX" id="mi" value="Minimum Order Quantity">
                                  Minimum Order Quantity<br>
                                  <INPUT name="de" TYPE="CHECKBOX" id="de" value="Delivery Time">
                                  Delivery Time<br>
                                  <INPUT name="in" TYPE="CHECKBOX" id="in" value="International Standards met">
                                  International Standards met<br>
                                  <INPUT name="sa" TYPE="CHECKBOX" id="sa" value="Sample Availability / Cost">
                                  Sample Availability / Cost
                                  &nbsp;</td>
                              </tr>
                            </table>
                            <br/>
                            <table width="459" border=0 align="center" cellpadding=0 cellspacing=0>
                              <tr>
                                <td colspan=3 class="STYLE36">2. I would like to -</td>
                              </tr>
                              <tr>
                                <td>&nbsp;</td>
                                <td colspan=2><INPUT name="order_s" TYPE="CHECKBOX" id="order_s" value="Yes">
                                  order
                                  samples for</td>
                              </tr>
                              <tr>
                                <td>&nbsp;&nbsp;</td>
                                <td>&nbsp;&nbsp;</td>
                                <td>(please type in Model.)<br>
                                  <TEXTAREA name="p_id_s" id="p_id_s"></TEXTAREA>
                                  <table width="418" border=0 cellpadding=0>
                                    <tr>
                                      <td colspan=2 >This is my courier account information:</td>
                                    </tr>
                                    <tr>
                                      <td width=50 >&nbsp;</td>
                                      <td><INPUT name="account_inf" TYPE="RADIO" value="FedEx" checked>
                                        FedEx<br>
                                        <input name="account_inf" type="RADIO" value="UPS">
                                        UPS<br>
                                        <INPUT name="account_inf" TYPE="RADIO" value="DHL">
                                        DHL<br>
                                        <INPUT name="account_inf" TYPE="RADIO" value="other">
                                        Other (please specify)<br>
                                        &nbsp; &nbsp; &nbsp;
                                        <INPUT name="other_txt" TYPE="TEXT" id="other_txt">
                                      </td>
                                    </tr>
                                    <tr>
                                      <td colspan=2>Account number
                                        <INPUT name="account_num" TYPE="TEXT" id="account_num">
                                      </td>
                                    </tr>
                                  </table></td>
                              </tr>
                            </table>
                            <table  border=0 cellspacing=0 cellpadding=0>
                              <tr>
                                <td height="36">&nbsp;</td>
                                <td width="73">&nbsp;</td>
                                <td width="496" valign="top"><br>
                                  Other message(Below 4Kb ): </td>
                              </tr>
                              <tr>
                                <td height="107">&nbsp;</td>
                                <td>&nbsp;</td>
                                <td valign="top"><TEXTAREA name="ot_ms" cols="68" rows="8" id="ot_ms"></TEXTAREA>
                                </td>
                              </tr>
                              <tr>
                                <td height="0"></td>
                                <td></td>
                                <td></td>
                              </tr>
                            </table>
                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                              <tr>
                                <td width="573" height="27" align="center" valign=top class=MainText>&nbsp;</td>
                              </tr>
                            </table>
                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                              <tr>
                                <td width="573" height="27" align="center" valign=top><input name="send_en" type="hidden" id="send_en" value="ok">
                                  <img src="img/s1.gif" width="96" height="24"
				 style="CURSOR:pointer;" 
                        onClick="javascript:on_reset()">
                                  <input name="" type="image" src="img/send.gif" />
                                </td>
                              </tr>
                            </table></td>
                        </tr>
                 
                </table>
				 </form>
				</td>
            </tr>
          </tbody>
        </table></TD>
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
