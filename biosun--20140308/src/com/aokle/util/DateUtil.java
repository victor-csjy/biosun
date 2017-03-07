package com.aokle.util;

import java.sql.Time;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

/**
 * 说明:日期处理工具,所有非法的日期都会使用默认的日期来代替 1970-01-01 00:00:00
 * 
 * @author 覃永才
 * 
 */
public class DateUtil {
	public static final java.sql.Timestamp DATETIME_DEFAULT = Timestamp
			.valueOf("1970-01-01 00:00:00.000");
	public static final java.sql.Date DATE_DEFAULT = new java.sql.Date(
			Timestamp.valueOf("1970-01-01 00:00:00.000").getTime());
	public static final Time TIME_DEFAULT = new Time(DATETIME_DEFAULT.getTime());
	public static final java.util.Date JAVA_DATE_DEFAULT = new java.util.Date(
			DATE_DEFAULT.getTime());

	public static final String DATE_DEFAULT_STR = "1970-01-01";
	public static final String DATETIME_DEFAULT_STR = "1970-01-01 00:00:00.000";
	public static final String TIME_DEFAULT_STR = "00:00:00.000";

	public static java.util.Date nullToJavaUtilDate(java.util.Date date) {
		if (date == null) {
			return new java.util.Date(JAVA_DATE_DEFAULT.getTime());
		}
		return date;
	}

	public static java.sql.Date nullToSqlDate(java.sql.Date date) {
		if (date == null) {
			return new java.sql.Date(DATE_DEFAULT.getTime());
		}
		return date;
	}

	public static Timestamp nullToTimestamp(Timestamp date) {
		if (date == null) {
			return new Timestamp(DATETIME_DEFAULT.getTime());
		}
		return date;
	}

	public static Time nullToTime(Time time) {
		if (time == null) {
			return new Time(TIME_DEFAULT.getTime());
		}
		return time;
	}

	public static java.sql.Timestamp getTimestampNow() {
		return new Timestamp(System.currentTimeMillis());
	}

	public static java.sql.Timestamp toTimestamp(String dateStr,
			java.sql.Timestamp timestampDefault) {
		Timestamp timestamp = timestampDefault;

		if (timestamp == null) {
			timestamp = DATETIME_DEFAULT;
		}
		if (dateStr == null || "".equals(dateStr.trim())) {
			return timestamp;
		}
		try {
			timestamp = Timestamp.valueOf(dateStr);
		} catch (Exception e) {

		}
		return timestamp;
	}

	public static java.sql.Timestamp toTimestamp(String dateStr) {
		return toTimestamp(dateStr, null);
	}

	public static java.sql.Timestamp toTimestamp(java.util.Date date) {
		if (date == null)
			return null;
		return (new Timestamp(date.getTime()));
	}

	public static java.sql.Timestamp toTimestamp(long time) {
		return (new Timestamp(time));
		/*
		 * if (time < DATETIME_DEFAULT.getTime()) { return (new
		 * Timestamp(System.currentTimeMillis())); } else { return (new
		 * Timestamp(time)); }
		 */
	}

	public static java.util.Date getJavaUtilDateNow() {
		return new Date();
	}

	/**
	 * 功能：字符串转换为日期 字符串转换为日期 注意：dateStr 的格式要与 format对应，否则出错
	 * 
	 * @param dateStr
	 * @param format
	 * @param dateDefault
	 * @return java.util.Date
	 */
	public static java.util.Date toDate(String dateStr, String format,
			Date dateDefault) {
		Date date = dateDefault;
		if (date == null)
			date = DATE_DEFAULT;
		if (dateStr == null || "".equals(dateStr.trim())) {
			return date;
		}
		try {
			SimpleDateFormat dateFormat = new SimpleDateFormat(format);
			date = dateFormat.parse(dateStr);
		} catch (ParseException e) {

		}
		return date;
	}

