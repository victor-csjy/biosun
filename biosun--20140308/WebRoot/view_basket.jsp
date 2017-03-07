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
<%@page import="hk.com.biosun.model.ProductsTable"%>
<%@page import="hk.com.biosun.service.SmallTableService"%>
<%@page import="hk.com.biosun.util.SessionUtil"%>
<%@page import="hk.com.biosun.service.CartService"%>
<%@page import="hk.com.biosun.define.ProductCart"%>
<%
CartService cartService = SessionUtil.getCartService(request);
if (cartService == null) {
	out.println("<SCRIPT LANGUAGE='JavaScript'>alert('System Error!Please try it again later!');location.href='products.jsp';</SCRIPT>");
	return;
}
ProductCart productCart;
List<ProductsTable> productsList=cartService.getListProductsTable();
int productsListSize=productsList!=null?productsList.size():0;
ProductsTable productsTable;

BigTableService bigTableService=new BigTableService();
List<BigTable> bigTableList=bigTableService.getListFront();
int bigTableListSize=bigTableList!=null?bigTableList.size():0;
BigTable bigTable;

SmallTableService smallTableService=new SmallTableService();
SmallTable smallTable;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML xmlns:asp xmlns:uc1>
<HEAD>
<TITLE>Welcome to Biosun Technology Co., Ltd.</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<LINK href="css/style.css" type=text/css rel=stylesheet>
<SCRIPT src="js/js.js" type=text/javascript></SCRIPT>
<SCRIPT language=JavaScript type=text/JavaScript>
<!--
function on_submit(sid_p)
{
	
	var formx = document.forms["form" + sid_p];
	if(formx.qty.value==""||isNaN(formx.qty.value)||parseInt(formx.qty.value)>1000||parseInt(formx.qty.value)<1)
	{
	 alert("Please input an integer not big than 1000");
	 formx.qty.value="";
	  formx.qty.focus();			   
	 return false;
	}
	
   formx.qty.value=parseInt(formx.qty.value);
   formx.submit(); 	
}
//-->
</SCRIPT>
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
      <TD><TABLE cellSpacing=0 cellPadding=0 width=778 align=center border=0>
          <TBODY>
            <TR>
              <TD><TABLE cellSpacing=0 cellPadding=0 width=778 align=center
											border=0>
                  <TBODY>
                    <TR>
                      <TD width=778 valign="bottom"><%@ include file="header.jsp"%></TD>
                    </TR>
                  </TBODY>
                </TABLE></TD>
            </TR>
          </TBODY>
        </TABLE></TD>
    </TR>
    <TR>
      <TD><TABLE cellSpacing=0 cellPadding=0 width=778 align=center border=0>
          <TBODY>
            <TR>
              <TD height=6></TD>
            </TR>
          </TBODY>
        </TABLE>
        <TABLE cellSpacing=0 cellPadding=0 width=778 align=center border=0>
          <TBODY>
            <TR>
              <TD width=191 height="228" vAlign=top bgcolor="#E3E9F6"><table border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td height="95" valign="top"><div align="center">
                        <table border="0" cellpadding="0" cellspacing="0">
                          <tr>
                            <td height="76" valign="top"><table width="100%" height="16" border="0"
																		cellpadding="0" cellspacing="0">
                                <tr>
                                  <td><table width="191" border="0" cellpadding="0"
																					cellspacing="0">
                                      <tr>
                                        <td height="33" colspan="3"
																							background="img/about-1.gif"><table width="100%" border="0" cellpadding="0"
																								cellspacing="5">
                                            <tr>
                                              <td width="9%">&nbsp;</td>
                                              <td width="91%"><span class="STYLE29">Products </span> </td>
                                            </tr>
                                          </table></td>
                                      </tr>
                                      <tr>
                                        <td width="6" background="img/a3.jpg">&nbsp;</td>
                                        <td width="179" valign="top"><table width="179" border="0" cellpadding="0"
																								cellspacing="0" bgcolor="#FFFFFF">
                                            <tr>
                                              <td><%
																											for(int i=0;i<bigTableListSize;i++){
																											   bigTable=bigTableList.get(i);
																										%>
                                                <table width="100%" border="0" cellpadding="0"
																											cellspacing="2">
                                                  <tr>
                                                    <td width="18%"><div align="center"> <img src="img/pc-14.gif" width="14"
																															height="15"> &nbsp;&nbsp; </div></td>
                                                    <td width="82%"><a
																														href="product_big.jsp?big_id=<%=bigTable.getBigId()%>"
																														class="STYLE26"><%=StrUtil.toHtmlTag(bigTable.getBigName())%></a> </td>
                                                  </tr>
                                                  <tr>
                                                    <td colspan="2"><img src="img/0-1.gif" width="170"
																														height="11"> </td>
                                                  </tr>
                                                </table>
                                                <%
																											}
																										%>
                                              </td>
                                            </tr>
                                          </table></td>
                                        <td width="7" background="img/a3.jpg">&nbsp;</td>
                                      </tr>
                                      <tr>
                                        <td colspan="3"><img src="img/about.gif" width="191" height="8"> </td>
                                      </tr>
                                    </table></td>
                                </tr>
                              </table></td>
                          </tr>
                          <tr>
                            <td height="9" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
                          </tr>
                          <tr>
                            <td height="9" valign="top"><%@ include
																		file="left.jsp"%></td>
                          </tr>
                        </table>
                      </div></td>
                  </tr>
                </table></TD>
              <TD width=592 rowspan="2" vAlign=top><TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
                  <TBODY>
                    <TR>
                      <TD width=""><div align="right">
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
                        </div></TD>
                    </TR>
                    <TR>
                      <TD class=MainText vAlign=top>&nbsp;</TD>
                    </TR>
                    <TR>
                      <TD class=MainText vAlign=top><table width="580" border="0" align="right"
															cellpadding="0" cellspacing="3">
                          <tr>
                            <td width="3%"><div align="left"> <img src="img/dian.gif" width="15" height="15"> </div></td>
                            <td width="31%"><span class="STYLE27"> View Basket </span> </td>
                            <td width="62%"><div align="right"> <span class="STYLE34">You are here</span> <STRONG>:</STRONG><a href="index.jsp" class="STYLE26">Home</a>-- <span class="STYLE30"><a href="products.jsp"
																			class="STYLE26">Products</a> </span> -- <span class="STYLE30"><a href="#"
																			class="STYLE26">View_Basket</a> </span> </div></td>
                            <td width="4%">&nbsp;</td>
                          </tr>
                        </table></TD>
                    </TR>
                    <TR>
                      <TD class=MainText vAlign=top><div align="right"> <img src="img/pc-16.gif" width="580" height="3"> </div></TD>
                    </TR>
                    <TR>
                      <TD height="13">&nbsp;</TD>
                    </TR>
                    <%
													if (productsListSize < 1) {
												%>
                    <TR>
                      <TD height="27" align="center" vAlign=top><p> Enquiry Basket Is Empty </p>
                        <p> <span style="CURSOR:pointer;"><img
																	src="img/send1.gif" width="96" height="24"
																	style="CURSOR:pointer;"
																	onClick="javascript:history.go(-1)"> </span> </p></TD>
                    </TR>
                    <%
													} else {
												%>
                    <TR>
                      <TD class=MainText vAlign=top><table width="72%" border="0" align="right"
															cellpadding="0" cellspacing="0">
                          <tr>
                            <td width="191" height="24">&nbsp;</td>
                            <td width="82" align="center"><img src="img/send1.gif" width="96" height="24"
																		style="CURSOR: pointer;"
																		onClick="javascript:history.go(-1)"> </td>
                            <td width="27">&nbsp;</td>
                            <td width="118"><a href="send_enquiry.jsp"><img src="img/send.gif"
																			width="96" height="24" border="0"> </a> </td>
                          </tr>
                        </table></TD>
                    </TR>
                    <TR>
                      <TD height=5 valign="top"><table width="550" border="0" align="right"
															cellpadding="0" cellspacing="0">
                          <tbody>
                            <tr>
                              <td valign="top" class="hanggao"><%
																			for(int i=0;i<productsListSize;i++){
																			   productsTable=productsList.get(i);
																			   productCart=cartService.getProductCart(productsTable.getPId());
																			   if(productCart==null){
																			      continue;
																			   }
																		%>
                                <table width="82%" border="0" align="center"
																			cellpadding="0" cellspacing="8">
                                  <tr>
                                    <td width="28%"><div align="center"> <a
																							href="products_detail.jsp?p_id=<%=productsTable.getPId()%>"
																							target="_blank"> <img
																								src="product/pic/small<%=productsTable.getPPic()%>"
																								width="144" height="117" border="0" /> </a> </div></td>
                                    <td width="72%"><table width="100%" border="0" cellpadding="0"
																						cellspacing="5">
                                        <tr>
                                          <td width="276"><strong> <a
																									href="products_detail.jsp?p_id=<%=productsTable.getPId()%>"
																									class="STYLE14"><%=(StrUtil.toHtmlTag(productsTable.getPModel())+ "/" + StrUtil.toHtmlTag(productsTable.getPName()))%></a> </strong> </td>
                                          <td width="99"><div align="right"> <img src="img/lo0010.gif" width="23"
																										height="20"> <span class="STYLE31"><a
																										href="products_detail.jsp?p_id=<%=productsTable.getPId()%>"
																										target="_blank" class="STYLE14"><strong>Detail</strong> </a>&nbsp;</span> </div></td>
                                        </tr>
                                        <tr>
                                          <td height="71" colspan="2" valign="top"><%=StrUtil.toHtmlTag(productsTable.getDetail1())%></td>
                                        </tr>
                                      </table></td>
                                  </tr>
                                  
                                    <tr colspan="2">
                                      <td height="20" colspan="2" valign="top"><div align="right"> 
									  <form name="form<%=i%>" action="change_car.jsp" method="POST">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img src="img/lo0010.gif" width="23" height="20"> Qty.
                                          <input name="qty" type="text" class="style2"
																							id="qty"
																							value="<%=productCart.getPCount()%>"
																							size="5">
                                          <input name="p_id" type="hidden" id="p_id"
																							value="<%=productCart.getPId()%>">
                                          &nbsp;&nbsp;&nbsp; <img src="img/chang_qty.gif" width="102"
																							height="20" style="CURSOR: pointer;"
																							onClick="javascript:on_submit(<%=i%>)"> <a
																							href="del_product.jsp?p_id=<%=productCart.getPId()%>"><img
																								src="img/remove.gif" width="102" height="20"
																								border="0"> </a> </form></div></td>
                                    </tr>
                                  
                                  <tr>
                                    <td colspan="2"><img src="img/1-10.gif" width="552" height="1" /> </td>
                                  </tr>
                                </table>
                                <%
																		  }
																		%>
                                <table width="100%" border="0" cellpadding="0"
																			cellspacing="0">
                                  <tr>
                                    <td><div align="right">
                                        <table width="72%" border="0" align="right"
																							cellpadding="0" cellspacing="0">
                                          <tr>
                                            <td width="191" height="24">&nbsp;</td>
                                            <td width="75" align="center"><img src="img/send1.gif" width="96" height="24"
																										style="CURSOR: pointer;"
																										onClick="javascript:history.go(-1)"> </td>
                                            <td width="25">&nbsp;</td>
                                            <td width="118"><a href="send_enquiry.jsp"><img
																											src="img/send.gif" width="96" height="24"
																											border="0"> </a> </td>
                                          </tr>
                                        </table>
                                      </div></td>
                                  </tr>
                                </table></td>
                            </tr>
                          </tbody>
                          <%
																}
															%>
                        </table></TD>
                    </TR>
                  </TBODY>
                </TABLE></TD>
            </TR>
          </TBODY>
        </TABLE></TD>
    </TR>
  </TBODY>
</TABLE>
<%@ include file="foot.jsp"%>
</BODY>
</HTML>
