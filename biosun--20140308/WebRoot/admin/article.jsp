<%@page contentType="text/html;charset=utf-8"%>
<%@ page import="com.aokle.util.StrUtil"%>
<%@ page import="com.aokle.util.MathUtil"%>
<%@ page import="hk.com.biosun.model.Article"%>
<%@ page import="hk.com.biosun.service.ArticleService"%>
<%@page import="hk.com.biosun.util.ReqParamUtil"%>
<%@ page import="java.util.*"%>
<%@include file="session_admin.jsp" %>
<%
String article_type=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("article_type")));

int article_id=MathUtil.toInt(request.getParameter("article_id"));
int article_id_find=MathUtil.toInt(request.getParameter("article_id_find"));

String title=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("title")));
String article_date=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("article_date")));
String order_by=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("order_by")));
int pageNo=MathUtil.toInt(request.getParameter("page"),1);
String Action=request.getParameter("Action");
String submit_find=request.getParameter("submit_find");
String submit_all=request.getParameter("submit_all");
String article_del=request.getParameter("article_del");

ArticleService articleService=new ArticleService();
if(article_del!=null&&article_del.equals("ok")){
  int result=articleService.delete(article_id);
  if(result>0){ 
     out.println("<SCRIPT LANGUAGE='JavaScript'>alert('删除成功!');</SCRIPT>");
  }else{ 
     out.println("<SCRIPT LANGUAGE='JavaScript'>alert('删除失败！');</SCRIPT>");   
  } 	
}
List<Object> valuesList=new ArrayList<Object>();
StringBuffer condSB=new StringBuffer("WHERE article_type=?");
valuesList.add(article_type);
if(article_id_find>0&&submit_all==null){
   condSB.append(" AND article_id=?");
   valuesList.add(article_id_find);
}
if(submit_all!=null){
    article_id_find=0;
    title="";
    order_by="";
    article_date="";
}else { 
    if(!title.equals("")){
       condSB.append(" AND title LIKE ?");
       valuesList.add("%"+title+"%");
    }    
	if(!article_date.equals("")){
	   condSB.append(" AND article_date LIKE ?");
	   valuesList.add("%"+article_date+"%");
	}
}

int recordCount=articleService.getCount(condSB.toString(),valuesList);
condSB.append(" ORDER BY ");
if(order_by.equals("")){
    condSB.append("order_id,article_date DESC"); 
}else {
    condSB.append(order_by+" DESC"); 
}
int pageSize = MathUtil.toInt(request.getParameter("pageSize"),20);

List<Article> articleList=articleService.getList(condSB.toString(),valuesList,pageSize,pageNo);
int articleListSize=articleList!=null?articleList.size():0;
Article article;
int pageCount=(recordCount-1)/pageSize+1;
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<script language="javascript">
 function on_submit()
 {
 if(isNaN(document.form1.article_id.value)&&document.form1.article_id.value!="")
  {
    alert("请输入整数的文章ID!");
	form1.article_id.value="";	
    document.form1.article_id.focus();
	return false;
  }
}
  </script> 
  <script language="javascript">  
function del_cf()
{
   if(confirm("确定要删除!，并且不能恢复！"))
     return true;
   else
     return false;
	 
}
</SCRIPT>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<link href="css/Style.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.STYLE2 {
	font-size: 16px;
	font-weight: bold;
	color: #000000;
}
-->
</style>

</head>
<body>
<div align="center">
<br><br>
  <table width="919" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr >
      <td width="867" height="218" align="left" valign="top"  >
	    <form name="form1" method="post" action="article.jsp?article_type=<%=article_type%>"  onSubmit="return on_submit()">				  
	    <TABLE  width="98%" border=0 align="center" cellPadding=0 cellSpacing=0>
                  
				  
				  <tr bgcolor="">
                    <td height="21" colspan="3" align="left" valign="top"><span class="STYLE2">
                      综合文章——
                      <%
					if(article_type.equals("about_us"))out.print("About Us");
					else if(article_type.equals("sale_and_market"))out.print("Sale and Market");
					else if(article_type.equals("service"))out.print("Service");
					else if(article_type.equals("careers"))out.print("Careers");
					else if(article_type.equals("contact"))out.print("Contact");
					%>
                    </span>                    </td>
                    <td width="9"></td>
		  </tr>
                  <tr bgcolor="">
                    <td width="9" height="9"></td>
                    <td width="827"></td>
                    <td width="22"></td>
                    <td></td>
          </tr>
 <tr bgcolor="">
                    <td height="30"></td>
                    <td align="center" valign="middle">文章ID
                      <input name="article_id_find" type="text" id="article_id_find" value="<%=article_id_find>0?String.valueOf(article_id_find):""%>"  size="10" maxlength="150" >
