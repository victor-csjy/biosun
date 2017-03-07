package com.aokle.util;

import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.sql.Blob;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.sql.rowset.serial.SerialBlob;

public class StrUtil {
	public static final String RANDOM_DEFAULT_STR = "123456789abcdefghijklmnopqrstuvwxyz";

	/**
	 * ����:null����ת��Ϊ���ַ���,ǰ��ո�ȥ��
	 * 
	 * @param str
	 * @param strDefault
	 * @return
	 */
	public static String nullToStr(String str, String strDefault, boolean isTrim) {
		if (str == null || "null".equalsIgnoreCase(str.trim())) {
			if (isTrim) {
				return strDefault.trim();
			} else {
				return strDefault;
			}
		} else {
			if (isTrim) {
				return str.trim();
			} else {
				return str;
			}
		}
	}

	public static String nullToStr(String str, boolean isTrim) {
		return nullToStr(str, "", isTrim);
	}

	public static String nullToStr(String str) {
		return nullToStr(str, "", false);
	}

	public static String urlEncode(String str, String charset) {
		if (str == null) {
			return "";
		}
		String strTemp = str.trim();
		try {
			strTemp = (charset == null || charset.trim().equals("")) ? URLEncoder
					.encode(str, "UTF-8")
					: URLEncoder.encode(str, charset);
		} catch (Exception e) {
		}
		return strTemp;
	}

	public static String urlEncode(String str) {
		return urlEncode(str, "");
	}

	public static String urlDecode(String str, String charset) {
		if (str == null) {
			return "";
		}
		String strTemp = str.trim();
		try {
			strTemp = charset.equals("") ? URLDecoder.decode(strTemp, "UTF-8")
					: URLDecoder.decode(strTemp, charset);
		} catch (Exception e) {
		}
		return strTemp;
	}

	/**
	 * ���ܣ���ʽ��������������
	 * 
	 * @param str
	 * @param lengthLeave
	 * @param suffixStr
	 * @return
	 */
	public static String fomatStr(String str, int lengthLeave, String suffixStr) {
		if (str == null || str.equals(""))
			return "";
		else {
			str = str.trim();
			if (str.length() > lengthLeave) {
				str = str.substring(0, (lengthLeave - 2));
				if (suffixStr == null)
					str = str + "...";
				else
					str = str + suffixStr;
			}
			return str;
		}
	}

	public static String fomatStr(String str, int lengthLeave) {
		return fomatStr(str, lengthLeave, null);
	}

