<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="com.aokle.util.StrUtil"%>
<%@page import="hk.com.biosun.model.Article"%>
<%@page import="hk.com.biosun.service.ArticleService"%>
<%@page import="hk.com.biosun.model.NewsType"%>
<%@page import="hk.com.biosun.service.NewsTypeService"%>
<%@page import="hk.com.biosun.model.UserInf"%>
<%@page import="hk.com.biosun.service.BigTableService"%>
<%@page import="hk.com.biosun.service.SmallTableService"%>
<%@page import="hk.com.biosun.service.NewsTableService"%>
<%@page import="hk.com.biosun.model.NewsTable"%>
<%@page import="hk.com.biosun.model.ProductsTable"%>
<%@page import="hk.com.biosun.service.ProductsTableService"%>
<%
NewsTableService newsTableService=new NewsTableService();
List<NewsTable>  newsTableList=newsTableService.getListFront(-1,1,100,1);
int newsTableListSize=newsTableList!=null?newsTableList.size():0;
NewsTable newsTable;			 
ArticleService articleService=new ArticleService();
Article article=articleService.getByPK(26);
int articleBrowseTimes=article!=null?article.getBrowseTimes():0;//存储的是首页放的产品数量
if(articleBrowseTimes<1){
  articleBrowseTimes=6;
}
if(articleBrowseTimes>60){
  articleBrowseTimes=60;
}

ProductsTableService productsTableService=new ProductsTableService();
List<ProductsTable> productsTableList=productsTableService.getListFront(0,0,null,"index_order,order_id,p_date DESC", articleBrowseTimes,1);
int productsTableListSize=productsTableList!=null?productsTableList.size():0;
ProductsTable productsTable;

