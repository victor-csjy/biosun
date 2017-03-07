<%@page contentType="text/html;charset=utf-8"%>
<%@ page import="com.aokle.util.StrUtil"%>
<%@ page import="com.aokle.util.MathUtil"%>
<%@ page import="hk.com.biosun.model.NewsTable"%>
<%@ page import="hk.com.biosun.model.NewsType"%>
<%@ page import="hk.com.biosun.service.NewsTableService"%>
<%@ page import="hk.com.biosun.service.NewsTypeService"%>
<%@page import="hk.com.biosun.util.ReqParamUtil"%>
<%@ page import="java.util.*"%>
<%@include file="session_admin.jsp" %>
<%
int news_type=MathUtil.toInt(request.getParameter("news_type"));
String news_name=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("news_name")));

int news_id=MathUtil.toInt(request.getParameter("news_id"));
int news_id_find=MathUtil.toInt(request.getParameter("news_id_find"));
String news_title=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("news_title")));
String news_date=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("news_date")));
String order_by=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("order_by")));
int pageNo=MathUtil.toInt(request.getParameter("page"),1);

String submit_all=request.getParameter("submit_all");
String news_del=request.getParameter("news_del");

NewsTableService newsTableService=new NewsTableService();
if(news_del!=null&&news_del.equals("ok")){
  int result=newsTableService.delete(news_id);
  if(result>0){ 
     out.println("<SCRIPT LANGUAGE='JavaScript'>alert('删除成功!');</SCRIPT>");
  }else{ 
     out.println("<SCRIPT LANGUAGE='JavaScript'>alert('删除失败！');</SCRIPT>");   
  }	
}

List<Object> valuesList=new ArrayList<Object>();
StringBuffer condSB=new StringBuffer("WHERE news_type=?");
valuesList.add(news_type);

if(news_id_find>0&&submit_all==null){
  condSB.append(" AND news_id=?");
  valuesList.add(news_id_find);
}
if(submit_all!=null){
  news_id=-1;news_title="";order_by="";news_date="";
}else { 
  if(!news_title.equals("")){
    condSB.append(" AND news_title LIKE ?");
    valuesList.add("%"+news_title+"%");
  }
  if(!news_date.equals("")){
    condSB.append(" AND news_date LIKE ?");
    valuesList.add("%"+news_date+"%");
  }   
}

int recordCount=newsTableService.getCount(condSB.toString(),valuesList);
condSB.append(" ORDER BY ");
if(order_by.equals("")){
    condSB.append("order_id,news_date DESC"); 
}else {
    condSB.append(order_by+" DESC"); 
}
List<NewsTable> newsTableList=newsTableService.getList(condSB.toString(),valuesList);
int newsTableListSize=newsTableList!=null?newsTableList.size():0;
NewsTable newsTable;
int pageSize = MathUtil.toInt(request.getParameter("pageSize"),20);
int pageCount=(recordCount-1)/pageSize+1;

