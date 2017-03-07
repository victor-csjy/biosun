<%@page contentType="text/html;charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@page import="com.aokle.util.StrUtil"%>
<%@page import="com.aokle.util.MathUtil"%>
<%@page import="hk.com.biosun.util.ReqParamUtil"%>
<%@page import="hk.com.biosun.model.Article"%>
<%@page import="hk.com.biosun.service.ArticleService"%>
<%@page import="hk.com.biosun.define.ArticleTypeDef"%>
<%
int articleId=MathUtil.toInt(request.getParameter("articleId"));
String articleType=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("articleType")));
ArticleService articleService=new ArticleService();
Article article=articleService.getByPKFront(articleId,articleType);
if(article==null){
   out.println("<script language=\"javascript\" type=\"text/javascript\">alert('No Infomation');javascript:location.href='index.jsp';</script>");
   return; 
}else{
  articleService.updateBrowseTimes(article.getArticleId(),1);
}
List<Article> list=articleService.getListFront(articleType);
int listSize =list==null?0:list.size();
Article articleTmp;
String flashName=ArticleTypeDef.getArticleTypeFlashName(article.getArticleType());
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML xmlns:asp xmlns:uc1><HEAD><TITLE><%=article.getTitle()%>-Welcome to Biosun Technology Co., Ltd.</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<LINK href="css/style.css" type=text/css rel=stylesheet>
</HEAD>
<BODY>
<SCRIPT src="js/js.js" type=text/javascript></SCRIPT>

<TABLE width=778 border=0 align=center cellPadding=0 cellSpacing=0 bgcolor="#FFFFFF">
  <TBODY>
  <TR>
    <TD>
      <TABLE cellSpacing=0 cellPadding=0 width=778 align=center border=0>
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
        </TBODY></TABLE></TD></TR>
  <TR>
    <TD>
      <TABLE cellSpacing=0 cellPadding=0 width=778 align=center border=0>
        <TBODY>
        <TR>
          <TD height=6></TD>
        </TR></TBODY></TABLE>
      <TABLE cellSpacing=0 cellPadding=0 width=778 align=center border=0>
        
        <TBODY>
        <TR>
          <TD width=191 vAlign=top bgcolor="#E3E9F6" ><table width="191" border="0" cellpadding="0" cellspacing="0">
            
            
            <tr>
              <td height="130" valign="top"><div align="center">
                <table border="0" cellpadding="0" cellspacing="0">
                  
                  
                  <tr>
                    <td height="130" valign="top"><table width="100%" height="16" border="0" cellpadding="0" cellspacing="0">
                      
                      <tr>
                        <td><table width="191" border="0" cellpadding="0" cellspacing="0">
                          
                          <tr>
                            <td height="33" colspan="3" background="img/about-1.gif"><table width="100%" border="0" cellpadding="0" cellspacing="5">
                              <tr>
                                <td width="9%">&nbsp;</td>
                                              <td width="91%"><span class="STYLE29"><%=ArticleTypeDef.getArticleTypeName(article.getArticleType())%></span></td>
                                            </tr>
                              </table></td>
                                      </tr>
                          <tr>
                            
                            
                            
                            
                            
                            
                            
                            
                           <td width="6" background="img/a3.jpg">&nbsp;</td>
                                        <td width="179" valign="top"><table width="179" border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
                                            
                                            <tr>
                                              <td>
                                                
                                                <%
                                                for(int i=0;i<listSize;i++){
                                                   articleTmp=list.get(i);
                                               %>	  
                                                <table width="100%" border="0" cellpadding="0" cellspacing="2">
                                                  <tr>
                                                    <td width="18%"><div align="center"><img src="img/pc-14.gif" width="14" height="15">&nbsp;&nbsp;</div></td>
                                                    <td width="82%">
                                                      <a href="article.jsp?articleId=<%=articleTmp.getArticleId()%>&articleType=<%=articleTmp.getArticleType()%>" class="STYLE26<%=(articleTmp.getArticleId()==article.getArticleId())?" title":"" %>"><%=StrUtil.fomatStr(StrUtil.toHtmlTag(articleTmp.getTitle()),22)%></a></td>
                                                  </tr>
                                                  <tr>
                                                    <td colspan="2"><img src="img/0-1.gif" width="170" height="11"></td>
                                                  </tr>
                                                </table>
										      <%}%>	</td>
                                            </tr>
                                       </table></td>
									<td width="6"  background="img/a3.jpg">&nbsp;</td>	  
                              </tr>
                          <tr>
                            <td height="8" colspan="3" valign="top"><img src="img/about.gif" width="191" height="8"></td>
                                      </tr>
                          
                          
                              </table>			                      </td>
                                </tr>
                      <tr>
                        <td><!--DWLayoutEmptyCell-->&nbsp;</td>
                      </tr>
                      <tr>
                        <td><%@ include file="left.jsp"%></td>
                      </tr>
                      
                      
                      </table></td>
                          </tr>
                    </table>
                    </div></td>
                  </tr>
            
          </table></TD>
          <TD width=592 rowspan="3" vAlign=top>
            <TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
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
                <TD class=MainText vAlign=top>&nbsp;</TD>
              </TR>
              <TR>
                <TD class=MainText vAlign=top><table width="580" border="0" align="right" cellpadding="0" cellspacing="3">
                  
                  <tr>
                    <td width="3%" height="18"><div align="left"><img src="img/dian.gif" width="15" height="15"></div></td>
                    <td width="264" valign="top"><span class="STYLE27">
					<%=StrUtil.toHtmlTag(article.getTitle())%>					
					</span></td>
                    <td width="282" align="right" valign="top"><span class="STYLE34">You are here</span> <STRONG>:</STRONG><a href="index.jsp" class="STYLE26">Home</a>--<span class="STYLE35"><a href="article.jsp?articleType=<%=article.getArticleType()%>" class="STYLE26"><%=ArticleTypeDef.getArticleTypeName(article.getArticleType())%></a></span></td>
                  </tr>
                </table></TD>
              </TR>
              <TR>
                <TD class=MainText vAlign=top><div align="right"><img src="img/pc-16.gif" width="580" height="3"></div></TD>
              </TR>
              <TR>
                <TD class=MainText vAlign=top>&nbsp;</TD>
              </TR>
              <TR>
                <TD height=5><TABLE cellSpacing=0 cellPadding=0 width=95% align=center border=0>
                  <TBODY>
                    <TR>
                      <TD class=MainText vAlign=bottom><%=StrUtil.toHtmlTag(article.getContent())%></TD></TR>
                  </TBODY>
                </TABLE></TD>
              </TR>              
              </TBODY></TABLE></TD>          
        </TR>
        
        </TBODY></TABLE></TD></TR>
  </TBODY></TABLE>
<%@ include file="foot.jsp"%>
</BODY></HTML>