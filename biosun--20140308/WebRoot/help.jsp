<%@page contentType="text/html;charset=utf-8"%>
<%@page import="com.aokle.util.StrUtil"%>
<%@page import="hk.com.biosun.model.Article"%>
<%@page import="hk.com.biosun.service.ArticleService"%>
<%
ArticleService articleService=new ArticleService();
Article article=articleService.getByPKFront(25,"help_web");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<link href="admin/css/Style.css" rel="stylesheet" type="text/css">

<style type="text/css">
<!--
.STYLE2 {
	font-size: 16px;
	font-weight: bold;
	color: #000000;
}
.STYLE3 {
	font-size: 16px;
	font-weight: bold;
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
      <td width="42"  >&nbsp;</td>
      <td width="609"  >&nbsp;</td>
      <td width="105"  >&nbsp;</td>
      <td width="42"  >&nbsp;</td>
    </tr>
    <tr >
      <td height="27"  >&nbsp;</td>
      <td colspan="2" valign="top"  >
	  <span class="STYLE2">综合文章——系统帮助</span></td>
					
					
      <td  >&nbsp;</td>
      <td  >&nbsp;</td>
    </tr>
    <tr >
      <td height="20"  >&nbsp;</td>
      <td  >&nbsp;</td>
      <td  >&nbsp;</td>
      <td  >&nbsp;</td>
      <td  >&nbsp;</td>
    </tr>
    <tr >
      <td height="26"  >&nbsp;</td>
      <td  >&nbsp;</td>
      <td colspan="2" align="center" valign="middle" bgcolor="#CDD198"  ><span class="STYLE3">系统帮助</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="admin/help_edit.jsp">编辑</a></td>
     <td  >&nbsp;</td>
    </tr>
    <tr >
      <td height="18"  ></td>
      <td  ></td>
      <td  >&nbsp;</td>
      <td  ></td>
      <td  ></td>
    </tr>
    <tr >
      <td height="465"  ></td>
      <td  ></td>
      <td colspan="2" valign="top"  ><%=StrUtil.toHtmlTag(article.getContent())%></td>
          <td  ></td>
    </tr>
    <tr >
      <td height="2"  ></td>
      <td  ></td>
      <td  ></td>
      <td  ></td>
      <td  ></td>
    </tr>
	  </table>
  
<br><br>
</div>
</body>
</html>