	public static java.util.Date toDate(String dateStr, Date dateDefault,
			int type) {
		Date date = dateDefault;
		if (date == null)
			date = DATE_DEFAULT;

		if (dateStr == null || "".equals(dateStr.trim())) {
			return date;
		}
		switch (type) {
		case 0:
			date = toDate(dateStr, "yyyy-MM-dd", dateDefault);
			break;
		case 1:
			date = toDate(dateStr, "HH:mm:ss", dateDefault);
			break;
		case 2:
			date = toDate(dateStr, "yyyy-MM-dd HH:mm:ss", dateDefault);
			break;
		case 3:
			date = toDate(dateStr, "MM-dd", dateDefault);
			break;
		case 4:
			date = toDate(dateStr, "HH:mm", dateDefault);
			break;
		case 5:
			date = toDate(dateStr, "MM-dd HH:mm:ss", dateDefault);
			break;
		case 6:
			date = toDate(dateStr, "yyyy-MM-dd HH:mm:ss.S", dateDefault);
			break;
		case 7:
			date = toDate(dateStr, "yyyyMMdd", dateDefault);
			break;
		case 8:
			date = toDate(dateStr, "yyyyMMddHHmmssS", dateDefault);
			break;
		case 9:
			date = toDate(dateStr, "MM-dd HH:mm", dateDefault);
			break;
		case 10:
			date = toDate(dateStr, "yyyy-MM-dd HH:mm:ss.SSS", dateDefault);
			break;
		default:
			date = toDate(dateStr, "yyyy-MM-dd HH:mm:ss", dateDefault);
			break;
		}
		return date;
	}

	public static java.util.Date toDate(String dateStr, int type) {
		return toDate(dateStr, JAVA_DATE_DEFAULT, type);
	}

	public static java.util.Date toDate(String dateStr) {
		return toDate(dateStr, 0);
	}

	public static java.sql.Date getJavaSqlDateNow() {
		return new java.sql.Date(System.currentTimeMillis());
	}

	public static java.sql.Date toSqlDate(String strDate) {
		return toSqlDate(strDate, DATE_DEFAULT);
	}

	public static java.sql.Date toSqlDate(String strDate,
			java.sql.Date defaultValue) {
		java.sql.Date date = defaultValue;
		if (strDate == null || "".equals(strDate.trim())) {
			return date;
		}
		try {
			date = java.sql.Date.valueOf(strDate);
		} catch (Exception e) {

		}
		return date;
	}

	/**
	 * 功能:返回当前format格式的日期,format错误返回 dateDefault字符串
	 * 
	 * @param format
	 * @return
	 */
	public static String getDateNowStr(String format, String dateDefault) {
		return dateToStr(new java.util.Date(), format, dateDefault);
	}

	public static String getDateNowStr(String format) {
		return getDateNowStr(format, "");
	}

	public static String timestampToStr(java.sql.Timestamp timestamp,
			String dateDefault, int type) {
		String timestampStr = dateDefault;
		if (timestampStr == null || "".equals(timestampStr.trim())) {
			timestampStr = DATETIME_DEFAULT_STR;
		}
		if (timestamp == null) {
			return timestampStr;
		} else {
			timestampStr = formatDate(timestamp.getTime(), type);
			return timestampStr;
		}
	}

	public static String timestampToStr(java.sql.Timestamp timestamp, int type) {
		return timestampToStr(timestamp, "", type);
	}

	public static String timestampToStr(java.sql.Timestamp timestamp) {
		return timestampToStr(timestamp, "", 2);
	}

	public static String dateSqlToStr(java.sql.Date date, String dateDefault,
			int type) {
		String dateStr = dateDefault;
		if (dateStr == null || "".equals(dateStr.trim())) {
			dateStr = DATE_DEFAULT_STR;
		}
		if (date == null) {
			return dateStr;
		} else {
			dateStr = formatDate(date.getTime(), type);
			return dateStr;
		}
	}

	public static String dateSqlToStr(java.sql.Date date, int type) {
		return dateSqlToStr(date, "", type);
	}

	public static String dateSqlToStr(java.sql.Date date) {
		return dateSqlToStr(date, "", 0);// type=0 yyyy-MM-dd
	}

	/**
	 * 功能：日期转换为字符串
	 * 
	 * @param date
	 * @param format
	 * @param dateDefault
	 * @return
	 */
	public static String dateToStr(Date date, String format, String dateDefault) {
		String dateStr = dateDefault;
		if (date == null)
			date = DATE_DEFAULT;
		try {
			SimpleDateFormat dateTimeFormat = new SimpleDateFormat(format);
			dateTimeFormat.format(date);
		} catch (Exception e) {

		}
		return dateStr;
	}

