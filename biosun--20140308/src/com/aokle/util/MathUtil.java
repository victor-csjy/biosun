package com.aokle.util;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.Arrays;
import java.util.Random;
import java.util.regex.Pattern;
/**
 * java������������<br>
 * boolean <br>
 * int 4byte<br>
 * byte 1byte<br>
 * short 2byte<br>
 * long 8byte<br>
 * char 2byte 0-65536(û�з���)<br>
 * float 4byte<br>
 * double 8byte<br>
 * ������������ת��<br>
 * byte[1] short[2] int[4] long[8] float[4] double[8]<br>
 * <br>
 * mysql���ݿ���������,���������ݿ����趨����λ,�������tinyint(4)==tinyint(8) ��Χ���� -128��127<br>
 * tinyint(4) -128��127 java byte<br>
 * smallint(6) -32768��32767 java short 3��<br>
 * int(11) -2147483648��2147483647 java int 21��<br>
 * bigint(20) -9223372036854775808��9223372036854775807 java long 9ǧ��ǧ��<br>
 * bit(1)<br>
 * �Զ���ʹ�õĲ���:<br>
 * bit(1),tinyint(1)��ת��Ϊboolean<br>
 * tinyint(4),smallint(6)��ת��Ϊshort<br>
 * int(11)ת��Ϊint<br>
 * bigint(20)ת��Ϊlong<br>
 * 
 * @author qinyongcai ������
 * 
 */
public class MathUtil {
	private static final Random random = new Random(System.currentTimeMillis()); // ʹ����Ը���

	private static final String randomStr = "abcdefghijklmnopqrstyzABCDEFGHIJKLMNOPQRSTYZ0123456789";
	private static final char[] randomStrArr = randomStr.toCharArray();
	private static final int randomStrLength = randomStr.length();

	public static String getSimpleStr(String str) {
		if (str == null || str.trim().equalsIgnoreCase("null")) {
			return "";
		} else {
			return str.trim();
		}
	}

	public static boolean toBoolean(String str, boolean defaultValue) {
		boolean returnValue = defaultValue;
		str = getSimpleStr(str);
		if ("false".equals(str) || "".equals(str) || "0".equals(str)) {
			return false;
		} else if ("true".equals(str) || "1".equals(str)) {
			return true;
		}
		return returnValue;
	}

	public static boolean toBoolean(String str) {
		return toBoolean(str, false);
	}

	public static boolean toBoolean(int booleanInt) {
		if (booleanInt < 1) {
			return false;
		} else {
			return true;
		}
	}

	public static byte toByte(String str) {
		return toByte(str, (byte) 0);
	}

	public static byte toByte(String str, byte defaultValue) {
		byte byteTemp = defaultValue;
		str = getSimpleStr(str);
		if ("".equals(str)) {
			return defaultValue;
		}
		try {
			byteTemp = Byte.parseByte(str);
		} catch (Exception e) {
		}
		return byteTemp;
	}

	public static short toShort(String str) {
		return toShort(str, (short) 0);
	}

	public static short toShort(String str, short defaultValue) {
		short shortTemp = defaultValue;
		str = getSimpleStr(str);
		if (str.equals("")) {
			return shortTemp;
		}
		try {
			shortTemp = Short.parseShort(str);
		} catch (Exception e) {
		}
		return shortTemp;
	}

	public static char toChar(String str) {
		return toChar(str, ' ');
	}

	public static char toChar(String str, char defaultValue) {
		char charTemp = defaultValue;
		str = getSimpleStr(str);
		if (str.equals("")) {
			return charTemp;
		}
		try {
			if (str.length() > 1) {
				str = str.substring(0, 1);
			}
			if (str.length() == 1) {
				charTemp = str.charAt(0);
			}
		} catch (Exception e) {
		}
		return charTemp;
	}

	public static int toInt(String str, int defaultValue) {
		str = getSimpleStr(str);
		if (str.equals("")) {
			return defaultValue;
		}
		int d = defaultValue;
		try {
			d = Integer.parseInt(str);
		} catch (Exception e) {
		}
		return d;
	}

	public static int toInt(String str) {
		return toInt(str, 0);
	}

	public static long toLong(String str, long defaultValue) {
		str = getSimpleStr(str);
		if (str.equals("")) {
			return defaultValue;
		}
		long d = defaultValue;
		try {
			d = Long.parseLong(str);
		} catch (Exception e) {
		}
		return d;
	}

	public static long toLong(String str) {
		return toLong(str, 0);
	}

	public static float toFloat(String str, float defaultValue) {
		str = getSimpleStr(str);
		if (str.equals("")) {
			return defaultValue;
		}
		float d = defaultValue;
		try {
			d = Float.parseFloat(str);
		} catch (Exception e) {
		}
		return d;
	}

	public static float toFloat(String str) {
		return toFloat(str, 0.0f);
	}

	public static double toDouble(String str, double defaultValue) {
		str = getSimpleStr(str);
		if (str.equals("")) {
			return defaultValue;
		}
		double d = defaultValue;
		try {
			d = Double.parseDouble(str);
		} catch (Exception e) {
		}
		return d;
	}

