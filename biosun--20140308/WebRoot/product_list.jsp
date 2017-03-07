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
<%@page import="com.aokle.util.MathUtil"%>
<%@page import="hk.com.biosun.service.ProductsTableService"%>
<%@page import="hk.com.biosun.util.ReqParamUtil"%>
<%
BigTableService bigTableService=new BigTableService();
List<BigTable> bigTableList=bigTableService.getListFront();
int bigTableListSize=bigTableList!=null?bigTableList.size():0;
BigTable bigTable;
BigTable bigTableTmp;

SmallTableService smallTableService=new SmallTableService();
SmallTable smallTable;
SmallTable smallTableTmp;

List<SmallTable> smallTableList;
int smallTableListSize=0;

String bigSmall=StrUtil.toHtmlTxt(request.getParameter("big_small"));
int bigId=MathUtil.toInt(request.getParameter("big_id"));
int smallId=MathUtil.toInt(request.getParameter("small_id"));

int index=bigSmall.indexOf('_');
if(index>-1){
   String[] bigSmallArr=bigSmall.split("\\_");
   if(bigSmallArr!=null&&bigSmallArr.length==2){
     bigId=MathUtil.toInt(bigSmallArr[0]);
     smallId=MathUtil.toInt(bigSmallArr[1]);
   }
}

String keyWord=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("key_word")));
int pageNo=MathUtil.toInt(request.getParameter("page"),1);
bigTable=bigTableService.getByPKFront(bigId);
smallTable=smallTableService.getByPKFront(smallId);

