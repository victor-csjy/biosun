<%@page contentType="text/html;charset=utf-8"%>
<%@page import="hk.com.biosun.util.SessionUtil"%>
<%
	if (SessionUtil.getAdmin(request) == null) {
		response.sendRedirect("admin_login.jsp");
		return;
	}
%>