	public static String dateToStr(Date date, String dateDefault, int type) {
		if (dateDefault == null)
			dateDefault = DATE_DEFAULT_STR;
		if (date == null) {
			return dateDefault;
		} else {
			return formatDate(date.getTime(), type);
		}
	}

	public static String dateToStr(Date date, int type) {
		return dateToStr(date, "", type);
	}

	public static String dateToStr(Date date) {
		return dateToStr(date, "", 0);
	}

	public static String formatOtherDate(long time, long migration, int type) {
		return formatDate(time + migration, type);
	}

	/**
	 * 功能:得到另外一个日期
	 * 
	 * @param date
	 * @param amount
	 *            偏移值
	 * @param type
	 *            amount的单位 1=年 2=月 5=天 10=小时 12=分 13=秒 14=毫秒<br>
	 *            Calendar.YEAR=1 Calendar.MONTH=2 Calendar.DATE=5 <br>
	 *            Calendar.HOUR=10 Calendar.MINUTE=12 Calendar.SECOND=13
	 *            Calendar.MILLISECOND=14
	 * @return
	 */
	public static Date toOtherDate(Date date, long amount, int type) {
		if (date == null) {
			date = DATE_DEFAULT;
		}
		if (type == 14) {
			return new Date(date.getTime() + amount);
		}
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(type, (int) amount);
		return calendar.getTime();
	}

	/**
	 * 功能:得到另外一个日期
	 * 
	 * @param date
	 * @param amount
	 *            偏移值
	 * @param type
	 *            amount的单位 1=年 2=月 5=天 10=小时 12=分 13=秒 14=毫秒<br>
	 *            Calendar.YEAR=1 Calendar.MONTH=2 Calendar.DATE=5 <br>
	 *            Calendar.HOUR=10 Calendar.MINUTE=12 Calendar.SECOND=13
	 *            Calendar.MILLISECOND=14
	 * @return
	 */
	public static Date toOtherDateNow(Date date, long amount, int type) {
		if (date == null) {
			date = new Date();
		}
		return toOtherDate(date, amount, type);
	}

	public static String formatDate(long time) {
		return formatDate(time, 0);
	}

	public static String formatDate(int type) {
		return formatDate(JAVA_DATE_DEFAULT.getTime(), type);
	}

	public static String formatDate() {
		return formatDate(JAVA_DATE_DEFAULT.getTime(), 0);
	}

	public static String formatDate(Timestamp time, int type) {
		return formatDate(time.getTime(), type);
	}

	/**
	 * 返回当前日期
	 * 
	 * @param date
	 * @param type
	 * @return
	 */
	public static String formatDate(Date date, int type) {
		if (date == null) {
			date = new Date();
		}
		return formatDate(date.getTime(), type);
	}

	public static String formatDate(long time, int type) {
		SimpleDateFormat df;
		switch (type) {
		case 0:
			df = new SimpleDateFormat("yyyy-MM-dd");
			break;
		case 1:
			df = new SimpleDateFormat("HH:mm:ss");
			break;
		case 2:
			df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			break;
		case 3:
			df = new SimpleDateFormat("MM-dd");
			break;
		case 4:
			df = new SimpleDateFormat("HH:mm");
			break;
		case 5:
			df = new SimpleDateFormat("MM-dd HH:mm:ss");
			break;
		case 6:
			df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
			break;
		case 7:
			df = new SimpleDateFormat("yyyyMMdd");
			break;
		case 8:
			df = new SimpleDateFormat("yyyyMMddHHmmssS");
			break;
		case 9:
			df = new SimpleDateFormat("MM-dd HH:mm");
			break;
		case 10:
			df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
			break;
		case 11:
			df = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			break;
		case 12:
			df = new SimpleDateFormat("yyyyMMddHHmmssSSS");
			break;
		case 13:
			df = new SimpleDateFormat("HH:mm, EEE. dd/MM/yyyy", Locale.US);// 17:00,
			break;
		default:
			df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			break;
		}
		return df.format(time);
	}

	public static String getTimeNowStr() {
		return getTimeNowStr(0);
	}

