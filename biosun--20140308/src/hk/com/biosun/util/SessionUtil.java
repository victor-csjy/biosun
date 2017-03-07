package hk.com.biosun.util;

import hk.com.biosun.model.Admin;
import hk.com.biosun.model.UserInf;
import hk.com.biosun.service.CartService;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;

public class SessionUtil {
	private static Logger LOG = Logger.getLogger(SessionUtil.class);

	public static Object getAttribute(HttpServletRequest request, String name) {
		if (request == null || name == null)
			return null;
		return request.getSession().getAttribute(name);
	}
	public static void setAttribute(HttpServletRequest request, String name,
			Object value) {
		if (request == null || name == null || "".equals(name)) {
			return;
		}
		request.getSession().setAttribute(name, value);
	}

	public static void removeAttribute(HttpServletRequest request, String name) {
		if (request == null || name == null) {
			return;
		}
		request.getSession().removeAttribute(name);
	}

	public static void setUserInf(HttpServletRequest request, UserInf userInf) {
		setAttribute(request, "userInf", userInf);
	}

	public static UserInf getUserInf(HttpServletRequest request) {
		try {
			return (UserInf) getAttribute(request, "userInf");
		} catch (Exception e) {
			e.printStackTrace();
			LOG.error(e);
		}
		return null;
	}

	public static void setAdmin(HttpServletRequest request, Admin admin) {
		setAttribute(request, "admin", admin);
	}

	public static Admin getAdmin(HttpServletRequest request) {
		try {
			return (Admin) getAttribute(request, "admin");
		} catch (Exception e) {
			e.printStackTrace();
			LOG.error(e);
		}
		return null;
	}

	public static String getAdminName(HttpServletRequest request) {
		try {
			Admin admin = (Admin) getAttribute(request, "admin");
			if (admin != null) {
				return admin.getAdminName();
			}
		} catch (Exception e) {
			e.printStackTrace();
			LOG.error(e);
		}
		return "";
	}

	public static void removeUserInf(HttpServletRequest request) {
		removeAttribute(request, "userInf");
	}

	public static CartService getCartService(HttpServletRequest request) {
		try {
			Object object = getAttribute(request, "cartService");
			if (object == null) {
				CartService cartService = new CartService();
				setAttribute(request, "cartService", cartService);
				return cartService;
			} else if (object instanceof CartService) {
				return (CartService) object;
			}
		} catch (Exception e) {
			e.printStackTrace();
			LOG.error(e);
		}
		return null;
	}

	public static void setVerifyCode(HttpServletRequest request,
			String verifyCode) {
		if (verifyCode == null) {
			return;
		}
		setAttribute(request, "verifyCode", verifyCode);
	}

	public static String getVerifyCode(HttpServletRequest request) {
		return (String) getAttribute(request, "verifyCode");
	}

}
