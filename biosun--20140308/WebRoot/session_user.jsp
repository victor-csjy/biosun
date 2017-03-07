<%@page contentType="text/html;charset=utf-8"%>
<%@page import="hk.com.biosun.util.SessionUtil"%>
<%
if(SessionUtil.getUserInf(request)==null){ 
  response.sendRedirect("index.jsp");
  return;
}
%>