ProductsTableService productsTableService=new ProductsTableService();
ProductsTable productsTable;
int recordCount=productsTableService.getCountFront(bigId,smallId,keyWord);
int pageSize=10;
int pageCount=(recordCount-1)/pageSize+1;
if(pageNo>pageCount){
   pageNo=pageCount;
}
List<ProductsTable> productsTableList=productsTableService.getListFront(bigId,smallId,keyWord,pageSize,pageNo);
int productsTableListSize=productsTableList!=null?productsTableList.size():0;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
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
}
//-->
</SCRIPT>
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
.STYLE34 {color: #999999}
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
                      <TD width=778  valign="bottom"><%@ include file="header.jsp"%></TD>
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
              <TD width="191" vAlign=top bgcolor="#E3E9F6"><table border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td height="95" valign="top"><div align="center">
                        <table border="0" cellpadding="0" cellspacing="0">
                          <tr>
                            <td height="76" valign="top"><table width="100%" height="16" border="0" cellpadding="0" cellspacing="0">
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
                                        <td width="173" valign="top"><table width="179" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
                                            <tr>
                                              <td><%
											 for(int i=0;i<bigTableListSize;i++){
											   bigTableTmp=bigTableList.get(i);
											 %>
                                                <table width="100%" border="0" cellpadding="0" cellspacing="2">
                                                  <tr>
                                                    <td width="170" height="18" valign="top">&nbsp;&nbsp;<img src="img/pc-17a.gif" width="8" height="9" /><a href="product_big.jsp?big_id=<%=bigTableTmp.getBigId()%>" class="STYLE26"><%=StrUtil.toHtmlTag(bigTableTmp.getBigName())%></a></td>
                                                  </tr>
                                                  <% if(bigTableTmp.getBigId()== bigId){
                                                       smallTableList=smallTableService.getListFront(bigId);
                                                       smallTableListSize=smallTableList!=null?smallTableList.size():0;
		                                               for(int j=0;j<smallTableListSize;j++){
		                                                 smallTableTmp=smallTableList.get(j);
		                                               %>
                                                  <tr>
                                                    <td width="170" height="18" valign="top">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="img/pc-17a.gif" width="8" height="9" /> <a href="product_list.jsp?big_id=<%=smallTableTmp.getBigId()%>&&small_id=<%=smallTableTmp.getSmallId()%>" class="STYLE26">
                                                      <%if(smallTableTmp.getSmallId()== smallId){%>
                                                      <font color="#FF0000"  > <strong><%=StrUtil.toHtmlTag(smallTableTmp.getSmallName())%></strong></font>
                                                      <%}
	else {%>
                                                      <%=StrUtil.toHtmlTag(smallTableTmp.getSmallName())%>
                                                      <%}%>
                                                      </a></td>
                                                  </tr>
                                                  <%}}%>
                                                </table>
                                                <%}%>
                                              </td>
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
                            <td height="9" valign="top">&nbsp;</td>
                          </tr>
                          <tr>
                            <td height="9" valign="top"><%@ include file="left_pro.jsp"%></td>
                          </tr>
                        </table>
                      </div></td>
                  </tr>
                </table></TD>
              <TD rowspan="2" vAlign=top><TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
                  <TBODY>
                    <TR>
                      <TD><div align="right">
                          <script language="javascript">
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
                      <TD height="16" vAlign=top class=MainText>&nbsp;</TD>
                    </TR>
                    <TR>
                      <TD vAlign=top class=MainText><table width="580" border="0" align="right" cellpadding="0" cellspacing="3">
                          <tr>
                            <td width="3%"><div align="left"><img src="img/dian.gif" width="15" height="15"></div></td>
                            <td width="29%"><span class="STYLE27">
                              <%if(smallTable==null)out.print("Search Result");
					
					 else out.print(StrUtil.toHtmlTag(smallTable.getSmallName()));
					 %>
                              </span></td>
                            <td width="66%"><div align="right"><span class="STYLE34">You are here</span> <STRONG>:</STRONG><a href="index.jsp" class="STYLE26">Home</a>--<span class="STYLE30"><a href="products.jsp" class="STYLE26">Products</a></span>-- <span class="STYLE30">
                                <%if(bigTable==null) {%>
                                <a href="products.jsp" class="STYLE26">All Products</a>
                                <%}
	 else {%>
                                <a href="product_big.jsp?big_id=<%=bigTable.getBigId()%>" class="STYLE26"><%=StrUtil.toHtmlTag(bigTable.getBigName())%> </a>
                                <%}%>
                                <%if(smallTable!=null){%>
                                --<span class="STYLE30"><a href="#" class="STYLE26"> <%=StrUtil.toHtmlTag(smallTable.getSmallName())%></a>
                                <%}%>
                                </span></div></td>
                            <td width="2%">&nbsp;</td>
                          </tr>
                        </table></TD>
                    </TR>
                    <TR>
                      <TD height="3" vAlign=top class=MainText><div align="right"><img src="img/pc-16.gif" width="580" height="3"></div></TD>
                    </TR>
                    <TR>
                      <TD height="8">&nbsp;</TD>
                    </TR>
                    <TR>
                      <TD height="9"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                          <tr>
                            <td><div align="center">
                                <%if(smallTable!=null&&!"".equals(smallTable.getContent())){%>
                                <table cellspacing="0" cellpadding="0" width="560" border="0">
                                  <tbody>
                                    <tr>
                                      <td width="10" height="18">&nbsp;</td>
                                      <td colspan="2" valign="top" style="FONT-SIZE: 10pt"><b> Brief Introduction</b></td>
                                      <td width="60">&nbsp;</td>
                                      <td width="20">&nbsp;</td>
                                    </tr>
                                    <tr>
                                      <td height="1" colspan="5" bgcolor="#73B549"></td>
                                    </tr>
                                    <tr>
                                      <td colspan="2"><!--DWLayoutEmptyCell-->&nbsp;</td>
                                      <td  colspan="2" valign="top"><table width="520" border="0" align="center" cellpadding="0" cellspacing="0">
                                          <tr>
                                            <td width="520">&nbsp;</td>
                                          </tr>
                                          <tr>
                                            <td width="520" valign="top"><table width="520" border="0" cellpadding="0" cellspacing="0">
                                                <tr>
                                                  <td width="520"><%=StrUtil.toHtmlTag(smallTable.getContent())%></td>
                                                </tr>
                                              </table></td>
                                          </tr>
                                          <tr>
                                            <td height="16">&nbsp;</td>
                                          </tr>
                                        </table></td>
                                      <td width="10" >&nbsp;</td>
                                    </tr>
                                    <tr>
                                      <td height="0"></td>
                                      <td width="10"></td>
                                      <td width="460"></td>
                                      <td></td>
                                      <td></td>
                                    </tr>
                                    <tr> </tr>
                                  </tbody>
                                </table>
                                <%}%>
                                <table width="560" border="0" align="center" cellpadding="0" cellspacing="0">
                                  <tr>
                                    <td width="10">&nbsp;</td>
                                    <td><b>
                                      <%if(smallTable!=null)out.print(StrUtil.toHtmlTag(smallTable.getSmallName()));
								
								else if(bigTable!=null)out.print(StrUtil.toHtmlTag(bigTable.getBigName()));
								
								else out.print("All Products");
								     if(!"".equals(keyWord)){%>
                                      <%="/&nbsp;"+StrUtil.toHtmlTag(keyWord)%>
                                      <%}%>
                                      </b>
                                      <%if(recordCount==0)out.print(" : Sorry, No record as your requirement. Please contact us for detail!");
   else if(recordCount==1)out.print(" : Total "+recordCount+" Record.");
   else out.print(" : Total "+recordCount+" Records.");%></td>
                                    <td width="10">&nbsp;</td>
                                  </tr>
                                </table>
                                <table cellspacing="0" cellpadding="0" width="560" border="0">
                                  <tbody>
                                    <tr>
                                      <td width="560" height="1" bgcolor="#73B549"><img height="1" src="" 
                        width="1" /></td>
                                    </tr>
                                  </tbody>
                                </table>
                              </div></td>
                          </tr>
                          <tr>
                            <td>&nbsp;</td>
                          </tr>
                        </table></TD>
                    </TR>
                    <TR>
                      <TD height="23" align="right" vAlign=top><a href="view_basket.jsp"><img src="img/over.gif" width="96" height="24" border="0"></a>&nbsp;&nbsp;&nbsp;<a href="send_enquiry.jsp"><img src="img/send.gif" width="96" height="24" border="0"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
                    </TR>
                    <TR>
                      <TD height=220 valign="top"><table width="550" border="0" align="right" cellpadding="0" cellspacing="0">
                          <tbody>
                            <tr>
                              <td valign="top" class="hanggao"><%  
						  for(int i=0;i<productsTableListSize;i++) {
						    productsTable=productsTableList.get(i);
						  %>
                              
                                  <table width="82%" border="0" align="center" cellpadding="0" cellspacing="8">
                                  <tr>
                                    <td width="38%"><div align="center">
                                        <div align="center">
                                          <table width="185" height="140" border="0" cellpadding="0" cellspacing="0" background="img/bg01.gif">
                                            <tr>
                                              <td><div align="center"><a href="products_detail.jsp?p_id=<%=productsTable.getPId()%>" target="_blank"><img src="product/pic/small<%=productsTable.getPPic()%>" width="175" height="125" border="0" /></a></div></td>
                                            </tr>
                                          </table>
                                        </div>
                                      </div></td>
                                    <td width="62%"><table width="100%" border="0" cellpadding="0" cellspacing="5">
                                        <tr>
                                          <td><a href="products_detail.jsp?p_id=<%=productsTable.getPId()%>"  class="STYLE14"><strong><%=StrUtil.toHtmlTag(productsTable.getPModel())+"&nbsp;/&nbsp;"+StrUtil.toHtmlTag(productsTable.getPName())%></strong></a></td>
                                          <td><div align="right"><img src="img/lo0010.gif" width="23" height="20"><span class="STYLE31"><a href="products_detail.jsp?p_id=<%=productsTable.getPId()%>" target="_blank" class="STYLE14"><strong>Detail</strong></a>&nbsp;</span></div></td>
                                        </tr>
                                        <tr>
                                          <td colspan="2"><%=StrUtil.toHtmlTag(productsTable.getDetail1())%></td>
                                        </tr>
                                        
										<tr>
                                          <td height="30" colspan="2"><div align="right">
										   <form  name="form<%=i%>" action="add_to_car.jsp"   method="POST"  onSubmit="return on_submit(<%=i%>);">
										  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="img/lo0010.gif" width="23" height="20">Qty.
                                              <input name="qty" type="text" class="style2" id="qty" size="5">
                                              <input name="p_id" type="hidden" id="p_id" value="<%=productsTable.getPId()%>">
                                              &nbsp;&nbsp;&nbsp;
                                              <input name="" type="image" src="img/lo000.gif"/>
                                           </form>
										    </div>
											
											</td>
                                        </tr>
										
                                      </table>
									 
                                </td>
                            </tr>
                            <tr>
                              <td colspan="2"><img src="img/1-10.gif" width="552" height="1" /></td>
                            </tr>
                        </table>
<%}%>
                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                          <tr>
                            <TD height="23" align="right" vAlign=top><a href="view_basket.jsp"><img src="img/over.gif" width="96" height="24" border="0"></a>&nbsp;&nbsp;&nbsp;<a href="send_enquiry.jsp"><img src="img/send.gif" width="96" height="24" border="0"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
                          </tr>
                          <tr>
                            <td align="center">&nbsp;&nbsp;</td>
                          </tr>
                          <tr>
                            <td align="center"><div align="center">Page <strong><%=pageNo%></strong>/<%=pageCount%> (<%=recordCount%>
                                <%
                                if(recordCount<2)out.print("record");
			                    else out.print("records");
			                    %>
                                )&nbsp;&nbsp; 
                                <% if(recordCount>pageSize){%>
                                |<a href="product_list.jsp?page=1&&big_id=<%=bigId%>&&small_id=<%=smallId%>&&key_word=<%=keyWord%>&&big_small=<%=bigSmall%>"  class="STYLE14">&lt;&lt;&nbsp;First</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="product_list.jsp?page=<%=(pageNo-1)%>&&big_id=<%=bigId%>&&small_id=<%=smallId%>&&key_word=<%=keyWord%>&&big_small=<%=bigSmall%>"  class="STYLE14">&lt;&nbsp;Previous</a>&nbsp;&nbsp;&nbsp;&nbsp; <a href="product_list.jsp?page=<%=(pageNo+1)%>&&big_id=<%=bigId%>&&small_id=<%=smallId%>&&key_word=<%=keyWord%>&&big_small=<%=bigSmall%>"  class="STYLE14">Next&nbsp;&gt; </a> &nbsp;&nbsp;&nbsp;&nbsp;<a href="product_list.jsp?page=<%=pageCount%>&&big_id=<%=bigId%>&&small_id=<%=smallId%>&&key_word=<%=keyWord%>&&big_small=<%=bigSmall%>"  class="STYLE14">Last&nbsp;&gt;&gt;</a> | <% }%></div></td>
                          </tr>
                        </table></td>
                    </tr>
                  </tbody>
                </table></TD>
            </TR>
          </TBODY>
        </TABLE></TD>
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
