package hk.com.biosun.service;

import hk.com.biosun.dao.impl.BigAndSmallTableDAOImpl;
import hk.com.biosun.define.BigAndSmallTable;

import java.util.List;

public class BigAndSmallTableService {

	public List<BigAndSmallTable> getList() {
		BigAndSmallTableDAOImpl bigAndSmallTableDAOImpl = new BigAndSmallTableDAOImpl();
		return bigAndSmallTableDAOImpl.getList();
	}
}
