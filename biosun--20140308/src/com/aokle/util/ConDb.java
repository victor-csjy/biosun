package com.aokle.util;

import java.sql.*;

public class ConDb {
	String sDBDriver = new String("com.mysql.jdbc.Driver");
	String sConnStr = new String(
			"jdbc:mysql://localhost:3306/dbabiosuncomhk?useUnicode=true&characterEncoding=utf8");
	Statement stmt = null;
	Connection conn = null;
	ResultSet rs = null;

	public ConDb() {

		try {
			Class.forName(sDBDriver);
		} catch (java.lang.ClassNotFoundException e) {
			System.err.println("Condb(): " + e.getMessage());
		}

		try {
			conn = DriverManager.getConnection(sConnStr, "root", "");
		} catch (SQLException ex) {
			System.err.println("Condb: " + ex.getMessage());
		}
	}

	public ResultSet executeQuery(String sql) {

		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			/*
			 * ResultSet.TYPE_SCROLL_inSENSITIVE:常量允许记录指针向前或向后移动
			 * ResultSet.CONCUR-READ-ONLY:对象仅能读取
			 */
			rs = stmt.executeQuery(sql);
		} catch (SQLException ex) {
			System.err.println("Condb.executeQuery(): " + ex.getMessage());
		}
		return rs;
	}

	public int executeUpdate(String sql) {
		int row_modified = 0;
		try {
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
					ResultSet.CONCUR_UPDATABLE);
			row_modified = stmt.executeUpdate(sql);
		} catch (SQLException ex) {
			System.err.println("Condb.executeUpdate(): " + ex.getMessage());
		}
		return row_modified;
	}

	public void closedb() {
		try {
			if (stmt != null)
				stmt.close();
			stmt = null;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			conn.close();
			conn = null;
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		ConDb conDb = new ConDb();
		ResultSet rs = conDb
				.executeQuery("SELECT * FROM admin WHERE admin_name='admin' ");
		if (rs != null) {
			try {
				ResultSetMetaData rsMeta = rs.getMetaData();
				int columnCount = rsMeta.getColumnCount();
				for (int i = 1; i <= columnCount; i++) {
					System.out.println("i=" + i + " columnName="
							+ rsMeta.getColumnName(i));
					System.out.println("i=" + i + " columnLabel="
							+ rsMeta.getColumnLabel(i));
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}
