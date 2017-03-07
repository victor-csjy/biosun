package com.aokle.db.proxool;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import org.apache.log4j.Logger;

import com.aokle.db.ICon;

public class ConUtil implements ICon {
	private static final Logger LOG = Logger.getLogger(ConUtil.class);
	Connection con;
	Statement stmt;
	PreparedStatement pstmt;
	ResultSet rs;
	String connStr;// ���ݿ����Ӵ�

	// �Զ��������ӳ�
	static {
		try {
			// DOMConfigurator.configure("D:/java/eclipseworkspace/biosun/WebRoot/WEB-INF/log4j.xml");//
			// ����.xml�ļ�
			// JAXPConfigurator.configure("D:/java/eclipseworkspace/biosun/WebRoot/WEB-INF/proxool.xml",false);
		} catch (RuntimeException e) {
			LOG.error(e);
		} catch (Exception e) {
			LOG.error(e);
		}
	}

	public ConUtil(String connStr) {
		this.connStr = connStr;
		if (this.connStr == null || this.connStr.equals("")) {
			System.err.println(new StringBuffer(
					"Database Connection is failure connStr=").append(
					this.connStr).toString());
			LOG.error(new StringBuffer(
					"Database Connection is failure connStr=").append(
					this.connStr).toString());
		} else {
			init();
		}
	}

	public ConUtil() {
		this.connStr = "proxool.dafault";
		init();
	}

	public void init() {
		try {
			Class.forName("org.logicalcobwebs.proxool.ProxoolDriver");
			con = DriverManager.getConnection(connStr);
		} catch (java.lang.ClassNotFoundException e) {
			LOG
					.error(
							"Initialize database pool failure,Please confirm the config file WEB-INF/proxool.xml and ProxoolDriver exist!",
							e);

		} catch (RuntimeException e) {
			e.printStackTrace();
			LOG.error(e);
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.error(e);
		}
	}

	public String getDataBasePool() {
		return this.connStr;
	}

	public void setDataBasePool(String dataBasePool) {
		this.connStr = dataBasePool;
	}

	public Connection getCon() {
		return this.con;
	}

