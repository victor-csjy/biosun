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
<%
int pId=MathUtil.toInt(request.getParameter("p_id"));
ProductsTableService productsTableService=new ProductsTableService();
ProductsTable productsTable=productsTableService.getByPKFront(pId);
if(productsTable==null){
  out.println("<SCRIPT LANGUAGE='JavaScript'>alert('Parameter Error!');location.href='products.jsp';</SCRIPT>");
  return; 
}
BigTableService bigTableService=new BigTableService();
BigTable bigTable=bigTableService.getByPKFront(productsTable.getBigId());
if(bigTable==null){
    out.println("<SCRIPT LANGUAGE='JavaScript'>alert('Parameter Error!');location.href='products.jsp';</SCRIPT>");
    return;  
}
SmallTableService smallTableService=new SmallTableService();
SmallTable smallTable=smallTableService.getByPKFront(productsTable.getSmallId());
if(smallTable==null){
    out.println("<SCRIPT LANGUAGE='JavaScript'>alert('Parameter Error!');location.href='products.jsp';</SCRIPT>");
    return;  
}

productsTableService.updateBrowseTimes(pId,1);
List<ProductsTable>  productsTableList= productsTableService.getListFront(productsTable.getBigId(),productsTable.getSmallId(),null,5000,1);
int productsTableListSize=productsTableList!=null?productsTableList.size():0;
ProductsTable productsTableTmp;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>Welcome to Biosun Technology Co., Ltd.</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8"><LINK 
href="css/style.css" type=text/css rel=stylesheet>
 <SCRIPT src="js/js.js" type=text/javascript></SCRIPT>
<script language="javascript">
 function on_submit(){
   if(form1.qty.value==""||isNaN(form1.qty.value)||parseInt(form1.qty.value)<1||parseInt(form1.qty.value)>1000){
      alert("Please input an integer not big than 1000!");
	  form1.qty.value="";	
      document.form1.qty.focus();
	  return false;
   }
  form1.qty.value=parseInt(form1.qty.value);  
}

function on_submit_com()
 {

   if(form_com.com_content.value==""||form_com.com_content.value.length>6000)
  {
    alert("Input the Comments!");	
    document.form_com.com_content.focus();
	return false;
  }  
  
}
function on_reset(){  
 form_com.reset();  
 }
</script> 

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
<style>
.p_name_css {
	font-size: 16px;
	font-weight: bold;
	color: #000000
	}
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
      <TABLE cellSpacing="0" cellPadding="0" width="778" align="center" border="0">
        <TBODY>
        <TR>
          <TD height=6></TD>
        </TR></TBODY></TABLE>
      <TABLE cellSpacing=0 cellPadding=0 width=778 align=center border=0>
        
        <TBODY>
        <TR>
          <TD width=191 vAlign=top bgcolor="#E3E9F6"><table width="191" border="0" cellpadding="0" cellspacing="0">
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
                <td width="173" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                    <tr>
                      <td>
                          <table width="179" border="0" cellpadding="0" cellspacing="2" bgcolor="#FFFFFF">
                            
                            <tr>
                              <td width="169" height="18" valign="top" >&nbsp;<img src="img/pc-17a.gif" width="8" height="9" /><a href="product_big.jsp?big_id=<%=bigTable.getBigId()%>" class="STYLE26"><%=StrUtil.toHtmlTag(bigTable.getBigName())%></a></td>
                            </tr>
							 <tr>
                              <td height="18" valign="top">
                               &nbsp;&nbsp;&nbsp;<img src="img/pc-17a.gif" width="8" height="9" /><a href="product_list.jsp?big_id=<%=smallTable.getBigId()%>&&small_id=<%=smallTable.getSmallId()%>" class="STYLE26"><%=StrUtil.toHtmlTag(smallTable.getSmallName())%></a></td>
                            </tr>
					<%
					for(int i=0;i<productsTableListSize;i++){
					    productsTableTmp=productsTableList.get(i);
					%>	
						 <tr>
                              <td height="18" valign="top">
							   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="img/pc-17a.gif" width="8" height="9" /><a href="products_detail.jsp?p_id=<%=productsTableTmp.getPId()%>" class="STYLE26">
							  
	<%if(pId==productsTableTmp.getPId()){%>
	<font color="#FF0000"  >
	<strong><%=StrUtil.toHtmlTag(productsTableTmp.getPModel())%></strong></font>	
	<%}
	else {%><%=StrUtil.toHtmlTag(productsTableTmp.getPModel())%><%}%></a>	 </td>
                            </tr>
					<%}%>		
                          </table>                          </td>
                    </tr>
                </table></td>
                <td width="6" background="img/a3.jpg">&nbsp;</td>
              </tr>
              <tr>
                <td colspan="3"><img src="img/about.gif" width="191" height="8"></td>
              </tr>
              <tr>
                <td colspan="3">&nbsp;</td>
              </tr>
            </table>
            <table border="0" cellpadding="0" cellspacing="0">
              
              <tr>
                <td height="31" valign="top"><div align="center">
                    <%@ include file="left.jsp"%>
                </div></td>
              </tr>
            </table></TD>
          <TD width="592" rowspan="3" vAlign=top><div align="right">
            <table cellspacing=0 cellpadding=0 width="100%" border=0>
              
              <tbody>
                <tr>
                  <td><div align="right"><script language="javascript">
	if (AC_FL_RunContent == 0) {
	} else {
		AC_FL_RunContent(
			'codebase', 'http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0',
			'width', '580',
			'height', '133',
			'src', 'flash/<%=productsTable.getBigId()%>',
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
			'movie', 'flash/<%=productsTable.getBigId()%>',
			'salign', ''
			); //end AC code
	}