NewsTypeService  newsTypeService=new NewsTypeService();
NewsType newsType=newsTypeService.getByPK(news_type);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<script language="javascript">
 function on_submit()
 {
 if(isNaN(document.form1.news_id.value)&&document.form1.news_id.value!="")
  {
    alert("请输入整数的文章ID!");
	form1.news_id.value="";	
    document.form1.news_id.focus();
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
<br> <table width="919" border="0" align="center" cellpadding="0" cellspacing="0">
    
    
    <tr >
      <td width="867" height="218" align="left" valign="top"  >
	  
	   <form name="form1" method="post" action="news_m.jsp?news_type=<%=news_type%>&&news_name=<%=news_name%>"  onSubmit="return on_submit()"> 
	    <TABLE  width="98%" border=0 align="center" cellPadding=0 cellSpacing=0>
                  
				  
				  <tr bgcolor="">
                    <td height="21" colspan="2" align="left" valign="top"><span class="STYLE2">
                      Events——<%=newsType!=null?StrUtil.toHtmlTag(newsType.getNewsName()):""%>
					
                    </span>                    </td>
                    <td width="58"></td>
		  </tr>
				  <tr bgcolor="">
				    <td width="8" height="9"></td>
				    <td width="784"></td>
				    <td></td>
	      </tr>
                
                  <tr bgcolor="">
                    <td height="30"></td>
                    <td align="center" valign="middle">ID
                      <input name="news_id_find" type="text" id="news_id_find" value="<%=news_id_find>0?String.valueOf(news_id_find):""%>"  size="10" maxlength="150" >
&nbsp;&nbsp;标题
<input name="news_title" type="text" id="news_title" value="<%=news_title%>"  size="30" maxlength="150" >
&nbsp;&nbsp;发布时间
<input name="news_date" type="text" id="news_date" value="<%=news_date%>"  size="19" maxlength="25" ></td>
          <td></td>
                  </tr>

                  
                  <tr bgcolor="">
                    <td height="30"></td>
                    <td align="center" valign="middle">
                    <input name="pageSize" type="hidden" id="pageSize" value="<%=pageSize%>"/>
                    <input name="submit_find" type="submit"  id="submit_find" value="查  找">
&nbsp;&nbsp;&nbsp;&nbsp;
<input name="submit_all" type="submit" id="submit_all" value="显示全部">
&nbsp;&nbsp;&nbsp;&nbsp;
<input name="B1" type="button" class="button" value="添加文章" 
 onClick="location.href='news_add.jsp?news_type=<%=news_type%>&&news_name=<%=news_name%>'"></td>
          <td>&nbsp;</td>
            </tr>  
       
	   <tr bgcolor="">
                    <td height="107">&nbsp;</td>
            <td valign="top">
			  <table width="100%" border="1" cellpadding="0" cellspacing="0"  bordercolor="#000000" bordercolordark="#FFFFFF" >
                
                <tr class="bgcolor4" >
                  <td width="47" height="26" valign="middle" class="bgcolor4">ID</td>
                  <TD width="178" vAlign=center class="bgcolor4">标题</TD>
                  <TD width="64" align="center" vAlign=middle class="bgcolor4">是否显示</TD>
                  <TD width="48" align="center">滚动区</TD>
                  <TD width="190" align="center" vAlign=middle class="bgcolor4">发布时间</TD>
                  <TD width="95" align="center" vAlign=middle>显示顺序</TD>
                  <TD width="58" align="center" vAlign=middle class="bgcolor4">
				    <a href="news_m.jsp?pageSize=<%=pageSize%>&&page=<%=pageNo%>&&news_title=<%=news_title%>&&news_date=<%=news_date%>&&news_type=<%=news_type%>&&news_name=<%=news_name%>&&order_by=browse_times">浏览次数</a></TD>
                  <TD width="87" align="center" vAlign=middle  class="bgcolor4" >操作</TD>
                </tr>
			    <% for(int i=0;i<newsTableListSize;i++) {
			         newsTable=newsTableList.get(i);
						  %>
						  
                <tr bgcolor="#f8f8f8" onMouseOver="this.bgColor='#FFFFFF'" onMouseOut="this.bgColor='#f8f8f8'">
                  <td height="26" align="center" valign="middle">[<%=newsTable.getNewsId()%>]</td>
                  <TD align="left" vAlign=middle> &nbsp;
                    <%=StrUtil.fomatStr(newsTable.getNewsTitle(),30)%></TD>
                  <TD vAlign=middle>&nbsp;
                  <%if("1".equals(newsTable.getIsShow()))
							                          out.print("是");
								                      else out.print("否");
								                     %>				    </TD>
                  <TD align="left" valign="middle">&nbsp; <%if("1".equals(newsTable.getIsRoll()))
							                          out.print("是");
								                      else out.print("否");
								                     %>	</TD>
                  <TD vAlign=middle>&nbsp;<%=newsTable.getNewsDate()%></TD>
                  <TD vAlign=middle>&nbsp;<%=newsTable.getOrderId()%></TD>
                  <TD vAlign=middle >&nbsp;<%=newsTable.getBrowseTimes()%></TD>
                  <TD align="center" vAlign=middle >
<a href="news_change.jsp?news_type=<%=news_type%>&&news_id=<%=newsTable.getNewsId()%>&&news_name=<%=news_name%>" target="_self">修改</a> <a href="news_m.jsp?pageSize=<%=pageSize%>&&news_id=<%=newsTable.getNewsId()%>&&page=<%=pageNo%>&&news_type=<%=news_type%>&&news_del=ok&&news_name=<%=news_name%>" onClick="return del_cf();">删除</a></TD>
                </tr>
					
			    <%} if(newsTableListSize>0){ %>
					  
                <tr>
                  <td height="31" colspan="8" align="center" valign="middle" > <div align="center"> 
                          
                      <%
		if(pageNo>1){ %>
                      <a href="news_m.jsp?pageSize=<%=pageSize%>&&page=<%=(pageNo-1)%>&&news_title=<%=news_title%>&&news_date=<%=news_date%>&&news_type=<%=news_type%>&&order_by=<%=order_by%>&&news_name=<%=news_name%>">上一页</a>&nbsp;&nbsp; 
                      <%}
		 if (pageNo<pageCount)
		 { %>
                      <a href="news_m.jsp?pageSize=<%=pageSize%>&&page=<%=(pageNo+1)%>&&news_title=<%=news_title%>&&news_date=<%=news_date%>&&news_type=<%=news_type%>&&order_by=<%=order_by%>&&news_name=<%=news_name%>">下一页</a>
                      <% } 

        %>
                      &nbsp;&nbsp;&nbsp;&nbsp;共<strong><%=pageCount%></strong>页<strong><%=recordCount%></strong>条记录 
                      &nbsp;&nbsp;&nbsp;&nbsp;
                      <SELECT name=pageSizeSelect id=pageSizeSelect onChange="location.href=this.options[this.selectedIndex].value;">
										<OPTION value=# selected><%=pageSize%></OPTION>												
<OPTION  value=news_m.jsp?pageSize=20&&page=<%=pageNo%>&&news_title=<%=news_title%>&&news_date=<%=news_date%>&&news_type=<%=news_type%>&&order_by=<%=order_by%>&&news_name=<%=news_name%>>20</OPTION>
<OPTION  value=news_m.jsp?pageSize=30&&page=<%=pageNo%>&&news_title=<%=news_title%>&&news_date=<%=news_date%>&&news_type=<%=news_type%>&&order_by=<%=order_by%>&&news_name=<%=news_name%>>30</OPTION>
<OPTION  value=news_m.jsp?pageSize=50&&page=<%=pageNo%>&&news_title=<%=news_title%>&&news_date=<%=news_date%>&&news_type=<%=news_type%>&&order_by=<%=order_by%>&&news_name=<%=news_name%>>50</OPTION>
<OPTION  value=news_m.jsp?pageSize=75&&page=<%=pageNo%>&&news_title=<%=news_title%>&&news_date=<%=news_date%>&&news_type=<%=news_type%>&&order_by=<%=order_by%>&&news_name=<%=news_name%>>75</OPTION>
<OPTION  value=news_m.jsp?pageSize=100&&page=<%=pageNo%>&&news_title=<%=news_title%>&&news_date=<%=news_date%>&&news_type=<%=news_type%>&&order_by=<%=order_by%>&&news_name=<%=news_name%>>100</OPTION>

</select>条/页&nbsp; 
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
<OPTION  value=news_m.jsp?pageSize=<%=pageSize%>&&page=<%=i%>&&news_title=<%=news_title%>&&news_date=<%=news_date%>&&news_type=<%=news_type%>&&order_by=<%=order_by%>&&news_name=<%=news_name%>><%=i%></OPTION>
  <%}%>
  </select>
</label>页</div></td>
                </tr>
			    <%}
				  else {%>
                <tr>
                  <td height="22" colspan="8" align="center" valign="middle"><font color="#FF0000">没有记录！</td>
                </tr>
			    <%}%>
            </table>
			
			</td>
                  <td>&nbsp;</td>
          </tr>
	   <tr bgcolor="">
	     <td height="21">&nbsp;</td>
	     <td>&nbsp;</td>
	     <td>&nbsp;</td>
	     </tr>
      </TABLE>
	  </form>
	  
	  </td>
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