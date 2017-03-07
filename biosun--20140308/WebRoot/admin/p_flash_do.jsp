<%@page contentType="text/html;charset=utf-8"%>
<%@page import="hk.com.biosun.util.ReqParamUtil"%>
<%@page import="com.aokle.util.StrUtil"%>
<%@page import="com.aokle.util.PathUtil"%>
<%@page import="java.io.File"%>
<%@include file="session_admin.jsp"%>
<%
String flashName=StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request.getParameter("flashName")));
if("".equals(flashName)){
     out.println("<SCRIPT LANGUAGE='JavaScript'>alert('上传失败！');javascript:history.back(-1);</SCRIPT>");
	 return;
}
File file=new File(PathUtil.getRealPath()+"flash/"+flashName);
if(!file.exists()){
    out.println("<SCRIPT LANGUAGE='JavaScript'>alert('上传失败,服务器上没有这个文件："+"flash/"+flashName+"');javascript:history.back(-1);</SCRIPT>");
	return;
}else{
    out.println("<SCRIPT LANGUAGE='JavaScript'>alert('上传成功！');javascript:history.back(-1);</SCRIPT>");
	return;
}
%>