	public static String strEncode(String str, String charsetOld,
			String charsetNew) {
		byte[] bTemp;
		if (str == null || (str.trim()).equals(""))
			return str;
		if ((charsetOld == null || charsetOld.equals(""))
				&& (charsetNew == null || charsetNew.equals(""))) {
			return str;
		}
		try {

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

	public static String unicodeToGB2312(String str) {
		return strEncode(str, "ISO8859_1", "GB2312");
	}

	public static String unicodeToGBK(String str) {
		return strEncode(str, "ISO8859_1", "GBK");
	}

	public static String gbkToUnicode(String str) {
		return strEncode(str, "GBK", "ISO8859_1");
	}

	public static String unicodeToUTF8(String str) {
		return strEncode(str, "ISO8859_1", "UTF-8");
	}

	/**
	 * ���ܣ��滻�����ַ������滻&���ţ�����ǰ̨ʹ��js�е�toHtmlTxt()�����ڿͻ��˽����滻������������ĸ�����
	 * �����ᵼ��toHtmlTag�������ı��е�&lt;|&gt;|&quot;|&#039; �����滻�ɣ�<|>|"|'
	 * 
	 * @param str
	 * @return
	 */
	public static String toHtmlTxt(String str) {
		if (str == null) {
			return "";
		}
		int index = str.indexOf('<');
		if (index < 0) {
			index = str.indexOf('>');
			if (index < 0) {
				index = str.indexOf('\"');
				if (index < 0) {
					index = str.indexOf('\'');
				}
			}
		}
		if (index < 0) {// û���κ������ַ�
			return str;
		} else {
			StringBuffer results = null;
			char[] orig = null;
			int beg = 0, len = str.length();

			for (int i = 0; i < len; i++) {
				char c = str.charAt(i);
				// 1.default�������û�з��ϵ�case��ִ����,default�����Ǳ����.
				// 2.case��������Բ��ô�����.
				// 3.switch�����ж��������Խ���int,byte,char,short,���ܽ�����������.
				// 4.һ��caseƥ��,�ͻ�˳��ִ�к���ĳ������,�����ܺ����case�Ƿ�ƥ��,ֱ������break,������һ���Կ����úü���caseִ��ͳһ���.
				// Ҫ���ı��� ������Ļ�"&lt;" ��ת���Ļ���ת��Ϊ"<"
				switch (c) {
				case 0:
				case '<':
				case '>':
				case '\"':
				case '\'': {
					if (results == null) {
						orig = str.toCharArray();
						results = new StringBuffer(len + 10);
					}
					if (i > beg) {
						results.append(orig, beg, i - beg);
					}
					beg = i + 1;
					// System.out.println("i=" + i + " c=" + c + " beg=" +
					// beg+
					// " results=" + results.toString());
					switch (c) {
					default:
						continue;
					case '<':
						results.append("&lt;");
						break;
					case '>':
						results.append("&gt;");
						break;
					case '\"':
						results.append("&quot;");
						break;
					case '\'':
						results.append("&#039;");
						break;
					}
					break;
				}
				}
			}
			if (results == null) {
				return str;
			}
			results.append(orig, beg, len - beg);
			return results.toString();
		}
	}

	/**
	 * ���ܣ��ú�����ò�Ҫֱ��ת�� �ǹ���Ա������������ò�Ҫʹ�� ����ֱ��ת���� script�����ִ��
	 * Ҫ��һ��Ҫת���Ļ�����������scriptToHtml()������ע�͵�script���� �磺<%=scriptToHtml(htmlDecode(str))%>
	 * 
	 * @param str
	 * @return
	 */
	public static String toHtmlTag(String str) {
		if (str == null || str.equals(""))
			return "";

		int index = str.indexOf("&lt;");
		if (index > -1) {
			str = str.replaceAll("&lt;", "<");
		}
		index = str.indexOf("&gt;");
		if (index > -1) {
			str = str.replaceAll("&gt;", ">");
		}
		index = str.indexOf("&quot;");
		if (index > -1) {
			str = str.replaceAll("&quot;", "\"");
		}
		index = str.indexOf("&#039;");
		if (index > -1) {
			str = str.replaceAll("&#039;", "\'");
		}
		return str;
	}

	/**
	 * ���Դ�Сд�滻
	 * 
	 * @param source
	 * @param oldstring
	 * @param newstring
	 * @return
	 */

	public static String scriptToHtml(String str) {
		if (str == null) {
			return "";
		}
		if (str.length() < 8) {
			return str;
		}
		return ignoreCaseReplace(ignoreCaseReplace(str, "<script","&lt;script"), "</script>", "&lt;/script&gt;");
	}

	public static String ignoreCaseReplace(String source, String oldstring,
			String newstring) {
		Pattern pattern = Pattern.compile(oldstring, Pattern.CASE_INSENSITIVE);
		Matcher matcher = pattern.matcher(source);
		String result = matcher.replaceAll(newstring);
		return result;
	}

	/**
	 * ���ܣ���ȡ����ַ���
	 * 
	 * @param strRandom
	 *            ����ַ����ķ�Χ
	 * @param strLong
	 *            �����ַ��ĸ���
	 * @return String
	 */
	public static String getRandStr(String strRandom, int strLong) {
		StringBuffer stringResultSB = new StringBuffer();
		Random random = new Random();
		if (strRandom == null || strRandom.length() == 0) {
			strRandom = RANDOM_DEFAULT_STR;
		}
		char chars[] = strRandom.toCharArray();
		for (int i = 0; i < strLong; i++) {
			stringResultSB.append(chars[random.nextInt(chars.length)]);
		}
		return stringResultSB.toString();
	}

	public static String getRandStr(int stringLong) {
		return getRandStr("", stringLong);
	}

	public static boolean isCharOrNum(String s) {
		int len = s.length();
		for (int i = 0; i < len; ++i) {
			char ch = s.charAt(i);
			if (!(((ch >= 'a') && (ch <= 'z')) || ((ch >= 'A') && (ch <= 'Z')) || ((ch >= '0') && (ch <= '9')))) {
				return false;
			}
		}
		return true;
	}

	/**
	 * ���ܣ������ж� ��Pattern.compile("[0-9]*"); ����
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isInteger(String str) {
		if (str == null)
			return false;
		Pattern pattern = Pattern.compile("[0-9]+");
		return pattern.matcher(str).matches();
	}

	/**
	 * ���ܣ��������ж� ^[-+]?(\\d+(\\.\\d*)?|\\.\\d+)$
	 * ^[-+]?(\\d+(\\.\\d*)?|\\.\\d+)[fF]?$
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isDecimal(String str) {
		Pattern pattern = Pattern.compile("^[-\\+]?\\d+(\\.\\d*)?|\\.\\d+$");
		return pattern.matcher(str).matches();
	}

	/**
	 * ���ܣ����ַ�����Ϊ���� �����г��ַ�����������κ��ַ�
	 * 
	 * @param str
	 * @return
	 */
	public boolean isMemberId(String str) {
		Pattern pattern = Pattern.compile("^[a-zA-Z][a-zA-Z0-9]*$");
		Matcher isNum = pattern.matcher(str);
		if (!isNum.matches()) {
			return false;
		}
		return true;
	}

	public static boolean isSimpleCode(String s) {
		int len = s.length();
		for (int i = 0; i < len; ++i) {
			char ch = s.charAt(i);
			if (!(((ch >= 'a') && (ch <= 'z')) || ((ch >= 'A') && (ch <= 'Z'))
					|| ((ch >= '0') && (ch <= '9')) || ch == '-' || ch == '_')) {
				return false;
			}
		}
		return true;
	}

	public static boolean isChars(String s) {
		int len = s.length();
		for (int i = 0; i < len; ++i) {
			char ch = s.charAt(i);
			if (!(((ch >= 'a') && (ch <= 'z')) || ((ch >= 'A') && (ch <= 'Z')))) {
				return false;
			}
		}
		return true;
	}

	public static boolean isNotCN(String str) {
		Pattern pa = Pattern.compile("[\u4E00-\u9FA0]", Pattern.CANON_EQ);
		Matcher m = pa.matcher(str);
		if (m.find())
			return false;
		else
			return true;
	}

	public static boolean isEmail(String email) {
		String input = email;

		Pattern p = Pattern.compile("^\\.|^\\@");
		Matcher m = p.matcher(input);
		if (m.find()) {
			return false;
		}

		p = Pattern.compile("^www\\.");
		m = p.matcher(input);
		if (m.find()) {
			return false;
		}

		p = Pattern.compile("[^A-Za-z0-9\\.\\@_\\-~#]+");
		m = p.matcher(input);
		boolean result = m.find();
		if (result) {
			return false;
		}
		if (email.indexOf("@") == -1)
			return false;
		return true;
	}

	/**
	 * ���ܣ�һ�������ַ��������ַ�
	 * 
	 * @param str
	 * @return
	 */
	public static int getChineseLength(String str) {
		int k = 0;
		for (int i = 0; i < str.length(); i++) {
			if (str.charAt(i) > 255)
				k += 2;
			else
				k += 1;
		}
		return k;
	}

	/**
	 * ���ܣ�boolean ת��Ϊ�ַ���
	 * 
	 * @param booleanTemp
	 * @param type
	 *            0=���� "true" �� "false" 1=����"1" �� "0"
	 * @return "true" �� "false" �� "1" �� "0"
	 */
	public static String booleanToStr(boolean booleanTemp, int type) {
		if (booleanTemp) {
			if (type == 0) {
				return "true";
			} else {
				return "1";
			}
		} else {
			if (type == 0) {
				return "false";
			} else {
				return "0";
			}
		}
	}

	public static String booleanToStr(boolean booleanTemp) {
		return booleanToStr(booleanTemp, 0);
	}

	public static boolean nullToBoolean(int booleanInt) {
		if (booleanInt <= 0) {
			return false;
		} else {
			return true;
		}
	}

	public static String toFirstUpperCase(String str) {// ��һ���ַ���������ĸ���д
		if (str == null || "".equals(str)) {
			return str;
		}
		if (str.length() == 1) {
			return str.toUpperCase();
		}
		// A 65 a 97 Z 90 z 122
		int charInt = (int) str.charAt(0);
		if (charInt > 96 && charInt < 123) {// ��Сд��ĸ ��Сд��ĸ��ת��
			return String.valueOf(str.charAt(0)).toUpperCase()
					+ str.substring(1);
		}
		return str;
	}

	public static String toFirstLowerCase(String str) {// ��һ���ַ���������ĸ��Сд
		if (str == null || "".equals(str)) {
			return str;
		}
		if (str.length() == 1) {
			return str.toLowerCase();
		}
		// A 65 a 97 Z 90 z 122
		int charInt = (int) str.charAt(0);
		if (charInt > 64 && charInt < 91) {// �Ǵ�д��ĸ
			return String.valueOf(str.charAt(0)).toLowerCase()
					+ str.substring(1);
		}
		return str;
	}

	public static String dropHtmlTag(String str) {
		if (str == null || "".equals(str)) {
			return str;
		}
		str = str.replaceAll("</?[^>]+>", ""); // �޳���<html>�ı�ǩ
		return str;
	}

	public static String getTextAreaHtml(String str) {
		if (str == null || "".equals(str)) {
			return "";
		}
		str = str.replaceAll("\r\n", "<br/>");
		str = str.replaceAll("\r", "<br/>");
		str = str.replaceAll("\n", "<br/>");
		str = str.replaceAll(" ", "&nbsp;");
		return str;
	}

	public static String trimLineEnter(String str) {
		if (str == null || "".equals(str)) {
			return "";
		}
		while (str.startsWith("\r")) {
			str = str.substring(1);
		}
		while (str.startsWith("\n")) {
			str = str.substring(1);
		}

		while (str.endsWith("\n")) {
			str = str.substring(0, str.length() - 1);
		}
		while (str.endsWith("\r")) {
			str = str.substring(0, str.length() - 1);
		}
		return str;
	}

	/**
	 * ����:ȥ���ַ���ǰ��� ĳ�������ַ�
	 * 
	 * @param str
	 * @param charStr
	 * @return
	 */
	public static String trimBeginEndChar(String str, String charStr) {
		if (str == null || str.equalsIgnoreCase("")) {
			return "";
		}
		if (charStr == null || charStr.equals("")) {
			return str;
		}

		int charStrLength = charStr.length();
		while (str.startsWith(charStr)) {
			str = str.substring(charStrLength);
		}
		while (str.endsWith(charStr)) {
			str = str.substring(0, str.length() - charStrLength);
		}
		return str;
	}

	public static String escape(String src) {
		int i;
		char j;
		StringBuffer tmp = new StringBuffer();
		tmp.ensureCapacity(src.length() * 6);
		for (i = 0; i < src.length(); i++) {
			j = src.charAt(i);
			if (Character.isDigit(j) || Character.isLowerCase(j)
					|| Character.isUpperCase(j))
				tmp.append(j);
			else if (j < 256) {
				tmp.append("%");
				if (j < 16)
					tmp.append("0");
				tmp.append(Integer.toString(j, 16));
			} else {
				tmp.append("%u");
				tmp.append(Integer.toString(j, 16));
			}
		}
		return tmp.toString();
	}

	public static String unescape(String src) {
		StringBuffer tmp = new StringBuffer();
		tmp.ensureCapacity(src.length());
		int lastPos = 0, pos = 0;
		char ch;
		while (lastPos < src.length()) {
			pos = src.indexOf("%", lastPos);
			if (pos == lastPos) {
				if (src.charAt(pos + 1) == 'u') {
					ch = (char) Integer.parseInt(src
							.substring(pos + 2, pos + 6), 16);
					tmp.append(ch);
					lastPos = pos + 6;
				} else {
					ch = (char) Integer.parseInt(src
							.substring(pos + 1, pos + 3), 16);
					tmp.append(ch);
					lastPos = pos + 3;
				}
			} else {
				if (pos == -1) {
					tmp.append(src.substring(lastPos));
					lastPos = src.length();
				} else {
					tmp.append(src.substring(lastPos, pos));
					lastPos = pos;
				}
			}
		}
		return tmp.toString();
	}

	/**
	 * ����:�滻������ַ�,java�����replace�޷��滻һЩ������ַ�
	 * 
	 * @param str
	 * @param strOld
	 * @param strNew
	 * @param type
	 *            1=strReplaceFirst 2=strReplaceLast 3||����=strReplaceAll
	 * @return
	 */
	public static String strReplace(String str, String strOld, String strNew,
			int type) {

		if (str == null || "".equals(str)) {
			return "";
		}
		if (strOld == null || "".equals(strOld)) {
			return str;
		}
		if (strNew == null) {
			return str;
		}
		if (strOld.equals(strNew)) {
			return str;
		}

		StringBuffer resultSB = new StringBuffer();
		int strLength = str.length();
		int strOldLength = strOld.length();
		int posStart = 0;
		int pos;

		switch (type) {
		case 1:
			if ((posStart = str.indexOf(strOld)) != -1) {
				resultSB.append(str.substring(0, posStart));
				resultSB.append(strNew);
				resultSB.append(str.substring(posStart + strOldLength));
			}
			break;
		case 2:
			if ((posStart = str.lastIndexOf(strOld)) != -1) {
				resultSB.append(str.substring(0, posStart));
				resultSB.append(strNew);
				resultSB.append(str.substring(posStart + strOldLength));
			}
			break;
		default:
			try {
				while ((pos = str.indexOf(strOld, posStart)) >= 0) {
					resultSB.append(str.substring(posStart, pos));
					resultSB.append(strNew);
					posStart = pos + strOldLength;
				}
				if (posStart < strLength) {
					resultSB.append(str.substring(posStart));
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return resultSB.toString();
	}

	public static String strReplaceFirst(String str, String strOld, String strNew) {
		return strReplace(str, strOld, strNew, 1);
	}

	public static String strReplaceLast(String str, String strOld, String strNew) {
		return strReplace(str, strOld, strNew, 2);
	}

	public static String strReplaceAll(String str, String strOld, String strNew) {
		return strReplace(str, strOld, strNew, 3);
	}

	public static String toClassName(String str) {// ��һ���ַ��� ת��Ϊ�����Ĺ��� ����ĸ��д
		// "_��ĸ" ת��Ϊ"��д��ĸ"
		if (str == null || "".equals(str.trim())) {
			return str;
		}
		str = str.trim().replaceAll(" ", "").replaceAll("��", "");
		// ȥ��ǰ����� ����,��Ԫ���� �и��ַ� ��Ϊ��Щ���ǲ���׼��д��
		while (str.startsWith("_") || str.startsWith("-")
				|| str.startsWith("$")) {
			str = str.substring(1);
		}
		while (str.endsWith("_") || str.endsWith("-") || str.startsWith("$")) {
			if (str.length() > 1) {
				str = str.substring(0, str.length() - 1);
			} else {
				return "";
			}
		}
		if ("".equals(str)) {
			return "";
		}
		if (str.length() == 1) {
			return str.toUpperCase();
		}
		int index = str.indexOf('_');
		String tempStr = "";
		if (index < 1) {// û��
			return toFirstUpperCase(str);
		} else {// �������е��»��� �ѽ������������ĸת����д ����϶��������ݵ�
			tempStr = toFirstUpperCase(str.substring(0, index));
			str = tempStr
					+ toFirstUpperCase(toClassName(str.substring(index + 1)));
		}
		index = str.indexOf('-');
		if (index < 1) {// û��
			return toFirstUpperCase(str);
		} else {// �������е��»��� �ѽ������������ĸת����д ����϶��������ݵ�
			tempStr = toFirstUpperCase(str.substring(0, index));
			str = tempStr
					+ toFirstUpperCase(toClassName(str.substring(index + 1)));
		}
		index = str.indexOf('$');
		if (index < 1) {// û��
			return toFirstUpperCase(str);
		} else {// �������е��»��� �ѽ������������ĸת����д ����϶��������ݵ�
			tempStr = toFirstUpperCase(str.substring(0, index));
			return tempStr
					+ toFirstUpperCase(toClassName(str.substring(index + 1)));
		}
	}

	public static String toClassPropertyName(String str) {// ��һ���ַ��� ת��Ϊ��������Ĺ���
		return toFirstLowerCase(toClassName(str));
	}

	public static Blob toBlob(String str) {
		if (str == null || "".equals(str)) {
			return null;
		} else {
			try {
				return new SerialBlob(str.getBytes());
			} catch (Exception e) {
			}
			return null;
		}
	}

	public static Blob toClob(String str) {
		if (str == null || "".equals(str)) {
			return null;
		} else {
			try {
				return new SerialBlob(str.getBytes());
			} catch (Exception e) {
			}
			return null;
		}
	}

	public static URL toURL(String str) {
		if (str == null || "".equals(str)) {
			return null;
		} else {
			try {
				return new URL(str);
			} catch (Exception e) {
			}
			return null;
		}
	}
}
