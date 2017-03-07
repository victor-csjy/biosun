<%@page contentType="text/html;charset=utf-8"%>
<%@ page import="com.aokle.util.StrUtil"%>
<%@ page import="com.aokle.util.MathUtil"%>
<%@ page import="hk.com.biosun.service.ArticleService"%>
<%@page import="hk.com.biosun.util.ReqParamUtil"%>
<%@page import="hk.com.biosun.model.Article"%>
<%@ page import="java.util.*"%>
<%@include file="session_admin.jsp" %>
<%
int article_id=MathUtil.toInt(request.getParameter("article_id"));

String article_type=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("article_type")));
String title=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("title")));
String article_date=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("article_date")));
String is_show=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("is_show")));
String order_id=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("order_id")));
String content=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("content0")));
String Action=request.getParameter("Action");
ArticleService articleService=new ArticleService();

if(Action!=null&&Action.equals("change_set")&&!content.equals("")){
   List<Object> valuesList=new ArrayList<Object>();
   valuesList.add(title);
   valuesList.add(content);
   valuesList.add(article_type);
   valuesList.add(article_date);
   valuesList.add(is_show);
   valuesList.add(order_id);
   valuesList.add(article_id);
   int result=articleService.update("title=?,content=?,article_type=?,article_date=?,is_show=?,order_id=?","WHERE article_id=?",valuesList);
   if(result>0){  
      out.println("<SCRIPT LANGUAGE='JavaScript'>alert('操作成功!');javascript:history.back(-1);</SCRIPT>");
      return; 
   }else{ 
      out.println("<SCRIPT LANGUAGE='JavaScript'>alert('操作失败！');javascript:history.back(-1);</SCRIPT>");
      return; 
   }
}
Article article=articleService.getByPK(article_id);
if(article==null){
     out.println("<SCRIPT LANGUAGE='JavaScript'>alert('操作失败！');javascript:history.back(-1);</SCRIPT>");;
     return; 
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<script language="javascript">
 function on_submit()
 {
 if(form1.title.value=="")
  {
    alert("请输入标题!");
	form1.title.value="";	
    document.form1.title.focus();
	return false;
  }
  if(form1.article_date.value=="")
  {
    alert("请输入发布日期!");
	form1.article_date.value="";	
    document.form1.article_date.focus();
	return false;
  }
  
   if(form1.order_id.value==""||isNaN(form1.order_id.value))
  {
    alert("请输入一个整数的排序号!");
	form1.order_id.value="";	
    document.form1.order_id.focus();
	return false;
  }  
  
}
  </script>
  
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
  <table width="811" border="0" align="center" cellpadding="0" cellspacing="0">
    
    <tr >
      <td width="13" height="44"  >&nbsp;</td>
      <td width="651"  >&nbsp;</td>
      <td width="147"  >&nbsp;</td>
    </tr>
    <tr >
      <td height="27"  >&nbsp;</td>
      <td valign="top"  >
	  <span class="STYLE2">
                      综合文章——<%
					if(article_type.equals("about_us"))out.print("About Us");
					else if(article_type.equals("sale_and_market"))out.print("Sale and Market");
					else if(article_type.equals("service"))out.print("Service");
					else if(article_type.equals("careers"))out.print("Careers");
					else if(article_type.equals("contact"))out.print("Contact");
					%>
                    </span>                    </td>
					
					
      <td  >&nbsp;</td>
    </tr>
    <tr >
      <td height="17"  >&nbsp;</td>
      <td  >&nbsp;</td>
      <td  >&nbsp;</td>
    </tr>
    
    
    <tr >
      <td height="647"  ><td colspan="2" valign="top"  >                  	
	  <form name="form1" method="POST" action="article_change.jsp"  onSubmit="return on_submit()" >
	      <table width="90%" border="1" align=center cellpadding="1" cellspacing="1" bordercolor="#000000" bordercolordark="#cad7f7" >
	       <tr >
	         <td width="157" height="26" valign="middle"  >&nbsp;	 标题： </td>
    <td width="628" valign="top"  >
	<input name="title" type="text" id="title" value="<%=article.getTitle()%>" size="60" maxlength="150" ></td>
	       </tr>
	       <tr >
	         <td height="26" valign="middle"  >&nbsp;	 类型：
              <label></label></td>
    <td valign="top"  >
	
	<select name="article_type" id="article_type">
        <option value="about_us" <%if(article.getArticleType().equals("about_us"))out.print("selected");%>>About Us</option>
    <option value="sale_and_market" <%if(article.getArticleType().equals("sale_and_market"))out.print("selected");%>>Sale and Market</option>
        <option value="service" <%if(article.getArticleType().equals("service"))out.print("selected");%>>Service</option>
		 <option value="careers" <%if(article.getArticleType().equals("careers"))out.print("selected");%>>Careers</option>
		  <option value="contact" <%if(article.getArticleType().equals("contact"))out.print("selected");%>>Contact</option>
        </select></td>
            </tr><tr >
	         <td height="26" valign="middle"  >&nbsp;	 发布日期： </td>
    <td valign="top"  ><input name="article_date" type="text" id="article_date" 
	  value="<%=article.getArticleDate()%>" size="25" maxlength="150" ></td>
             </tr>
	<tr >
	         <td height="26" valign="middle"  >&nbsp;	 是否显示：	           
               <label></label></td>
    <td valign="top"  ><label>
    <input name="is_show" type="radio" value="1" <%if(article.getIsShow().equals("1"))out.print("checked");%> >
是 &nbsp;&nbsp;
<input type="radio" name="is_show" value="0" <%if(article.getIsShow().equals("0"))out.print("checked");%>>
否
    </label></td>
            </tr>
	
	<tr >
	         <td height="26" valign="middle"  >&nbsp;	 排序号： </td>
    <td valign="top"  ><input name="order_id" type="text" id="order_id" value="<%=article.getOrderId()%>"  size="10" maxlength="150" ></td>
             </tr>
			 
			 
	 
	 <tr >
	 <td height="26" colspan="2" valign="middle"  >&nbsp;	 文章内容： </td>
     </tr>
	       
	        <tr class="chinese">
	          <td height="454" colspan="2" valign="top"><div align="center">	
	            <input type="hidden" name=content0 " id="content0" value="<%=article.getContent()%>"/>
	            <iframe ID="eWebEditor0" src="../ewebeditor/eWebEditor.jsp?id=content0&style=CoolBlue" frameborder="0" scrolling="no" width="790" height="450"></iframe>
              </div></td>
            </tr>
	        <tr class="chinese">
	          <td height="26" colspan="2" align="center" valign="middle"><p align="center">
                                 
								 <input name="article_id" type="hidden" id="article_id" value="<%=article_id%>">
								 
								  <input name="B2" type="submit" class="button" id="B2" value="修改">
	<input name="Action" type="hidden" id="Action" value="change_set">&nbsp;
<input name="B1" type="button" class="button" value="返回" onClick="location.href='index_face.jsp'">
              </p>
              </td>
        </table>
    </form>
    </td></tr>
	  </table>
<br><br>
</div>
</body>
</html>