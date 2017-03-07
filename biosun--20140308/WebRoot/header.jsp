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
<script language=javascript type=text/javascript>
<!--
function showOrHide(id,showHide){
   var obj=document.getElementById(id);
   if(showHide==1){
      obj.style.display="block";
   }else{
      obj.style.display="none";
   }
}
//-->
</script>
<style>
.datetime_css {color: #FFFFFF;font-size: 11px;}

</style>
<TABLE cellSpacing=0 cellPadding=0 width=778 align=center 
border=0>
  <TBODY>
    <TR>
      <TD width=778 height=60 valign="top" background="img/banner1.gif"><table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td width="778" height="56" valign="bottom" background="img/banner1.gif"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td width="71%">&nbsp;</td>
                  <td width="17%"><a href="sitemap.jsp"><img src="img/1.gif" width="128" height="21" border="0" /></a></td>
                  <td width="12%"><a href="index_cn.jsp"><img src="img/2.gif" width="96" height="21" border="0" /></a></td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                  <td><a href="article.jsp?articleId=21&articleType=terms_of_use"><img src="img/3.gif" width="128" height="21" border="0" /></a></td>
                  <td><a href="index.jsp"><img src="img/4.gif" width="95" height="21" border="0" /></a></td>
                </tr>
              </table></td>
          </tr>
        </table></TD>
    </TR>
    <TR>
      <TD height=32 valign="top"><TABLE cellSpacing=0 cellPadding=0 width=778 align=center border=0>
          <TBODY>
            <TR>
              <TD valign="bottom"><table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" background="img/007.gif">
                  <tr>
                    <td><table width="100%" border="0" cellpadding="0" cellspacing="0" >
                        <tbody  >
                          <tr >
                            <td width="200" height="20" valign="middle"><span class="datetime_css">&nbsp;&nbsp;Beijing Time: <%=DateUtil.formatDate(System.currentTimeMillis(),13)%> </span> </td>
                            <td rowspan="2" align="center"><div align="center"><a href="index.jsp">Home</a></div></td>
                            <td width="16" rowspan="2" align="center"><span class="STYLE12">|</span></td>
                            <td rowspan="2" align="center" onmouseover="showOrHide('layerId0',1)" onmouseout="showOrHide('layerId0',0)"><div align="center"><a href="article.jsp?articleType=about_us"><span class="STYLE12">&nbsp;</span>About Us</a></div></td>
                            <td width="17" rowspan="2" align="center" ><div align="center"><span class="STYLE12">&nbsp;|</span></div></td>
                            <td rowspan="2" align="center" onmouseover="showOrHide('layerId1',1)" onmouseout="showOrHide('layerId1',0)"><div align="center"><span class="STYLE12">&nbsp;&nbsp;</span><a href="news.jsp" >Events</a></div></td>
                            <td width="17" rowspan="2" align="center" ><div align="center"><span class="STYLE12">&nbsp;|</span></div></td>
                            <td rowspan="2" align="center"   onmouseover="showOrHide('layerId2',1)" onmouseout="showOrHide('layerId2',0)" ><div align="center"><span class="STYLE12">&nbsp;&nbsp;</span><a href="products.jsp">Products</a></div></td>
                            <td width="17" rowspan="2" align="center"  ><div align="center"><span class="STYLE12">&nbsp;&nbsp;</span><span class="STYLE12">|</span></div></td>
                            <td rowspan="2" align="center"  onmouseover="showOrHide('layerId3',1)" onmouseout="showOrHide('layerId3',0)"><div align="center"><a href="article.jsp?articleType=sale_and_market">Sale & Market</a><span class="STYLE12">&nbsp;</span></div></td>
                            <td width="16" rowspan="2" align="center"  ><div align="center"><span class="STYLE12">|</span></div></td>
                            <td rowspan="2" align="center"  onmouseover="showOrHide('layerId4',1)" onmouseout="showOrHide('layerId4',0)" ><div align="center"><a href="article.jsp?articleType=service">Service</a></div></td>
                            <td width="16" rowspan="2" align="center"  ><div align="center"><span class="STYLE12">|</span></div></td>
                            <td rowspan="2" align="center" onmouseover="showOrHide('layerId5',1)" onmouseout="showOrHide('layerId5',0)" ><div align="center"><a href="article.jsp?articleType=careers" >Careers</a></div></td>
                            <td width="16" rowspan="2" align="center" ><div align="center"><span class="STYLE12">|</span></div></td>
                            <td rowspan="2" align="center"  onmouseover="showOrHide('layerId6',1)" onmouseout="showOrHide('layerId6',0)" ><div align="center"><a href="article.jsp?articleType=contact">Contact</a></div></td>
                            <td width="13" rowspan="2" align="center" ><!--DWLayoutEmptyCell-->&nbsp;</td>
                          </tr>
                          <tr >
                            <td height="1"></td>
                          </tr>
                          <tr>
                            <TD width="142" height="1" vAlign=top  >
                            
                            <DIV  style="Z-INDEX: 1; WIDTH: 3px; POSITION: absolute">
                                <div id=layerId0 style="Z-INDEX: 2; WIDTH: 150px; POSITION: absolute; HEIGHT: 20px; left: 257px; top: 0px; display:none;">
                                  <TABLE class=letter cellSpacing=1 cellPadding=0 width="100%" border=0 bgcolor=#E3E9F6 onmouseover="showOrHide('layerId0',1)" onmouseout="showOrHide('layerId0',0)">
                                    <TBODY>
                                      <%
            Article articleHeaherTmp;
            ArticleService  articleServiceHeaher=new ArticleService();
            List<Article> articleHeaherList=articleServiceHeaher.getListFront("about_us");
            int articleHeaherListSize=articleHeaherList!=null?articleHeaherList.size():0;
            for(int i=0;i<articleHeaherListSize;i++){
               articleHeaherTmp=articleHeaherList.get(i);
            %>
                                      <TR>
                                        <TD bgColor="#E3E9F6" height=20 ><DIV align="left">&nbsp;<img src="img/pc-17a.gif" width="8" height="9" /><a href="article.jsp?articleId=<%=articleHeaherTmp.getArticleId()%>&articleType=<%=articleHeaherTmp.getArticleType()%>" class="STYLE26"><%=StrUtil.toHtmlTag(articleHeaherTmp.getTitle())%></a></DIV></TD>
                                      </TR>
                                      <%}%>
                                    </TBODY>
                                  </TABLE>
                                </div>
                                
                                <div id=layerId1 style="Z-INDEX: 2; WIDTH: 150px; POSITION: absolute; HEIGHT: 1px; left: 339px; top: 0px; display:none;">
                                  <TABLE class=letter cellSpacing=1 cellPadding=0 width="100%"   border=0 bgcolor=#E3E9F6 onmouseover="showOrHide('layerId1',1)" onmouseout="showOrHide('layerId1',0)" >
                                    <TBODY>
                                      <%
			NewsTypeService newsTypeServiceHeaher=new NewsTypeService();
            NewsType newsTypeHeaher; 
			List<NewsType> newsTypeListHeaher=newsTypeServiceHeaher.getList();
			int newsTypeListHeaherSize=newsTypeListHeaher!=null?newsTypeListHeaher.size():0;
			for(int i=0;i<newsTypeListHeaherSize;i++){
			   newsTypeHeaher=newsTypeListHeaher.get(i);
			%>
                                      <TR>
                                        <TD bgColor=#E3E9F6 height=20><DIV align="left">&nbsp;<img src="img/pc-17a.gif" width="8" height="9" /><a href="news_list.jsp?news_type=<%=newsTypeHeaher.getNewsType()%>" class="STYLE26"><%=StrUtil.toHtmlTag(newsTypeHeaher.getNewsName())%></a> </DIV></TD>
                                      </TR>
                                      <%}%>
                                    </TBODY>
                                  </TABLE>
                                </div>
                                
                                <div id=layerId2 style="Z-INDEX: 2; WIDTH: 210px; POSITION: absolute; HEIGHT: 1px; left: 406px; top: 0px; display:none;">
                                  <TABLE class=letter cellSpacing=1 cellPadding=0 width="100%"  border=0 bgcolor=#E3E9F6 onmouseover="showOrHide('layerId2',1)" onmouseout="showOrHide('layerId2',0)" >
                                    <TBODY>
                                      <%
                                       BigTableService bigTableServiceHeaher=new BigTableService();
                                       BigTable bigTableHeaher;
                                       List<BigTable> bigTableListHeaher=bigTableServiceHeaher.getListFront();
                                       int bigTableListSizeHeaher=bigTableListHeaher==null?0:bigTableListHeaher.size();
                                       
                                       SmallTableService smallTableServiceHeaher=new SmallTableService();
                                       SmallTable smallTableHeaher;
                                       List<SmallTable> smallTableListHeaher;
                                       int smallTableListSizeHeaher=0;
                                       
                                       for(int i=0;i<bigTableListSizeHeaher;i++){
                                            bigTableHeaher=bigTableListHeaher.get(i);
                                       %>
                                      <TR>
                                        <TD bgColor=#E3E9F6 height=20><DIV align="left">&nbsp;<img src="img/pc-17a.gif" width="8" height="9" /><a href="product_big.jsp?big_id=<%=bigTableHeaher.getBigId()%>" class="STYLE26"><%=StrUtil.toHtmlTag(bigTableHeaher.getBigName())%></a></DIV></TD>
                                      </TR>
                                      <%
                                            smallTableListHeaher=smallTableServiceHeaher.getListFront(bigTableHeaher.getBigId());
                                            smallTableListSizeHeaher=smallTableListHeaher==null?0:smallTableListHeaher.size();
                                            for(int j=0;j<smallTableListSizeHeaher;j++){
                                                smallTableHeaher=smallTableListHeaher.get(j);
                                      %>
                                      <TR>
                                        <TD bgColor=#E3E9F6 height=20><DIV align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="img/pc-17a.gif" width="8" height="9" /><a href="product_list.jsp?big_id=<%=smallTableHeaher.getBigId()%>&&small_id=<%=smallTableHeaher.getSmallId()%>" class="STYLE26"> <%=StrUtil.toHtmlTag(smallTableHeaher.getSmallName())%></a></DIV></TD>
                                      </TR>
                                      <%}
                                      }%>
                                    </TBODY>
                                  </TABLE>
                                </div>
                                
                                <div id=layerId3 style="Z-INDEX: 2; WIDTH: 150px; POSITION: absolute; HEIGHT: 1px; left: 485px; top: 0px; display:none;">
                                  <TABLE class=letter cellSpacing=1 cellPadding=0 width="100%"   border=0 bgcolor=#E3E9F6 onmouseover="showOrHide('layerId3',1)" onmouseout="showOrHide('layerId3',0)">
                                    <TBODY>
                                      <%
			articleHeaherList=articleServiceHeaher.getListFront("sale_and_market");
            articleHeaherListSize=articleHeaherList==null?0:articleHeaherList.size();
            for(int i=0;i<articleHeaherListSize;i++){
               articleHeaherTmp=articleHeaherList.get(i);	 
			%>
                                      <TR>
                                        <TD bgColor="#E3E9F6" height=20 ><DIV align="left">&nbsp;<img src="img/pc-17a.gif" width="8" height="9" /><a href="article.jsp?articleId=<%=articleHeaherTmp.getArticleId()%>&articleType=<%=articleHeaherTmp.getArticleType()%>" class="STYLE26"><%=StrUtil.toHtmlTag(articleHeaherTmp.getTitle())%></a></DIV></TD>
                                      </TR>
                                      <%}%>
                                    </TBODY>
                                  </TABLE>
                                </div>
                                
                                <div id=layerId4 style="Z-INDEX: 2; WIDTH: 150px; POSITION: absolute; HEIGHT: 1px; left: 588px; top: 0px; display:none;">
                                  <table class=letter cellspacing=1 cellpadding=0 width="100%"  border=0 bgcolor=#E3E9F6 onmouseover="showOrHide('layerId4',1)" onmouseout="showOrHide('layerId4',0)" >
                                    <tbody>
                                      <%
			articleHeaherList=articleServiceHeaher.getListFront("service");
            articleHeaherListSize=articleHeaherList==null?0:articleHeaherList.size();
            for(int i=0;i<articleHeaherListSize;i++){
               articleHeaherTmp=articleHeaherList.get(i);	 
			%>
                                      <TR>
                                        <TD bgColor="#E3E9F6" height=20 ><DIV align="left">&nbsp;<img src="img/pc-17a.gif" width="8" height="9" /><a href="article.jsp?articleId=<%=articleHeaherTmp.getArticleId()%>&articleType=<%=articleHeaherTmp.getArticleType()%>" class="STYLE26"><%=StrUtil.toHtmlTag(articleHeaherTmp.getTitle())%></a></DIV></TD>
                                      </TR>
                                      <%}%>
                                    </tbody>
                                  </table>
                                </div>
                                <div id=layerId5 style="Z-INDEX: 2; WIDTH: 120px; POSITION: absolute; HEIGHT: 1px; left: 650px; top: 0px; display:none;">
                                  <table class=letter cellspacing=1 cellpadding=0 width="100%"   border=0 bgcolor=#E3E9F6 onmouseover="showOrHide('layerId5',1)" onmouseout="showOrHide('layerId5',0)" >
                                    <tbody>
                                      <%
			articleHeaherList=articleServiceHeaher.getListFront("careers");
            articleHeaherListSize=articleHeaherList==null?0:articleHeaherList.size();
            for(int i=0;i<articleHeaherListSize;i++){
               articleHeaherTmp=articleHeaherList.get(i);	 
			%>
                                      <TR>
                                        <TD bgColor="#E3E9F6" height=20 ><DIV align="left">&nbsp;<img src="img/pc-17a.gif" width="8" height="9" /><a href="article.jsp?articleId=<%=articleHeaherTmp.getArticleId()%>&articleType=<%=articleHeaherTmp.getArticleType()%>" class="STYLE26"><%=StrUtil.toHtmlTag(articleHeaherTmp.getTitle())%></a></DIV></TD>
                                      </TR>
                                      <%}%>
                                    </tbody>
                                  </table>
                                </div>
                                <div id=layerId6 style="Z-INDEX: 2; WIDTH: 100px; POSITION: absolute; HEIGHT: 20px; left: 678px; top: 0px; display:none;">
                                  <table class=letter cellspacing=1 cellpadding=0 width="100%" bgcolor=#E3E9F6 onmouseover="showOrHide('layerId6',1)" onmouseout="showOrHide('layerId6',0)">
                                    <tbody>
                                      <%
			articleHeaherList=articleServiceHeaher.getListFront("contact");
            articleHeaherListSize=articleHeaherList==null?0:articleHeaherList.size();
            for(int i=0;i<articleHeaherListSize;i++){
               articleHeaherTmp=articleHeaherList.get(i);	 
			%>
                                      <TR>
                                        <TD bgColor="#E3E9F6" height=20 ><DIV align="left">&nbsp;<img src="img/pc-17a.gif" width="8" height="9" /><a href="article.jsp?articleId=<%=articleHeaherTmp.getArticleId()%>&articleType=<%=articleHeaherTmp.getArticleType()%>" class="STYLE26"><%=StrUtil.toHtmlTag(articleHeaherTmp.getTitle())%></a></DIV></TD>
                                      </TR>
                                      <%}%>
                                    </tbody>
                                  </table>
                                
                                </div>
                                
                              </div></TD>
                            <td width="2"></td>
                            <td></td>
                          </tr>
                        </tbody>
                      </table></td>
                  </tr>
                </table></TD>
            </TR>
            <TR>
              <TD width=778 bgColor=#FF0000 height=6></TD>
            </TR>
          </TBODY>
        </TABLE></TD>
    </TR>
  </TBODY>
</TABLE>
