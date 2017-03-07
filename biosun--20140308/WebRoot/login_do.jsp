<%@page contentType="text/html;charset=utf-8"%>
<%@page import="com.aokle.util.StrUtil"%>
<%@page import="hk.com.biosun.util.ReqParamUtil"%>
<%@page import="hk.com.biosun.model.UserInf"%>
<%@page import="hk.com.biosun.service.UserInfService"%>
<%@page import="hk.com.biosun.util.SessionUtil"%>
<%
String id=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("id"), true));
String password=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("password"), true));
String login=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("login"), true));
String re_url=request.getHeader("referer");
if(login.equals("")||id.indexOf("@")==-1||id.indexOf(".")==-1||password.length()<6){
    out.println("<SCRIPT LANGUAGE='JavaScript'>alert('Your ID or Password is wrong!');javascript:history.back(-1);</SCRIPT>");
    return;
}
id=id.replaceAll("=","");
password=password.replaceAll("=","");

UserInfService userInfService=new UserInfService();
UserInf userInf=userInfService.getByPK(id);
if(userInf!=null&&!"".equals(password)&&userInf.getPassword().equals(password)){
  SessionUtil.setUserInf(request,userInf);
  userInfService.updateLoginInfo(userInf);
  if(re_url.indexOf("fp_do.jsp")==-1){
      out.println("<SCRIPT LANGUAGE='JavaScript'>alert('Sign in Success!');location.href='"+re_url+"';</SCRIPT>");
  }else {
      out.println("<SCRIPT LANGUAGE='JavaScript'>alert('Sign in Success!');location.href='index.jsp';</SCRIPT>");
  }
}else{
   out.println("<SCRIPT LANGUAGE='JavaScript'>alert('Fail! Your password is wrong!');javascript:history.back(-1);</SCRIPT>");
   return;
}
%>