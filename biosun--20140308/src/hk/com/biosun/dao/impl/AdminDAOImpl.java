/*
 * ˵������Ӧ���ݿ��admin��DAOImpl��<br>
 * �޸����ݿ��ṹ,���������ɸ����Լ���Ӧ�Ļ�����,�ӿ���
 * 
 * �����dataBasePool ��Ӧ���ݿ����ӳر���,һ��ʹ�����ݿ�����,ֻ��reset()���������»ָ���ʼֵ,��һ���ݿ����ӳ�Ӧ�ò���Ҫ�������<br>
 * �����execStatus ִ��״̬ 0=��ʼֵ 1=ִ�гɹ� 2=�ڻ����гɹ����[���û����ʱ���������]<br>
 * -1=ִ���쳣 -2=û�н������ݿ����(���������������Ҫ��) -3=û�л�ȡ���ݿ����� -4=���������������п�ֵnull<br>
 * execStatusÿ������ʹ��ǰ�����¸�ֵ<br>
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
	 * ���ܣ�����ResultSet����ֵ
	 *
	 * @param admin
	 *            ��Ļ�����
	 * @param rs
	 *            ���ݿ��adminȫ�н����
	 * @throws Exception
	 *            �׳��쳣
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
	 * ���ܣ�����������ѯ
	 *
	 * @param adminName
	 *
	 * @return Admin����,����Ϊnull����
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
	 * ���ܣ�����exeCondition������ѯ,ֱ�ӵ����ݿ��л��
	 *
	 * @param  exeCondition ��ѯ����
	 * @param values
	 *            ����Ϊnull,���������ֵ��������null
	 *
	 * @return Admin����,����Ϊnull����
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
	 * ���ܣ���������,����������ѯ,ֱ�ӵ����ݿ��л��
	 *
	 * @param  exeCondition ��ѯ����
	 * 
	 * @return Admin����,����Ϊnull����
	 */
	public Admin select(String exeCondition) {
		return select(exeCondition, null);
	}
	/**
	 * ���ܣ���������,��ѯ�������еļ�¼,���ص�һ����¼,ֱ�ӵ����ݿ��л��
	 *
	 * @return Admin����,����Ϊnull����
	 */
	public Admin select() {
		return select(null, null);
	}
	/**
	 * ���ܣ�����һ�������ļ�¼
	 *
	 * @param admin ����Ķ���
	 *
	 * @return -3=�޷���ȡ���ݿ����� -2=���������� -1=�����쳣 n>-1=�ɹ�����ļ�¼
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
	 * ���ܣ����������޸�һ�������ļ�¼
	 *
	 * @param admin �޸ĵĶ���
	 *
	 * @return -3=�޷���ȡ���ݿ����� -2=���������� -1=�޸��쳣 n>-1=�ɹ��޸ĵļ�¼
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
	 * ���ܣ����޸�ֵΪnull������ֶ�,�����ṩ������ֵ���Լ��޸�������ִ�������޸�
	 *
	 * @param admin �޸ĵĶ���
	 *
	 * @return -3=�޷���ȡ���ݿ����� -2=���������� -1=�޸��쳣 n>-1=�ɹ��޸ĵļ�¼
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
	 * ���ܣ���������,����SQL�����ֵ�޸ļ�¼,
	 *
	 * @param sql  ����admin���SQL���
	 * @param values ����Ϊnull,���������ֵ��������null
	 * 
	 * @return -3=�޷���ȡ���ݿ����� -2=���������� -1=�޸��쳣 n>-1=�ɹ��޸ĵļ�¼
	 */
	public int update(String sql, Object[] values) {
		this.execStatus = 0;
		if (sql == null || "".equals(sql)) {
			return -2;
		}
		return update(sql, values, null, false);
	}
	/**
	 * ���ܣ�����sql������Ӧ��ֵ,�Լ�ֵ���������޸ļ�¼
	 *
	 * @param sql
	 * @param values Ҫ�����Ϊnull,�������������(valuesSqlType,isContainNullValue)�������
	 * @param valuesSqlType  ��ֵ��û��null��ʱ��valuesSqlType��������������
	 * @param isContainNullValue true=ֵ�к���nullֵ false=ֵ��û����nullֵ
	 *
	 * @return  -4=���������е�ֵ�п�(null)�� -3=�޷���ȡ���ݿ����� -2=���������� -1=�޸��쳣 n>-1=�ɹ��޸ĵļ�¼
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
	 * ���ܣ���������,�����ṩ������ֵ���Լ��޸�������ִ�������޸�
	 *
	 * @param columns ��
	 * @param exeCondition �޸����� ����Ϊ�� WHERE�ؼ��ֻ��Զ������
	 * @param values ����Ϊnull,���������ֵ��������null
	 *
	 * @return -3=�޷���ȡ���ݿ����� -2=���������� -1=�޸��쳣 n>-1=�ɹ��޸ĵļ�¼
	 */
	public int update(String columns, String exeCondition, Object[] values) {
		return update(columns, exeCondition, values, null, false);
	}
	/**
	 * ���ܣ�����sql������Ӧ��ֵ,�Լ�ֵ���������޸ļ�¼
	 *
	 * @param columns ��
	 * @param exeCondition �޸����� ����Ϊ�� WHERE�ؼ��ֻ��Զ������
	 * @param values ����Ϊnull,���������ֵ��������null
	 * @param valuesSqlType ��ֵ��û��null��ʱ��valuesSqlType��������������
	 * @param isContainNullValue true=ֵ�к���nullֵ false=ֵ��û����nullֵ
	 *
	 * @return -3=�޷���ȡ���ݿ����� -2=���������� -1=�޸��쳣 n>-1=�ɹ��޸ĵļ�¼
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
	 * ���ܣ���������ɾ����¼
	 *
	 * @param adminName
	 *
	 * @return -3=�޷���ȡ���ݿ����� -2=���������� -1=ɾ���쳣 n>-1=�ɹ�ɾ���ļ�¼
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
	 * ���ܣ����ݶ�������ɾ��һ����¼
	 *
	 * @param admin ɾ���Ķ���
	 *
	 * @return -3=�޷���ȡ���ݿ����� -2=���������� -1=ɾ���쳣 n>-1=�ɹ�ɾ���ļ�¼
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
	 * ���ܣ�����this.exeCondition����ɾ����¼,ɾ����������Ϊ�� ���ұ���Ҫ�� WHERE�ؼ���,��ֹɾ�������ȫ�������ݼ�¼<br>

	 *
	 * @param exeCondition ִ������
	 * @param values ִ�������ж�Ӧ��ֵ,����Ϊnull,���������ֵ��������null
	 *
	 * @return -4=���������е�ֵ�п�(null)�� -3=�޷���ȡ���ݿ����� -2=���������� -1=ɾ���쳣 n>-1=�ɹ�ɾ���ļ�¼
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
	 * ���ܣ�����this.exeCondition����ɾ����¼,ɾ����������Ϊ�� ���ұ���Ҫ�� WHERE�ؼ���,��ֹɾ�������ȫ�������ݼ�¼<br>

	 *
	 * @param exeCondition ִ������
	 *
	 * @return -4=���������е�ֵ�п�(null)�� -3=�޷���ȡ���ݿ����� -2=���������� -1=ɾ���쳣 n>-1=�ɹ�ɾ���ļ�¼
	 */
	public int delete(String exeCondition) {
		this.execStatus = 0;
		if (exeCondition == null) {
			return -2;
		}
		return delete(exeCondition, null);
	}
	/**
	 * ���ܣ�ɾ���������м�¼<br>

	 *
	 * @return -4=���������е�ֵ�п�(null)�� -3=�޷���ȡ���ݿ����� -2=���������� -1=ɾ���쳣 n>-1=�ɹ�ɾ���ļ�¼
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
	 * ���ܣ���������ͳ��
	 *
	 * @param columns ͳ�Ƶ���,���԰������ݿ�ĺ���
	 * @param exeCondition ����
	 * @param values ��������ֵ�����Ե���null,��ֵ�����пն���null
	 *
	 * @return -4=���������е�ֵ�п�(null)�� -3=�޷���ȡ���ݿ����� -1=��ѯ�쳣 n>-1=����ͳ�Ƶļ�¼��
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
	 * ���ܣ���������,��������ͳ��
	 *
	 * @param columns ͳ�Ƶ���,���԰������ݿ�ĺ���
	 * @param exeCondition ����
	 *
	 * @return -4=���������е�ֵ�п�(null)�� -3=�޷���ȡ���ݿ����� -1=��ѯ�쳣 n>-1=����ͳ�Ƶļ�¼��
	 */
	public long count(String columns, String exeCondition) {
		return count(columns, exeCondition, null);
	}
	/**
	 * ���ܣ���������,��������ͳ��
	 *
	 * @param exeCondition ����
	 * @param values ��������ֵ�����Ե���null,��ֵ�����пն���null
	 *
	 * @return -4=���������е�ֵ�п�(null)�� -3=�޷���ȡ���ݿ����� -1=��ѯ�쳣 n>-1=����ͳ�Ƶļ�¼��
	 */
	public long count(String exeCondition, Object[] values) {
		return count(null, exeCondition, values);
	}
	/**
	 * ���ܣ���������,��������ͳ��
	 *
	 * @param exeCondition ����
	 *
	 * @return -4=���������е�ֵ�п�(null)�� -3=�޷���ȡ���ݿ����� -1=��ѯ�쳣 n>-1=����ͳ�Ƶļ�¼��
	 */
	public long count(String exeCondition) {
		return count(null, exeCondition, null);
	}
	/**
	 * ���ܣ���������,��������ͳ��
	 *
	 * @return -4=���������е�ֵ�п�(null)�� -3=�޷���ȡ���ݿ����� -1=��ѯ�쳣 n>-1=����ͳ�Ƶļ�¼��
	 */
	public long count() {
		return count(null, null, null);
	}
	/**
	 * ���ܣ�����������ѯ�����ػ������List<br>
	 *
	 * @param exeCondition ����
	 * @param values ��������ֵ�����Ե���null,��ֵ�����пն���null
	 * @param pageSize ÿҳ��ʾ�ļ�¼��
	 * @param pageNo ҳ��
	 *
	 * @return ���ܷ���null��List
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
	 * ���ܣ���������,����������ѯ�����ػ������List<br>
	 *
	 * @param exeCondition ����
	 * @param values ��������ֵ�����Ե���null,��ֵ�����пն���null
	 *
	 * @return ���ܷ���null��List
	 */
	public List<Admin> getList(String exeCondition, Object[] values) {
		return getList(exeCondition, values, 0, 0);
	}
	/**
	 * ���ܣ���������,����������ѯ�����ػ������List<br>
	 *
	 * @param exeCondition ����
	 * @param pageSize ÿҳ��ʾ�ļ�¼��
	 * @param pageNo ҳ��
	 *
	 * @return ���ܷ���null��List
	 */
	public List<Admin> getList(String exeCondition, int pageSize, int pageNo) {
		return getList(exeCondition, null, pageSize, pageNo);
	}
	/**
	 * ���ܣ���������,����������ѯ�����ػ������List<br>
	 *
	 * @param exeCondition ����
	 *
	 * @return ���ܷ���null��List
	 */
	public List<Admin> getList(String exeCondition) {
		return getList(exeCondition, null, 0, 0);
	}
	/**
	 * ���ܣ���������,����������ѯ�����ػ������List<br>
	 *
	 * @return ���ܷ���null��List
	 */
	public List<Admin> getList() {
		return getList(null, null, 0, 0);
	}
	/**
	 * ���ܣ����������dataBasePool���ݿ������Լ�execStatusִ��״̬
	 */
	public void reset() {
		setExecStatus(0);
	}
	/**
	 * ���ܣ���ȡ�����execStatusִ��״̬
	 */
	public int getExecStatus() {
		return execStatus;
	}
	/**
	 * ���ܣ����������execStatusִ��״̬
	 */
	public void setExecStatus(int execStatus) {
		this.execStatus = execStatus;
	}
}