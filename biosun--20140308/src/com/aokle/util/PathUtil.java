package com.aokle.util;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

/**
 * 11.适当考虑Java的跨平台性，尽量使用Java提供给你的功能。
 * 比如，换行回车到底是\r\n还是\r或者是\n，不同的系统是不一样的。所以考虑一下使用Java提供的功能吧<br>
 * System类中提供public static String getProperty(String key)方法，其中key可以取如下的值。<br>
 * file.separator 文件分隔符（在 UNIX 系统中是“/”）<br>
 * path.separator 路径分隔符（在 UNIX 系统中是“:”）<br>
 * line.separator 行分隔符（在 UNIX 系统中是“/n”）<br>
 * 
 * @author qinyongcai
 */
public class PathUtil {

	/**
	 * 功能：返回应用的文件夹 magicwebsoft 前后都没有 /
	 * 
	 * @param request
	 * @return 如：magicwebsoft
	 */
	public static String getContextPath(HttpServletRequest request) {
		String contextPathStr = "";
		contextPathStr = (String) request.getContextPath();// 返回/qyc
		if (contextPathStr == null) {
			contextPathStr = "";
		}
		// 删除前后的/
		while (contextPathStr.startsWith("/")) {
			contextPathStr = contextPathStr.substring(1);// 删除第一个 /
		}
		while (contextPathStr.endsWith("/")) {
			contextPathStr = contextPathStr.substring(0, (contextPathStr.length() - 1));// 删除最后一个 /
		}
		return contextPathStr;
	}

	/**
	 * 功能：后面自动添加 "/"
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
	 * 功能：返回当前访问页面的完整URL地址，即浏览器当前的完整地址
	 * 
	 * @param request
	 * @param scheme
	 *            协议：默认http 或 ddn
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
	 * 功能：返回没有参数的URL
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
	 * 功能：获取URL的参数串，如：dodoId=123&netbarId=123
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
	 * 功能：获取绝对路径的函数
	 * 
	 * @param request
	 * @return D:\java\tomcat5.5\webapps\magicwebsoft\
	 */
	public static String getRealPath(HttpServletRequest request) {
		return (String) request.getSession().getServletContext().getRealPath(
				"/");
	}

	/**
	 * 功能：获得应用的的绝对路径,后面有/
	 * 
	 * @return D:\java\tomcat5.5\webapps\magicwebsoft\
	 */
	public static String getRealPath() {
		String realPathStr = PathUtil.class.getProtectionDomain()
				.getCodeSource().getLocation().getPath();
		if (realPathStr == null || "".equals(realPathStr)) {
			realPathStr = PathUtil.class.getResource("").getPath();
			if (realPathStr == null || "".equals(realPathStr)) {
				System.out.println("1 无法获取应用的真实路径！");
				return null;
			}
		}

		int index = realPathStr.indexOf("/WEB-INF/");
		if (index < -1) {
			index = realPathStr.indexOf("\\WEB-INF\\");
		}
		if (index > -1) {
			realPathStr = realPathStr.substring(0, index + 1);// 获取应用的绝对路径
		}

		while (realPathStr.indexOf(":") > 0
				&& (realPathStr.startsWith("/") || realPathStr.startsWith("\\"))) {
			// windows下删除第一个/
			// linux下不要删除
			realPathStr = realPathStr.substring(1);
		}
		// 替换成 File.separator realPathStr.replaceAll("/",
		// File.separator);File.separator==\ 时，会出现异常

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
	 * 功能：把web路径转换为真实路径形式,前后的路径由 webPathStr格式来决定
	 * 
	 * @param webPathStr
	 *            如：front/person/templet/
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
	 * 功能：获取当前应用的完整的真实路径 要是webPathStr=="" 则最后有 File.separator 否则根据
	 * webPathStr格式来返回
	 * 
	 * @param webPathStr
	 *            web路径 如：front/person/templet/ 或 front/person/templet 或
	 *            front/person/templet/1/1.css
	 * @return 完整的绝对路径
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
	 * 功能：返回配置文件的绝对路径，优先顺序：WEB-INF/classes/,WEB-INF
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
