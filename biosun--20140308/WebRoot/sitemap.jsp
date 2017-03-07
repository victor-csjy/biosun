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
<%@page import="hk.com.biosun.define.ArticleTypeDef"%>
<%
String flashName=ArticleTypeDef.getArticleTypeFlashName("index");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML xmlns:asp xmlns:uc1>
<HEAD>
<TITLE>Welcome to Biosun Technology Co., Ltd.</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<LINK 
href="css/style.css" type=text/css rel=stylesheet>
<SCRIPT src="js/js.js" type=text/javascript></SCRIPT>
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
                      <TD width=778  valign="bottom"><%@ include file="header.jsp"%>
                      </TD>
                    </TR>
                    <TR>
                      <TD width=778 bgColor=#ffffff height=6></TD>
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
          </TBODY>
        </TABLE>
        <TABLE cellSpacing=0 cellPadding=0 width=778 align=center border=0>
          
          <TBODY>
            <TR>
              <TD width=191 align="center" vAlign=top bgcolor="#E3E9F6" ><table width="191" border="0" cellpadding="0" cellspacing="0">
                  
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
                                <td height="18" valign="top">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="img/pc-17a.gif" width="8" height="9" /><a href="change_inf.jsp" class="STYLE26">Update Information</a></td>
                              </tr>
                              <tr>
                                <td height="18" valign="top">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="img/pc-17a.gif" width="8" height="9" /><a href="find_password.jsp" class="STYLE26">Forget Password</a><a href="sitemap.jsp" class="STYLE26"></a></td>
                              </tr>
                              <tr>
                                <td height="18" valign="top">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="img/pc-17a.gif" width="8" height="9" /><a href="sitemap.jsp" class="STYLE26"><font color="#FF0000"  ><strong>Sitemap</strong></font></a></td>
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
                </table></TD>
              <TD rowspan="8" vAlign=top><TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
                  
                  <TBODY>
                    <TR>
                      <TD colspan="2"><div align="right">
                          <script language="javascript">
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
                        </div></TD>
                    </TR>
                    <TR>
                      <TD height=37 colspan="2" ><table width="97%" border="0" align="right" cellpadding="0" cellspacing="3">
                          
                          <tr>
                            <td width="3%" height="30"><div align="left"><img src="img/dian.gif" width="15" height="15"></div></td>
                            <td width="191"><span class="STYLE27">Site map</span></td>
                            <td width="368" align="right"><span class="STYLE34">You are here</span> <STRONG>:</STRONG><a href="index.jsp" class="STYLE26">Home</a>--<a href="#"  class="STYLE26">Sitemap</a> </td>
                          </tr>
                        </table></TD>
                    </TR>
                    <tr>
                      <td height="3" colspan="2" valign=top class=MainText><div align="right"><img src="img/pc-16.gif" width="580" height="3"></div></td>
                    </tr>
                    <TR>
                      <TD width="61" height=16>&nbsp;</TD>
                      <TD width="531">&nbsp;</TD>
                    </TR>
                    <TR>
                      <TD>&nbsp;</TD>
                      <TD valign="top" ><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#73B549" bordercolordark="#FFFFFF">
                          
                          <tr>
                            <td width="64" height="25" valign="middle"><strong><a href="index.jsp"  class="STYLE26">&nbsp;&nbsp;Home:</a></strong></td>
                            <td width="145" >&nbsp;&nbsp;<a href="index.jsp" class="STYLE26">English</a></td>
                            <td width="164" >&nbsp;&nbsp;<a href="index_cn.jsp" class="STYLE26">中文版</a></td>
                            <td width="158" >&nbsp;&nbsp;<a href="article.jsp?articleId=21&articleType=terms_of_use"  class="STYLE26">Terms of Use</a></td>
                          </tr>
                          <tr>
                            <td height="25" >&nbsp;</td>
                            <td  >&nbsp;&nbsp; <a href="reg.jsp" class="STYLE26">New User Sign Up</a></td>
                            <td  >&nbsp;&nbsp;<a href="login.jsp" class="STYLE26"> Sign In</a></td>
                            <td  >&nbsp;&nbsp;<a href="change_inf.jsp" class="STYLE26"> Update Information</a></td>
                          </tr>
                          <tr>
                            <td height="25" >&nbsp;</td>
                            <td  >&nbsp;&nbsp; <a href="find_password.jsp" class="STYLE26">Forget Password</a></td>
                            <td  >&nbsp;&nbsp;<a href="sitemap.jsp" class="STYLE26">Sitemap</a></td>
                            <td  ><!--DWLayoutEmptyCell-->&nbsp;</td>
                          </tr>
                          <tr>
                            <td height="11" colspan="4" valign="bottom"><img src="img/new0.gif" width="530" height="11"></td>
                          </tr>
                          <tr>
                            <td  valign="middle" class="STYLE26" ><span class="STYLE31"><strong>&nbsp;&nbsp;<a href="article.jsp?articleType=about_us"  class="STYLE26">About Us:</a></strong></span></td>
                            <td colspan="3" rowspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                  <%
            Article article;
            ArticleService  articleService=new ArticleService();
            List<Article> articleList=articleService.getListFront("about_us");
            int articleListSize=articleList==null?0:articleList.size();
            for(int i=0;i<articleListSize;i++){
               article=articleList.get(i);
			   if(i%3==0&&i!=0){
			       out.println("</tr><tr>");
			   }
			   %>
                                  <td width="155" height="26" valign="top">&nbsp;&nbsp;<a href="article.jsp?articleType=about_us&articleId=<%=article.getArticleId()%>" class="STYLE26"><%=StrUtil.toHtmlTag(article.getTitle())%></a></td>
                                  <%
			
			} %>
                                </tr>
                              </table>
							  </td>
                          </tr>
						  
                          <tr>
                            <td height="11" colspan="4" valign="bottom"  ><img src="img/new0.gif" width="530" height="11"></td></tr>
                         
                          <tr>
                            <td valign="middle" class="STYLE31" ><strong>&nbsp;&nbsp;<a href="news.jsp"  class="STYLE26">Events:</a></strong></td>
                            <td colspan="3" rowspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tr>
            <%
			NewsTypeService newsTypeService=new NewsTypeService();
            NewsType newsType; 
			List<NewsType> newsTypeList=newsTypeService.getList();
			int newsTypeListSize=newsTypeList!=null?newsTypeList.size():0;
			for(int i=0;i<newsTypeListSize;i++){
			   newsType=newsTypeList.get(i);
			   if(i%3==0&&i!=0){
			       out.println("</tr><tr>");
			   }
			   %>
                                  <td width="155" height="26" valign="top">&nbsp;&nbsp;<a href="news_list.jsp?news_type=<%=newsType.getNewsType()%>" class="STYLE26"><%=StrUtil.toHtmlTag(newsType.getNewsName())%></a></td>
            <%
			
			} %>
                                </tr>
                              </table>
							  </td>
							  
							  
                          </tr>
                          <tr>
                            <td height="11" colspan="4" valign="bottom" ><img src="img/new0.gif" width="530" height="11"></td>
                          </tr>
                         
						  <tr>
						  <td valign="middle" ><strong class="STYLE31">&nbsp;&nbsp;<a href="products.jsp"  class="STYLE26">Products</a>:</strong></td>
                            <td colspan="3" rowspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tr>
            <%
			                           BigTableService bigTableService=new BigTableService();
                                       BigTable bigTable;
                                       List<BigTable> bigTableList=bigTableService.getListFront();
                                       int bigTableListSize=bigTableList==null?0:bigTableList.size();
                                       
                                       for(int i=0;i<bigTableListSize;i++){
                                            bigTable=bigTableList.get(i);
			                                    if(i%3==0&&i!=0){
			                                        out.println("</tr><tr>");
			                                    }
			   %>
                                  <td width="155" height="26" valign="top">&nbsp;&nbsp;<a href="product_big.jsp?big_id=<%=bigTable.getBigId()%>" class="STYLE26"><%=StrUtil.toHtmlTag(bigTable.getBigName())%></a></td>
            <%
			} %>
                                </tr>
                              </table>
							  </td>
                          </tr>
                         
                          <tr>
                            <td height="11" colspan="4" valign="bottom" ><img src="img/new0.gif" width="530" height="11"></td>
                          </tr>
                        
						
                          <tr>
                            <td  valign="middle" ><strong>&nbsp;&nbsp;<a href="article.jsp?articleType=sale_and_market"  class="STYLE26">Sale &amp; </a>&nbsp;&nbsp;<a href="article.jsp?articleType=sale_and_market"  class="STYLE26">Market</a>:&nbsp;</strong></td>
                           <td colspan="3" rowspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                  <%
           
            articleList=articleService.getListFront("sale_and_market");
            articleListSize=articleList==null?0:articleList.size();
            for(int i=0;i<articleListSize;i++){
               article=articleList.get(i);
			   if(i%3==0&&i!=0){
			       out.println("</tr><tr>");
			   }
			   %>
                                  <td width="155" height="26" valign="top">&nbsp;&nbsp;<a href="article.jsp?articleType=sale_and_market&articleId=<%=article.getArticleId()%>" class="STYLE26"><%=StrUtil.toHtmlTag(article.getTitle())%></a></td>
                                  <%
			
			} %>
                                </tr>
                              </table>
							  </td>
                          </tr>
                       
                          <tr>
                            <td height="8" colspan="4" valign="bottom"><img src="img/new0.gif" width="530" height="11"></td>
                          </tr>
                         
                          <tr>
                            <td valign="middle" ><strong>&nbsp;&nbsp;<a href="article.jsp?articleType=service"  class="STYLE26">Service:</a>&nbsp;</strong></td>
                             <td colspan="3" rowspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                  <%
           
            articleList=articleService.getListFront("service");
            articleListSize=articleList==null?0:articleList.size();
            for(int i=0;i<articleListSize;i++){
               article=articleList.get(i);
			   if(i%3==0&&i!=0){
			       out.println("</tr><tr>");
			   }
			   %>
                                  <td width="155" height="26" valign="top">&nbsp;&nbsp;<a href="article.jsp?articleType=service&articleId=<%=article.getArticleId()%>" class="STYLE26"><%=StrUtil.toHtmlTag(article.getTitle())%></a></td>
            <%
			
			} %>
                                </tr>
                              </table>
							  </td>
                          </tr>
						  
						  
                          <tr>
                            <td height="8" colspan="4" valign="bottom"><img src="img/new0.gif" width="530" height="11"></td>
                          </tr>
                        
                          <tr>
                            <td  valign="middle" ><strong>&nbsp;&nbsp;<a href="article.jsp?articleType=careers"  class="STYLE26">Careers</a>:&nbsp;</strong></td>
                           <td colspan="3" rowspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                  <%
           
            articleList=articleService.getListFront("careers");
            articleListSize=articleList==null?0:articleList.size();
            for(int i=0;i<articleListSize;i++){
               article=articleList.get(i);
			   if(i%3==0&&i!=0){
			       out.println("</tr><tr>");
			   }
			   %>
                                  <td width="155" height="26" valign="top">&nbsp;&nbsp;<a href="article.jsp?articleType=careers&articleId=<%=article.getArticleId()%>" class="STYLE26"><%=StrUtil.toHtmlTag(article.getTitle())%></a></td>
            <%
			
			} %>
                                </tr>
                              </table>
							  </td>
                          </tr>
						  
						  
                          <tr>
                            <td height="8" colspan="4" valign="bottom"><img src="img/new0.gif" width="530" height="11"></td>
                          </tr>
                          
						  
                          <tr>
                            <td valign="middle" class="STYLE26" ><strong>&nbsp;&nbsp;<a href="article.jsp?articleType=contact"  class="STYLE26">Contact:</a>&nbsp;</strong></td>
                           <td colspan="3" rowspan="2" valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                  <%
           
            articleList=articleService.getListFront("contact");
            articleListSize=articleList==null?0:articleList.size();
            for(int i=0;i<articleListSize;i++){
               article=articleList.get(i);
			   if(i%3==0&&i!=0){
			       out.println("</tr><tr>");
			   }
			   %>
                                  <td width="155" height="26" valign="top">&nbsp;&nbsp;<a href="article.jsp?articleType=contact&articleId=<%=article.getArticleId()%>" class="STYLE26"><%=StrUtil.toHtmlTag(article.getTitle())%></a></td>
            <%
			
			} %>
                                </tr>
                              </table>
							  </td>
                          </tr>
						   <tr>
                            <td height="8" colspan="4" valign="bottom"><img src="img/new0.gif" width="530" height="11"></td>
                          </tr>
						  
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