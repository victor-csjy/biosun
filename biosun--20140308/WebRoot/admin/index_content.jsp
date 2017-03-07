<%@page contentType="text/html;charset=utf-8"%>
<%@ page import="com.aokle.util.StrUtil"%>
<%@ page import="hk.com.biosun.model.Article"%>
<%@ page import="hk.com.biosun.service.ArticleService"%>
<%@page import="hk.com.biosun.util.ReqParamUtil"%>
<%@ page import="java.util.*"%>
<%@include file="session_admin.jsp" %>
<%
String content=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("content0")));
String Action=request.getParameter("Action");
ArticleService articleService=new ArticleService();
if(Action!=null&&Action.equals("change_set")&&!content.equals("")){
  List<Object> valuesList=new ArrayList<Object>();
  valuesList.add(content);
  valuesList.add(26);
  int result=articleService.update("content=?","WHERE article_id=?",valuesList);
  if(result>0){  
      out.println("<SCRIPT LANGUAGE='JavaScript'>alert('操作成功!');javascript:history.back(-1);</SCRIPT>");
      return; 
  }else{ 
      out.println("<SCRIPT LANGUAGE='JavaScript'>alert('操作失败！');javascript:history.back(-1);</SCRIPT>");
      return; 
  }
}
Article article=articleService.getByPK(26);
if(article==null){
    out.println("<SCRIPT LANGUAGE='JavaScript'>alert('No Data,操作失败！');javascript:history.back(-1);</SCRIPT>");;
    return; 
}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
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
	  <span class="STYLE2">综合文章——index</span></td>
      <td  >&nbsp;</td>
    </tr>
    <tr >
      <td height="18"  >&nbsp;</td>
      <td  >&nbsp;</td>
      <td  >&nbsp;</td>
    </tr>
    <tr >
      <td height="511"  >&nbsp;</td>
      <td colspan="2" valign="top"  >                  	
       <form name="form1" method="POST" action="index_content.jsp"  onSubmit="return on_submit()" >
	    <table width="90%" border="1" align=center cellpadding="1" cellspacing="1" bordercolor="#000000" bordercolordark="#cad7f7" >
	 <tr >
	 <td height="26" valign="middle"  >&nbsp;	 文章内容： </td>
     </tr>
          <tr class="chinese">
            <td height="454" valign="top"><div align="center">	
	            <input type="hidden" name=content0 " id="content0" value="<%=article.getContent()%>"/>
	            <iframe ID="eWebEditor0" src="../ewebeditor/eWebEditor.jsp?id=content0&style=CoolBlue" frameborder="0" scrolling="no" width="790" height="450"></iframe>
            </div></td>
          </tr>
          <tr class="chinese">
            <td height="27" align="center" valign="middle"><p align="center">
							    <input name="B2" type="submit" class="button" id="B2" value="修改">
	<input name="Action" type="hidden" id="Action" value="change_set">&nbsp;
<input name="B1" type="button" class="button" value="返回" onClick="location.href='index_face.jsp'">
            </p></td>
        </table>
		
		</form>
    </tr>
	  </table>
<br><br>
</div>
</body>
</html>