	public static double toDouble(String str) {
		return toDouble(str, 0.0);
	}

	public static BigDecimal toBigDecimal(String str) {
		BigDecimal bigDecimal = new BigDecimal("0.0");
		str = getSimpleStr(str);

		if ("".equals(str) || !isNumber(str)) {
			return bigDecimal;
		}
		try {
			bigDecimal = new BigDecimal(str);
		} catch (Exception e) {

		}
		return bigDecimal;
	}

	public static BigDecimal nullToBigDecimal(BigDecimal bigDecimal) {
		if (bigDecimal == null) {
			return new BigDecimal("0.0");
		}
		return bigDecimal;
	}

	public static boolean isNumeric(String s) {
		if (s == null) {
			return false;
		}
		boolean flag = true;
		char[] numbers = s.toCharArray();
		if (numbers.length == 0)
			return false;
		for (int i = 0; i < numbers.length; i++) {
			if (!Character.isDigit(numbers[i])) {
				flag = false;
				break;
			}
		}
		return flag;
	}

	public static boolean isDouble(String str) {
		try {
			Double.parseDouble(str);
			return true;
		} catch (NumberFormatException nfe) {
			return false;
		}
	}

	public static boolean isNumber(String str) {
		try {
			Double.parseDouble(str);
			return true;
		} catch (NumberFormatException nfe) {
			return false;
		}
	}

	/**
	 * ���ܣ���ʽ��˫������
	 * 
	 * @param doublenumber
	 * @param rules
	 * @return
	 */
	public static String formatDouble(double doubleNumber, String rules) {
		String formatResult = "Format Error";
		if (rules == null || "".equals(rules))
			rules = "########0.00";
		try {
			DecimalFormat nFormat = new DecimalFormat(rules);
			formatResult = nFormat.format(doubleNumber);
		} catch (Exception e) {
		}
		return formatResult;
	}

	public static String formatDouble(double doubleNumber) {
		return formatDouble(doubleNumber, 2);
	}

	public static String formatDouble(double doubleNumber, int type) {
		String doubleString = "";
		switch (type) {
			case 0 :
				doubleString = formatDouble(doubleNumber, "########0");
				break;
			case 1 :
				doubleString = formatDouble(doubleNumber, "########0.0");
				break;
			case 2 :
				doubleString = formatDouble(doubleNumber, "########0.00");
				break;
			case 3 :
				doubleString = formatDouble(doubleNumber, "########0.000");
				break;
			case 4 :
				doubleString = formatDouble(doubleNumber, "########0.0000");
				break;
			case 5 :
				doubleString = formatDouble(doubleNumber, "########0.00000");
				break;
			case 6 :
				doubleString = formatDouble(doubleNumber, "########0.000000");
				break;
			case 7 :
				doubleString = formatDouble(doubleNumber, "########0.0000000");
				break;
			case 8 :
				doubleString = formatDouble(doubleNumber, "########0.00000000");
				break;
			default :
				doubleString = formatDouble(doubleNumber, "########0.00");
				break;
		}
		return doubleString;
	}

	/**
	 * ���ܣ���ʽ��������
	 * 
	 * @param floatNumber
	 * @param type
	 * @return
	 */
	public static String formatFloat(float floatNumber, int type) {
		String formatResult = "Format Error";
		double doubleTemp = 0.00d;
		try {
			doubleTemp = Double.parseDouble(Float.toString(floatNumber));
			formatResult = formatDouble(doubleTemp, type);
		} catch (Exception e) {
		}
		return formatResult;
	}

	public static String formatFloat(float floatNumber) {
		return formatFloat(floatNumber, 2);
	}

	/**
	 * ���ܣ��ж��Ƿ������ִ�
	 * 
	 * @param str
	 * @return true=�����ִ� false=�����ִ�
	 */
	public static boolean isDigitStr(String str) {
		if (str == null || "".equals(str)) {
			return false;
		} else {
			return Pattern.matches("\\d+", str);
		}
	}

	/**
	 * ���ܣ����������ַ�������,������С��,����������,��������ȡ20�ڴξͷ�������,������ǿ����ֹ
	 * 
	 * @param valueMin
	 * @param valueMax
	 *            ����ֵ�в�����
	 * @param size
	 *            �ж��ٸ����Ϸ��ض��ٸ�
	 * @return valueMin<=return<valueMax
	 */
	public static int[] getRandomIntArray(int valueMin, int valueMax, int size) {
		Integer[] reInteger = new Integer[size];
		int valueCount = valueMax - valueMin;

		if (valueCount <= size) {
			for (int i = 0; i < valueCount; i++) {
				reInteger[i] = new Integer(valueMin + i);
			}
		} else {// ���ϵ�������size
			int forCount = 0;
			for (int iPos = 0; iPos < size;) {// ��ֹ���������ѭ��
				int ranValue = getRandomInt(valueMin, valueMax);
				if (!isInArray(reInteger, ranValue)) {
					reInteger[iPos] = new Integer(ranValue);
					iPos++;
				}
				forCount++;
				if (forCount > 20000000) {// ��������ȡ2ǧ��ξͷ�������,������ǿ����ֹ
					(new Exception(
							new StringBuffer(
									"ERROR!!! over 20000000 times at  public static int[] getRandomIntArray(")
									.append(valueMin).append(",").append(
											valueMax).append(",").append(size)
									.append(")").toString())).printStackTrace();
					break;
				}
			}
		}

		int reIntLength = 0;
		for (int i = 0; i < size; i++) {
			if (reInteger[i] != null)
				reIntLength++;
		}
		if (reIntLength < 1) {
			return null;
		} else {
			int[] reInt = new int[reIntLength];
			for (int i = 0, j = 0; i < size; i++) {
				if (reInteger[i] != null) {
					reInt[j] = reInteger[i];
					j++;
				}
			}
			Arrays.sort(reInt);
			return reInt;
		}
	}

