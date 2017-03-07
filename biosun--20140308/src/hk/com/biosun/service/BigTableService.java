package hk.com.biosun.service;

import hk.com.biosun.cache.BigTableCache;
import hk.com.biosun.cache.ICacheSimple;
import hk.com.biosun.dao.BigTableDAO;
import hk.com.biosun.dao.impl.BigTableDAOImpl;
import hk.com.biosun.model.BigTable;

import java.util.List;

public class BigTableService {

	public BigTable getByPKFront(int bigId) {
		if (bigId < 1) {
			return null;
		}
		BigTable bigTable = getByPK(bigId);
		if (bigTable != null && !"1".equals(bigTable.getBigClassShow())) {
			return null;
		}
		return bigTable;
	}

	public List<BigTable> getListFront() {
		BigTableDAO bigTableDAO = new BigTableDAOImpl();
		String exeCondition = "WHERE big_class_show='1' ORDER BY big_order";
		return bigTableDAO.getList(exeCondition);
	}

	public List<BigTable> getList() {
		ICacheSimple<BigTable> cacheSimple = BigTableCache.getInstance();
		return cacheSimple.getList();
	}

	public BigTable getByPK(int bigId) {
		if (bigId < 1) {
			return null;
		} else {
			ICacheSimple<BigTable> cacheSimple = BigTableCache.getInstance();
			return cacheSimple.get(String.valueOf(bigId));
		}
	}

	public BigTable getByBigName(String bigName) {
		if (bigName == null || "".equals(bigName)) {
			return null;
		} else {
			BigTableDAO bigTableDAO = new BigTableDAOImpl();
			return bigTableDAO.select("WHERE big_name=?",
					new Object[] { bigName });
		}
	}

	public int add(String big_code, String big_name, String big_order,
			String big_class_show, String content) {
		BigTableDAO bigTableDAO = new BigTableDAOImpl();
		BigTable bigTable = new BigTable();
		bigTable.setBigCode(big_code);
		bigTable.setBigName(big_name);
		bigTable.setBigOrder(big_order);
		bigTable.setBigClassShow(big_class_show);
		bigTable.setContent(content);
		int result = bigTableDAO.insert(bigTable);
		if (result > 0) {
			ICacheSimple<BigTable> cacheSimple = BigTableCache.getInstance();
			cacheSimple.reload();
		}
		return result;
	}

	public int deleteByPK(int bigId) {
		if (bigId < 1) {
			return -1;
		}
		BigTableDAO bigTableDAO = new BigTableDAOImpl();
		int result = bigTableDAO.deleteByPK(bigId);
		if (result > 0) {
			ICacheSimple<BigTable> cacheSimple = BigTableCache.getInstance();
			cacheSimple.reload();
		}
		return result;
	}

	public int updateByPk(int big_id_orient, String class_code,
			String class_name, String content, String order_id,
			String class_show) {
		if (big_id_orient < 1) {
			return -1;
		}
		BigTableDAO bigTableDAO = new BigTableDAOImpl();
		int result = bigTableDAO.update(
				"big_code=?,big_name=?,content=?,big_order=?,big_class_show=?",
				"WHERE big_id=?", new Object[] { class_code, class_name,
						content, order_id, class_show, big_id_orient });

		if (result > 0) {
			ICacheSimple<BigTable> cacheSimple = BigTableCache.getInstance();
			cacheSimple.reload();
		}
		return result;
	}

}