	public static String getTimeNowStr(int type) {
		SimpleDateFormat df;
		switch (type) {
		case 0:
			df = new SimpleDateFormat("HH:mm:ss");
			break;
		case 1:
			df = new SimpleDateFormat("HH:mm:ss.S");
			break;
		case 2:
			df = new SimpleDateFormat("HH:mm:ss.SSS");
			break;
		default:
			df = new SimpleDateFormat("HH:mm:ss");
		}
		return df.format(getTimeNow());
	}

	public static Time getTimeNow() {
		return new Time(new Date().getTime());
	}

	public static Time toSqlTime(String strTime) {
		return toSqlTime(strTime, TIME_DEFAULT);
	}

	public static Time toSqlTime(String strTime, Time defaultValue) {
		Time time = defaultValue;
		try {
			time = Time.valueOf(strTime);
		} catch (Exception e) {

		}
		return time;
	}

	/**
	 * 功能：获取年龄
	 * 
	 * @param dateAnother
	 * @param birthDate
	 * @return
	 */
	public static int getAge(Date dateAnother, Date birthDate) {
		if (dateAnother == null)
			dateAnother = new Date();
		return getYear(dateAnother) - getYear(birthDate);
	}

	public static int getAge(Date birthDate) {
		return getAge(new Date(), birthDate);
	}

	public static int getAge(String dateAnotherStr, int type1,
			String birthDateStr, int type2) {
		return getAge(toDate(dateAnotherStr, type1),
				toDate(birthDateStr, type2));
	}

	public static int getAge(String dateAnotherStr, String birthDateStr,
			int type) {
		return getAge(toDate(dateAnotherStr, type), toDate(birthDateStr, type));
	}

	public static int getAge(String dateAnotherStr, String birthDateStr) {
		return getAge(toDate(dateAnotherStr, 0), toDate(birthDateStr, 0));
	}

	/**
	 * 功能：获取年份
	 * 
	 * @param date
	 * @return
	 */
	public static int getYear(Date date) {
		if (date == null)
			date = JAVA_DATE_DEFAULT;
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		return calendar.get(1);
	}

	public static int getYear(String dateStr, int type) {
		return getYear(toDate(dateStr, type));
	}

	public static int getYear() {
		return getYear(JAVA_DATE_DEFAULT);
	}

	/**
	 * 功能：获取一年中的第几周
	 * 
	 * @param strDate
	 * @param type
	 * @return
	 */
	public static int getWeek(String strDate, int type) {
		return getWeek(toDate(strDate, type));
	}

	public static int getWeek(String strDate) {
		return getWeek(strDate, 0);
	}

	public static int getWeek(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		return calendar.get(3);
	}

	public static int getWeek() {
		return getWeek(JAVA_DATE_DEFAULT);
	}

	public static int getWeekNow() {
		return getWeek(new Date());
	}

	public static int getYearWeek(Date dateTmp) {
		int yearInt = getYear(dateTmp);
		int weekInt = getWeek(dateTmp);
		return yearInt * 100 + weekInt;
	}

	public static int getYearWeekNow() {
		Date dateTmp = new Date();
		return getYearWeek(dateTmp);
	}

	public static int getYearWeek() {
		int yearInt = getYear(JAVA_DATE_DEFAULT);
		int weekInt = getWeek(JAVA_DATE_DEFAULT);
		return yearInt * 100 + weekInt;
	}

	public static int getMonth(Date date) {
		if (date == null)
			date = JAVA_DATE_DEFAULT;
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		return calendar.get(2);
	}

	public static int getYearMonth(Date dateTmp) {
		int yearInt = getYear(dateTmp);
		int monthInt = getMonth(dateTmp);
		return yearInt * 100 + monthInt;
	}

	public static int getYearMonthNow() {
		Date dateTmp = new Date();
		return getYearMonth(dateTmp);
	}

	public static int getDayBetween(Date startDate, Date endDate) {
		if (startDate == null)
			startDate = new Date();
		if (endDate == null)
			return 0;
		long times = endDate.getTime() - startDate.getTime();
		int day = (int) (times / (1000 * 60 * 60 * 24));
		return day;
	}

	public static int getDayBetween(String startDateStr, String endDateStr) {
		Date startDate = null;
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		if (startDateStr == null) {
			startDate = new Date();
		} else {
			try {
				startDate = dateFormat.parse(startDateStr);
			} catch (ParseException e) {
			}
		}
		Date endDate = null;
		if (endDateStr != null) {
			try {
				endDate = dateFormat.parse(endDateStr);
			} catch (ParseException e) {
			}
		}
		return getDayBetween(startDate, endDate);
	}

