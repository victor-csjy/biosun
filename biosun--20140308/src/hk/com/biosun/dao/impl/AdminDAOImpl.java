/*
 * 说明：对应数据库表admin的DAOImpl类<br>
 * 修改数据库表结构,请重新生成该类以及相应的基础类,接口类
 * 
 * 类变量dataBasePool 对应数据库连接池编码,一般使用数据库名称,只有reset()方法才重新恢复初始值,单一数据库连接池应用不需要这个变量<br>
 * 类变量execStatus 执行状态 0=初始值 1=执行成功 2=在缓存中成功获得[启用缓存的时候才起作用]<br>
 * -1=执行异常 -2=没有进行数据库操作(传入的条件不符合要求) -3=没有获取数据库连接 -4=条件参数数组中有空值null<br>
 * execStatus每个方法使用前都重新赋值<br>
 * 
 * Datetime:Sat Mar 27 19:01:44 CST 2010
 * @author 
 * 
 */
package hk.com.biosun.dao.impl;

import hk.com.biosun.dao.AdminDAO;
import hk.com.biosun.model.Admin;

import java.math.BigDecimal;
import java.net.URL;
import java.sql.Blob;
import java.sql.Clob;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Time;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.aokle.db.ICon;
import com.aokle.db.proxool.ConUtil;


public class AdminDAOImpl implements AdminDAO {
	private static Logger log = Logger.getLogger(AdminDAOImpl.class);

	private int execStatus;

	/**
	 * 功能：根据ResultSet设置值
	 *
	 * @param admin
	 *            表的基础类
	 * @param rs
	 *            数据库表admin全列结果集
	 * @throws Exception
	 *            抛出异常
	 */
	private void setFieldFromRs(Admin admin, ResultSet rs) throws Exception {
		if (rs == null || rs.isAfterLast()) {
			return;
		}
		if (admin == null) {
			throw new NullPointerException(
					"AdminDAOImpl.java setFieldFromRs() the paramer admin is NULL");
		}
		admin.setAdminName(rs.getString("admin_name"));
		admin.setAdminPw(rs.getString("admin_pw"));
	}

