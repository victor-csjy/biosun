package com.aokle.util;

import javax.servlet.http.HttpServletRequest;

public class IpUtil {
	/**
	 * 功能：获取客户端真实的IP地址 type在这里不起任何作用 X-Forwarded-For: unknown
	 * 。X-Forwarded-For确实存在，但其值却为unknown，继续找原因。上网搜了搜，原因出在了Squid上。 squid.conf
	 * 的配制文件 forwarded_for 项默认是为on，如果 forwarded_for 设成了 off 则： X-Forwarded-For:
	 * unknown 一查，发现forwarded_for 项设为了off，原因找到了，把forwarded_for 项设为了on
	 * 如果通过了多级反向代理的话，X-Forwarded-For的值并不止一个，而是一串Ip值，究竟哪个才是真正的用户端的真实IP呢？
	 * 答案是取X-Forwarded-For中第一个非unknown的有效IP字符串。 如：
	 * X-Forwarded-For：192.168.1.110, 192.168.1.120, 192.168.1.130,
	 * 192.168.1.100 用户真实IP为： 192.168.1.110
	 * 
	 * @param request
	 * @param type=0
	 *            获取客户端的 type=1 获取服务器的
	 * @return String
	 */
	public static String getIpAddr(HttpServletRequest request, int type) {
		String ip = "";
		if (type == 0) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
			if (ip == null || ip.length() == 0
					|| "unknown".equalsIgnoreCase(ip)) {
				ip = request.getHeader("Proxy-Client-IP");
			}
			if (ip == null || ip.length() == 0
					|| "unknown".equalsIgnoreCase(ip)) {
				ip = request.getHeader("WL-Proxy-Client-IP");
			}
			if (ip == null || ip.length() == 0
					|| "unknown".equalsIgnoreCase(ip)) {
				ip = request.getHeader("HTTP_CLIENT_IP");
			}
			if (ip == null || ip.length() == 0
					|| "unknown".equalsIgnoreCase(ip)) {
				ip = request.getRemoteAddr();
			}
			return ip == null ? "" : ip.trim();
		} else if (type == 1) {
			ip = request.getLocalAddr();// jdk1.4不支持
			return ip == null ? "" : String.valueOf(ip).trim();
		} else {
			return "";
		}
	}

	public static String getIpAddrClient(HttpServletRequest request) {
		return getIpAddr(request, 0);
	}
	public static String getIpAddrServer(HttpServletRequest request) {
		return getIpAddr(request, 1);
	}
}
