<%@page contentType="text/html;charset=utf-8"%>
<%@page import="hk.com.biosun.model.UserInf"%>
<%@page import="hk.com.biosun.model.MailTable"%>
<%@page import="hk.com.biosun.util.SessionUtil"%>
<%@page import="com.aokle.util.DateUtil"%>
<%@page import="com.aokle.util.StrUtil"%>
<%@page import="com.aokle.util.MathUtil"%>
<%@page import="hk.com.biosun.util.ReqParamUtil"%>
<%@page import="hk.com.biosun.service.UserInfService"%>
<%@page import="hk.com.biosun.service.MailTableService"%>
<%@page import="hk.com.biosun.service.ComTableService"%>
<%@page import="hk.com.biosun.service.ProductsTableService"%>
<%@page import="hk.com.biosun.model.ProductsTable"%>
<%
	int pId = MathUtil.toInt(request.getParameter("p_id"));
	String needFb = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
			.getParameter("need_fb")));
	String comContent = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("com_content")));
	String actionStr = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("Action")));
	if (!actionStr.equalsIgnoreCase("ok") || comContent.length() > 4000) {
		out
				.println("<SCRIPT LANGUAGE='JavaScript'>alert('Paramenter Error！');javascript:history.back(-1);</SCRIPT>");
		return;
	}

	if (needFb.equals("")) {
		needFb = "No";
	}
	ProductsTableService productsTableService = new ProductsTableService();
	ProductsTable productsTable = productsTableService.getByPK(pId);
	if (productsTable == null) {
		out
				.println("<SCRIPT LANGUAGE='JavaScript'>alert('Paramenter Error！');javascript:history.back(-1);</SCRIPT>");
		return;
	}
	UserInf userInfSes = SessionUtil.getUserInf(request);
	String userId = userInfSes != null ? userInfSes.getId() : "";
	ComTableService comTableService = new ComTableService();
	int resultAdd = comTableService.add(pId, comContent, needFb, "",
			userId,productsTable.getPModel(),productsTable.getPName(),productsTable.getPPic());
	if (resultAdd < 1) {
		out
				.println("<SCRIPT LANGUAGE='JavaScript'>alert('Fail！');javascript:history.back(-1);</SCRIPT>");
		return;
	}

	productsTableService.updateComTimes(pId, 1);
	if (!"".equals(userId)) {
		UserInfService userInfService = new UserInfService();
		userInfService.updateUsercomTimes(userId, 1);
	}
	if (needFb.equalsIgnoreCase("Yes") && !userId.equals("")) {
		MailTableService mailTableService = new MailTableService();
		MailTable mailTable = mailTableService.getByPK("1");
		if (mailTable == null) {
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('Feedback Error!');location.href='index.jsp';</SCRIPT>");
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
		emailContentSB.append(StrUtil.toHtmlTag(mailTable
				.getMailPrefix()));
		emailContentSB
				.append("<br><br>Thanks for your interest to Biosun.<br> <br>");
		emailContentSB
				.append("And below is your comments on our product in Biosun website at ");
		emailContentSB.append(DateUtil.formatDate(System
				.currentTimeMillis(), 13));
		emailContentSB
				.append("(Beijing Time):<br><br><strong>1.Your Interested Model and Product Name:</strong>");
		emailContentSB.append("<br>&nbsp;&nbsp;&nbsp;<a href='");
		emailContentSB.append(mailTable.getWebsite());
		emailContentSB.append("/products_detail.jsp?p_id=");
		emailContentSB.append(pId);
		emailContentSB.append("' target='_blank'>");
		emailContentSB.append(productsTable.getPModel());
		emailContentSB.append("</a><br>&nbsp;&nbsp;&nbsp;<a href='");
		emailContentSB.append(mailTable.getWebsite());
		emailContentSB.append("/products_detail.jsp?p_id=");
		emailContentSB.append(pId);
		emailContentSB.append("' target='_blank'>");
		emailContentSB.append(productsTable.getPName());
		emailContentSB.append("</a>");
		emailContentSB
				.append("<br><strong><br>2. Your Comments Which Need Our Feedback:</strong><br>");
		emailContentSB.append(comContent);
		emailContentSB
				.append("<br><br><strong>3. Your Member Information:</strong><br>");
		emailContentSB
				.append("&nbsp;&nbsp;&nbsp;User ID: <a href='mailto:");
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
		emailContentSB
				.append("<br>&nbsp;&nbsp;&nbsp;Website: <a href='");
		emailContentSB.append(userInfSes.getWebsite());
		emailContentSB.append("'>");
		emailContentSB.append(userInfSes.getWebsite());
		emailContentSB.append("</a>");
		emailContentSB
				.append("<br>&nbsp;&nbsp;&nbsp;Mailing Address: ");
		emailContentSB.append(userInfSes.getMailingAddress());
		emailContentSB.append(",");
		emailContentSB.append(userInfSes.getACity());
		emailContentSB.append(",");
		emailContentSB.append(userInfSes.getAState());
		emailContentSB.append(",");
		emailContentSB.append(userInfSes.getAZip());
		emailContentSB.append(",");
		emailContentSB.append(userInfSes.getACountry());
		emailContentSB
				.append("<br>&nbsp;&nbsp;&nbsp;Your business Type: ");
		String temp_mail = userInfSes.getDi() + ","
				+ userInfSes.getMa() + "," + userInfSes.getEn() + ","
				+ userInfSes.getIm1() + "," + userInfSes.getIm2() + ","
				+ userInfSes.getRe() + "," + userInfSes.getBu() + ","
				+ userInfSes.getBr() + "," + userInfSes.getPr() + ","
				+ userInfSes.getOt();
		temp_mail = temp_mail.trim();
		for (int b = 0; temp_mail.indexOf(",,") != -1; b++)
			temp_mail = temp_mail.replaceAll(",,", ",");
		if (temp_mail.indexOf(",") == 0)
			temp_mail = temp_mail.substring(1, temp_mail.length());
		if (temp_mail.lastIndexOf(",") == (temp_mail.length() - 1))
			temp_mail = temp_mail.substring(0, temp_mail.length() - 1);

		emailContentSB.append(temp_mail);

		emailContentSB
				.append("<br><br>You will get our feedback as soon as possible based on above information!<br>");
		emailContentSB.append("<br>Thanks again.<br>");
		emailContentSB.append("<br>Best Regards!<br>");
		emailContentSB.append(StrUtil.toHtmlTag(mailTable
				.getMailSuffix()));
		int resultSend = 0;
		for (int j = 0; j < 3; j++) {
			String toMail = "";
			String subject = "";

			if (j != 2)
				subject = "Your Comments on BioSun Product!";
			else
				subject = "Need Feedback on "
						+ StrUtil.toHtmlTag(productsTable.getPModel()
								+ " " + productsTable.getPName())
						+ " !";
						
			if (j == 0){
				toMail = userInfSes.getId();
				if(toMail.equals(userInfSes.getEmail())){
				  continue;
				}
			} else if (j == 1){
				toMail = userInfSes.getEmail();
			} else if (j == 2){
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
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('Success!');location.href='index.jsp';</SCRIPT>");
			return;
		} else {
			out
					.println("<SCRIPT LANGUAGE='JavaScript'>alert('Fail!');location.href='index.jsp';</SCRIPT>");
			return;
		}
	}

	out
			.println("<SCRIPT LANGUAGE='JavaScript'>alert('Success!');location.href='index.jsp';</SCRIPT>");
	return;
%>