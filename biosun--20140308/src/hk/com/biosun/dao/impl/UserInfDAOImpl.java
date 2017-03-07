/*
 * 说明：对应数据库表user_inf的DAOImpl类<br>
 * 修改数据库表结构,请重新生成该类以及相应的基础类,接口类
 * 
 * 类变量dataBasePool 对应数据库连接池编码,一般使用数据库名称,只有reset()方法才重新恢复初始值,单一数据库连接池应用不需要这个变量<br>
 * 类变量execStatus 执行状态 0=初始值 1=执行成功 2=在缓存中成功获得[启用缓存的时候才起作用]<br>
 * -1=执行异常 -2=没有进行数据库操作(传入的条件不符合要求) -3=没有获取数据库连接 -4=条件参数数组中有空值null<br>
 * execStatus每个方法使用前都重新赋值<br>
 * 
 * Datetime:Sat Mar 27 19:01:46 CST 2010
 * @author 
 * 
 */
package hk.com.biosun.dao.impl;

import java.util.List;
import java.util.ArrayList;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.math.BigDecimal;
import java.net.URL;
import java.sql.Blob;
import java.sql.Clob;
import java.sql.Date;
import java.sql.Timestamp;
import java.sql.Time;
import java.sql.Types;
import hk.com.biosun.model.UserInf;
import hk.com.biosun.dao.UserInfDAO;
import com.aokle.db.ICon;
import com.aokle.db.proxool.ConUtil;
import org.apache.log4j.Logger;


public class UserInfDAOImpl implements UserInfDAO {
	private static Logger log = Logger.getLogger(UserInfDAOImpl.class);

	private int execStatus;

	/**
	 * 功能：根据ResultSet设置值
	 *
	 * @param userInf
	 *            表的基础类
	 * @param rs
	 *            数据库表user_inf全列结果集
	 * @throws Exception
	 *            抛出异常
	 */
	private void setFieldFromRs(UserInf userInf, ResultSet rs) throws Exception {
		if (rs == null || rs.isAfterLast()) {
			return;
		}
		if (userInf == null) {
			throw new NullPointerException(
					"UserInfDAOImpl.java setFieldFromRs() the paramer userInf is NULL");
		}
		userInf.setId(rs.getString("id"));
		userInf.setPassword(rs.getString("password"));
		userInf.setQuestion(rs.getString("question"));
		userInf.setAnswer(rs.getString("answer"));
		userInf.setSend(rs.getString("send"));
		userInf.setSex(rs.getString("sex"));
		userInf.setPerson(rs.getString("person"));
		userInf.setJobTitle(rs.getString("job_title"));
		userInf.setCompany(rs.getString("company"));
		userInf.setCountryCode(rs.getString("country_code"));
		userInf.setAreaCode(rs.getString("area_code"));
		userInf.setTel(rs.getString("tel"));
		userInf.setFCcode(rs.getString("f_ccode"));
		userInf.setFAcode(rs.getString("f_acode"));
		userInf.setFax(rs.getString("fax"));
		userInf.setEmail(rs.getString("email"));
		userInf.setMs(rs.getString("ms"));
		userInf.setWebsite(rs.getString("website"));
		userInf.setMailingAddress(rs.getString("mailing_address"));
		userInf.setACity(rs.getString("a_city"));
		userInf.setAState(rs.getString("a_state"));
		userInf.setAZip(rs.getString("a_zip"));
		userInf.setACountry(rs.getString("a_country"));
		userInf.setDi(rs.getString("di"));
		userInf.setMa(rs.getString("ma"));
		userInf.setEn(rs.getString("en"));
		userInf.setIm1(rs.getString("im1"));
		userInf.setIm2(rs.getString("im2"));
		userInf.setRe(rs.getString("re"));
		userInf.setBu(rs.getString("bu"));
		userInf.setBr(rs.getString("br"));
		userInf.setPr(rs.getString("pr"));
		userInf.setOt(rs.getString("ot"));
		userInf.setInvoice(rs.getString("invoice"));
		userInf.setOtherMs(rs.getString("other_ms"));
		userInf.setIdGrage(rs.getString("id_grage"));
		userInf.setEnTimes(rs.getInt("en_times"));
		userInf.setTradeTimes(rs.getInt("trade_times"));
		userInf.setLoginTimes(rs.getInt("login_times"));
		userInf.setUsercomTimes(rs.getInt("usercom_times"));
		userInf.setRegDate(rs.getString("reg_date"));
		userInf.setLoginLog(rs.getString("login_log"));
	}