&nbsp;&nbsp;文章标题
<input name="title" type="text" id="title" value="<%=title%>"  size="30" maxlength="150" >
&nbsp;&nbsp;发布时间
<input name="article_date" type="text" id="article_date" value="<%=article_date%>"  size="19" maxlength="25" ></td>
          <td></td>
                  <td></td>
                  </tr>
                  <tr bgcolor="">
                    <td height="30"></td>
                    <td align="center" valign="middle"><input name="pageSize" type="hidden" id="pageSize" value="<%=pageSize%>"/>
                    <input name="submit_find" type="submit"  id="submit_find" value="查  找">
&nbsp;&nbsp;&nbsp;&nbsp;
<input name="submit_all" type="submit" id="submit_all" value="显示全部">
&nbsp;&nbsp;&nbsp;&nbsp;
<input name="B1" type="button" class="button" value="添加文章" 
 onClick="location.href='article_add.jsp?article_type=<%=article_type%>'"></td>
          <td>&nbsp;</td>
          <td></td>
          </tr>  
      
	   <tr bgcolor="">
                    <td height="107">&nbsp;</td>
                    <td valign="top">
					  <table width="100%" border="1" cellpadding="0" cellspacing="0"  bordercolor="#000000" bordercolordark="#FFFFFF" >
                      <tr class="bgcolor4" >
                        <td width="47" height="26" valign="middle" class="bgcolor4">文章ID</td>
                    <TD width="220" vAlign=center class="bgcolor4">文章标题</TD>
                    <TD width="78" align="center" vAlign=middle class="bgcolor4">是否显示</TD>
                    <TD width="190" align="center" vAlign=middle class="bgcolor4">发布时间</TD>
                    <TD width="113" align="center" vAlign=middle>显示顺序</TD>
                    <TD width="58" align="center" vAlign=middle class="bgcolor4">
					<a href="article.jsp?pageSize=<%=pageSize%>&&page=<%=pageNo%>&&title=<%=title%>&&article_date=<%=article_date%>&&article_type=<%=article_type%>&&order_by=browse_times">浏览次数</a></TD>
                    <TD width="83" align="center" vAlign=middle  class="bgcolor4" >操作</TD>
                    </tr>
					 <% for(int i=0;i<articleListSize;i++) {
						  article=articleList.get(i);
					 %>
                      <tr bgcolor="#f8f8f8" onMouseOver="this.bgColor='#FFFFFF'" onMouseOut="this.bgColor='#f8f8f8'">
                        <td height="26" align="center" valign="middle">[<%=article.getArticleId()%>]</td>
                    <TD vAlign=center>&nbsp;<% if(article.getIsShow()==null||"0".equals(article.getIsShow())){%>
                                    <%=StrUtil.fomatStr(article.getTitle(),30)%>
                                    <%}else{%><a href="../article.jsp?pageSize=<%=pageSize%>&&articleId=<%=article.getArticleId()%>&articleType=<%=article.getArticleType()%>" target="_blank" title="到前台去预览"><%=StrUtil.fomatStr(article.getTitle(),30)%></a><%}%>
                                    
                                    </TD>
                    <TD vAlign=middle>&nbsp;
                      <%if("1".equals(article.getIsShow()))
							                          out.print("是");
								                      else out.print("否");
								                     %>				    </TD>
                    <TD vAlign=middle>&nbsp;<%=article.getArticleDate()%></TD>
                    <TD vAlign=middle>&nbsp;<%=article.getOrderId()%></TD>
                    <TD valign="middle" >&nbsp;<%=article.getBrowseTimes()%></TD>
                    <TD align="center" vAlign=middle >
<a href="article_change.jsp?article_type=<%=article_type%>&&article_id=<%=article.getArticleId()%>" target="_self">修改</a> <a href="article.jsp?pageSize=<%=pageSize%>&&article_id=<%=article.getArticleId()%>&&page=<%=pageNo%>&&article_type=<%=article_type%>&&article_del=ok" onClick="return del_cf();">删除</a></TD>
                    </tr>
					
					  <%} if(articleListSize>0){ %>
					  
                      <tr>
                        <td height="31" colspan="7" align="center" valign="middle" > <div align="center"> 
                          
                        <%
		if(pageNo>1){ %>
                         <a href="article.jsp?pageSize=<%=pageSize%>&&page=<%=(pageNo-1)%>&&title=<%=title%>&&article_date=<%=article_date%>&&article_type=<%=article_type%>&&order_by=<%=order_by%>">上一页</a>&nbsp;&nbsp; 
                        <%}
		 if (pageNo<pageCount)
		 { %>
                        <a href="article.jsp?pageSize=<%=pageSize%>&&page=<%=(pageNo+1)%>&&title=<%=title%>&&article_date=<%=article_date%>&&article_type=<%=article_type%>&&order_by=<%=order_by%>">下一页</a>
                        <% } 

        %>
                        &nbsp;&nbsp;&nbsp;&nbsp;共<strong><%=pageCount%></strong>页<strong><%=recordCount%></strong>条记录 
                          &nbsp;&nbsp;&nbsp;&nbsp;
                          <SELECT name=pageSizeSelect id=pageSizeSelect onChange="location.href=this.options[this.selectedIndex].value;">
										<OPTION value=# selected><%=pageSize%></OPTION>												
<OPTION  value=article.jsp?pageSize=20&&page=<%=pageNo%>&&title=<%=title%>&&article_date=<%=article_date%>&&article_type=<%=article_type%>&&order_by=<%=order_by%>>20</OPTION>	
<OPTION  value=article.jsp?pageSize=30&&page=<%=pageNo%>&&title=<%=title%>&&article_date=<%=article_date%>&&article_type=<%=article_type%>&&order_by=<%=order_by%>>30</OPTION>	
<OPTION  value=article.jsp?pageSize=50&&page=<%=pageNo%>&&title=<%=title%>&&article_date=<%=article_date%>&&article_type=<%=article_type%>&&order_by=<%=order_by%>>50</OPTION>	
<OPTION  value=article.jsp?pageSize=75&&page=<%=pageNo%>&&title=<%=title%>&&article_date=<%=article_date%>&&article_type=<%=article_type%>&&order_by=<%=order_by%>>75</OPTION>	
<OPTION  value=article.jsp?pageSize=100&&page=<%=pageNo%>&&title=<%=title%>&&article_date=<%=article_date%>&&article_type=<%=article_type%>&&order_by=<%=order_by%>>100</OPTION>													
											</select>
条/页&nbsp;&nbsp; 
<label>第
                            <SELECT name=menu1 onChange="javascript:location.href=this.options(this.selectedIndex).value;" >
  <OPTION value=# selected><%=pageNo%></OPTION>
                      <%
																int pageMin=pageNo-20;
																pageMin=pageMin<1?1:pageMin;
																int pageMax=pageNo+20;
																pageMax=pageMax>pageCount?pageCount:pageMax;
																if(pageMin>pageMax){
																   pageMin=pageMax;
																}
																for (int i = pageMin; i <= pageMax; i++) {
																		if (i == pageNo)
																			continue;
															%>
  <OPTION  value=article.jsp?pageSize=<%=pageSize%>&&page=<%=i%>&&title=<%=title%>&&article_date=<%=article_date%>&&article_type=<%=article_type%>&&order_by=<%=order_by%>><%=i%></OPTION>
  <%}%>
  </select>
</label>页</div></td>
                        </tr>
					
					 <%}
				  else {%>
                      <tr>
                        <td height="22" colspan="7" align="center" valign="middle"><font color="#FF0000">没有记录！</td>
                        </tr>
                      
					  <%}%>
                      </table></td>
                  <td>&nbsp;</td>
                  <td></td>
          </tr>
                  <tr bgcolor="">
                    <td height="21">&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td></td>
                  </tr>
      </TABLE></form> </td>
    <td width="52"  >&nbsp;</td>
    </tr>
    <tr >
      <td height="413"  >&nbsp;</td>
      <td  >&nbsp;</td>
    </tr>
  </table>
<br><br>
</div>
</body>
</html>