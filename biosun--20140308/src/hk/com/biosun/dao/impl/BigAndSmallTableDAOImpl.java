package hk.com.biosun.dao.impl;

import hk.com.biosun.define.BigAndSmallTable;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.aokle.db.ICon;
import com.aokle.db.proxool.ConUtil;

public class BigAndSmallTableDAOImpl {
	private static Logger log = Logger.getLogger(BigAndSmallTableDAOImpl.class);

	private int execStatus;

	private void setFieldFromRs(BigAndSmallTable bigAndSmallTable, ResultSet rs)
			throws Exception {
		if (rs == null || rs.isAfterLast()) {
			return;
		}
		if (bigAndSmallTable == null) {
			throw new NullPointerException(
					"BigAndSmallTableImpl.java setFieldFromRs() the paramer bigAndSmallTable is NULL");
		}
		bigAndSmallTable.setBigCode(rs.getString("big_table.big_code"));
		bigAndSmallTable.setBigId(rs.getInt("big_table.big_id"));
		bigAndSmallTable.setBigName(rs.getString("big_table.big_name"));
		bigAndSmallTable.setBigOrder(rs.getString("big_table.big_order"));
		bigAndSmallTable.setBigClassShow(rs
				.getString("big_table.big_class_show"));

		bigAndSmallTable.setSmallId(rs.getInt("small_table.small_id"));
		bigAndSmallTable.setSmallName(rs.getString("small_table.small_name"));
		bigAndSmallTable.setSmallOrder(rs.getString("small_table.small_order"));
		bigAndSmallTable.setSmallCode(rs.getString("small_table.small_code"));
		bigAndSmallTable.setSmallClassShow(rs
				.getString("small_table.small_class_show"));
	}

	public List<BigAndSmallTable> getList() {
		this.execStatus = 0;
		ICon iCon = null;
		List<BigAndSmallTable> list=null;
		try {
			iCon = new ConUtil();
			if (iCon.getCon() == null) {
				this.execStatus = -3;
				return null;
			}
			String sql = "SELECT big_table.*,small_table.* FROM big_table LEFT JOIN small_table ON (big_table.big_id=small_table.big_id) ORDER BY big_order,small_order";
			PreparedStatement ps = iCon.prepareStatement(sql);
			iCon.prepareStatement(sql);
			if (ps != null) {
				ResultSet rs = iCon.executePreSelect();
				BigAndSmallTable bigAndSmallTable;
				if (rs != null && rs.next()) {
					list = new ArrayList<BigAndSmallTable>();
					do {
						bigAndSmallTable = new BigAndSmallTable();
						setFieldFromRs(bigAndSmallTable, rs);
						list.add(bigAndSmallTable);
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
