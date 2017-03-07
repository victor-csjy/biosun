<%@page contentType="text/html;charset=utf-8"%>
<%@include file="session_admin.jsp" %>
<%
session.invalidate();
out.println("<SCRIPT LANGUAGE='JavaScript'>alert('成功退出!');location.href='admin_login.jsp';</SCRIPT>");  
return;
%>