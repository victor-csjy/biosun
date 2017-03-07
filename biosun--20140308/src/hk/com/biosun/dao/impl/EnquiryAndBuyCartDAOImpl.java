package hk.com.biosun.dao.impl;

import hk.com.biosun.define.EnquiryAndBuyCart;
import java.math.BigDecimal;
import java.net.URL;
import java.sql.Blob;
import java.sql.Clob;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.aokle.db.ICon;
import com.aokle.db.proxool.ConUtil;

public class EnquiryAndBuyCartDAOImpl {
	private static Logger log = Logger.getLogger(EnquiryAndBuyCartDAOImpl.class);

	private int execStatus;

	private void setFieldFromRs(EnquiryAndBuyCart enquiryAndBuyCart,
			ResultSet rs) throws Exception {
		if (rs == null || rs.isAfterLast()) {
			return;
		}
		if (enquiryAndBuyCart == null) {
			throw new NullPointerException(
					"EnquiryAndBuyCartImpl.java setFieldFromRs() the paramer enquiryAndBuyCart is NULL");
		}
		enquiryAndBuyCart.setEnId(rs.getString("enquiry.en_id"));
		enquiryAndBuyCart.setUserId(rs.getString("enquiry.user_id"));
		enquiryAndBuyCart.setEnP(rs.getString("enquiry.en_p"));
		enquiryAndBuyCart.setMi(rs.getString("enquiry.mi"));
		enquiryAndBuyCart.setDe(rs.getString("enquiry.de"));
		enquiryAndBuyCart.setInOk(rs.getString("enquiry.in_ok"));
		enquiryAndBuyCart.setSa(rs.getString("enquiry.sa"));
		enquiryAndBuyCart.setOrderS(rs.getString("enquiry.order_s"));
		enquiryAndBuyCart.setPIdS(rs.getString("enquiry.p_id_s"));
		enquiryAndBuyCart.setAccountInf(rs.getString("enquiry.account_inf"));
		enquiryAndBuyCart.setAccountNum(rs.getString("enquiry.account_num"));
		enquiryAndBuyCart.setOtMs(rs.getString("enquiry.ot_ms"));
		enquiryAndBuyCart.setEnDate(rs.getString("enquiry.en_date"));
		enquiryAndBuyCart.setEnStatus(rs.getString("enquiry.en_status"));
		enquiryAndBuyCart.setPId(rs.getInt("buy_car.p_id"));
		enquiryAndBuyCart.setPCount(rs.getInt("buy_car.p_count"));
		enquiryAndBuyCart.setPModel(rs.getString("buy_car.p_model"));
		enquiryAndBuyCart.setPPic(rs.getString("buy_car.p_pic"));
		enquiryAndBuyCart.setPName(rs.getString("buy_car.p_name"));
	}

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
			sqlSB
					.append(") AS countColumn FROM enquiry,buy_car WHERE enquiry.en_id=buy_car.en_id ");
			if (exeCondition == null || "".equals(exeCondition.trim())) {
				sql = sqlSB.toString();
			} else {
				if (exeCondition.toUpperCase().trim().startsWith("WHERE")) {
					exeCondition = exeCondition.trim().substring(5);
				}
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
						int valuesByteLength = valuesByte.length;
						for (int j = 0; j < valuesByteLength; j++) {
							valuesByte[j] = ((Byte[]) values[i])[j].byteValue();
						}
						ps.setBytes(i + 1, valuesByte);
					} else if (values[i] instanceof Clob) {
						ps.setClob(i + 1, (Clob) values[i]);
					} else if (values[i] instanceof Date) {
						ps.setDate(i + 1, (Date) values[i]);
					} else if (values[i] instanceof java.util.Date) {
						Date date = new Date(((java.util.Date) values[i])
								.getTime());
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
				// ps.close();
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

	public List<EnquiryAndBuyCart> getList(String exeCondition,
			Object[] values, int pageSize, int pageNo) {
		this.execStatus = 0;
		ICon iCon = null;
		boolean isPage = false;
		List<EnquiryAndBuyCart> list = null;
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
		if (exeCondition == null) {
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
			String sql = "SELECT enquiry.*,buy_car.* FROM enquiry,buy_car WHERE enquiry.en_id=buy_car.en_id  ";
			if (pageSize > 0 && pageNo > 0) {
				int indexLimit = -1;
				String exeConditionTmp = exeCondition;
				if (exeConditionTmp == null) {
					exeCondition = "";
					exeConditionTmp = "";
				} else {
					if (exeCondition.toUpperCase().trim().startsWith("WHERE")) {
						exeCondition = exeCondition.trim().substring(5);
					}
					exeConditionTmp = exeCondition.toUpperCase();
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
						int valuesByteLength = valuesByte.length;
						for (int j = 0; j < valuesByteLength; j++) {
							valuesByte[j] = ((Byte[]) values[i])[j].byteValue();
						}
						ps.setBytes(i + 1, valuesByte);
					} else if (values[i] instanceof Clob) {
						ps.setClob(i + 1, (Clob) values[i]);
					} else if (values[i] instanceof Date) {
						ps.setDate(i + 1, (Date) values[i]);
					} else if (values[i] instanceof java.util.Date) {
						Date date = new Date(((java.util.Date) values[i])
								.getTime());
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
				EnquiryAndBuyCart enquiryAndBuyCart;
				if (rs != null && rs.next()) {
					list = new ArrayList<EnquiryAndBuyCart>();
					do {
						enquiryAndBuyCart = new EnquiryAndBuyCart();
						setFieldFromRs(enquiryAndBuyCart, rs);
						list.add(enquiryAndBuyCart);
					} while (rs.next());
				}
				this.execStatus = 1;
				if (rs != null) {
					rs.close();
					rs = null;
				}
				// ps.close();
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

	public int getExecStatus() {
		return execStatus;
	}

	public void setExecStatus(int execStatus) {
		this.execStatus = execStatus;
	}
}
