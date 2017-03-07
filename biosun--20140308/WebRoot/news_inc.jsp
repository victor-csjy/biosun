<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="com.aokle.util.StrUtil"%>
<%@page import="com.aokle.util.MathUtil"%>
<%@page import="hk.com.biosun.model.NewsType"%>
<%@page import="hk.com.biosun.service.NewsTypeService"%>
<%
int newsTypeIdNewsInc=MathUtil.toInt(request.getParameter("news_type"));
NewsTypeService newsTypeServiceNewsInc=new NewsTypeService();
List<NewsType> newsTypeNewsIncList=newsTypeServiceNewsInc.getList();
int newsTypeNewsIncListSize=newsTypeNewsIncList!=null?newsTypeNewsIncList.size():0;
NewsType newsTypeNewsInc;
%>
<style type="text/css">
<!--
.STYLE1 {
	color: #FFFFFF;
	font-weight: bold;
}
-->
</style>
<table width="191" border="0" cellpadding="0" cellspacing="0">
                      
                      <tr>
                        <td><table border="0" cellpadding="0" cellspacing="0">
                          <tr>
                            <td height="33" colspan="3" background="img/about-1.gif"><table width="100%" border="0" cellpadding="0" cellspacing="5">
                              <tr>
                                <td width="9%"></td>
                                <td width="91%"><span class="STYLE1">Events</span></td>
                              </tr>
                            </table></td>
                          </tr>
                          <tr>
                            <td width="6" background="img/a3.jpg">&nbsp;</td>
                                        <td width="179" valign="top"><table width="179" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
                                            <tr>
                                              <td>
                                              <%for(int iNewsInc=0;iNewsInc<newsTypeNewsIncListSize;iNewsInc++){ 
                                                newsTypeNewsInc=newsTypeNewsIncList.get(iNewsInc);
                                              %>	 
                                                
                                                <table width="100%" border="0" cellpadding="0" cellspacing="2">
                                                  <tr>
                                                    <td width="18%"><div align="center"><img src="img/pc-14.gif" width="14" height="15">&nbsp;&nbsp;</div></td>
<td width="82%">


	
<a href="news_list.jsp?news_type=<%=newsTypeNewsInc.getNewsType()%>" class="STYLE26">

<%if(newsTypeNewsInc.getNewsType()==newsTypeIdNewsInc ||(newsTypeIdNewsInc==0&&iNewsInc==0)){%>
	<font color="#FF0000"  >
	<strong>
	<%=StrUtil.toHtmlTag(newsTypeNewsInc.getNewsName())%>
	</strong></font>	
	<%}
	else {%><%=StrUtil.toHtmlTag(newsTypeNewsInc.getNewsName())%>
	<%}%>
	</a>
</td>
                                                  </tr>
                                                  <tr>
                                                    <td colspan="2"><img src="img/0-1.gif" width="170" height="11"></td>
                                                  </tr>
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
                      <tr>
                        <td height="8"></td>
  </tr>
</table>