	public ResultSet select(String sql) throws SQLException {
		if (con == null) {
			throw new SQLException("Don't get database Connection from pool!");
		}
		try {
			if (stmt == null) {
				stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
						ResultSet.CONCUR_READ_ONLY);
			}
			rs = stmt.executeQuery(sql);
		} catch (RuntimeException e) {
			e.printStackTrace();
			LOG.error(e);
			throw e;
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.error(e);
			throw e;
		}
		return rs;
	}

	public long count(String sql) throws SQLException {
		long result = 0;
		if (con == null) {
			throw new SQLException("Don't get database Connection from pool!");
		}
		try {
			if (stmt == null) {
				stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
						ResultSet.CONCUR_READ_ONLY);
			}
			rs = stmt.executeQuery(sql);
			if (rs != null && rs.next()) {
				result = rs.getLong(1);
			}
		} catch (RuntimeException e) {
			e.printStackTrace();
			LOG.error(e);
			throw e;
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.error(e);
			throw e;
		}
		return result;
	}

	public int insert(String sql) throws SQLException {
		if (con == null) {
			throw new SQLException("Don't get database Connection from pool!");
		}
		int result = 0;
		try {
			if (stmt == null) {
				stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
						ResultSet.CONCUR_READ_ONLY);
			}
			result = stmt.executeUpdate(sql);
		} catch (RuntimeException e) {
			e.printStackTrace();
			LOG.error(e);
			throw e;
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.error(e);
			throw e;
		}
		return result;
	}

	public int update(String sql) throws SQLException {
		int result = 0;
		if (con == null) {
			throw new SQLException("Don't get database Connection from pool!");
		}
		try {
			if (stmt == null) {
				stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
						ResultSet.CONCUR_READ_ONLY);
			}
			result = stmt.executeUpdate(sql);
		} catch (RuntimeException e) {
			e.printStackTrace();
			LOG.error(e);
			throw e;
		} catch (SQLException e) {
			LOG.error(e);
			throw e;
		}
		return result;
	}

	public int delete(String sql) throws SQLException {
		int result = 0;
		if (con == null) {
			throw new SQLException("Don't get database Connection from pool!");
		}
		try {
			if (stmt == null) {
				stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
						ResultSet.CONCUR_READ_ONLY);
			}
			result = stmt.executeUpdate(sql);
		} catch (RuntimeException e) {
			e.printStackTrace();
			LOG.error(e);
			throw e;
		} catch (SQLException e) {
			LOG.error(e);
			throw e;
		}
		return result;
	}

	public void beginTrans() throws SQLException {
		if (con == null) {
			throw new SQLException("Don't get database Connection from pool!");
		}
		try {
			con.setAutoCommit(false);
		} catch (RuntimeException e) {
			e.printStackTrace();
			LOG.error(e);
			throw e;
		} catch (SQLException e) {
			LOG.error(e);
			throw e;
		}
	}

	public void commit() throws SQLException {
		if (con == null) {
			throw new SQLException("Don't get database Connection from pool!");
		}
		try {
			con.commit();
		} catch (RuntimeException e) {
			e.printStackTrace();
			LOG.error(e);
			throw e;
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.error(e);
			throw e;
		} finally {
			try {
				con.setAutoCommit(true);
			} catch (RuntimeException e) {
				e.printStackTrace();
				LOG.error(e);
				throw e;
			} catch (SQLException e) {
				e.printStackTrace();
				LOG.error(e);
				throw e;
			}
		}
	}

	public void rollback() throws SQLException {// Ϊʲô���׳��쳣
		if (con == null) {
			throw new SQLException("Don't get database Connection from pool!");
		}
		try {
			con.rollback();
			con.setAutoCommit(true);
		} catch (RuntimeException e) {
			e.printStackTrace();
			LOG.error(e);
			throw e;
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.error(e);
			throw e;
		}
	}

	public boolean getAutoCommit() throws SQLException {
		boolean result = false;
		if (con == null) {
			throw new SQLException("Don't get database Connection from pool!");
		}
		try {
			result = con.getAutoCommit();
		} catch (RuntimeException e) {
			e.printStackTrace();
			LOG.error(e);
			throw e;
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.error(e);
			throw e;
		}
		return result;
	}

	public int getTransactionIsolation() throws SQLException {
		int result = 0;
		if (con == null) {
			throw new SQLException("Don't get database Connection from pool!");
		}
		try {
			result = con.getTransactionIsolation();
		} catch (RuntimeException e) {
			e.printStackTrace();
			LOG.error(e);
			throw e;
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.error(e);
			throw e;
		}
		return result;
	}

	/**
	 * void setFetchSize(int rows) ���÷��ص����ݿ��������� ���û�ȡ��С void setMaxFieldSize(int
	 * max)��������ֶ��� void setMaxRows(int max) �����������
	 * 
	 * @param size
	 */
	public void setFetchSize(int size) throws SQLException {
		if (con == null) {
			throw new SQLException("Don't get database Connection from pool!");
		}
		try {
			if (pstmt != null) {
				pstmt.setFetchSize(size);
				return;
			}
			if (stmt == null) {
				stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
						ResultSet.CONCUR_READ_ONLY);
			}
			stmt.setFetchSize(size);// ���÷��ص����ݿ���������
		} catch (RuntimeException e) {
			e.printStackTrace();
			LOG.error(e);
			throw e;
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.error(e);
			throw e;
		}
	}

	public void setMaxRows(int maxRows) throws SQLException {
		if (con == null) {
			throw new SQLException("Don't get database Connection from pool!");
		}
		try {
			if (pstmt != null) {
				pstmt.setMaxRows(maxRows);// �����������
				return;
			}
			if (stmt == null) {
				stmt = con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,
						ResultSet.CONCUR_READ_ONLY);
			}
			stmt.setMaxRows(maxRows);
		} catch (RuntimeException e) {
			e.printStackTrace();
			LOG.error(e);
			throw e;
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.error(e);
			throw e;
		}
	}

	public PreparedStatement prepareStatement(String sql) throws SQLException {
		if (con == null) {
			throw new SQLException("Don't get database Connection from pool!");
		}
		if (pstmt == null) {
			try {
				pstmt = con.prepareStatement(sql,
						ResultSet.TYPE_SCROLL_INSENSITIVE,
						ResultSet.CONCUR_READ_ONLY);
			} catch (RuntimeException e) {
				e.printStackTrace();
				LOG.error(e);
				throw e;
			} catch (SQLException e) {
				e.printStackTrace();
				LOG.error(e);
				throw e;
			}
		}
		return pstmt;
	}

	public ResultSet executePreSelect() throws SQLException {
		if (con == null) {
			throw new SQLException("Don't get database Connection from pool!");
		}
		try {
			rs = pstmt.executeQuery();
		} catch (RuntimeException e) {
			e.printStackTrace();
			LOG.error(e);
			throw e;
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.error(e);
			throw e;
		}
		return rs;
	}

	public long executePreCount() throws SQLException {
		long result = 0;
		if (con == null) {
			throw new SQLException("Don't get database Connection from pool!");
		}
		try {
			rs = pstmt.executeQuery();
			if (rs != null && rs.next()) {
				result = rs.getLong(1);
			}
		} catch (RuntimeException e) {
			e.printStackTrace();
			LOG.error(e);
			throw e;
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.error(e);
			throw e;
		}
		return result;
	}

	public int executePreInsert() throws SQLException {
		int result = 0;
		if (con == null) {
			throw new SQLException("Don't get database Connection from pool!");
		}
		if (con == null)
			return result;
		try {
			result = pstmt.executeUpdate();
		} catch (RuntimeException e) {
			e.printStackTrace();
			LOG.error(e);
			throw e;
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.error(e);
			throw e;
		}
		return result;
	}

	public int executePreUpdate() throws SQLException {
		int result = 0;
		if (con == null) {
			throw new SQLException("Don't get database Connection from pool!");
		}
		if (con == null)
			return result;
		try {
			result = pstmt.executeUpdate();
		} catch (RuntimeException e) {
			e.printStackTrace();
			LOG.error(e);
			throw e;
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.error(e);
			throw e;
		}
		return result;
	}

	public int executePreDelete() throws SQLException {
		int result = 0;
		if (con == null) {
			throw new SQLException("Don't get database Connection from pool!");
		}
		if (con == null)
			return result;
		try {
			result = pstmt.executeUpdate();
		} catch (RuntimeException e) {
			e.printStackTrace();
			LOG.error(e);
			throw e;
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.error(e);
			throw e;
		}
		return result;
	}

	/*
	 * protected void finalize() throws Throwable { super.finalize(); try { if
	 * (rs != null) { rs.close(); rs = null; } } catch (RuntimeException e) {
	 * e.printStackTrace(); LOG.error(e); throw e; } catch (SQLException e) {
	 * e.printStackTrace(); LOG.error(e); throw e; } finally { try { if (stmt !=
	 * null) { stmt.close(); stmt = null; } } catch (RuntimeException e) {
	 * e.printStackTrace(); LOG.error(e); throw e; } catch (SQLException e) {
	 * e.printStackTrace(); LOG.error(e); throw e; } finally { try { if (pstmt !=
	 * null) { pstmt.close(); pstmt = null; } } catch (RuntimeException e) {
	 * e.printStackTrace(); LOG.error(e); throw e; } catch (SQLException e) {
	 * e.printStackTrace(); LOG.error(e); throw e; } finally { if (con != null) {
	 * try { if (!con.isClosed()) { con.close(); con = null; } con = null; }
	 * catch (RuntimeException e) { e.printStackTrace(); LOG.error(e); throw e; }
	 * catch (SQLException e) { e.printStackTrace(); LOG.error(e); throw e; } } } } } }
	 */
	/**
	 * ����:�ر����ݿ�����<br>
	 * ��JAVAӦ�ó�����,Ҫ�Լ��ر�proxool���ӳء�ʹ��ProxoolFacade.shutdown(0)�����رա�<br>
	 * û�йر���ᱨ�� ERROR: org.logicalcobwebs.proxool.ShutdownHook#remove : Problem
	 * calling "get cause" on IllegalStateException.
	 * java.lang.reflect.InvocationTargetException at
	 * sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method) at
	 * sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:39)
	 */
	public void close() {
		try {
			if (rs != null) {
				rs.close();
				rs = null;
			}
		} catch (RuntimeException e) {
			e.printStackTrace();
			LOG.error(e);
		} catch (SQLException e) {
			e.printStackTrace();
			LOG.error(e);
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
					stmt = null;
				}
			} catch (RuntimeException e) {
				e.printStackTrace();
				LOG.error(e);
			} catch (SQLException e) {
				e.printStackTrace();
				LOG.error(e);
			} finally {
				try {
					if (pstmt != null) {
						pstmt.close();
						pstmt = null;
					}
				} catch (RuntimeException e) {
					e.printStackTrace();
					LOG.error(e);
					throw e;
				} catch (SQLException e) {
					e.printStackTrace();
					LOG.error(e);
				} finally {
					if (con != null) {
						try {
							if (!con.isClosed()) {
								con.close();
								con = null;
							}
							con = null;
						} catch (RuntimeException e) {
							e.printStackTrace();
							LOG.error(e);
							throw e;
						} catch (SQLException e) {
							e.printStackTrace();
							LOG.error(e);
						}
					}
				}
			}
		}
	}

	public static void main(String[] args) {

		ConUtil iCon = null;
		try {
			iCon = new ConUtil();
			if (iCon.getCon() == null) {
				return;
			}
			String sql = "SELECT * FROM article WHERE article_id=?";
			PreparedStatement ps = iCon.prepareStatement(sql);
			if (ps != null) {
				ps.setInt(1, 6);
				ResultSet rs = iCon.executePreSelect();
				if (rs != null && rs.next()) {
					System.out.println("title=" + rs.getString("title"));
				}
				if (rs != null) {
					rs.close();
					rs = null;
				}
				ps.close();
				ps = null;
			}
			iCon.close();
			iCon = null;
		} catch (Exception e) {
			LOG.error(e);
		} finally {
			try {
				if (iCon != null) {
					iCon.close();
					iCon = null;
				}
			} catch (Exception e) {
				LOG.error(e);
			}
		}
	}
}
