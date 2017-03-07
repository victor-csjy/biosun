package hk.com.biosun.util;

import javax.servlet.http.HttpServletRequest;

public class ReqParamUtil {

	public static String strEncode(String str, String charsetOld,
			String charsetNew) {
		byte[] bTemp;
		if (str == null || (str.trim()).equals(""))
			return str;
		if ((charsetOld == null || charsetOld.equals(""))
				&& (charsetNew == null || charsetNew.equals(""))) {
			return str;
		}
		try {// String(s.getBytes("ISO8859-1"),"gb2312");
			if (charsetOld == null || "".equals(charsetOld)) {
				bTemp = str.getBytes();
			} else {
				bTemp = str.getBytes(charsetOld); // "ISO8859_1"
			}
			if (charsetNew == null || "".equals(charsetNew)) {
				str = new String(bTemp);
			} else {
				str = new String(bTemp, charsetNew);
			}
		} catch (Exception e) {
		}
		return str;
	}

	/** *************ˢ�·�ʽ�ύ**************************************************** */
	/**
	 * ����:ˢ�·�ʽ�ύ,Ĭ��post��ʽ
	 * 
	 * @param s
	 *            ��������ת��ΪGBK,��ʹ��trim
	 * @return
	 */

	public static String getReqParam(HttpServletRequest request,
			String paramName) {
		return getReqParam(request.getParameter(paramName), request.getMethod());
	}

	public static String getReqParam(String s) {
		return getReqParamGet(s);
	}

	public static String getReqParam(String s, boolean isUseTrim) {
		return getReqParamGet(s, isUseTrim);
	}

	public static String getReqParam(String s, String methodName) {
		if (methodName == null || "".equalsIgnoreCase("POST")) {
			return getReqParamPost(s);
		} else {
			return getReqParamGet(s);
		}
	}

	public static String getReqParamPost(String s, String charsetOld,
			String charsetNew, boolean isUseTrim) {
		if (s == null || "".equals(s)) {
			return "";
		}
		s = strEncode(s, charsetOld, charsetNew);
		if (isUseTrim) {
			return s.trim();
		} else {
			return s;
		}
	}

	public static String getReqParamPost(String s, String charsetNew,
			boolean isUseTrim) {
		return getReqParamPost(s, "ISO8859-1", charsetNew, isUseTrim);
	}

	public static String getReqParamPost(String s, boolean isUseTrim) {
		return getReqParamPost(s, "ISO8859-1", "UTF-8", isUseTrim);
	}

	public static String getReqParamPost(String s) {
		return getReqParamPost(s, "ISO8859-1", "UTF-8", false);
	}

	/** *********************************************** */
	public static String getReqParamGet(String s, String charsetOld,
			String charsetNew, boolean isUseTrim) {
		if (s == null || "".equals(s)) {
			return "";
		}
		s = strEncode(s, charsetOld, charsetNew);
		if (isUseTrim) {
			return s.trim();
		} else {
			return s;
		}
	}

	public static String getReqParamGet(String s, String charsetNew,
			boolean isUseTrim) {
		return getReqParamGet(s, "ISO8859-1", charsetNew, isUseTrim);
	}

	public static String getReqParamGet(String s, boolean isUseTrim) {
		return getReqParamGet(s, "ISO8859-1", "UTF-8", isUseTrim);
	}

	public static String getReqParamGet(String s) {
		return getReqParamGet(s, "ISO8859-1", "UTF-8", false);
	}

	/** *********************************************************************** */
	/** *********************������ajax��ʽ��************************************ */
	/** *********************************************************************** */

	/**
	 * ����:ajax��ʽ�ύ,Ĭ��post��ʽ
	 * 
	 * @param s
	 *            ������ת��,��ʹ��trim
	 * @return
	 */

	public static String getReqParamAjax(String s) {
		return getReqParamAjaxPost(s);
	}

	/**
	 * ����: ajax��ʽ�ύ,����ʹ�ø÷�����ȡ����
	 * 
	 * @param s
	 * 
	 * @param methodName
	 *            POST ��ʽ��ת��,GETת����ISO8859_1(ISO-8859-1)ΪGBK,����ʹ��trim
	 * @return
	 */
	public static String getReqParamAjax(String s, String methodName) {
		if (methodName == null || "POST".equalsIgnoreCase(methodName)) {
			return getReqParamAjaxPost(s);
		} else {
			return getReqParamAjaxGet(s);
		}
	}

	public static String getReqParamAjaxPost(String s, String charsetOld,
			String charsetNew, boolean isUseTrim) {
		if (s == null || "".equals(s)) {
			return "";
		}
		s = strEncode(s, charsetOld, charsetNew);
		if (isUseTrim) {
			return s.trim();
		} else {
			return s;
		}
	}

	public static String getReqParamAjaxPost(String s, String charsetNew,
			boolean isUseTrim) {
		return getReqParamAjaxPost(s, null, charsetNew, isUseTrim);
	}

	public static String getReqParamAjaxPost(String s, boolean isUseTrim) {
		return getReqParamAjaxPost(s, null, null, isUseTrim);
	}

	public static String getReqParamAjaxPost(String s) {
		return getReqParamAjaxPost(s, null, null, false);
	}

	/** *********************************************** */
	public static String getReqParamAjaxGet(String s, String charsetOld,
			String charsetNew, boolean isUseTrim) {
		if (s == null || "".equals(s)) {
			return "";
		}
		s = strEncode(s, charsetOld, charsetNew);
		if (isUseTrim) {
			return s.trim();
		} else {
			return s;
		}
	}

	public static String getReqParamAjaxGet(String s, String charsetNew,
			boolean isUseTrim) {
		return getReqParamAjaxGet(s, null, charsetNew, isUseTrim);
	}

	public static String getReqParamAjaxGet(String s, boolean isUseTrim) {
		return getReqParamAjaxGet(s, "ISO8859_1", "UTF-8", isUseTrim);
	}

	public static String getReqParamAjaxGet(String s) {
		return getReqParamAjaxGet(s, "ISO8859_1", "UTF-8", false);
	}
}
