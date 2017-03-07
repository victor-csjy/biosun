package com.aokle.util;

import javax.servlet.http.HttpServletRequest;

public class IpUtil {
	/**
	 * ���ܣ���ȡ�ͻ�����ʵ��IP��ַ type�����ﲻ���κ����� X-Forwarded-For: unknown
	 * ��X-Forwarded-Forȷʵ���ڣ�����ֵȴΪunknown��������ԭ�����������ѣ�ԭ�������Squid�ϡ� squid.conf
	 * �������ļ� forwarded_for ��Ĭ����Ϊon����� forwarded_for ����� off �� X-Forwarded-For:
	 * unknown һ�飬����forwarded_for ����Ϊ��off��ԭ���ҵ��ˣ���forwarded_for ����Ϊ��on
	 * ���ͨ���˶༶�������Ļ���X-Forwarded-For��ֵ����ֹһ��������һ��Ipֵ�������ĸ������������û��˵���ʵIP�أ�
	 * ����ȡX-Forwarded-For�е�һ����unknown����ЧIP�ַ����� �磺
	 * X-Forwarded-For��192.168.1.110, 192.168.1.120, 192.168.1.130,
	 * 192.168.1.100 �û���ʵIPΪ�� 192.168.1.110
	 * 
	 * @param request
	 * @param type=0
	 *            ��ȡ�ͻ��˵� type=1 ��ȡ��������
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
			ip = request.getLocalAddr();// jdk1.4��֧��
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