</script>
                  </div></td>
                </tr>
                <tr>
                  <td height="16" valign=top class=MainText>&nbsp;</td>
                </tr>
                <tr>
                  <td height="24" valign=top class=MainText><table width="580" border="0" align="right" cellpadding="0" cellspacing="3">
                      <tr>
                        <td width="16"><div align="left"><img src="img/dian.gif" width="15" height="15"></div></td>
                        <td width="78"><span class="STYLE27"> <%=StrUtil.toHtmlTag(smallTable.getSmallName())%></span></td>
                        <td width="465"><div align="right">
                            <DIV align="right"><span class="STYLE35">You are here</span> <STRONG>:</STRONG><a href="index.jsp" class="STYLE26">Home</a>--<span class="STYLE30"><a href="products.jsp" class="STYLE26">Products</a></span> --<span class="STYLE30"><a href="product_big.jsp?big_id=<%=bigTable.getBigId()%>" class="STYLE26"> <%=StrUtil.toHtmlTag(bigTable.getBigName())%></a></span> --<span class="STYLE30"><a href="product_list.jsp?big_id=<%=bigTable.getBigId()%>&&small_id=<%=smallTable.getBigId()%>" class="STYLE26"> <%=StrUtil.toHtmlTag(smallTable.getSmallName())%></a></span> </DIV>
                        </div></td>
                        <td width="14">&nbsp;</td>
                      </tr>
                  </table></td>
                </tr>
                <tr>
                  <td height="3" valign=top class=MainText><div align="right"><img src="img/pc-16.gif" width="580" height="3"></div></td>
                </tr>
                <tr>
                  <td height="16" valign=top class=MainText><div align="right"></div></td>
                </tr>
                <tr>
                  <TD class=MainText vAlign=top><div align="right">
                      <form  name="form1" action="add_to_car.jsp"   method="POST"  onSubmit="return on_submit()">
                        <table width="72%" border="0" align="right" cellpadding="0" cellspacing="5">
                          <tr>
                            <td width="150"><table width="96" height="24" border="0" cellpadding="0" cellspacing="0" background="img/s2.gif">
                                <tr>
                                  <td><table width="100%" border="0" cellpadding="0" cellspacing="0">
                                      <tr>
                                        <td>Qty.
                                          <input name="qty"  id="qty" type="text" class="ner" size="5">
                                            <input name="p_id" type="hidden" id="p_id" value="<%=pId%>">
                                          &nbsp;</td>
                                      </tr>
                                  </table></td>
                                </tr>
                            </table></td>
                            <td width="118"><input name="Input" type="image" src="img/over0.gif" />
                            </td>
                            <td width="118"><a href="view_basket.jsp" target="_self"><img src="img/over.gif" width="96" height="24" border="0"></a></td>
                            <td width="118"><a href="send_enquiry.jsp"><img src="img/send.gif" width="96" height="24" border="0"></a></td>
                          </tr>
                        </table>
                      </form>
                  </div></TD>
                </tr>
                <tr>
                  <td valign="top"><table width="90%" border="0" align="right" cellpadding="0" cellspacing="0">
                      
                      <tr>
                        <td width="43%"><div align="center"><span class="p_name_css"><%=StrUtil.toHtmlTag(productsTable.getPModel())%><BR>
                                  <BR>
                                  <%=StrUtil.toHtmlTag(productsTable.getPName())%></span></div></td>
                        <td width="57%"><a href="show_pic.jsp?p_pic=<%=StrUtil.toHtmlTag(productsTable.getPPic())%>"  title="Show Big Picture" target="_blank"><img src="product/pic/small<%=productsTable.getPPic()%>" alt="Show Big Picture"  width="318" height="227" border="0"></a></td>
                      </tr>
                      <tr>
                        <td colspan="2">
