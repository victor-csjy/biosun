<%@page contentType="text/html;charset=utf-8"%>
<%@page import="com.aokle.util.PathUtil"%>
<%
String realPath=PathUtil.getRealPath();
String contextPath=PathUtil.getContextPath(request);
String appUrl=PathUtil.getAppUrl(request);
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>path</title>
</head>

<body>
realPath=<%=realPath%><br/>
contextPath=<%=contextPath%><br/>
appUrl=<%=appUrl%><br/>
</body>
</html>