	public static Date getThisYearBirthday(Date birthday) {
		if (birthday == null) {
			return null;
		}
		String thisYearBirthdayStr = DateUtil.getYear(new Date()) + "-"
				+ DateUtil.formatDate(birthday.getTime(), 3);
		try {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			return dateFormat.parse(thisYearBirthdayStr);
		} catch (ParseException e) {
		}
		return null;
	}

	public static String getTimePass(long timeLong) {
		StringBuffer resultSB = new StringBuffer();
		String unit = "前";
		if (timeLong < 0L) {
			unit = "后";
			timeLong = -1 * timeLong;
		}
		if (timeLong < 0L) {
			unit = "后";
			timeLong = -1 * timeLong;
		}
		if (timeLong < 60000) {// 少于1分钟就是“刚刚”
			if (unit.equals("前")) {
				return "刚刚";
			} else {
				return "即将";
			}
		} else if (timeLong < 3600000) {// 少于1个小时“分钟”
			resultSB.append((int) (timeLong / 60000L)).append("分钟");
		} else if (timeLong < 86400000) {// 少于24个小时“小时”
			resultSB.append((int) (timeLong / 3600000L)).append("小时");
		} else {// 大于等于24个小时“天”
			resultSB.append((int) (timeLong / 86400000L)).append("天");
		}
		return resultSB.append(unit).toString();
	}

	public static String getTimePass(long timeLong, long timeLongAnother) {
		return getTimePass(timeLongAnother - timeLong);
	}

	public static String getTimePass(Timestamp timestamp, long timeAnotherLong) {
		if (timestamp == null) {
			return getTimePass(timeAnotherLong - System.currentTimeMillis());
		} else {
			return getTimePass(timeAnotherLong - timestamp.getTime());
		}
	}

	public static String getTimePass(Timestamp timestamp) {
		return getTimePass(timestamp, System.currentTimeMillis());
	}

	public static String getTimePass(Timestamp timestamp,
			Timestamp timestampAnother) {
		if (timestampAnother == null) {
			return getTimePass(timestamp, System.currentTimeMillis());
		} else {
			return getTimePass(timestamp, timestampAnother.getTime());
		}

	}

	public static String getDateStr(String datetime) {
		if (datetime == null || "".equals(datetime)) {
			return "";
		}
		if (datetime.length() < 11) {
			return datetime;
		} else {
			return datetime.substring(0, 10);
		}
	}

	public static int getDayOfWeek() {
		//System.out.println("EEEE="+new SimpleDateFormat("EEE.", Locale.US).format(System.currentTimeMillis()));
		//EEEE 或 EEE.
		Calendar calendar = Calendar.getInstance();
		calendar.setTimeInMillis(System.currentTimeMillis());
		//范围 1~7  1=星期日 7=星期六
		return calendar.get(Calendar.DAY_OF_WEEK);
	}

	public static void main(String[] args) {

		/*
		 * LogUtil.info(getTimeNow()); LogUtil.info(getTimeNowStr());
		 * LogUtil.info(getTimeNowStr(1)); LogUtil.info(getTimeNowStr(2));
		 * 
		 * LogUtil.info(nullToJavaUtilDate(null));
		 * LogUtil.info(nullToSqlDate(null));
		 * LogUtil.info(nullToTimestamp(null)); LogUtil.info(nullToTime(null));
		 */
		// Date dateNow = new Date();
		// System.out.println(getDayBetween(dateNow,Tools.stringToDate("2010-01-28")));
		// System.out.println(getYearMonthNow());
		// Date date = toOtherDateNow(dateNow, 10, 14);//amount的单位 1=年 2=月 5=天
		// 10=小时 12=分 13=秒 14=毫秒
		// LogUtil.info(formatDate(dateNow, 6));
		// LogUtil.info(formatDate(date.getTime(), 6));
		// System.out.println(getDateStr("2010-03-29 23:12:08"));
		System.out.println(formatDate(System.currentTimeMillis(), 13));
		System.out.println(getDayOfWeek());
		System.out.println(getWeek(new Date()));

	}

}