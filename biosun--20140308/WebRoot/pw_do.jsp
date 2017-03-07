<%@page contentType="text/html;charset=utf-8"%>
<%@page import="com.aokle.util.StrUtil"%>
<%@page import="hk.com.biosun.util.ReqParamUtil"%>
<%@page import="hk.com.biosun.model.UserInf"%>
<%@page import="hk.com.biosun.util.SessionUtil"%>
<%@page import="hk.com.biosun.service.UserInfService"%>
<%
UserInf userInfSes = SessionUtil.getUserInf(request);
if (userInfSes == null) {
	out.println("<SCRIPT LANGUAGE='JavaScript'>alert('Please Sign in！');location.href='login.jsp';</SCRIPT>");
	return;
}
	
String id=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("change_id"), true));
String oldPw=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("old_pw"), true));
String password=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("news1"), true));
String changePw=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("change_pw"), true));		

UserInfService userInfService=new UserInfService();
if(changePw.equals("change_ok")&&!id.equals("")){
  int result=userInfService.updatePassWord(id,password,oldPw);
  if(result>0) {     
      out.println("<SCRIPT LANGUAGE='JavaScript'>alert('Success!');javascript:history.back(-1);</SCRIPT>");
      return; 
   }else{ 
      out.println("<SCRIPT LANGUAGE='JavaScript'>alert('Fail');javascript:history.back(-1);</SCRIPT>");
      return; 
   }
}
%>