	/**
	 * 功能：根据主键查询
	 *
	 * @param adminName
	 *
	 * @return Admin对象,可能为null对象
	 */
	public Admin selectByPK(String adminName) {
		this.execStatus = 0;
		if(adminName == null) {
			return null;
		}
		Admin returnValue = null;
		ICon iCon = null;
		try {
			iCon = new ConUtil();
			if (iCon.getCon() == null) {
				this.execStatus = -3;
				return null;
			}
			String sql = "SELECT * FROM admin  WHERE admin_name=?";
			PreparedStatement ps = iCon.prepareStatement(sql);
			if (ps != null) {
				ps.setString(1,adminName);
				ResultSet rs = iCon.executePreSelect();
				if (rs != null && rs.next()) {
					returnValue = new Admin();
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
	 * @return Admin对象,可能为null对象
	 */
	public Admin select(String exeCondition, Object[] values) {
		this.execStatus = 0;
		Admin returnValue = null;
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
			String sql = "SELECT * FROM admin ";
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
					returnValue = new Admin();
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
	 * @return Admin对象,可能为null对象
	 */
	public Admin select(String exeCondition) {
		return select(exeCondition, null);
	}
	/**
	 * 功能：方法重载,查询表中所有的记录,返回第一条记录,直接到数据库中获得
	 *
	 * @return Admin对象,可能为null对象
	 */
	public Admin select() {
		return select(null, null);
	}
	/**
	 * 功能：插入一条完整的记录
	 *
	 * @param admin 插入的对象
	 *
	 * @return -3=无法获取数据库连接 -2=条件不符合 -1=插入异常 n>-1=成功插入的记录
	 */
	public int insert(Admin admin) {
		this.execStatus = 0;
		int returnValue = 0;
		ICon iCon = null;
		if (admin == null) {
			return -2;
		}
		if (admin.getAdminName() == null) {
			return -2;
		}
		try {
			iCon = new ConUtil();
			if (iCon.getCon() == null) {
				this.execStatus = -3;
				return -3;
			}
			String sql = "INSERT INTO admin (admin_name,admin_pw) VALUES (?,?)";
			PreparedStatement ps = iCon.prepareStatement(sql);
			if (ps != null) {
				ps.setString(1, admin.getAdminName());
				if (admin.getAdminPw() == null) {
					ps.setNull(2, Types.VARCHAR);
				} else {
					ps.setString(2, admin.getAdminPw());
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
	 * @param admin 修改的对象
	 *
	 * @return -3=无法获取数据库连接 -2=条件不符合 -1=修改异常 n>-1=成功修改的记录
	 */
	public int update(Admin admin) {
		this.execStatus = 0;
		int returnValue = 0;
		ICon iCon = null;
		if (admin == null) {
			return -2;
		}
		if (admin.getAdminName() == null) {
			return -2;
		}
		try {
			iCon = new ConUtil();
			if (iCon.getCon() == null) {
				this.execStatus = -3;
				return -3;
			}
			String sql = "UPDATE admin SET admin_pw=?  WHERE admin_name=?";
			PreparedStatement ps = iCon.prepareStatement(sql);
			if (ps != null) {
				if (admin.getAdminPw() == null) {
					ps.setNull(1, Types.VARCHAR);
				} else {
					ps.setString(1, admin.getAdminPw());
				}
				ps.setString(2, admin.getAdminName());
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
	 * @param admin 修改的对象
	 *
	 * @return -3=无法获取数据库连接 -2=条件不符合 -1=修改异常 n>-1=成功修改的记录
	 */
	public int updateSelective(Admin admin) {
		this.execStatus = 0;
		int returnValue = 0;
		if (admin == null) {
			return -2;
		}
		if (admin.getAdminName() == null) {
			return -2;
		}
		List<Object> valuesList = new ArrayList<Object>();
		StringBuffer sqlSB = new StringBuffer("UPDATE admin SET ");
		StringBuffer sqlUpdateSB = new StringBuffer();
		if (admin.getAdminPw() != null) {
			sqlUpdateSB.append(",admin_pw=?");
			valuesList.add(admin.getAdminPw());
		}
		if (valuesList.size() < 1) {
			return -2;
		}
		sqlUpdateSB.delete(0, 1);
		sqlSB.append(sqlUpdateSB);
		sqlSB.append(" WHERE admin_name=?");
		valuesList.add(admin.getAdminName());
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
	 * @param sql  关于admin表的SQL语句
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
		String sql = "UPDATE admin ";
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
	 * @param adminName
	 *
	 * @return -3=无法获取数据库连接 -2=条件不符合 -1=删除异常 n>-1=成功删除的记录
	 */
	public int deleteByPK(String adminName) {
		int returnValue = 0;
		this.execStatus = 0;
		if(adminName == null) {
			return -2;
		}
		ICon iCon = null;
		try {
			iCon = new ConUtil();
			if (iCon.getCon() == null) {
				this.execStatus = -3;
				return -3;
			}
			String sql = "DELETE FROM admin  WHERE admin_name=?";
			PreparedStatement ps = iCon.prepareStatement(sql);
			if (ps != null) {
				ps.setString(1,adminName);
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
	 * @param admin 删除的对象
	 *
	 * @return -3=无法获取数据库连接 -2=条件不符合 -1=删除异常 n>-1=成功删除的记录
	 */
	public int delete(Admin admin) {
		this.execStatus = 0;
		if (admin == null) {
			return -2;
		}
		if (admin.getAdminName() == null) {
			return -2;
		}
		return deleteByPK(admin.getAdminName());
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
			String sql = "DELETE FROM admin ";
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
			String sql = "DELETE FROM admin ";
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
			sqlSB.append(") AS countColumn FROM admin ");
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
	public List<Admin> getList(String exeCondition, Object[] values, int pageSize, int pageNo) {
		this.execStatus = 0;
		ICon iCon = null;
		boolean isPage = false;
		List<Admin> list = null;
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
			String sql = "SELECT * FROM admin ";
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
				Admin admin;
				if (rs != null && rs.next()) {
					list = new ArrayList<Admin>();
					do {
						admin = new Admin();
						setFieldFromRs(admin, rs);
						list.add(admin);
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
	public List<Admin> getList(String exeCondition, Object[] values) {
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
	public List<Admin> getList(String exeCondition, int pageSize, int pageNo) {
		return getList(exeCondition, null, pageSize, pageNo);
	}
	/**
	 * 功能：方法重载,根据条件查询，返回基础表的List<br>
	 *
	 * @param exeCondition 条件
	 *
	 * @return 可能返回null的List
	 */
	public List<Admin> getList(String exeCondition) {
		return getList(exeCondition, null, 0, 0);
	}
	/**
	 * 功能：方法重载,根据条件查询，返回基础表的List<br>
	 *
	 * @return 可能返回null的List
	 */
	public List<Admin> getList() {
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