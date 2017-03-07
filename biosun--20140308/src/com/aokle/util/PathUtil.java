package com.aokle.util;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

/**
 * 11.�ʵ�����Java�Ŀ�ƽ̨�ԣ�����ʹ��Java�ṩ����Ĺ��ܡ�
 * ���磬���лس�������\r\n����\r������\n����ͬ��ϵͳ�ǲ�һ���ġ����Կ���һ��ʹ��Java�ṩ�Ĺ��ܰ�<br>
 * System�����ṩpublic static String getProperty(String key)����������key����ȡ���µ�ֵ��<br>
 * file.separator �ļ��ָ������� UNIX ϵͳ���ǡ�/����<br>
 * path.separator ·���ָ������� UNIX ϵͳ���ǡ�:����<br>
 * line.separator �зָ������� UNIX ϵͳ���ǡ�/n����<br>
 * 
 * @author qinyongcai
 */
public class PathUtil {

	/**
	 * ���ܣ�����Ӧ�õ��ļ��� magicwebsoft ǰ��û�� /
	 * 
	 * @param request
	 * @return �磺magicwebsoft
	 */
	public static String getContextPath(HttpServletRequest request) {
		String contextPathStr = "";
		contextPathStr = (String) request.getContextPath();// ����/qyc
		if (contextPathStr == null) {
			contextPathStr = "";
		}
		// ɾ��ǰ���/
		while (contextPathStr.startsWith("/")) {
			contextPathStr = contextPathStr.substring(1);// ɾ����һ�� /
		}
		while (contextPathStr.endsWith("/")) {
			contextPathStr = contextPathStr.substring(0, (contextPathStr.length() - 1));// ɾ�����һ�� /
		}
		return contextPathStr;
	}

	/**
	 * ���ܣ������Զ���� "/"
	 * 
	 * @param request
	 * @param scheme
	 * @return http://localhost:8080/magicwebsoft/
	 */
	public static String getAppUrl(HttpServletRequest request, String scheme) {
		StringBuffer fullUrlSB = new StringBuffer();
		if (scheme == null || "".equals(scheme)) {
			scheme = (String) request.getScheme();
			if (scheme == null || "".equals(scheme)) {
				scheme = "http";
			}
		}
		fullUrlSB.append(scheme);

		fullUrlSB.append("://");
		String serverName = (String) request.getServerName();
		if (serverName != null) {
			fullUrlSB.append(serverName);
		}
		int serverPort = request.getServerPort();
		if (serverPort != 80) {
			fullUrlSB.append(':');
			fullUrlSB.append(serverPort);
		}

		String contextPath = getContextPath(request);
		if (contextPath.equals("")) {
			fullUrlSB.append('/');
		} else {
			fullUrlSB.append('/');
			fullUrlSB.append(contextPath);
			fullUrlSB.append('/');
		}
		return fullUrlSB.toString();
	}

	public static String getAppUrl(HttpServletRequest request) {
		return getAppUrl(request, "");
	}

	/**
	 * ���ܣ����ص�ǰ����ҳ�������URL��ַ�����������ǰ��������ַ
	 * 
	 * @param request
	 * @param scheme
	 *            Э�飺Ĭ��http �� ddn
	 * @return http://localhost:8080/magicwebsoft/url.jsp?sam=09sdsadad&dsadsa=09987sdd
	 */
	public static String getUrl(HttpServletRequest request, String scheme) {
		StringBuffer urlSB = new StringBuffer(getUrlNoParam(request, scheme));
		String queryString = (String) request.getQueryString();
		if (queryString == null || "".equals(queryString)
				|| "/".equals(queryString)) {
			queryString = "";
		} else {
			queryString = "?" + queryString;
		}
		urlSB.append(queryString);
		return urlSB.toString();
	}

	public static String getUrl(HttpServletRequest request) {
		return getUrl(request, "");
	}

	/**
	 * ���ܣ�����û�в�����URL
	 * 
	 * @param request
	 * @param scheme
	 * @return http://localhost:8080/magicwebsoft/url.jsp
	 */
	public static String getUrlNoParam(HttpServletRequest request, String scheme) {
		StringBuffer urlNoParamSB = new StringBuffer();
		if (scheme == null || "".equals(scheme)) {
			scheme = (String) request.getScheme();
			if (scheme == null || "".equals(scheme)) {
				scheme = "http";
			}
		}
		urlNoParamSB.append(scheme);

		urlNoParamSB.append("://");
		String serverName = (String) request.getServerName();
		if (serverName != null) {
			urlNoParamSB.append(serverName);
		}
		int serverPort = request.getServerPort();
		if (serverPort != 80) {
			urlNoParamSB.append(':');
			urlNoParamSB.append(serverPort);
		}

		String requestURI = (String) request.getRequestURI();
		if (requestURI == null) {
			requestURI = "/";
		}
		urlNoParamSB.append(requestURI);
		return urlNoParamSB.toString();
	}

	public static String getUrlNoParam(HttpServletRequest request) {
		return getUrlNoParam(request, "http");
	}

	/**
	 * ���ܣ���ȡURL�Ĳ��������磺dodoId=123&netbarId=123
	 * 
	 * @param request
	 * @return sam=09sdsadad&dsadsa=09987sdd
	 */
	public static String getUrlQuery(HttpServletRequest request) {
		String urlQuery = request.getQueryString();
		if (urlQuery == null || "/".equals(urlQuery)) {
			urlQuery = "";
		}
		return urlQuery;
	}

