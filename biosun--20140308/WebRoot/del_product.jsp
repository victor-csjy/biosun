<%@page contentType="text/html;charset=utf-8"%>
<%@page import="com.aokle.util.MathUtil"%>
<%@page import="hk.com.biosun.util.SessionUtil"%>
<%@page import="hk.com.biosun.service.CartService"%>
 <% 
    int pIdDelToCart = MathUtil.toInt(request.getParameter("p_id"));
	
	CartService cartServiceDelToCart = SessionUtil.getCartService(request);
	if (cartServiceDelToCart == null) {
		out.println("<SCRIPT LANGUAGE='JavaScript'>alert('System Error!Please try it again later!');javascript:history.back(-1);</SCRIPT>");
		return;
	}
	int resultDelToCart = cartServiceDelToCart.delete(pIdDelToCart);
	if (resultDelToCart > 0) {
		out.println("<SCRIPT LANGUAGE='JavaScript'>location.href='view_basket.jsp';</SCRIPT>");
		return;
	} else {
		out.println("<SCRIPT LANGUAGE='JavaScript'>alert('Parameter Error!');javascript:history.back(-1);</SCRIPT>");
		return;
	}
 %>