<%@page contentType="text/html;charset=utf-8"%>
<%@page import="hk.com.biosun.model.UserInf"%>
<%@page import="hk.com.biosun.util.SessionUtil"%>
<%@page import="hk.com.biosun.service.UserInfService"%>
<%
	UserInf userInfSes = SessionUtil.getUserInf(request);
	if (userInfSes == null) {
		out
				.println("<SCRIPT LANGUAGE='JavaScript'>alert('Please Sign in！');location.href='login.jsp';</SCRIPT>");
		return;
	}
	UserInfService userInfService = new UserInfService();
	int result = userInfService.update(request);
	if (result > 0) {
	    UserInf userInf=userInfService.getByPK(userInfSes.getId());
	    if(userInf!=null){
	       SessionUtil.setUserInf(request,userInf);
		   out.println("<SCRIPT LANGUAGE='JavaScript'>alert('Success!');javascript:history.back(-1);</SCRIPT>");
		}else{
		   out.println("<SCRIPT LANGUAGE='JavaScript'>alert('Success,But you must login again!');location.href='login.jsp';</SCRIPT>");
		}
		return;
	} else {
		out
				.println("<SCRIPT LANGUAGE='JavaScript'>alert('Fail!');javascript:history.back(-1);</SCRIPT>");
		return;
	}
%>