	/**
	 * 功能：根据主键查询
	 *
	 * @param id
	 *
	 * @return UserInf对象,可能为null对象
	 */
	public UserInf selectByPK(String id) {
		this.execStatus = 0;
		if(id == null) {
			return null;
		}
		UserInf returnValue = null;
		ICon iCon = null;
		try {
			iCon = new ConUtil();
			if (iCon.getCon() == null) {
				this.execStatus = -3;
				return null;
			}
			String sql = "SELECT * FROM user_inf  WHERE id=?";
			PreparedStatement ps = iCon.prepareStatement(sql);
			if (ps != null) {
				ps.setString(1,id);
				ResultSet rs = iCon.executePreSelect();
				if (rs != null && rs.next()) {
					returnValue = new UserInf();
					setFieldFromRs(returnValue, rs);
					this.execStatus = 1;
				}
				if (rs != null) {
					rs.close();
					rs = null;
				}
				//ps.close();
				ps = null;
			} else {
				returnValue = null;
				this.execStatus = -1;
			}
			iCon.close();
			iCon = null;
		} catch (Exception e) {
			returnValue = null;
			this.execStatus = -1;
			e.printStackTrace();
			log.error(e);
		} finally {
			try {
				if (iCon != null) {
					iCon.close();
					iCon = null;
				}
			} catch (Exception e) {
				e.printStackTrace();
				log.error(e);
			}
		}
		return returnValue;
	}
	/**
	 * 功能：根据exeCondition条件查询,直接到数据库中获得
	 *
	 * @param  exeCondition 查询条件
	 * @param values
	 *            可以为null,但是里面的值不允许有null
	 *
	 * @return UserInf对象,可能为null对象
	 */
	public UserInf select(String exeCondition, Object[] values) {
		this.execStatus = 0;
		UserInf returnValue = null;
		ICon iCon = null;
		int valuesLength = 0;
		if (values != null) {
			valuesLength = values.length;
			for (int i = 0; i < valuesLength; i++) {
				if (values[i] == null) {
					this.execStatus = -4;
					return null;
				}
			}
		}
		try {
			iCon = new ConUtil();
			if (iCon.getCon() == null) {
				this.execStatus = -3;
				return null;
			}
			String sql = "SELECT * FROM user_inf ";
			StringBuffer sqlSB = new StringBuffer(sql);
			if (exeCondition == null || "".equals(exeCondition.trim())) {
			} else {
				sqlSB.append(' ').append(exeCondition);
				sql = sqlSB.toString();
			}
			PreparedStatement ps = iCon.prepareStatement(sql);
			if (ps != null) {
				if (values != null && valuesLength > 0) {
					for (int i = 0; i < valuesLength; i++) {
						if (values[i] instanceof BigDecimal) {
							ps.setBigDecimal(i + 1, (BigDecimal) values[i]);
						} else if ((values[i] instanceof Blob)) {
							ps.setBlob(i + 1, (Blob) values[i]);
						} else if ((values[i] instanceof Boolean)) {
							ps.setBoolean(i + 1, (Boolean) values[i]);
						} else if ((values[i] instanceof Byte)) {
							ps.setByte(i + 1, (Byte) values[i]);
						} else if ((values[i] instanceof Byte[])) {
							byte[] valuesByte = new byte[((Byte[]) values[i]).length];
							int valuesByteLength=valuesByte.length;
							for (int j = 0; j < valuesByteLength; j++) {
								valuesByte[j] = ((Byte[]) values[i])[j].byteValue();
							}
							ps.setBytes(i + 1, valuesByte);
						} else if (values[i] instanceof Clob) {
							ps.setClob(i + 1, (Clob) values[i]);
						} else if (values[i] instanceof Date) {
							ps.setDate(i + 1, (Date) values[i]);
						} else if (values[i] instanceof java.util.Date) {
							Date date = new Date(((java.util.Date) values[i]).getTime());
							ps.setDate(i + 1, date);
						} else if ((values[i] instanceof Double)) {
							ps.setDouble(i + 1, (Double) values[i]);
						} else if ((values[i] instanceof Float)) {
							ps.setFloat(i + 1, (Float) values[i]);
						} else if ((values[i] instanceof Integer)) {
							ps.setInt(i + 1, (Integer) values[i]);
						} else if ((values[i] instanceof Long)) {
							ps.setLong(i + 1, (Long) values[i]);
						} else if ((values[i] instanceof Short)) {
							ps.setShort(i + 1, (Short) values[i]);
						} else if ((values[i] instanceof String)) {
							ps.setString(i + 1, (String) values[i]);
						} else if ((values[i] instanceof Time)) {
							ps.setTime(i + 1, (Time) values[i]);
						} else if ((values[i] instanceof Timestamp)) {
							ps.setTimestamp(i + 1, (Timestamp) values[i]);
						} else if ((values[i] instanceof URL)) {
							ps.setURL(i + 1, (URL) values[i]);
						} else {
							ps.setObject(i + 1, values[i]);
						}
					}
				}
				ResultSet rs = iCon.executePreSelect();
				if (rs != null && rs.next()) {
					returnValue = new UserInf();
					setFieldFromRs(returnValue, rs);
					this.execStatus = 1;
				}
				if (rs != null) {
					rs.close();
					rs = null;
				}
				//ps.close();
				ps = null;
			} else {
				returnValue = null;
				this.execStatus = -1;
			}
			iCon.close();
			iCon = null;
		} catch (Exception e) {
			returnValue = null;
			this.execStatus = -1;
			e.printStackTrace();
			log.error(e);
		} finally {
			try {
				if (iCon != null) {
					iCon.close();
					iCon = null;
				}
			} catch (Exception e) {
				e.printStackTrace();
				log.error(e);
			}
		}
		return returnValue;
	}
	/**
	 * 功能：方法重载,根据条件查询,直接到数据库中获得
	 *
	 * @param  exeCondition 查询条件
	 * 
	 * @return UserInf对象,可能为null对象
	 */
	public UserInf select(String exeCondition) {
		return select(exeCondition, null);
	}
	/**
	 * 功能：方法重载,查询表中所有的记录,返回第一条记录,直接到数据库中获得
	 *
	 * @return UserInf对象,可能为null对象
	 */
	public UserInf select() {
		return select(null, null);
	}
	/**
	 * 功能：插入一条完整的记录
	 *
	 * @param userInf 插入的对象
	 *
	 * @return -3=无法获取数据库连接 -2=条件不符合 -1=插入异常 n>-1=成功插入的记录
	 */
	public int insert(UserInf userInf) {
		this.execStatus = 0;
		int returnValue = 0;
		ICon iCon = null;
		if (userInf == null) {
			return -2;
		}
		if (userInf.getId() == null) {
			return -2;
		}
		try {
			iCon = new ConUtil();
			if (iCon.getCon() == null) {
				this.execStatus = -3;
				return -3;
			}
			String sql = "INSERT INTO user_inf (password,question,answer,send,sex,person,job_title,company,country_code,area_code,tel,f_ccode,f_acode,fax,email,ms,website,mailing_address,a_city,a_state,a_zip,a_country,di,ma,en,im1,im2,re,bu,br,pr,ot,invoice,other_ms,id_grage,en_times,trade_times,login_times,usercom_times,reg_date,login_log) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			PreparedStatement ps = iCon.prepareStatement(sql);
			if (ps != null) {
				if (userInf.getPassword() == null) {
					ps.setNull(1, Types.VARCHAR);
				} else {
					ps.setString(1, userInf.getPassword());
				}
				if (userInf.getQuestion() == null) {
					ps.setNull(2, Types.VARCHAR);
				} else {
					ps.setString(2, userInf.getQuestion());
				}
				if (userInf.getAnswer() == null) {
					ps.setNull(3, Types.VARCHAR);
				} else {
					ps.setString(3, userInf.getAnswer());
				}
				if (userInf.getSend() == null) {
					ps.setNull(4, Types.CHAR);
				} else {
					ps.setString(4, userInf.getSend());
				}
				if (userInf.getSex() == null) {
					ps.setNull(5, Types.CHAR);
				} else {
					ps.setString(5, userInf.getSex());
				}
				if (userInf.getPerson() == null) {
					ps.setNull(6, Types.VARCHAR);
				} else {
					ps.setString(6, userInf.getPerson());
				}
				if (userInf.getJobTitle() == null) {
					ps.setNull(7, Types.VARCHAR);
				} else {
					ps.setString(7, userInf.getJobTitle());
				}
				if (userInf.getCompany() == null) {
					ps.setNull(8, Types.VARCHAR);
				} else {
					ps.setString(8, userInf.getCompany());
				}
				if (userInf.getCountryCode() == null) {
					ps.setNull(9, Types.VARCHAR);
				} else {
					ps.setString(9, userInf.getCountryCode());
				}
				if (userInf.getAreaCode() == null) {
					ps.setNull(10, Types.VARCHAR);
				} else {
					ps.setString(10, userInf.getAreaCode());
				}
				if (userInf.getTel() == null) {
					ps.setNull(11, Types.VARCHAR);
				} else {
					ps.setString(11, userInf.getTel());
				}
				if (userInf.getFCcode() == null) {
					ps.setNull(12, Types.VARCHAR);
				} else {
					ps.setString(12, userInf.getFCcode());
				}
				if (userInf.getFAcode() == null) {
					ps.setNull(13, Types.VARCHAR);
				} else {
					ps.setString(13, userInf.getFAcode());
				}
				if (userInf.getFax() == null) {
					ps.setNull(14, Types.VARCHAR);
				} else {
					ps.setString(14, userInf.getFax());
				}
				if (userInf.getEmail() == null) {
					ps.setNull(15, Types.VARCHAR);
				} else {
					ps.setString(15, userInf.getEmail());
				}
				if (userInf.getMs() == null) {
					ps.setNull(16, Types.VARCHAR);
				} else {
					ps.setString(16, userInf.getMs());
				}
				if (userInf.getWebsite() == null) {
					ps.setNull(17, Types.VARCHAR);
				} else {
					ps.setString(17, userInf.getWebsite());
				}
				if (userInf.getMailingAddress() == null) {
					ps.setNull(18, Types.VARCHAR);
				} else {
					ps.setString(18, userInf.getMailingAddress());
				}
				if (userInf.getACity() == null) {
					ps.setNull(19, Types.VARCHAR);
				} else {
					ps.setString(19, userInf.getACity());
				}
				if (userInf.getAState() == null) {
					ps.setNull(20, Types.VARCHAR);
				} else {
					ps.setString(20, userInf.getAState());
				}
				if (userInf.getAZip() == null) {
					ps.setNull(21, Types.VARCHAR);
				} else {
					ps.setString(21, userInf.getAZip());
				}
				if (userInf.getACountry() == null) {
					ps.setNull(22, Types.VARCHAR);
				} else {
					ps.setString(22, userInf.getACountry());
				}
				if (userInf.getDi() == null) {
					ps.setNull(23, Types.VARCHAR);
				} else {
					ps.setString(23, userInf.getDi());
				}
				if (userInf.getMa() == null) {
					ps.setNull(24, Types.VARCHAR);
				} else {
					ps.setString(24, userInf.getMa());
				}
				if (userInf.getEn() == null) {
					ps.setNull(25, Types.VARCHAR);
				} else {
					ps.setString(25, userInf.getEn());
				}
				if (userInf.getIm1() == null) {
					ps.setNull(26, Types.VARCHAR);
				} else {
					ps.setString(26, userInf.getIm1());
				}
				if (userInf.getIm2() == null) {
					ps.setNull(27, Types.VARCHAR);
				} else {
					ps.setString(27, userInf.getIm2());
				}
				if (userInf.getRe() == null) {
					ps.setNull(28, Types.VARCHAR);
				} else {
					ps.setString(28, userInf.getRe());
				}
				if (userInf.getBu() == null) {
					ps.setNull(29, Types.VARCHAR);
				} else {
					ps.setString(29, userInf.getBu());
				}
				if (userInf.getBr() == null) {
					ps.setNull(30, Types.VARCHAR);
				} else {
					ps.setString(30, userInf.getBr());
				}
				if (userInf.getPr() == null) {
					ps.setNull(31, Types.VARCHAR);
				} else {
					ps.setString(31, userInf.getPr());
				}
				if (userInf.getOt() == null) {
					ps.setNull(32, Types.VARCHAR);
				} else {
					ps.setString(32, userInf.getOt());
				}
				if (userInf.getInvoice() == null) {
					ps.setNull(33, Types.VARCHAR);
				} else {
					ps.setString(33, userInf.getInvoice());
				}
				if (userInf.getOtherMs() == null) {
					ps.setNull(34, Types.VARCHAR);
				} else {
					ps.setString(34, userInf.getOtherMs());
				}
				if (userInf.getIdGrage() == null) {
					ps.setNull(35, Types.VARCHAR);
				} else {
					ps.setString(35, userInf.getIdGrage());
				}
				ps.setInt(36, userInf.getEnTimes());
				ps.setInt(37, userInf.getTradeTimes());
				ps.setInt(38, userInf.getLoginTimes());
				ps.setInt(39, userInf.getUsercomTimes());
				if (userInf.getRegDate() == null) {
					ps.setNull(40, Types.VARCHAR);
				} else {
					ps.setString(40, userInf.getRegDate());
				}
				if (userInf.getLoginLog() == null) {
					ps.setNull(41, Types.LONGVARCHAR);
				} else {
					ps.setString(41, userInf.getLoginLog());
				}
				returnValue = iCon.executePreUpdate();
				if (returnValue > 0) {
					this.execStatus = 1;
				}
				//ps.close();
				ps = null;
			} else {
				returnValue = -1;
				this.execStatus = -1;
			}
			iCon.close();
			iCon = null;
		} catch (Exception e) {
			returnValue = -1;
			this.execStatus = -1;
			e.printStackTrace();
			log.error(e);
		} finally {
			try {
				if (iCon != null) {
					iCon.close();
					iCon = null;
				}
			} catch (Exception e) {
				e.printStackTrace();
				log.error(e);
			}
		}
		return returnValue;
	}
	/**
	 * 功能：根据主键修改一条完整的记录
	 *
	 * @param userInf 修改的对象
	 *
	 * @return -3=无法获取数据库连接 -2=条件不符合 -1=修改异常 n>-1=成功修改的记录
	 */
	public int update(UserInf userInf) {
		this.execStatus = 0;
		int returnValue = 0;
		ICon iCon = null;
		if (userInf == null) {
			return -2;
		}
		if (userInf.getId() == null) {
			return -2;
		}
		try {
			iCon = new ConUtil();
			if (iCon.getCon() == null) {
				this.execStatus = -3;
				return -3;
			}
			String sql = "UPDATE user_inf SET password=?,question=?,answer=?,send=?,sex=?,person=?,job_title=?,company=?,country_code=?,area_code=?,tel=?,f_ccode=?,f_acode=?,fax=?,email=?,ms=?,website=?,mailing_address=?,a_city=?,a_state=?,a_zip=?,a_country=?,di=?,ma=?,en=?,im1=?,im2=?,re=?,bu=?,br=?,pr=?,ot=?,invoice=?,other_ms=?,id_grage=?,en_times=?,trade_times=?,login_times=?,usercom_times=?,reg_date=?,login_log=?  WHERE id=?";
			PreparedStatement ps = iCon.prepareStatement(sql);
			if (ps != null) {
				if (userInf.getPassword() == null) {
					ps.setNull(1, Types.VARCHAR);
				} else {
					ps.setString(1, userInf.getPassword());
				}
				if (userInf.getQuestion() == null) {
					ps.setNull(2, Types.VARCHAR);
				} else {
					ps.setString(2, userInf.getQuestion());
				}
				if (userInf.getAnswer() == null) {
					ps.setNull(3, Types.VARCHAR);
				} else {
					ps.setString(3, userInf.getAnswer());
				}
				if (userInf.getSend() == null) {
					ps.setNull(4, Types.CHAR);
				} else {
					ps.setString(4, userInf.getSend());
				}
				if (userInf.getSex() == null) {
					ps.setNull(5, Types.CHAR);
				} else {
					ps.setString(5, userInf.getSex());
				}
				if (userInf.getPerson() == null) {
					ps.setNull(6, Types.VARCHAR);
				} else {
					ps.setString(6, userInf.getPerson());
				}
				if (userInf.getJobTitle() == null) {
					ps.setNull(7, Types.VARCHAR);
				} else {
					ps.setString(7, userInf.getJobTitle());
				}
				if (userInf.getCompany() == null) {
					ps.setNull(8, Types.VARCHAR);
				} else {
					ps.setString(8, userInf.getCompany());
				}
				if (userInf.getCountryCode() == null) {
					ps.setNull(9, Types.VARCHAR);
				} else {
					ps.setString(9, userInf.getCountryCode());
				}
				if (userInf.getAreaCode() == null) {
					ps.setNull(10, Types.VARCHAR);
				} else {
					ps.setString(10, userInf.getAreaCode());
				}
				if (userInf.getTel() == null) {
					ps.setNull(11, Types.VARCHAR);
				} else {
					ps.setString(11, userInf.getTel());
				}
				if (userInf.getFCcode() == null) {
					ps.setNull(12, Types.VARCHAR);
				} else {
					ps.setString(12, userInf.getFCcode());
				}
				if (userInf.getFAcode() == null) {
					ps.setNull(13, Types.VARCHAR);
				} else {
					ps.setString(13, userInf.getFAcode());
				}
				if (userInf.getFax() == null) {
					ps.setNull(14, Types.VARCHAR);
				} else {
					ps.setString(14, userInf.getFax());
				}
				if (userInf.getEmail() == null) {
					ps.setNull(15, Types.VARCHAR);
				} else {
					ps.setString(15, userInf.getEmail());
				}
				if (userInf.getMs() == null) {
					ps.setNull(16, Types.VARCHAR);
				} else {
					ps.setString(16, userInf.getMs());
				}
				if (userInf.getWebsite() == null) {
					ps.setNull(17, Types.VARCHAR);
				} else {
					ps.setString(17, userInf.getWebsite());
				}
				if (userInf.getMailingAddress() == null) {
					ps.setNull(18, Types.VARCHAR);
				} else {
					ps.setString(18, userInf.getMailingAddress());
				}
				if (userInf.getACity() == null) {
					ps.setNull(19, Types.VARCHAR);
				} else {
					ps.setString(19, userInf.getACity());
				}
				if (userInf.getAState() == null) {
					ps.setNull(20, Types.VARCHAR);
				} else {
					ps.setString(20, userInf.getAState());
				}
				if (userInf.getAZip() == null) {
					ps.setNull(21, Types.VARCHAR);
				} else {
					ps.setString(21, userInf.getAZip());
				}
				if (userInf.getACountry() == null) {
					ps.setNull(22, Types.VARCHAR);
				} else {
					ps.setString(22, userInf.getACountry());
				}
				if (userInf.getDi() == null) {
					ps.setNull(23, Types.VARCHAR);
				} else {
					ps.setString(23, userInf.getDi());
				}
				if (userInf.getMa() == null) {
					ps.setNull(24, Types.VARCHAR);
				} else {
					ps.setString(24, userInf.getMa());
				}
				if (userInf.getEn() == null) {
					ps.setNull(25, Types.VARCHAR);
				} else {
					ps.setString(25, userInf.getEn());
				}
				if (userInf.getIm1() == null) {
					ps.setNull(26, Types.VARCHAR);
				} else {
					ps.setString(26, userInf.getIm1());
				}
				if (userInf.getIm2() == null) {
					ps.setNull(27, Types.VARCHAR);
				} else {
					ps.setString(27, userInf.getIm2());
				}
				if (userInf.getRe() == null) {
					ps.setNull(28, Types.VARCHAR);
				} else {
					ps.setString(28, userInf.getRe());
				}
				if (userInf.getBu() == null) {
					ps.setNull(29, Types.VARCHAR);
				} else {
					ps.setString(29, userInf.getBu());
				}
				if (userInf.getBr() == null) {
					ps.setNull(30, Types.VARCHAR);
				} else {
					ps.setString(30, userInf.getBr());
				}
				if (userInf.getPr() == null) {
					ps.setNull(31, Types.VARCHAR);
				} else {
					ps.setString(31, userInf.getPr());
				}
				if (userInf.getOt() == null) {
					ps.setNull(32, Types.VARCHAR);
				} else {
					ps.setString(32, userInf.getOt());
				}
				if (userInf.getInvoice() == null) {
					ps.setNull(33, Types.VARCHAR);
				} else {
					ps.setString(33, userInf.getInvoice());
				}
				if (userInf.getOtherMs() == null) {
					ps.setNull(34, Types.VARCHAR);
				} else {
					ps.setString(34, userInf.getOtherMs());
				}
				if (userInf.getIdGrage() == null) {
					ps.setNull(35, Types.VARCHAR);
				} else {
					ps.setString(35, userInf.getIdGrage());
				}
				ps.setInt(36, userInf.getEnTimes());
				ps.setInt(37, userInf.getTradeTimes());
				ps.setInt(38, userInf.getLoginTimes());
				ps.setInt(39, userInf.getUsercomTimes());
				if (userInf.getRegDate() == null) {
					ps.setNull(40, Types.VARCHAR);
				} else {
					ps.setString(40, userInf.getRegDate());
				}
				if (userInf.getLoginLog() == null) {
					ps.setNull(41, Types.LONGVARCHAR);
				} else {
					ps.setString(41, userInf.getLoginLog());
				}
				ps.setString(42, userInf.getId());
				returnValue = iCon.executePreUpdate();
				if (returnValue > 0) {
					this.execStatus = 1;
				}
				//ps.close();
				ps = null;
			} else {
				returnValue = -1;
				this.execStatus = -1;
			}
			iCon.close();
			iCon = null;
		} catch (Exception e) {
			returnValue = -1;
			this.execStatus = -1;
			e.printStackTrace();
			log.error(e);
		} finally {
			try {
				if (iCon != null) {
					iCon.close();
					iCon = null;
				}
			} catch (Exception e) {
				e.printStackTrace();
				log.error(e);
			}
		}
		return returnValue;
	}
	/**
	 * 功能：不修改值为null对象的字段,根据提供的列与值，以及修改条件来执行批量修改
	 *
	 * @param userInf 修改的对象
	 *
	 * @return -3=无法获取数据库连接 -2=条件不符合 -1=修改异常 n>-1=成功修改的记录
	 */
	public int updateSelective(UserInf userInf) {
		this.execStatus = 0;
		int returnValue = 0;
		if (userInf == null) {
			return -2;
		}
		if (userInf.getId() == null) {
			return -2;
		}
		List<Object> valuesList = new ArrayList<Object>();
		StringBuffer sqlSB = new StringBuffer("UPDATE user_inf SET ");
		StringBuffer sqlUpdateSB = new StringBuffer();
		if (userInf.getPassword() != null) {
			sqlUpdateSB.append(",password=?");
			valuesList.add(userInf.getPassword());
		}
		if (userInf.getQuestion() != null) {
			sqlUpdateSB.append(",question=?");
			valuesList.add(userInf.getQuestion());
		}
		if (userInf.getAnswer() != null) {
			sqlUpdateSB.append(",answer=?");
			valuesList.add(userInf.getAnswer());
		}
		if (userInf.getSend() != null) {
			sqlUpdateSB.append(",send=?");
			valuesList.add(userInf.getSend());
		}
		if (userInf.getSex() != null) {
			sqlUpdateSB.append(",sex=?");
			valuesList.add(userInf.getSex());
		}
		if (userInf.getPerson() != null) {
			sqlUpdateSB.append(",person=?");
			valuesList.add(userInf.getPerson());
		}
		if (userInf.getJobTitle() != null) {
			sqlUpdateSB.append(",job_title=?");
			valuesList.add(userInf.getJobTitle());
		}
		if (userInf.getCompany() != null) {
			sqlUpdateSB.append(",company=?");
			valuesList.add(userInf.getCompany());
		}
		if (userInf.getCountryCode() != null) {
			sqlUpdateSB.append(",country_code=?");
			valuesList.add(userInf.getCountryCode());
		}
		if (userInf.getAreaCode() != null) {
			sqlUpdateSB.append(",area_code=?");
			valuesList.add(userInf.getAreaCode());
		}
		if (userInf.getTel() != null) {
			sqlUpdateSB.append(",tel=?");
			valuesList.add(userInf.getTel());
		}
		if (userInf.getFCcode() != null) {
			sqlUpdateSB.append(",f_ccode=?");
			valuesList.add(userInf.getFCcode());
		}
		if (userInf.getFAcode() != null) {
			sqlUpdateSB.append(",f_acode=?");
			valuesList.add(userInf.getFAcode());
		}
		if (userInf.getFax() != null) {
			sqlUpdateSB.append(",fax=?");
			valuesList.add(userInf.getFax());
		}
		if (userInf.getEmail() != null) {
			sqlUpdateSB.append(",email=?");
			valuesList.add(userInf.getEmail());
		}
		if (userInf.getMs() != null) {
			sqlUpdateSB.append(",ms=?");
			valuesList.add(userInf.getMs());
		}
		if (userInf.getWebsite() != null) {
			sqlUpdateSB.append(",website=?");
			valuesList.add(userInf.getWebsite());
		}
		if (userInf.getMailingAddress() != null) {
			sqlUpdateSB.append(",mailing_address=?");
			valuesList.add(userInf.getMailingAddress());
		}
		if (userInf.getACity() != null) {
			sqlUpdateSB.append(",a_city=?");
			valuesList.add(userInf.getACity());
		}
		if (userInf.getAState() != null) {
			sqlUpdateSB.append(",a_state=?");
			valuesList.add(userInf.getAState());
		}
		if (userInf.getAZip() != null) {
			sqlUpdateSB.append(",a_zip=?");
			valuesList.add(userInf.getAZip());
		}
		if (userInf.getACountry() != null) {
			sqlUpdateSB.append(",a_country=?");
			valuesList.add(userInf.getACountry());
		}
		if (userInf.getDi() != null) {
			sqlUpdateSB.append(",di=?");
			valuesList.add(userInf.getDi());
		}
		if (userInf.getMa() != null) {
			sqlUpdateSB.append(",ma=?");
			valuesList.add(userInf.getMa());
		}
		if (userInf.getEn() != null) {
			sqlUpdateSB.append(",en=?");
			valuesList.add(userInf.getEn());
		}
		if (userInf.getIm1() != null) {
			sqlUpdateSB.append(",im1=?");
			valuesList.add(userInf.getIm1());
		}
		if (userInf.getIm2() != null) {
			sqlUpdateSB.append(",im2=?");
			valuesList.add(userInf.getIm2());
		}
		if (userInf.getRe() != null) {
			sqlUpdateSB.append(",re=?");
			valuesList.add(userInf.getRe());
		}
		if (userInf.getBu() != null) {
			sqlUpdateSB.append(",bu=?");
			valuesList.add(userInf.getBu());
		}
		if (userInf.getBr() != null) {
			sqlUpdateSB.append(",br=?");
			valuesList.add(userInf.getBr());
		}
		if (userInf.getPr() != null) {
			sqlUpdateSB.append(",pr=?");
			valuesList.add(userInf.getPr());
		}
		if (userInf.getOt() != null) {
			sqlUpdateSB.append(",ot=?");
			valuesList.add(userInf.getOt());
		}
		if (userInf.getInvoice() != null) {
			sqlUpdateSB.append(",invoice=?");
			valuesList.add(userInf.getInvoice());
		}
		if (userInf.getOtherMs() != null) {
			sqlUpdateSB.append(",other_ms=?");
			valuesList.add(userInf.getOtherMs());
		}
		if (userInf.getIdGrage() != null) {
			sqlUpdateSB.append(",id_grage=?");
			valuesList.add(userInf.getIdGrage());
		}
		sqlUpdateSB.append(",en_times=?");
		valuesList.add(userInf.getEnTimes());

		sqlUpdateSB.append(",trade_times=?");
		valuesList.add(userInf.getTradeTimes());

		sqlUpdateSB.append(",login_times=?");
		valuesList.add(userInf.getLoginTimes());

		sqlUpdateSB.append(",usercom_times=?");
		valuesList.add(userInf.getUsercomTimes());

		if (userInf.getRegDate() != null) {
			sqlUpdateSB.append(",reg_date=?");
			valuesList.add(userInf.getRegDate());
		}
		if (userInf.getLoginLog() != null) {
			sqlUpdateSB.append(",login_log=?");
			valuesList.add(userInf.getLoginLog());
		}
		if (valuesList.size() < 1) {
			return -2;
		}
		sqlUpdateSB.delete(0, 1);
		sqlSB.append(sqlUpdateSB);
		sqlSB.append(" WHERE id=?");
		valuesList.add(userInf.getId());
		try {
			return update(sqlSB.toString(), valuesList.toArray(),null,false);
		} catch (Exception e) {
			returnValue = -1;
			this.execStatus = -1;
			e.printStackTrace();
			log.error(e);
		}
		return returnValue;
	}
	/**
	 * 功能：方法重载,根据SQL语句与值修改记录,
	 *
	 * @param sql  关于user_inf表的SQL语句
	 * @param values 可以为null,但是里面的值不允许有null
	 * 
	 * @return -3=无法获取数据库连接 -2=条件不符合 -1=修改异常 n>-1=成功修改的记录
	 */
	public int update(String sql, Object[] values) {
		this.execStatus = 0;
		if (sql == null || "".equals(sql)) {
			return -2;
		}
		return update(sql, values, null, false);
	}
	/**
	 * 功能：根据sql语句与对应的值,以及值的类型来修改记录
	 *
	 * @param sql
	 * @param values 要是这个为null,后面的两个参数(valuesSqlType,isContainNullValue)不做检测
	 * @param valuesSqlType  当值中没有null的时候，valuesSqlType这个参数不做检测
	 * @param isContainNullValue true=值中含有null值 false=值中没有有null值
	 *
	 * @return  -4=条件数组中的值有空(null)的 -3=无法获取数据库连接 -2=条件不符合 -1=修改异常 n>-1=成功修改的记录
	 */
	public int update(String sql, Object[] values, int[] valuesSqlType, boolean isContainNullValue) {
		this.execStatus = 0;
		int returnValue = 0;
		ICon iCon = null;
		if (sql == null || sql.equals("")) {
			return -2;
		}
		int valuesLength = 0;
		if (values == null) {
		} else {
			valuesLength = values.length;
			if (isContainNullValue) {
				if (valuesSqlType == null || valuesLength != valuesSqlType.length) {
					return -2;
				}
			} else {
				for (int i = 0; i < valuesLength; i++) {
					if (values[i] == null) {
						this.execStatus = -4;
						return -4;
					}
				}
			}
		}
		try {
			iCon = new ConUtil();
			if (iCon.getCon() == null) {
				this.execStatus = -3;
				return -3;
			}
			PreparedStatement ps = iCon.prepareStatement(sql);
			if (ps != null) {
				for (int i = 0; i < valuesLength; i++) {
					if (values[i] == null) {
						ps.setNull(i + 1, valuesSqlType[i]);
					} else {
						if (values[i] instanceof BigDecimal) {
							ps.setBigDecimal(i + 1, (BigDecimal) values[i]);
						} else if ((values[i] instanceof Blob)) {
							ps.setBlob(i + 1, (Blob) values[i]);
						} else if ((values[i] instanceof Boolean)) {
							ps.setBoolean(i + 1, (Boolean) values[i]);
						} else if ((values[i] instanceof Byte)) {
							ps.setByte(i + 1, (Byte) values[i]);
						} else if ((values[i] instanceof Byte[])) {
							byte[] valuesByte = new byte[((Byte[]) values[i]).length];
							int valuesByteLength=valuesByte.length;
							for (int j = 0; j < valuesByteLength; j++) {
								valuesByte[j] = ((Byte[]) values[i])[j].byteValue();
							}
							ps.setBytes(i + 1, valuesByte);
						} else if (values[i] instanceof Clob) {
							ps.setClob(i + 1, (Clob) values[i]);
						} else if (values[i] instanceof Date) {
							ps.setDate(i + 1, (Date) values[i]);
						} else if (values[i] instanceof java.util.Date) {
							Date date = new Date(((java.util.Date) values[i]).getTime());
							ps.setDate(i + 1, date);
						} else if ((values[i] instanceof Double)) {
							ps.setDouble(i + 1, (Double) values[i]);
						} else if ((values[i] instanceof Float)) {
							ps.setFloat(i + 1, (Float) values[i]);
						} else if ((values[i] instanceof Integer)) {
							ps.setInt(i + 1, (Integer) values[i]);
						} else if ((values[i] instanceof Long)) {
							ps.setLong(i + 1, (Long) values[i]);
						} else if ((values[i] instanceof Short)) {
							ps.setShort(i + 1, (Short) values[i]);
						} else if ((values[i] instanceof String)) {
							ps.setString(i + 1, (String) values[i]);
						} else if ((values[i] instanceof Time)) {
							ps.setTime(i + 1, (Time) values[i]);
						} else if ((values[i] instanceof Timestamp)) {
							ps.setTimestamp(i + 1, (Timestamp) values[i]);
						} else if ((values[i] instanceof URL)) {
							ps.setURL(i + 1, (URL) values[i]);
						} else {
							ps.setObject(i + 1, values[i]);
						}
					}
				}
				returnValue = iCon.executePreUpdate();
				this.execStatus = 1;
				//ps.close();
				ps = null;
			} else {
				returnValue = -1;
				this.execStatus = -1;
			}
			iCon.close();
			iCon = null;
		} catch (Exception e) {
			returnValue = -1;
			this.execStatus = -1;
			e.printStackTrace();
			log.error(e);
		} finally {
			try {
				if (iCon != null) {
					iCon.close();
					iCon = null;
				}
			} catch (Exception e) {
				e.printStackTrace();
				log.error(e);
			}
		}
		return returnValue;
	}
	/**
	 * 功能：方法重载,根据提供的列与值，以及修改条件来执行批量修改
	 *
	 * @param columns 列
	 * @param exeCondition 修改条件 不能为空 WHERE关键字会自动添加上
	 * @param values 可以为null,但是里面的值不允许有null
	 *
	 * @return -3=无法获取数据库连接 -2=条件不符合 -1=修改异常 n>-1=成功修改的记录
	 */
	public int update(String columns, String exeCondition, Object[] values) {
		return update(columns, exeCondition, values, null, false);
	}
	/**
	 * 功能：根据sql语句与对应的值,以及值的类型来修改记录
	 *
	 * @param columns 列
	 * @param exeCondition 修改条件 不能为空 WHERE关键字会自动添加上
	 * @param values 可以为null,但是里面的值不允许有null
	 * @param valuesSqlType 当值中没有null的时候，valuesSqlType这个参数不做检测
	 * @param isContainNullValue true=值中含有null值 false=值中没有有null值
	 *
	 * @return -3=无法获取数据库连接 -2=条件不符合 -1=修改异常 n>-1=成功修改的记录
	 */
	public int update(String columns, String exeCondition, Object[] values, int[] valuesSqlType, boolean isContainNullValue) {
		this.execStatus = 0;
		String sql = "UPDATE user_inf ";
		if (columns == null || "".equals(columns.trim())) {
			return -2;
		} else {
			if (exeCondition == null || exeCondition.trim().equals("")) {
				exeCondition = "";
			}
			if (!exeCondition.equals("")) {
				exeCondition = exeCondition.trim();
				String strTemp = exeCondition.toUpperCase();
				if (!strTemp.startsWith("WHERE ")) {
					StringBuffer exeConditionSB = new StringBuffer(exeCondition);
					exeConditionSB.insert(0, "WHERE ");
					exeCondition = exeConditionSB.toString();
				}
			}
			StringBuffer sqlSB = new StringBuffer(sql);
			columns = columns.trim();
			String columnsTmp = columns.toUpperCase();
			if (!columnsTmp.startsWith("SET ")) {
				sqlSB.append("SET ");
			}
			sqlSB.append(columns);
			if (!exeCondition.equals("")) {
				sqlSB.append(' ');
				sqlSB.append(exeCondition);
			}
			sql = sqlSB.toString();
		}
		return update(sql, values, valuesSqlType, isContainNullValue);
	}
	/**
	 * 功能：根据主键删除记录
	 *
	 * @param id
	 *
	 * @return -3=无法获取数据库连接 -2=条件不符合 -1=删除异常 n>-1=成功删除的记录
	 */
	public int deleteByPK(String id) {
		int returnValue = 0;
		this.execStatus = 0;
		if(id == null) {
			return -2;
		}
		ICon iCon = null;
		try {
			iCon = new ConUtil();
			if (iCon.getCon() == null) {
				this.execStatus = -3;
				return -3;
			}
			String sql = "DELETE FROM user_inf  WHERE id=?";
			PreparedStatement ps = iCon.prepareStatement(sql);
			if (ps != null) {
				ps.setString(1,id);
				returnValue = iCon.executePreDelete();
				if (returnValue > 0) {
					this.execStatus = 1;
				}
				//ps.close();
				ps = null;
			} else {
				returnValue = -1;
				this.execStatus = -1;
			}
			iCon.close();
			iCon = null;
		} catch (Exception e) {
			returnValue = -1;
			this.execStatus = -1;
			e.printStackTrace();
			log.error(e);
		} finally {
			try {
				if (iCon != null) {
					iCon.close();
					iCon = null;
				}
			} catch (Exception e) {
				e.printStackTrace();
				log.error(e);
			}
		}
		return returnValue;
	}
	/**
	 * 功能：根据对象主键删除一条记录
	 *
	 * @param userInf 删除的对象
	 *
	 * @return -3=无法获取数据库连接 -2=条件不符合 -1=删除异常 n>-1=成功删除的记录
	 */
	public int delete(UserInf userInf) {
		this.execStatus = 0;
		if (userInf == null) {
			return -2;
		}
		if (userInf.getId() == null) {
			return -2;
		}
		return deleteByPK(userInf.getId());
	}
	/**
	 * 功能：根据this.exeCondition条件删除记录,删除条件不能为空 并且必须要有 WHERE关键字,防止删除这个表全部的数据记录<br>

	 *
	 * @param exeCondition 执行条件
	 * @param values 执行条件中对应的值,可以为null,但是里面的值不允许有null
	 *
	 * @return -4=条件数组中的值有空(null)的 -3=无法获取数据库连接 -2=条件不符合 -1=删除异常 n>-1=成功删除的记录
	 */
	public int delete(String exeCondition, Object[] values) {
		this.execStatus = 0;
		int returnValue = 0;
		ICon iCon = null;
		int valuesLength = 0;
		if (exeCondition == null) {
			return -2;
		}
		if (values == null) {
		} else {
			valuesLength = values.length;
			for (int i = 0; i < valuesLength; i++) {
				if (values[i] == null) {
					this.execStatus = -4;
					return -4;
				}
			}
		}
		try {
			iCon = new ConUtil();
			if (iCon.getCon() == null) {
				this.execStatus = -3;
				return -3;
			}
			String sql = "DELETE FROM user_inf ";
			StringBuffer sqlSB = new StringBuffer(sql);
			if (exeCondition == null || "".equals(exeCondition.trim())) {
				return -2;
			} else {
				String exeConditionTmp = exeCondition.trim().toUpperCase();
				if (!exeConditionTmp.startsWith("WHERE ")) {
					StringBuffer exeConditionSB = new StringBuffer(exeCondition);
					exeConditionSB.insert(0, " WHERE ");
					exeCondition = exeConditionSB.toString();
				}
				sqlSB.append(' ').append(exeCondition);
				sql = sqlSB.toString();
			}
			PreparedStatement ps = iCon.prepareStatement(sql);
			iCon.prepareStatement(sql);
			if (ps != null) {
				for (int i = 0; i < valuesLength; i++) {
					if (values[i] instanceof BigDecimal) {
						ps.setBigDecimal(i + 1, (BigDecimal) values[i]);
					} else if ((values[i] instanceof Blob)) {
						ps.setBlob(i + 1, (Blob) values[i]);
					} else if ((values[i] instanceof Boolean)) {
						ps.setBoolean(i + 1, (Boolean) values[i]);
					} else if ((values[i] instanceof Byte)) {
						ps.setByte(i + 1, (Byte) values[i]);
					} else if ((values[i] instanceof Byte[])) {
							byte[] valuesByte = new byte[((Byte[]) values[i]).length];
							int valuesByteLength=valuesByte.length;
							for (int j = 0; j < valuesByteLength; j++) {
								valuesByte[j] = ((Byte[]) values[i])[j].byteValue();
							}
						ps.setBytes(i + 1, valuesByte);
					} else if (values[i] instanceof Clob) {
						ps.setClob(i + 1, (Clob) values[i]);
					} else if (values[i] instanceof Date) {
						ps.setDate(i + 1, (Date) values[i]);
					} else if (values[i] instanceof java.util.Date) {
							Date date = new Date(((java.util.Date) values[i]).getTime());
						ps.setDate(i + 1, date);
					} else if ((values[i] instanceof Double)) {
						ps.setDouble(i + 1, (Double) values[i]);
					} else if ((values[i] instanceof Float)) {
						ps.setFloat(i + 1, (Float) values[i]);
					} else if ((values[i] instanceof Integer)) {
						ps.setInt(i + 1, (Integer) values[i]);
					} else if ((values[i] instanceof Long)) {
						ps.setLong(i + 1, (Long) values[i]);
					} else if ((values[i] instanceof Short)) {
						ps.setShort(i + 1, (Short) values[i]);
					} else if ((values[i] instanceof String)) {
						ps.setString(i + 1, (String) values[i]);
					} else if ((values[i] instanceof Time)) {
						ps.setTime(i + 1, (Time) values[i]);
					} else if ((values[i] instanceof Timestamp)) {
						ps.setTimestamp(i + 1, (Timestamp) values[i]);
					} else if ((values[i] instanceof URL)) {
						ps.setURL(i + 1, (URL) values[i]);
					} else {
						ps.setObject(i + 1, values[i]);
					}
				}
				returnValue = iCon.executePreDelete();
				this.execStatus = 1;
				//ps.close();
				ps = null;
			} else {
				returnValue = -1;
				this.execStatus = -1;
			}
			iCon.close();
			iCon = null;
		} catch (Exception e) {
			returnValue = -1;
			this.execStatus = -1;
			e.printStackTrace();
			log.error(e);
		} finally {
			try {
				if (iCon != null) {
					iCon.close();
					iCon = null;
				}
			} catch (Exception e) {
				e.printStackTrace();
				log.error(e);
			}
		}
		return returnValue;
	}
	/**
	 * 功能：根据this.exeCondition条件删除记录,删除条件不能为空 并且必须要有 WHERE关键字,防止删除这个表全部的数据记录<br>

	 *
	 * @param exeCondition 执行条件
	 *
	 * @return -4=条件数组中的值有空(null)的 -3=无法获取数据库连接 -2=条件不符合 -1=删除异常 n>-1=成功删除的记录
	 */
	public int delete(String exeCondition) {
		this.execStatus = 0;
		if (exeCondition == null) {
			return -2;
		}
		return delete(exeCondition, null);
	}
	/**
	 * 功能：删除表中所有记录<br>

	 *
	 * @return -4=条件数组中的值有空(null)的 -3=无法获取数据库连接 -2=条件不符合 -1=删除异常 n>-1=成功删除的记录
	 */
	public int delete() {
		this.execStatus = 0;
		int returnValue = 0;
		ICon iCon = null;
		try {
			iCon = new ConUtil();
			if (iCon.getCon() == null) {
				this.execStatus = -3;
				return -3;
			}
			String sql = "DELETE FROM user_inf ";
			PreparedStatement ps = iCon.prepareStatement(sql);
			iCon.prepareStatement(sql);
			if (ps != null) {
				returnValue = iCon.executePreDelete();
				this.execStatus = 1;
				//ps.close();
				ps = null;
			} else {
				returnValue = -1;
				this.execStatus = -1;
			}
			iCon.close();
			iCon = null;
		} catch (Exception e) {
			returnValue = -1;
			this.execStatus = -1;
			e.printStackTrace();
			log.error(e);
		} finally {
			try {
				if (iCon != null) {
					iCon.close();
					iCon = null;
				}
			} catch (Exception e) {
				e.printStackTrace();
				log.error(e);
			}
		}
		return returnValue;
	}
	/**
	 * 功能：根据条件统计
	 *
	 * @param columns 统计的列,可以包含数据库的函数
	 * @param exeCondition 条件
	 * @param values 条件参数值，可以等于null,但值不能有空对象null
	 *
	 * @return -4=条件数组中的值有空(null)的 -3=无法获取数据库连接 -1=查询异常 n>-1=返回统计的记录数
	 */
	public long count(String columns, String exeCondition, Object[] values) {
		this.execStatus = 0;
		long returnValue = 0;
		ICon iCon = null;
		int valuesLength = 0;
		if (values == null) {
		} else {
			valuesLength = values.length;
			for (int i = 0; i < valuesLength; i++) {
				if (values[i] == null) {
					this.execStatus = -4;
					return -4;
				}
			}
		}
		if (columns == null || columns.trim().equals("")) {
			columns = "*";
		}
		try {
			iCon = new ConUtil();
			if (iCon.getCon() == null) {
				this.execStatus = -3;
				return -3;
			}
			String sql = "SELECT COUNT(";
			StringBuffer sqlSB = new StringBuffer(sql);
			sqlSB.append(columns);
			sqlSB.append(") AS countColumn FROM user_inf ");
			if (exeCondition == null || "".equals(exeCondition.trim())) {
				sql = sqlSB.toString();
			} else {
				sqlSB.append(exeCondition);
				sql = sqlSB.toString();
			}
			PreparedStatement ps = iCon.prepareStatement(sql);
			iCon.prepareStatement(sql);
			if (ps != null) {
				for (int i = 0; i < valuesLength; i++) {
					if (values[i] instanceof BigDecimal) {
						ps.setBigDecimal(i + 1, (BigDecimal) values[i]);
					} else if ((values[i] instanceof Blob)) {
						ps.setBlob(i + 1, (Blob) values[i]);
					} else if ((values[i] instanceof Boolean)) {
						ps.setBoolean(i + 1, (Boolean) values[i]);
					} else if ((values[i] instanceof Byte)) {
						ps.setByte(i + 1, (Byte) values[i]);
					} else if ((values[i] instanceof Byte[])) {
							byte[] valuesByte = new byte[((Byte[]) values[i]).length];
							int valuesByteLength=valuesByte.length;
							for (int j = 0; j < valuesByteLength; j++) {
								valuesByte[j] = ((Byte[]) values[i])[j].byteValue();
							}
						ps.setBytes(i + 1, valuesByte);
					} else if (values[i] instanceof Clob) {
						ps.setClob(i + 1, (Clob) values[i]);
					} else if (values[i] instanceof Date) {
						ps.setDate(i + 1, (Date) values[i]);
					} else if (values[i] instanceof java.util.Date) {
							Date date = new Date(((java.util.Date) values[i]).getTime());
						ps.setDate(i + 1, date);
					} else if ((values[i] instanceof Double)) {
						ps.setDouble(i + 1, (Double) values[i]);
					} else if ((values[i] instanceof Float)) {
						ps.setFloat(i + 1, (Float) values[i]);
					} else if ((values[i] instanceof Integer)) {
						ps.setInt(i + 1, (Integer) values[i]);
					} else if ((values[i] instanceof Long)) {
						ps.setLong(i + 1, (Long) values[i]);
					} else if ((values[i] instanceof Short)) {
						ps.setShort(i + 1, (Short) values[i]);
					} else if ((values[i] instanceof String)) {
						ps.setString(i + 1, (String) values[i]);
					} else if ((values[i] instanceof Time)) {
						ps.setTime(i + 1, (Time) values[i]);
					} else if ((values[i] instanceof Timestamp)) {
						ps.setTimestamp(i + 1, (Timestamp) values[i]);
					} else if ((values[i] instanceof URL)) {
						ps.setURL(i + 1, (URL) values[i]);
					} else {
						ps.setObject(i + 1, values[i]);
					}
				}
				returnValue = iCon.executePreCount();
				this.execStatus = 1;
				//ps.close();
				ps = null;
			} else {
				returnValue = -1;
				this.execStatus = -1;
			}
			iCon.close();
			iCon = null;
		} catch (Exception e) {
			returnValue = -1;
			this.execStatus = -1;
			e.printStackTrace();
			log.error(e);
		} finally {
			try {
				if (iCon != null) {
					iCon.close();
					iCon = null;
				}
			} catch (Exception e) {
				e.printStackTrace();
				log.error(e);
			}
		}
		return returnValue;
	}
	/**
	 * 功能：方法重载,根据条件统计
	 *
	 * @param columns 统计的列,可以包含数据库的函数
	 * @param exeCondition 条件
	 *
	 * @return -4=条件数组中的值有空(null)的 -3=无法获取数据库连接 -1=查询异常 n>-1=返回统计的记录数
	 */
	public long count(String columns, String exeCondition) {
		return count(columns, exeCondition, null);
	}
	/**
	 * 功能：方法重载,根据条件统计
	 *
	 * @param exeCondition 条件
	 * @param values 条件参数值，可以等于null,但值不能有空对象null
	 *
	 * @return -4=条件数组中的值有空(null)的 -3=无法获取数据库连接 -1=查询异常 n>-1=返回统计的记录数
	 */
	public long count(String exeCondition, Object[] values) {
		return count(null, exeCondition, values);
	}
	/**
	 * 功能：方法重载,根据条件统计
	 *
	 * @param exeCondition 条件
	 *
	 * @return -4=条件数组中的值有空(null)的 -3=无法获取数据库连接 -1=查询异常 n>-1=返回统计的记录数
	 */
	public long count(String exeCondition) {
		return count(null, exeCondition, null);
	}
	/**
	 * 功能：方法重载,根据条件统计
	 *
	 * @return -4=条件数组中的值有空(null)的 -3=无法获取数据库连接 -1=查询异常 n>-1=返回统计的记录数
	 */
	public long count() {
		return count(null, null, null);
	}
	/**
	 * 功能：根据条件查询，返回基础表的List<br>
	 *
	 * @param exeCondition 条件
	 * @param values 条件参数值，可以等于null,但值不能有空对象null
	 * @param pageSize 每页显示的记录数
	 * @param pageNo 页码
	 *
	 * @return 可能返回null的List
	 */
	public List<UserInf> getList(String exeCondition, Object[] values, int pageSize, int pageNo) {
		this.execStatus = 0;
		ICon iCon = null;
		boolean isPage = false;
		List<UserInf> list = null;
		int valuesLength = 0;
		if (values == null) {
		} else {
			valuesLength = values.length;
			for (int i = 0; i < valuesLength; i++) {
				if (values[i] == null) {
					this.execStatus = -4;
					return null;
				}
			}
		}
		if(exeCondition == null){
			exeCondition = "";
		} else {
			exeCondition = exeCondition.trim();
		}
		try {
			iCon = new ConUtil();
			if (iCon.getCon() == null) {
				this.execStatus = -3;
				return null;
			}
			String sql = "SELECT * FROM user_inf ";
			if (pageSize > 0 && pageNo > 0) {
				int indexLimit = -1;
				String exeConditionTmp = exeCondition;
				if (exeConditionTmp == null) {
					exeCondition = "";
					exeConditionTmp = "";
				} else {
					exeConditionTmp = exeConditionTmp.toUpperCase();
					indexLimit = exeConditionTmp.indexOf(" LIMIT ");
					if (indexLimit < 0) {
						if (exeConditionTmp.startsWith("LIMIT ")) {
							indexLimit = 0;
						}
					}
				}
				if (indexLimit < 0) {
					StringBuffer exeConditionSB = new StringBuffer(exeCondition);
					exeConditionSB.append(" LIMIT ?,?");
					exeCondition = exeConditionSB.toString();
					isPage = true;
				}
			}
			StringBuffer sqlSB = new StringBuffer(sql);
			if (exeCondition == null || "".equals(exeCondition.trim())) {
			} else {
				sqlSB.append(' ').append(exeCondition);
				sql = sqlSB.toString();
			}
			PreparedStatement ps = iCon.prepareStatement(sql);
			iCon.prepareStatement(sql);
			if (ps != null) {
				int i = 0;
				for (; i < valuesLength; i++) {
					if (values[i] instanceof BigDecimal) {
						ps.setBigDecimal(i + 1, (BigDecimal) values[i]);
					} else if ((values[i] instanceof Blob)) {
						ps.setBlob(i + 1, (Blob) values[i]);
					} else if ((values[i] instanceof Boolean)) {
						ps.setBoolean(i + 1, (Boolean) values[i]);
					} else if ((values[i] instanceof Byte)) {
						ps.setByte(i + 1, (Byte) values[i]);
					} else if ((values[i] instanceof Byte[])) {
							byte[] valuesByte = new byte[((Byte[]) values[i]).length];
							int valuesByteLength=valuesByte.length;
							for (int j = 0; j < valuesByteLength; j++) {
								valuesByte[j] = ((Byte[]) values[i])[j].byteValue();
							}
						ps.setBytes(i + 1, valuesByte);
					} else if (values[i] instanceof Clob) {
						ps.setClob(i + 1, (Clob) values[i]);
					} else if (values[i] instanceof Date) {
						ps.setDate(i + 1, (Date) values[i]);
					} else if (values[i] instanceof java.util.Date) {
							Date date = new Date(((java.util.Date) values[i]).getTime());
						ps.setDate(i + 1, date);
					} else if ((values[i] instanceof Double)) {
						ps.setDouble(i + 1, (Double) values[i]);
					} else if ((values[i] instanceof Float)) {
						ps.setFloat(i + 1, (Float) values[i]);
					} else if ((values[i] instanceof Integer)) {
						ps.setInt(i + 1, (Integer) values[i]);
					} else if ((values[i] instanceof Long)) {
						ps.setLong(i + 1, (Long) values[i]);
					} else if ((values[i] instanceof Short)) {
						ps.setShort(i + 1, (Short) values[i]);
					} else if ((values[i] instanceof String)) {
						ps.setString(i + 1, (String) values[i]);
					} else if ((values[i] instanceof Time)) {
						ps.setTime(i + 1, (Time) values[i]);
					} else if ((values[i] instanceof Timestamp)) {
						ps.setTimestamp(i + 1, (Timestamp) values[i]);
					} else if ((values[i] instanceof URL)) {
						ps.setURL(i + 1, (URL) values[i]);
					} else {
						ps.setObject(i + 1, values[i]);
					}
				}
				if (isPage) {
					ps.setInt(i + 1, (pageNo - 1) * pageSize);
					ps.setInt(i + 2, pageSize);
				}
				ResultSet rs = iCon.executePreSelect();
				UserInf userInf;
				if (rs != null && rs.next()) {
					list = new ArrayList<UserInf>();
					do {
						userInf = new UserInf();
						setFieldFromRs(userInf, rs);
						list.add(userInf);
					} while (rs.next());
				}
				this.execStatus = 1;
				if (rs != null) {
					rs.close();
					rs = null;
				}
				//ps.close();
				ps = null;
			} else {
				this.execStatus = -1;
			}
			iCon.close();
			iCon = null;
		} catch (Exception e) {
			this.execStatus = -1;
			e.printStackTrace();
			log.error(e);
		} finally {
			try {
				if (iCon != null) {
					iCon.close();
					iCon = null;
				}
			} catch (Exception e) {
				e.printStackTrace();
				log.error(e);
			}
		}
		return list;
	}
	/**
	 * 功能：方法重载,根据条件查询，返回基础表的List<br>
	 *
	 * @param exeCondition 条件
	 * @param values 条件参数值，可以等于null,但值不能有空对象null
	 *
	 * @return 可能返回null的List
	 */
	public List<UserInf> getList(String exeCondition, Object[] values) {
		return getList(exeCondition, values, 0, 0);
	}
	/**
	 * 功能：方法重载,根据条件查询，返回基础表的List<br>
	 *
	 * @param exeCondition 条件
	 * @param pageSize 每页显示的记录数
	 * @param pageNo 页码
	 *
	 * @return 可能返回null的List
	 */
	public List<UserInf> getList(String exeCondition, int pageSize, int pageNo) {
		return getList(exeCondition, null, pageSize, pageNo);
	}
	/**
	 * 功能：方法重载,根据条件查询，返回基础表的List<br>
	 *
	 * @param exeCondition 条件
	 *
	 * @return 可能返回null的List
	 */
	public List<UserInf> getList(String exeCondition) {
		return getList(exeCondition, null, 0, 0);
	}
	/**
	 * 功能：方法重载,根据条件查询，返回基础表的List<br>
	 *
	 * @return 可能返回null的List
	 */
	public List<UserInf> getList() {
		return getList(null, null, 0, 0);
	}
	/**
	 * 功能：重置类变量dataBasePool数据库名称以及execStatus执行状态
	 */
	public void reset() {
		setExecStatus(0);
	}
	/**
	 * 功能：获取类变量execStatus执行状态
	 */
	public int getExecStatus() {
		return execStatus;
	}
	/**
	 * 功能：设置类变量execStatus执行状态
	 */
	public void setExecStatus(int execStatus) {
		this.execStatus = execStatus;
	}
}