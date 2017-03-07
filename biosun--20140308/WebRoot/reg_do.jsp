<%@page contentType="text/html;charset=utf-8"%>
<%@page import="hk.com.biosun.model.UserInf"%>
<%@page import="hk.com.biosun.model.MailTable"%>
<%@page import="hk.com.biosun.util.SessionUtil"%>
<%@page import="com.aokle.util.DateUtil"%>
<%@page import="com.aokle.util.StrUtil"%>
<%@page import="hk.com.biosun.service.UserInfService"%>
<%@page import="hk.com.biosun.service.MailTableService"%>
<%
	UserInfService userInfService = new UserInfService();
	int resultAdd = userInfService.add(request);
	UserInf userInfSes;
	if (resultAdd == -2) {
		out
				.println("<SCRIPT LANGUAGE='JavaScript'>alert('Your ID E-mail is wrong!');javascript:history.back(-1);</SCRIPT>");
		return;
	}
	if (resultAdd == -1) {
		out
				.println("<SCRIPT LANGUAGE='JavaScript'>alert('register Fail！Your ID was registered berfore!');javascript:history.back(-1);</SCRIPT>");
		return;
	}
	//注册成功
	userInfSes = SessionUtil.getUserInf(request);
	if (userInfSes == null) {
		out
				.println("<SCRIPT LANGUAGE='JavaScript'>alert('Please login again!');location.href='login.jsp';</SCRIPT>");
		return;
	}

	MailTableService mailTableService = new MailTableService();
	MailTable mailTable = mailTableService.getByPK("1");
	if (mailTable == null) {
		out
				.println("<SCRIPT LANGUAGE='JavaScript'>alert('register Success!');location.href='index.jsp';</SCRIPT>");
		return;
	}
	StringBuffer emailContentSB = new StringBuffer();
	emailContentSB.append("<strong>Dear ");
	if ("1".equals(userInfSes.getSex())) {
		emailContentSB.append("Mr. ");
	} else {
		emailContentSB.append("Ms. ");
	}
	emailContentSB.append(userInfSes.getPerson());
	emailContentSB.append(",</strong>");
	emailContentSB.append(StrUtil.toHtmlTag(mailTable.getMailPrefix()));
	emailContentSB
			.append("<br><br>&nbsp;&nbsp;&nbsp;Thanks for your registration as a user in BIOSUN website for our service!");
	emailContentSB
			.append("<br><br>&nbsp;&nbsp;&nbsp;And below is your USER ID and Contact Information registered in our website at ");
	emailContentSB.append(DateUtil.formatDate(System
			.currentTimeMillis(), 13));
	emailContentSB
			.append("(Beijing Time):<br><br><strong>1.Your User ID Infomation:</strong>");
	emailContentSB
			.append("<br>&nbsp;&nbsp;&nbsp;User ID: <a href='mailto:");
	emailContentSB.append(userInfSes.getId());
	emailContentSB.append("'>");
	emailContentSB.append(userInfSes.getId());
	emailContentSB.append("</a><br>" + "&nbsp;&nbsp;&nbsp;Password:");
	emailContentSB.append(userInfSes.getPassword());
	emailContentSB.append("<br>&nbsp;&nbsp;&nbsp;Password Answer:");
	emailContentSB.append(userInfSes.getAnswer());
	emailContentSB
			.append("<br><br><strong>2. Your Member Information:</strong><br>");
	emailContentSB
			.append("&nbsp;&nbsp;&nbsp;User ID:  <a href='mailto:");
	emailContentSB.append(userInfSes.getId());
	emailContentSB.append("'>");
	emailContentSB.append(userInfSes.getId());
	emailContentSB.append("</a>");
	emailContentSB.append("<br>&nbsp;&nbsp;&nbsp;Contact Person: ");
	if ("1".equals(userInfSes.getSex())) {
		emailContentSB.append("Mr. ");
	} else {
		emailContentSB.append("Ms. ");
	}
	emailContentSB.append(userInfSes.getPerson());
	emailContentSB.append("<br>&nbsp;&nbsp;&nbsp;Job Title: ");
	emailContentSB.append(userInfSes.getJobTitle());
	emailContentSB.append("<br>&nbsp;&nbsp;&nbsp;Company: ");
	emailContentSB.append(userInfSes.getCompany());
	emailContentSB.append("<br>&nbsp;&nbsp;&nbsp;Tel: ");
	emailContentSB.append(userInfSes.getCountryCode());
	emailContentSB.append("-");
	emailContentSB.append(userInfSes.getAreaCode());
	emailContentSB.append("-");
	emailContentSB.append(userInfSes.getTel());
	emailContentSB.append("<br>&nbsp;&nbsp;&nbsp;Fax: ");
	emailContentSB.append(userInfSes.getFCcode());
	emailContentSB.append("-");
	emailContentSB.append(userInfSes.getFAcode());
	emailContentSB.append("-");
	emailContentSB.append(userInfSes.getFax());
	emailContentSB
			.append("<br>&nbsp;&nbsp;&nbsp;Email: <a href='mailto:");
	emailContentSB.append(userInfSes.getEmail());
	emailContentSB.append("'>");
	emailContentSB.append(userInfSes.getEmail());
	emailContentSB.append("</a>");
	emailContentSB.append("<br>&nbsp;&nbsp;&nbsp;Messenger: ");
	emailContentSB.append(userInfSes.getMs());
	emailContentSB.append("<br>&nbsp;&nbsp;&nbsp;Website: <a href='");
	emailContentSB.append(userInfSes.getWebsite());
	emailContentSB.append("'>");
	emailContentSB.append(userInfSes.getWebsite());
	emailContentSB.append("</a>");
	emailContentSB.append("<br>&nbsp;&nbsp;&nbsp;Mailing Address: ");
	emailContentSB.append(userInfSes.getMailingAddress());
	emailContentSB.append(",");
	emailContentSB.append(userInfSes.getACity());
	emailContentSB.append(",");
	emailContentSB.append(userInfSes.getAState());
	emailContentSB.append(",");
	emailContentSB.append(userInfSes.getAZip());
	emailContentSB.append(",");
	emailContentSB.append(userInfSes.getACountry());
	emailContentSB.append("<br>&nbsp;&nbsp;&nbsp;Your business Type: ");
	String temp_mail = userInfSes.getDi() + "," + userInfSes.getMa()
			+ "," + userInfSes.getEn() + "," + userInfSes.getIm1()
			+ "," + userInfSes.getIm2() + "," + userInfSes.getRe()
			+ "," + userInfSes.getBu() + "," + userInfSes.getBr() + ","
			+ userInfSes.getPr() + "," + userInfSes.getOt();
	temp_mail = temp_mail.trim();
	for (int b = 0; temp_mail.indexOf(",,") != -1; b++)
		temp_mail = temp_mail.replaceAll(",,", ",");
	if (temp_mail.indexOf(",") == 0)
		temp_mail = temp_mail.substring(1, temp_mail.length());
	if (temp_mail.lastIndexOf(",") == (temp_mail.length() - 1))
		temp_mail = temp_mail.substring(0, temp_mail.length() - 1);

	emailContentSB.append(temp_mail);
	emailContentSB
			.append("<br><br>&nbsp;&nbsp;&nbsp;For the sake to provide our in-time service to you, please keep your USER");
	emailContentSB
			.append(" ID Information in a safe place and update your Member Information timely.<br>");
	emailContentSB.append("<br>&nbsp;&nbsp;&nbsp;Thanks again.<br>");
	emailContentSB.append("<br>&nbsp;&nbsp;&nbsp;Best Regards!<br>");
	//邮件后缀
	emailContentSB.append(StrUtil.toHtmlTag(mailTable.getMailSuffix()));
	/*
	 emailContentSB
	 .append("<br><strong>Market Dept.<br>Biosun Technology Co.,Ltd.<br>Address: ");
	 emailContentSB
	 .append("Unit1-27A# Jilian Building, Xinzhou Rd. Futian Dist. Shenzhen City. Guangdong Province. PR China. 518035<br>");
	 emailContentSB
	 .append("Phone:   +86-755-83088501<br>Fax:    +86-755-83060186 <br>Email:   <a href='mailto:");
	 emailContentSB.append(mailTable.getMailAddress());
	 emailContentSB.append("'>");
	 emailContentSB.append(mailTable.getMailAddress());
	 emailContentSB.append("</a><br>Website:<a href='");
	 emailContentSB.append(mailTable.getWebsite());
	 emailContentSB.append("'> ");
	 emailContentSB.append(mailTable.getWebsite());
	 emailContentSB.append("</a></strong>");
	 */
	int resultSend = 0;
	for (int j = 0; j < 3; j++) {
		String toMail = "";
		String subject = "";

		if (j != 2)
			subject = "Your User Info in " + mailTable.getWebsite()
					+ " !";
		else
			subject = "New User Registion-- " + userInfSes.getId()
					+ " !";
		if (j == 0){
			toMail = userInfSes.getId();
			if(toMail.equals(userInfSes.getEmail())){
				 continue;
			}
		}else if (j == 1){
			toMail = userInfSes.getEmail();
		}else if (j == 2){
			toMail = mailTable.getMailAddress();
        }
		int result = mailTableService.sendEmail(mailTable, toMail,
				subject, emailContentSB.toString());
		if (j == 1 && result > 0) {
			resultSend = 1;
		}
	}
	if (resultSend > 0) {
		out
				.println("<SCRIPT LANGUAGE='JavaScript'>alert('Register Success!');location.href='index.jsp';</SCRIPT>");
		return;
	} else {
		out
				.println("<SCRIPT LANGUAGE='JavaScript'>alert('Register Fail!');location.href='index.jsp';</SCRIPT>");
		return;
	}
%>