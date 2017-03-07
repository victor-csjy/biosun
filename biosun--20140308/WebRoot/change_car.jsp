<%@page contentType="text/html;charset=utf-8"%>
<%@page import="com.aokle.util.MathUtil"%>
<%@page import="hk.com.biosun.util.SessionUtil"%>
<%@page import="hk.com.biosun.service.CartService"%>
<% 
    int pIdChangeToCart = MathUtil.toInt(request.getParameter("p_id"));
    int qtyChangeToCart = MathUtil.toInt(request.getParameter("qty"));
	CartService cartServiceChangeToCart = SessionUtil.getCartService(request);
	if (cartServiceChangeToCart == null) {
		out.println("<SCRIPT LANGUAGE='JavaScript'>alert('System Error!Please try it again later!');javascript:history.back(-1);</SCRIPT>");
		return;
	}
	int resultChangeToCart = cartServiceChangeToCart.change(pIdChangeToCart,qtyChangeToCart);
	if (resultChangeToCart > 0) {
		out.println("<SCRIPT LANGUAGE='JavaScript'>location.href='view_basket.jsp';</SCRIPT>");
		return;
	} else {
		out.println("<SCRIPT LANGUAGE='JavaScript'>alert('Parameter Error!');javascript:history.back(-1);</SCRIPT>");
		return;
	}
%>