<%if(!"".equals(StrUtil.toHtmlTag(productsTable.getApp()))){%><TABLE cellSpacing="0" cellPadding="0" width="560" border="0">
                              
                              <TBODY>
                                <TR id="menuTitle2" onClick="showsubmenu(2)" style="cursor:pointer;" >
                                  <TD width="20" height="16" valign="top" id="change_bg2" background="img/lo.gif"></TD>
                                  <TD width="540"><STRONG>Applications:</STRONG></TD>
                                </TR>
                                <TR>
                                  <TD height="12" colSpan="2"><TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
                                      <TBODY>
                                        <TR>
                                          <TD bgColor="#73B549"><IMG height="1" src="img/spacer.gif" width="1"></TD>
                                        </TR>
                                      </TBODY>
                                  </TABLE></TD>
                                </TR>
                                <TR>
                                  <TD height="36" colSpan="2" valign="top" id="submenu2"><div>
                                      <table width="100%" border="0" cellpadding="0" cellspacing="0" >
                                        
                                        <tr>
                                          <TD width="22" height="45">&nbsp;</TD>
                                          <TD width="538" valign="top"><%=StrUtil.toHtmlTag(productsTable.getApp())%> </TD>
                                        </tr>
                                      </table>
                                  </div></TD>
                                </TR>
                              </TBODY>
                            </TABLE><BR><%}						  
						if(!"".equals(StrUtil.toHtmlTag(productsTable.getDetail1())+StrUtil.toHtmlTag(productsTable.getDetail2()))){%>	
						<TABLE cellSpacing="0" cellPadding="0" width="560" border="0">
                            
                            <TBODY>
                              <TR id="menuTitle1" onClick="showsubmenu(1)" style="cursor:pointer;" >
                                <TD width="20" height="16" valign="top" id="change_bg1" background="img/lo.gif"></TD>
                                <TD width="540" valign="top"><STRONG>Features:</STRONG></TD>
                              </TR>
                              <TR>
                                <TD height="12" colSpan="2"><TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
                                    <TBODY>
                                      <TR>
                                        <TD bgColor="#73B549"><IMG height="1" src="img/spacer.gif" width="1"></TD>
                                      </TR>
                                    </TBODY>
                                </TABLE></TD>
                              </TR>
                              <TR>
                                <TD height="18" colSpan="2" valign="top" id="submenu1" style="DISPLAY: yes"><div>
                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                      
                                      <tr>
                                        <TD width="22" height="18">&nbsp;</TD>
                                        <TD width="538" valign="top"> 
										<%=StrUtil.toHtmlTag(productsTable.getDetail1())+StrUtil.toHtmlTag(productsTable.getDetail2())%> </TD>
                                      </tr>
                                    </table>
                                </div></TD>
                              </TR>
                            </TBODY>
                          </TABLE>                            
							<BR><%}
					
					if(!"".equals(StrUtil.toHtmlTag(productsTable.getSc()))){%>  
                      
                            <TABLE cellSpacing="0" cellPadding="0" width="560" border="0">
                              
                              <TBODY>
                                <TR id="menuTitle3" onClick="showsubmenu(3)" style="cursor:pointer;" >
                                  <TD width="20" height="16" valign="top" id="change_bg3" background="img/lo.gif"></TD>
                                  <TD width="540"><strong>Standard Configuration:</strong></TD>
                                </TR>
                                <TR>
                                  <TD height="12" colSpan="2"><TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
                                      <TBODY>
                                        <TR>
                                          <TD bgColor="#73B549"><IMG height="1" src="img/spacer.gif" width="1"></TD>
                                        </TR>
                                      </TBODY>
                                  </TABLE></TD>
                                </TR>
                                <TR>
                                  <TD height="36" colSpan="2" valign="top" id="submenu3" style="DISPLAY: yes"><div>
                                      <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                        
                                        <tr>
                                          <TD width="22" height="36">&nbsp;</TD>
                                          <TD width="538" valign="top"><%=StrUtil.toHtmlTag(productsTable.getSc())%></TD>
                                        </tr>
                                      </table>
                                  </div></TD>
                                </TR>
                              </TBODY>
                            </TABLE>
                          
						  <BR><%}
					if(!"".equals(StrUtil.toHtmlTag(productsTable.getOc()))){%>  
                      
                            <TABLE cellSpacing="0" cellPadding="0" width="560" border="0">
                              
                              <TBODY>
                                <TR id="menuTitle4" onClick="showsubmenu(4)" style="cursor:pointer;" >
                                  <TD width="20" height="16" valign="top" id="change_bg4" background="img/lo.gif"></TD>
                                  <TD width="540"><STRONG>Optional  Configurations:</STRONG></TD>
                                </TR>
                                <TR>
                                  <TD height="12" colSpan="2"><TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
                                      <TBODY>
                                        <TR>
                                          <TD bgColor="#73B549"><IMG height="1" src="img/spacer.gif" width="1"></TD>
                                        </TR>
                                      </TBODY>
                                  </TABLE></TD>
                                </TR>
                                <TR>
                                  <TD height="18" colSpan="2" valign="top"  id="submenu4" style="DISPLAY: yes"><div>
                                      <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                        
                                        <tr>
                                          <TD width="22" height="18">&nbsp;</TD>
                                          <TD width="538" valign="top"><%=StrUtil.toHtmlTag(productsTable.getOc())%></TD>
                                        </tr>
                                      </table>
                                  </div></TD>
                                </TR>
                              </TBODY>
                            </TABLE>
                          
						  <BR><%}
					if(!"".equals(StrUtil.toHtmlTag(productsTable.getSp()))){%>  
                      
                            <TABLE cellSpacing="0" cellPadding="0" width="560" border="0">
                              
                              <TBODY>
                                <TR id="menuTitle5" onClick="showsubmenu(5)" style="cursor:pointer;" >
                                  <TD width="20" height="16" valign="top" id="change_bg5" background="img/lo.gif"></TD>
                                  <TD width="540"><STRONG>Specification:</STRONG></TD>
                                </TR>
                                <TR>
                                  <TD height="12" colSpan="2"><TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
                                      <TBODY>
                                        <TR>
                                          <TD bgColor="#73B549"><IMG height="1" src="img/spacer.gif" width="1"></TD>
                                        </TR>
                                      </TBODY>
                                  </TABLE></TD>
                                </TR>
                                <TR>
                                  <TD height="18" colSpan="2" valign="top" id="submenu5" style="DISPLAY: yes"><div>
                                      <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                        
                                        <tr>
                                          <TD width="22" height="18">&nbsp;</TD>
                                          <TD width="538" valign="top"><%=StrUtil.toHtmlTag(productsTable.getSp())%></TD>
                                        </tr>
                                      </table>
                                  </div></TD>
                                </TR>
                              </TBODY>
                            </TABLE>
                          
						  
						  
						  <BR><%}
					if(!"".equals(StrUtil.toHtmlTag(productsTable.getEc1())+StrUtil.toHtmlTag(productsTable.getEc2()))){%>  
                      
					  
                            <TABLE cellSpacing="0" cellPadding="0" width="560" border="0">
                              
                              <TBODY>
                                <TR id="menuTitle6" onClick="showsubmenu(6)" style="cursor:pointer;" >
                                  <TD width="20" height="16" valign="top" id="change_bg6" background="img/lo.gif"></TD>
                                  <TD width="540"><STRONG><strong><strong>Download Literature:</strong></strong></STRONG></TD>
                                </TR>
                                <TR>
                                  <TD colSpan="2" height="12"><TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
                                      <TBODY>
                                        <TR>
                                          <TD bgColor="#73B549"><IMG height="1" src="img/spacer.gif" width="1"></TD>
                                        </TR>
                                      </TBODY>
                                  </TABLE></TD>
                                </TR>
                                <TR>
                                  <TD height="55" colspan="2" valign="top" id="submenu6" style="DISPLAY: yes"><div>
                                      <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                        
                                        <tr>
                                          <TD width="22" height="55" valign="top"></TD>
                                          <TD width="76" valign="top"><img height="55" src="img/acopdflogo2.gif" width="55" /></TD>
                                          <TD width="462" valign="middle"><strong><strong><span class="STYLE14">
                                            <%if(!StrUtil.toHtmlTag(productsTable.getEc1()).equals("")){%>
                                            <a href="product/ec/<%=StrUtil.toHtmlTag(productsTable.getEc1())%>" class="STYLE14"><%=StrUtil.toHtmlTag(productsTable.getEc1Word())%></a>
                                            <%}%>
                                            <br />
                                            <%if(!StrUtil.toHtmlTag(productsTable.getEc2()).equals("")){%>
                                            <a href="product/ec/<%=StrUtil.toHtmlTag(productsTable.getEc2())%>" class="STYLE14"><%=StrUtil.toHtmlTag(productsTable.getEc2Word())%></a></span>
                                                  <%}%>
                                          </strong></strong> </TD>
                                        </tr>
                                      </table>
                                  </div></TD>
                                </TR>
                              </TBODY>
                            </TABLE>
                          
						  <BR><%}%>
                            <TABLE cellSpacing="0" cellPadding="0" width="560" border="0">
                              
                              <TBODY>
                                <TR id="menuTitle7" onClick="showsubmenu(7)" style="cursor:pointer;" >
                                  <TD width="20" height="16" valign="top" id="change_bg7" background="img/lo.gif"></TD>
                                  <TD width="540"><strong>User Comments(Q&A, Below 6KB)</strong><span style="font-size:9pt;font-family:Arial;color:black;mso-font-kerning: 0pt">
                                    <strong>：</strong></span></TD>
                                </TR>
                                <TR>
                                  <TD height="12" colspan="2"><TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
                                      <TBODY>
                                        <TR>
                                          <TD bgColor="#73B549"><IMG height="1" src="img/spacer.gif" width="1"></TD>
                                        </TR>
                                      </TBODY>
                                  </TABLE></TD>
                                </TR>
                                <TR>
                                  <TD  colspan="2" valign="top" id="submenu7" >
								  <form  name="form_com" action="com_do.jsp"   method="POST" onSubmit="return on_submit_com()" >
                                      <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                        
                                        
                                          <tr>
                                            <TD width="22" height="15">&nbsp;</TD>
                                            <TD width="538"  align="left" valign="middle"><span class="STYLE38"><span class="STYLE39">Note: If you need our feedback to your comments, please sign in at first! </span></span></TD>
                                          </tr>
                                          <tr>
                                            <TD colspan="2"  align="left" valign="middle">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                <input name="need_fb" type="checkbox" id="need_fb" value="Yes">
                                              Need Feedback!</TD>
                                          </tr>
                                          <tr>
                                            <TD  colspan="2" align="center" valign="middle"><TEXTAREA  name=com_content rows=8 wrap="hard" cols=60></TEXTAREA></TD>
                                          </tr>
                                          <tr>
                                            <TD height="21" colspan="2" align="center" valign="bottom"><input name="Action" type="hidden" id="Action" value="ok">
                                                <input name="p_id_com" type="hidden" id="p_id_com" value="<%=pId%>">
                                                <img src="img/r-8.jpg" width="71" height="20" style="CURSOR:pointer;" 
                        onClick="javascript:on_reset()"> &nbsp;&nbsp;&nbsp;
                                                <input name="Input" type="image" src="img/r-9.jpg" />                                            </TD>
                                          </tr>
                                      </table>
									  </form></TD>
                                </TR>
                              </TBODY>
                          </TABLE></td>
                      </tr>
                  </table></td>
                </tr>
              </tbody>
            </table>
          </div></TD>
          </TR>
        </TBODY></TABLE></TD></TR>
</TBODY></TABLE>
<%@ include file="foot.jsp"%>
</BODY></HTML>