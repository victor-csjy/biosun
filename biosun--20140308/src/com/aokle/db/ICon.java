package com.aokle.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * ���ܣ����ݿ����ӵĽӿ�,�ӿ��в����г�Ա������һ��Ҫ��ֻ����final static���͵�
 * 
 * @author qinyongcai ������
 */
public interface ICon {

	public String getDataBasePool();

	public void setDataBasePool(String dataBasePool);

	public Connection getCon() throws SQLException;

	public ResultSet select(String sql) throws SQLException;

	public long count(String sql) throws SQLException;

	public int insert(String sql) throws SQLException;

	public int update(String sql) throws SQLException;

	public int delete(String sql) throws SQLException;

	public ResultSet executePreSelect() throws SQLException;

	public long executePreCount() throws SQLException;

	public int executePreInsert() throws SQLException;

	public int executePreUpdate() throws SQLException;

	public int executePreDelete() throws SQLException;

	public void beginTrans() throws SQLException;

	public void commit() throws SQLException;

	public void rollback() throws SQLException;

	public boolean getAutoCommit() throws SQLException;

	public int getTransactionIsolation() throws SQLException;

	public void setFetchSize(int size) throws SQLException;

	public void setMaxRows(int maxRows) throws SQLException;

	public PreparedStatement prepareStatement(String sql) throws SQLException;

	public void close() throws SQLException;
}