	/**
	 * ����������� ����valueMin,������valueMax
	 * 
	 * @param valueMin
	 * @param valueMax
	 * @return valueMin<=return<valueMax
	 */
	public static int getRandomInt(int valueMin, int valueMax) {
		if (valueMin >= valueMax) {// ����valueMin
			return valueMin;
		}
		int valueMinRandom = valueMin;
		int valueMaxRandom = valueMax;
		if (valueMin < 0) {// Ҫ������Ĵ���
			valueMinRandom = 0;
			valueMaxRandom = valueMax + valueMin * (-1);
		}
		int valueRandom = valueMinRandom;

		int forCount = 0;

		try {
			do {
				valueRandom = random.nextInt(valueMaxRandom);// ����һ�����ڵ���0С��n�������
				// n<1ʱ�׳��쳣
				forCount++;
				if (forCount > 20000000) {// ��������ȡ2ǧ��ξͷ�������,������ǿ����ֹ
					(new Exception(
							new StringBuffer(
									"ERROR!!! over 20000000 times at  public static int getRandomInt(")
									.append(valueMin).append(",").append(
											valueMax).append(")").toString()))
							.printStackTrace();
					return valueMin;
				}
			} while (valueRandom < valueMinRandom);
		} catch (Exception e) {
			e.printStackTrace();
		}

		if (valueMin < 0) {// Ҫ������Ĵ���
			valueRandom = valueRandom + valueMin;
		}
		return valueRandom;
	}

	public static int getNextRandomInt(int valueMax) {
		return getRandomInt(0, valueMax);
	}

	public static boolean isInArray(Integer ia[], int value) {
		int iaLength = 0;
		if (ia == null) {
			return false;
		} else {
			iaLength = ia.length;
		}
		for (int i = 0; i < iaLength; i++) {
			if (ia[i] == null) {
			} else if (ia[i].intValue() == value) {
				return true;
			}
		}
		return false;
	}
	/**
	 * 
	 * @param length
	 *            ����
	 * @param type
	 *            0=�����ַ� 1=�������� 2=�������֣������в�����0��ͷ 3=������ĸ 4=����Сд��ĸ 5=������д��ĸ
	 *            6=������Сд��ĸ 7=�������д��ĸ
	 */
	public static String getRandomStr(int length, int type) {
		// randomStr randomStrArr
		StringBuffer resultSB = new StringBuffer();
		int randomIndex;
		if (type == 1 || type == 2) {// 1=�������� 2=�������֣������в�����0��ͷ
			for (int i = 0; i < length; i++) {
				randomIndex = getRandomInt(randomStrLength - 10,
						randomStrLength);
				if (type == 2 && i == 0 && randomStrArr[randomIndex] == '0') {
					i = i - 1;
					continue;
				}
				resultSB.append(randomStrArr[randomIndex]);
			}
			return resultSB.toString();
		} else if (type > 2) {
			for (int i = 0; i < length; i++) {
				randomIndex = getRandomInt(0, randomStrLength - 10);
				resultSB.append(randomStrArr[randomIndex]);
			}
			if (type == 4) {
				return resultSB.toString().toLowerCase();
			} else if (type == 5) {
				return resultSB.toString().toUpperCase();
			} else {
				return resultSB.toString();
			}
		} else {// �����ַ�
			for (int i = 0; i < length; i++) {
				randomIndex = getRandomInt(0, randomStrLength);
				resultSB.append(randomStrArr[randomIndex]);
			}
			if (type == 6) {// 6=������Сд��ĸ
				return resultSB.toString().toLowerCase();
			} else if (type == 7) {// 7=�������д��ĸ
				return resultSB.toString().toUpperCase();
			} else {
				return resultSB.toString();
			}
		}
	}

	public static void main(String[] args) {
		/*
		 * int[] indexRandom = MathUtil.getRandomIntArray(0, 80, 100); for (int
		 * i = 0; indexRandom != null && i < indexRandom.length; i++) {
		 * System.out.println("indexRandom[" + i + "]=" + indexRandom[i]); }
		 */
		System.out.println("getRandomInt(0,100)=" + getRandomInt(0, -1));
	}

}