<%@page contentType="text/html;charset=utf-8"%>
<%@page import="java.util.*"%>
<%@page import="hk.com.biosun.model.UserInf"%>
<%@page import="hk.com.biosun.model.MailTable"%>
<%@page import="hk.com.biosun.util.SessionUtil"%>
<%@page import="com.aokle.util.DateUtil"%>
<%@page import="com.aokle.util.StrUtil"%>
<%@page import="com.aokle.util.MathUtil"%>
<%@page import="hk.com.biosun.util.ReqParamUtil"%>
<%@page import="hk.com.biosun.service.UserInfService"%>
<%@page import="hk.com.biosun.service.MailTableService"%>
<%@page import="hk.com.biosun.service.ProductsTableService"%>
<%@page import="hk.com.biosun.service.EnquiryService"%>
<%@page import="hk.com.biosun.model.ProductsTable"%>
<%@page import="hk.com.biosun.model.Enquiry"%>
<%@page import="hk.com.biosun.service.CartService"%>
<%@page import="hk.com.biosun.define.ProductCart"%>
<%@page import="hk.com.biosun.service.BuyCarService"%>
<%@page import="hk.com.biosun.model.BuyCar"%>
<%
	UserInf userInfSes = SessionUtil.getUserInf(request);
	if (userInfSes == null) {
		out
				.println("<SCRIPT LANGUAGE='JavaScript'>alert('Please Sign in！');location.href='login.jsp';</SCRIPT>");
		return;
	}

	String en_p = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
			.getParameter("en_p")));
	String mi = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
			.getParameter("mi")));
	String de = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
			.getParameter("de")));
	String in = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
			.getParameter("in")));
	String sa = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
			.getParameter("sa")));
	String order_s = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
			.getParameter("order_s")));
	String p_id_s = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
			.getParameter("p_id_s")));
	String account_inf = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("account_inf")));
	String other_txt = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("other_txt")));
	String account_num = StrUtil.toHtmlTxt(ReqParamUtil
			.getReqParam(request.getParameter("account_num")));
	String ot_ms = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
			.getParameter("ot_ms")));
	String send_en = StrUtil.toHtmlTxt(ReqParamUtil.getReqParam(request
			.getParameter("send_en")));
	if (account_inf.equals("other"))
		account_inf = account_inf + ":" + other_txt;

	if (!send_en.equalsIgnoreCase("ok")) {
		out
				.println("<SCRIPT LANGUAGE='JavaScript'>alert('Paramenter Error！');javascript:history.back(-1);</SCRIPT>");
		return;
	}
	CartService cartService = SessionUtil.getCartService(request);
	if (cartService == null) {
		out
				.println("<SCRIPT LANGUAGE='JavaScript'>alert('System Error!Please try it again later!');location.href='index.jsp';</SCRIPT>");
		return;
	}

	List<ProductCart> productCartList = cartService
			.getListProductCart();
	int productCartListSize = productCartList != null ? productCartList
			.size() : 0;
	if (productCartListSize < 1) {
		out
				.println("<SCRIPT LANGUAGE='JavaScript'>alert('Your basket is empty!');javascript:history.back(-1);</SCRIPT>");
		return;
	}
	MailTableService mailTableService = new MailTableService();
	MailTable mailTable = mailTableService.getByPK("1");
	if (mailTable == null) {
		out
				.println("<SCRIPT LANGUAGE='JavaScript'>alert('Mail server Error!');location.href='index.jsp';</SCRIPT>");
		return;
	}

	ProductCart productCart;
	//获得已经登录的ID！获得当前的询单号！
	//把询单添加到询单表
	//询单添加到询单表成功后才能进行下一步
	//把产品放到购物车表中！
	//只要有一个产品成功放到购物车表证明成功！{
	//修改产品的询单次数！
	//修改会员级别！询单一次是2级，询单二次或以上是3级，交易一次是4级，交易大于1是5级！
	//若是3级就不用修改！
	//查询会员的两个邮箱地址，管理员的邮箱地址
	//循环发送三封邮件！
	//提示成功，返回到send_enquiry.jsp
	String en_id = DateUtil.formatDate(System.currentTimeMillis(), 12);
	Enquiry enquiry = new Enquiry();
	enquiry.setEnId(en_id);
	enquiry.setUserId(userInfSes.getId());
	enquiry.setEnP(en_p);
	enquiry.setMi(mi);
	enquiry.setDe(de);

	enquiry.setInOk(in);
	enquiry.setSa(sa);
	enquiry.setOrderS(order_s);
	enquiry.setPIdS(p_id_s);
	enquiry.setAccountInf(account_inf);

	enquiry.setAccountNum(account_num);
	enquiry.setOtMs(ot_ms);
	enquiry.setEnDate(DateUtil
			.formatDate(System.currentTimeMillis(), 2));
	enquiry.setEnStatus("0");
	EnquiryService enquiryService = new EnquiryService();
	int resultAdd = enquiryService.add(enquiry);
	if (resultAdd < 1) {
		out
				.println("<SCRIPT LANGUAGE='JavaScript'>alert('Fail!');javascript:history.back(-1);</SCRIPT>");
		return;
	}
	//把产品放到购物车表中！en_id,p_id,p_count
	ProductsTableService productsTableService = new ProductsTableService();
	ProductsTable productsTable;
	BuyCarService buyCarService = new BuyCarService();
	BuyCar buyCar;
	int successCount = 0;
	for (int i = 0; i < productCartListSize; i++) {
		productCart = productCartList.get(i);
		productsTable=productsTableService.getByPK(productCart.getPId());
		buyCar = new BuyCar();
		buyCar.setEnId(en_id);
		buyCar.setPId(productCart.getPId());
		buyCar.setPCount(productCart.getPCount());
		buyCar.setUserId(userInfSes.getId());
		buyCar.setPModel(productsTable!=null?productsTable.getPModel():"");
		buyCar.setPPic(productsTable!=null?productsTable.getPPic():"");
		buyCar.setPName(productsTable!=null?productsTable.getPName():"");
		
		if (buyCarService.add(buyCar) > 0) {
			successCount++;
		}
	}

	if (successCount < 1) {//删除询单信息，返回。
		enquiryService.delete(en_id);
		out
				.println("<SCRIPT LANGUAGE='JavaScript'>alert('Fail!');javascript:history.back(-1);</SCRIPT>");
		return;
	}

	//修改会员级别！询单一次是2级，询单二次或以上是3级，交易一次是4级，交易大于1是5级！
	//若是3级就不用修改！
	//大于三时只修改询单次数，
	//修改级别和询单次数！
	int idGrage = MathUtil.toInt(userInfSes.getIdGrage());
	UserInfService userInfService = new UserInfService();
	userInfService.addEnTimes(userInfSes.getId(), idGrage, 1);
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
			.append("<br><br>Thanks for your interest and enquiry to Biosun Products.<br> <br>");

	emailContentSB
			.append("And below is your enquiry information in our website at ");
	emailContentSB.append(DateUtil.formatDate(System
			.currentTimeMillis(), 13));
	emailContentSB
			.append(" (Beijing Time):<br><br><strong>1.Enquiry ID: ");
	emailContentSB.append(en_id);
	emailContentSB.append("</strong>");
	//添加询单信息
	emailContentSB
			.append("<br><br><table width='70%' border=1 align='center' cellpadding=0 cellspacing=0   ");
	emailContentSB
			.append("bordercolordark='#FFFFFF' bordercolor='#B2C0EF'><tr ><td align='center' valign='middle' width='8%'>Item No.</td>");
	emailContentSB
			.append("<td align='center' valign='middle' width='35%'>Model</td><td align='center' valign='middle' >Product Name</td>");
	emailContentSB
			.append("<td width='8%' align='center' valign='middle'>Qty.(set)</td></tr>");

	
	List<ProductsTable> productsList = cartService
			.getListProductsTable();
	int productsListSize = productsList != null
			? productsList.size()
			: 0;
	
	for (int i = 0; i < productsListSize; i++) {
		productsTable = productsList.get(i);
		productCart = cartService.getProductCart(productsTable.getPId());
		if (productCart == null) {
			continue;
		}
		//修改该产品的询盘次数
		productsTableService.updateAskTimes(productsTable.getPId(), 1);
		emailContentSB
				.append("<tr ><td align='center' valign='middle'>");
		emailContentSB.append(i + 1);
		emailContentSB.append("</td><td>&nbsp;<a href='");
		emailContentSB.append(mailTable.getWebsite());
		emailContentSB.append("/products_detail.jsp?p_id=");
		emailContentSB.append(productsTable.getPId());
		emailContentSB.append("' target='_blank'>");
		emailContentSB.append(StrUtil.toHtmlTag(productsTable
				.getPModel()));

		emailContentSB.append("</a></td><td >&nbsp;<a href='");
		emailContentSB.append(mailTable.getWebsite());
		emailContentSB.append("/products_detail.jsp?p_id=");
		emailContentSB.append(productsTable.getPId());
		emailContentSB.append("' target='_blank'>");
		emailContentSB.append(StrUtil.toHtmlTag(productsTable
				.getPName()));
		emailContentSB
				.append("</a></td><td align='center' valign='middle' >");
		emailContentSB.append(productCart.getPCount());
		emailContentSB.append("</td></tr>");

	}

	emailContentSB.append("</table>");

	emailContentSB
			.append("<br><strong>2.Transaction Request:</strong><br>&nbsp;&nbsp;&nbsp;");
	emailContentSB.append(en_p);
	emailContentSB.append("?");
	if (!mi.equals("")) {
		emailContentSB.append("<br>&nbsp;&nbsp;&nbsp;");
		emailContentSB.append(mi);
		emailContentSB.append("?");
	}
	if (!de.equals("")) {
		emailContentSB.append("<br>&nbsp;&nbsp;&nbsp;");
		emailContentSB.append(de);
		emailContentSB.append("?");
	}
	if (!in.equals("")) {
		emailContentSB.append("<br>&nbsp;&nbsp;&nbsp;");
		emailContentSB.append(in);
		emailContentSB.append("?");
	}
	if (!sa.equals("")) {
		emailContentSB.append("<br>&nbsp;&nbsp;&nbsp;");
		emailContentSB.append(sa);
		emailContentSB.append("?");
	}

	if (order_s.equals("Yes")) {
		emailContentSB
				.append("<strong><br><br>3.Samples Request:</strong><br>&nbsp;&nbsp;&nbsp;Model No.:");
		emailContentSB.append(p_id_s);
		emailContentSB.append("<br>");
		emailContentSB.append("&nbsp;&nbsp;&nbsp;Your Courier Info:  ");
		emailContentSB.append(account_inf);
		emailContentSB.append("<br>");
		emailContentSB.append("&nbsp;&nbsp;&nbsp;Account Number:  ");
		emailContentSB.append(account_num);
		emailContentSB.append("<br>");
		emailContentSB.append("&nbsp;&nbsp;&nbsp;Other Message:  ");
		emailContentSB.append(ot_ms);
		emailContentSB.append("<br>");
	}

	emailContentSB.append("<br><strong>");
	if (order_s.equals("Yes"))
		emailContentSB.append("4");
	else {
		emailContentSB.append("3");
	}
	emailContentSB
			.append(".Your Registered Member Information:</strong><br>");

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
			.append("<br><br>You will get our feedback as soon as possible based on above information!<br>");
	emailContentSB.append("<br>Thanks again.<br>");
	emailContentSB.append("<br>Best Regards!<br>");
	emailContentSB.append(StrUtil.toHtmlTag(mailTable.getMailSuffix()));
	int resultSend = 0;
	for (int j = 0; j < 3; j++) {
		String toMail = "";
		String subject = "";
		if (j != 2)
			subject = "Your Enquiry ID:" + en_id + " in BioSun.";

		else
			subject = "Enquiry Info " + en_id + " !";
		if (j == 0){
			toMail = userInfSes.getId();
			if(toMail.equals(userInfSes.getEmail())){
				 continue;
			}
		}else if (j == 1) {
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
				.println("<SCRIPT LANGUAGE='JavaScript'>alert('Send enquiry Success!');location.href='view_basket.jsp';</SCRIPT>");
		return;
	} else {
		out
				.println("<SCRIPT LANGUAGE='JavaScript'>alert('Send enquiry Fail!');location.href='view_basket.jsp';</SCRIPT>");
		return;
	}
%>