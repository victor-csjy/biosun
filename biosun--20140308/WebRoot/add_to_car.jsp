<%@page contentType="text/html;charset=utf-8"%>
<%@page import="com.aokle.util.MathUtil"%>
<%@page import="hk.com.biosun.util.SessionUtil"%>
<%@page import="hk.com.biosun.service.CartService"%>
<%
	int pIdAddToCart = MathUtil.toInt(request.getParameter("p_id"));
	int qtyAddToCart = MathUtil.toInt(request.getParameter("qty"));
	CartService cartServiceAddToCart = SessionUtil.getCartService(request);
	if (cartServiceAddToCart == null) {
		out
				.println("<SCRIPT LANGUAGE='JavaScript'>alert('System Error!Please try it again later!');javascript:history.back(-1);</SCRIPT>");
		return;
	}
	int resultAddToCart = cartServiceAddToCart.add(pIdAddToCart,
			qtyAddToCart);
	if (resultAddToCart > 0) {
		out
				.println("<SCRIPT LANGUAGE='JavaScript'>alert('Success!');javascript:history.back(-1);</SCRIPT>");
		return;
	} else {
		out
				.println("<SCRIPT LANGUAGE='JavaScript'>alert('Parameter Error!');javascript:history.back(-1);</SCRIPT>");
		return;
	}
%>