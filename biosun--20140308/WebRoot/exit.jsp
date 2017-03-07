<%@page contentType="text/html;charset=utf-8"%>
<%@page import="hk.com.biosun.util.SessionUtil"%>
<%@include file="session_user.jsp" %>
<%
String re_url=request.getHeader("referer");
SessionUtil.removeUserInf(request);
session.invalidate();
out.println("<SCRIPT LANGUAGE='JavaScript'>alert('Sign Out Success!');location.href='"+re_url+"';</SCRIPT>");
return;
%>