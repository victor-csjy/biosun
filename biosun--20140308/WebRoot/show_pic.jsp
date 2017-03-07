<%@page contentType="text/html;charset=utf-8"%>
<%@page import="com.aokle.util.StrUtil"%>
<%
String pPic=StrUtil.toHtmlTxt(request.getParameter("p_pic"));
 %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Product Picture</title>
</head>
<body>
<div align="center">
  <table width="907" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td width="206" height="74">&nbsp;</td>
      <td width="393">&nbsp;</td>
      <td width="308">&nbsp;</td>
    </tr>
    <tr>
      <td height="236">&nbsp;</td>
      <td valign="top"><img src="product/pic/<%=pPic%>" ></td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td height="119">&nbsp;</td>
      <td>&nbsp;</td>
      <td>&nbsp;</td>
    </tr>
  </table>
</div>
</body>
</html>