SmallTableService smallTableService=new SmallTableService();
SmallTable smallTable;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<TITLE>Welcome to Biosun Technology Co., Ltd.123</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<LINK href="css/style.css" type=text/css rel=stylesheet>
<SCRIPT src="js/js.js" type=text/javascript></SCRIPT>
<style type="text/css">
<!--
body {
	background-color: #FFFFFF;
}
.STYLE12 {color: #FFFFFF}

.STYLE26 {font-family: "Arial", Times, serif; font-size: 9pt; color: #000000; }
.STYLE30 {font-family: "Arial", Times, serif;font-size: 12px}
.STYLE31 {
	color: #FFFFFF;
	font-size: 14px;
	font-weight: bold;
}

.index_sys {font-family: "Arial", Times, serif;font-size: 12px}
-->
</style>
</HEAD>
<BODY >
<TABLE width=778 border=0 align=center cellPadding=0 cellSpacing=0 bgcolor="#FFFFFF">
  <TBODY>
    <TR>
      <TD><TABLE cellSpacing=0 cellPadding=0 width=778 align=center border=0>
          <TBODY>
            <TR>
              <TD><TABLE cellSpacing=0 cellPadding=0 width=778 align=center border=0>
                  <TBODY>
                    <TR>
                      <TD width=778  valign="bottom"><%@ include file="header.jsp"%>
                      </TD>
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
              <TD width="191" vAlign=top bgcolor="#E3E9F6" align="center" ><table border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td height="33" background="img/about-1.gif"><div align="center">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                          <tr>
                            <td width="29%"><div align="right" class="STYLE31">News</div></td>
                            <td width="68%"><div align="right"><span class="STYLE12"><img src="img/07.jpg" width="18" height="16"><a href="news.jsp">more...&nbsp;</a>&nbsp;&nbsp;&nbsp;</span></div></td>
                          </tr>
                        </table>
                      </div></td>
                  </tr>
                  <tr>
                    <td width="191" height="130" background="img/a3.jpg" align="center"><table width="179" border="0" align="center" cellpadding="0" cellspacing="0">
                        <tr>
                          <td width="178" height="167" valign="top" bgcolor="#FFFFFF"><div id="marquees">
                              <!-- 这些是字幕的内容，你可以任意定义 -->
                              <table width="100%" border="0" cellpadding="0" cellspacing="5">
                                <%
                          for(int i=0;i<newsTableListSize;i++){
                              newsTable=newsTableList.get(i);
                          %>
                                <tr>
                                  <td colspan="2"><span class="STYLE30"><a href="news_show.jsp?news_type=<%=newsTable.getNewsType()%>&&news_id=<%=newsTable.getNewsId()%>" class="STYLE26">· <%=StrUtil.fomatStr(StrUtil.toHtmlTag(newsTable.getNewsTitle()),25)%> </a></span></td>
                                </tr>
                                <%}%>
                              </table>
                            </div>
                            <script language="javascript">
<!--
marqueesHeight=165; //内容区高度
stopscroll=false; //这个变量控制是否停止滚动
with(marquees){
noWrap=true; //这句表内容区不自动换行
style.width=180; //于是我们可以将它的宽度设为0，因为它会被撑大
style.height=marqueesHeight;
style.overflowY="hidden"; //滚动条不可见
onmouseover=new Function("stopscroll=true"); //鼠标经过，停止滚动
onmouseout=new Function("stopscroll=false"); //鼠标离开，开始滚动
}
//这时候，内容区的高度是无法读取了。下面输出一个不可见的层"templayer"，稍后将内容复制到里面：
document.write('<div id="templayer" style="position:absolute;z-index:1;visibility:hidden"></div>');
function init(){ //初始化滚动内容
//多次复制原内容到"templayer"，直到"templayer"的高度大于内容区高度：
while(templayer.offsetHeight<marqueesHeight){
templayer.innerHTML+=marquees.innerHTML;
} //把"templayer"的内容的“两倍”复制回原内容区：
marquees.innerHTML=templayer.innerHTML+templayer.innerHTML;
//设置连续超时，调用"scrollUp()"函数驱动滚动条：
setInterval("scrollUp()",20);
}
document.body.onload=init;
preTop=0; //这个变量用于判断滚动条是否已经到了尽头
function scrollUp(){ //滚动条的驱动函数
if(stopscroll==true) return; //如果变量"stopscroll"为真，则停止滚动 
preTop=marquees.scrollTop; //记录滚动前的滚动条位置
marquees.scrollTop+=1; //滚动条向下移动一个像素
//如果滚动条不动了，则向上滚动到和当前画面一样的位置
//当然不仅如此，同样还要向下滚动一个像素(+1)：
if(preTop==marquees.scrollTop){
marquees.scrollTop=templayer.offsetHeight-marqueesHeight+1;
}
}
-->
</script></td>
                        </tr>
                      </table></td>
                  </tr>
                  <tr>
                    <td><img src="img/about.gif" width="191" height="8"></td>
                  </tr>
                </table>
                <table width="100%" border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td>&nbsp;</td>
                  </tr>
                  <tr>
                    <td><div align="center">
                        <%@ include file="left.jsp"%>
                      </div></td>
                  </tr>
                </table></TD>
              <TD width=592 rowspan="4" vAlign=top><TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
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
                        </div></TD>
                    </TR>
                    <TR>
                      <TD height=5><TABLE cellSpacing=0 cellPadding=0 width=580 align=right border=0>
                          <TBODY>
                            <TR>
                              <TD width="545" height="20" vAlign=top class=MainText>&nbsp;</TD>
                            </TR>
                            <TR>
                              <TD height="18" vAlign=top><span class="index_sys"><%=StrUtil.toHtmlTag(article.getContent())%></span></TD>
                            </TR>
                            <TR>
                              <TD align="right"  vAlign=top><A  href="article.jsp?articleType=about_us"><IMG  height=13 
             src="img/Buttons_ReadMoreA.gif" 
            width=67  border=0 ></A>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
                            </TR>
                          </TBODY>
                        </TABLE></TD>
                    </TR>
                    <TR>
                      <TD height=2>&nbsp;</TD>
                    </TR>
                    <TR>
                      <TD height=3><div align="right">
                          <TABLE width=580 border=0 cellPadding=0 cellSpacing=0 background="img/009.gif">
                            <TBODY>
                              <TR>
                                <TD width="29" height=20 valign="bottom"><div align="left">&nbsp;&nbsp;&nbsp;<img src="img/06.jpg" width="18" height="16"><span class="STYLE12"></span></div></TD>
                                <TD width="471" valign="middle"><span class="STYLE12">New Products </span></TD>
                                <TD width="74"><span class="STYLE12"><img src="img/07.jpg" width="18" height="16"><a href="products.jsp">more...</a></span></TD>
                              </TR>
                            </TBODY>
                          </TABLE>
                        </div></TD>
                    </TR>
                    <TR>
                      <TD><TABLE cellSpacing=0 cellPadding=0 width=100% align=right 
      border=0>
                          <TBODY>
                            <TR>
                              <TD height="180" align=middle vAlign=top><div align="right">
                                  <table width="100%" border="0">
                                    <TR>
                                      <TD height=6></TD>
                                    </TR>
                                  </table>
                                  <TABLE width=580 border=0 align="right" cellPadding=0 cellSpacing=0 
            background="img/Pixel.gif">
                                    <TBODY>
                               
                               <TR>
                               <%
                                for(int i=0;i<productsTableListSize;i++){
                                   productsTable=productsTableList.get(i);
                                   smallTable=smallTableService.getByPK(productsTable.getSmallId());
								   if(i!=0&&i%3==0){
								           out.print("</tr><tr><td height=\"21\" colspan=\"3\" align=\"center\" valign=\"top\"><IMG height=11 hspace=0  src=\"img/OurNewProductsDots.gif\" width=580 border=0></td></tr><tr>");
								   }
                               %>    <TD valign="top"><div align="center">
											<table width="185" height="140" border="0" cellpadding="0" cellspacing="1" background="img/bg01.gif">
                                              <tr>
                                                <td><div align="center"><a href="product_list.jsp?big_id=<%=productsTable.getBigId()%>&&small_id=<%=productsTable.getSmallId()%>"><img src="product/pic/small<%=productsTable.getPPic()%>" width="175" height="125" border="0"></a></div></td>
                                              </tr>
                                            </table>
                                          </div>
                                          <div align="center">
                                            <table width="180" border="0" cellpadding="0" cellspacing="0">
                                              <tr>
                                                <td><div align="center"><a href="product_list.jsp?big_id=<%=productsTable.getBigId()%>&&small_id=<%=productsTable.getSmallId()%>"  class="STYLE26"><%=smallTable!=null?StrUtil.toHtmlTag(smallTable.getSmallName()):""%>&nbsp;:&nbsp;<%=StrUtil.toHtmlTag(productsTable.getPModel())%></a></div></td>
                                              </tr>
                                            </table>
                                            <a href="product_list.jsp?big_id=<%=productsTable.getBigId()%>&&small_id=<%=productsTable.getSmallId()%>"  class="STYLE26"></a></div></TD>
										<%
										}
										%>	
                                      </TR>
                                       <tr><td height="21" colspan="3" align="center" valign="top"><IMG height=11 hspace=0  src="img/OurNewProductsDots.gif" width=580 border=0></td></tr>
                                    
                                    </TBODY>
                                  </TABLE>
                                </div></TD>
                            </TR>
                          </TBODY>
                        </TABLE></TD>
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