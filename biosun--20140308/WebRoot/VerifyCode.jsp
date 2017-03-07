<%@page contentType="text/html;charset=utf-8"%>
<%@page import="hk.com.biosun.util.SessionUtil"%>
<%@ page import="javax.imageio.*,java.io.*"%>
<%@ page import="hk.com.biosun.util.VerifyCode"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
	response.reset();

	try {
		// 将认证码存入SESSION
		//调用 runVerifyCode(int i) ,把i改成所要的验证码位数
		VerifyCode verifyCode = new VerifyCode();
		String verifyCodeStr=verifyCode.runVerifyCode(4);
		//session.setAttribute("VerifyCode", VC.runVerifyCode(4));
		SessionUtil.setVerifyCode(request,verifyCodeStr);
		//session.setMaxInactiveInterval(60);
		// 输出图象到页面
		OutputStream outs = response.getOutputStream();
		ImageIO.write(verifyCode.CreateImage(verifyCodeStr), "JPEG", outs);
		outs.flush();
		outs.close();
		outs = null;
		response.flushBuffer();
		out.clear();
		out = pageContext.pushBody();
	} catch (Exception e) {
		return;
	}
%>