	/**
	 * ���ܣ���ȡ����·���ĺ���
	 * 
	 * @param request
	 * @return D:\java\tomcat5.5\webapps\magicwebsoft\
	 */
	public static String getRealPath(HttpServletRequest request) {
		return (String) request.getSession().getServletContext().getRealPath(
				"/");
	}

	/**
	 * ���ܣ����Ӧ�õĵľ���·��,������/
	 * 
	 * @return D:\java\tomcat5.5\webapps\magicwebsoft\
	 */
	public static String getRealPath() {
		String realPathStr = PathUtil.class.getProtectionDomain()
				.getCodeSource().getLocation().getPath();
		if (realPathStr == null || "".equals(realPathStr)) {
			realPathStr = PathUtil.class.getResource("").getPath();
			if (realPathStr == null || "".equals(realPathStr)) {
				System.out.println("1 �޷���ȡӦ�õ���ʵ·����");
				return null;
			}
		}

		int index = realPathStr.indexOf("/WEB-INF/");
		if (index < -1) {
			index = realPathStr.indexOf("\\WEB-INF\\");
		}
		if (index > -1) {
			realPathStr = realPathStr.substring(0, index + 1);// ��ȡӦ�õľ���·��
		}

		while (realPathStr.indexOf(":") > 0
				&& (realPathStr.startsWith("/") || realPathStr.startsWith("\\"))) {
			// windows��ɾ����һ��/
			// linux�²�Ҫɾ��
			realPathStr = realPathStr.substring(1);
		}
		// �滻�� File.separator realPathStr.replaceAll("/",
		// File.separator);File.separator==\ ʱ��������쳣

		if (realPathStr.endsWith(".jar") || realPathStr.endsWith(".Jar")
				|| realPathStr.endsWith(".JAR")) {
			realPathStr = realPathStr.substring(0, realPathStr.length() - 4);
			index = realPathStr.lastIndexOf('/');
			if (index < -1) {
				index = realPathStr.lastIndexOf("\\");
			}
			if (index > -1) {
				realPathStr = realPathStr.substring(0, index);
			}
		}
		if (File.separator.equals("\\")) {
			return realPathStr.replaceAll("/", "\\\\");
		}
		return realPathStr;
	}

	/**
	 * ���ܣ���web·��ת��Ϊ��ʵ·����ʽ,ǰ���·���� webPathStr��ʽ������
	 * 
	 * @param webPathStr
	 *            �磺front/person/templet/
	 * @return front(File.separator)person(File.separator)templet(File.separator)
	 */
	public static String toRealPathStr(String webPathStr) {
		if (webPathStr == null || "".equals(webPathStr)) {
			return "";
		}
		if (File.separator.equals("/")) {
			return webPathStr;
		} else if (File.separator.equals("\\")) {
			return webPathStr.replaceAll("/", "\\\\");
		}
		return webPathStr;
	}

	/**
	 * ���ܣ���ȡ��ǰӦ�õ���������ʵ·�� Ҫ��webPathStr=="" ������� File.separator �������
	 * webPathStr��ʽ������
	 * 
	 * @param webPathStr
	 *            web·�� �磺front/person/templet/ �� front/person/templet ��
	 *            front/person/templet/1/1.css
	 * @return �����ľ���·��
	 */
	public static String getFileRealPath(String webPathStr) {
		webPathStr = toRealPathStr(webPathStr);
		if (webPathStr == null || webPathStr.equals("")) {
			webPathStr = "";
		}
		while (webPathStr.startsWith(File.separator)) {
			webPathStr = webPathStr.substring(1);
		}
		return getRealPath() + webPathStr;
	}

	public static String toAnthorSplit(String str, String splitOldStr,
			String splitNewStr) {
		if (str == null || "".equals(str)) {
			return "";
		}
		if (splitOldStr == null || splitOldStr.equals("")
				|| splitNewStr == null || splitNewStr.equals("")
				|| splitOldStr.equals(splitNewStr)) {
			return str;
		}

		int indexTemp = str.indexOf(splitOldStr);
		String strTemp = "";
		while (indexTemp > 0) {
			strTemp = str.substring(0, indexTemp);
			str = strTemp + splitNewStr
					+ str.substring(indexTemp + splitOldStr.length());
			indexTemp = str.indexOf(splitOldStr);
		}
		return str;
	}

	/**
	 * ���ܣ����������ļ��ľ���·��������˳��WEB-INF/classes/,WEB-INF
	 * 
	 * @param fileName
	 * @return D:\java\tomcat5.5\webapps\magicwebsoft\WEB-INF\log4j.xml
	 */
	public static String getWebConfigFileRealPath(String fileName) {
		if (fileName == null || fileName.equals("")) {
			return "";
		}
		String fileRealPath = getFileRealPath("WEB-INF/classes/" + fileName);
		File file = new File(fileRealPath);
		if (file.isFile()) {
			return fileRealPath;
		} else {
			fileRealPath = getFileRealPath("WEB-INF/" + fileName);
			file = new File(fileRealPath);
			if (file.isFile()) {
				return fileRealPath;
			} else {
				return "";
			}
		}
	}

	public static void main(String[] args) {
		System.out.println("getRealPath()=" + getRealPath());
		System.out.println("getFileRealPath()="
				+ getFileRealPath("/WEB-INF/classes/com/"));
	}
}
