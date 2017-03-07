package hk.com.biosun.service;

import hk.com.biosun.cache.ICacheSimple;
import hk.com.biosun.cache.SmallTableCache;
import hk.com.biosun.dao.SmallTableDAO;
import hk.com.biosun.dao.impl.SmallTableDAOImpl;
import hk.com.biosun.model.SmallTable;

import java.util.List;

public class SmallTableService {
	public SmallTable getByPKFront(int smallId) {
		if (smallId < 1) {
			return null;
		}
		SmallTable smallTable = getByPK(smallId);
		if (smallTable != null && !"1".equals(smallTable.getSmallClassShow())) {
			return null;
		}
		return smallTable;
	}

	public List<SmallTable> getListFront(int bigId) {
		SmallTableDAO smallTableDAO = new SmallTableDAOImpl();

		StringBuffer exeConditionSB = new StringBuffer();
		if (bigId > 0) {
			exeConditionSB.append(" AND big_id=?");
		}
		exeConditionSB.append(" AND small_class_show='1'");
		exeConditionSB.append(" ORDER BY small_order");
		exeConditionSB.delete(0, 4);
		exeConditionSB.insert(0, "WHERE");
		if (bigId > 0) {
			Object[] values = { bigId };
			return smallTableDAO.getList(exeConditionSB.toString(), values);
		} else {
			return smallTableDAO.getList(exeConditionSB.toString());
		}
	}

	public SmallTable getByPK(int smallId) {
		if (smallId < 1) {
			return null;
		} else {
			ICacheSimple<SmallTable> cacheSimple = SmallTableCache
					.getInstance();
			return cacheSimple.get(String.valueOf(smallId));
		}
	}

	public List<SmallTable> getList() {
		SmallTableDAO smallTableDAO = new SmallTableDAOImpl();
		return smallTableDAO.getList();
	}

	public int add(String small_code, String small_name, int big_id,
			String small_order, String small_class_show, String content) {
		
		if(big_id<1){
			return -1;
		}
		SmallTableDAO smallTableDAO = new SmallTableDAOImpl();
		SmallTable smallTable = new SmallTable();
		smallTable.setSmallCode(small_code);
		smallTable.setSmallName(small_name);
		smallTable.setBigId(big_id);
		smallTable.setSmallOrder(small_order);
		smallTable.setSmallClassShow(small_class_show);
		smallTable.setContent(content);
		int result = smallTableDAO.insert(smallTable);
		if (result > 0) {
			ICacheSimple<SmallTable> cacheSimple = SmallTableCache
					.getInstance();
			cacheSimple.reload();
		}
		return result;
	}

	public int deleteByBigId(int bigId) {
		if (bigId < 1) {
			return -1;
		}
		SmallTableDAO smallTableDAO = new SmallTableDAOImpl();
		int result = smallTableDAO.delete("WHERE big_id=?",
				new Object[] { bigId });
		if (result > 0) {
			ICacheSimple<SmallTable> cacheSimple = SmallTableCache
					.getInstance();
			cacheSimple.reload();
		}
		return result;
	}

	public int deleteByPK(int smallId) {
		if (smallId < 1) {
			return -1;
		}
		SmallTableDAO smallTableDAO = new SmallTableDAOImpl();
		int result = smallTableDAO.deleteByPK(smallId);
		if (result > 0) {
			ICacheSimple<SmallTable> cacheSimple = SmallTableCache
					.getInstance();
			cacheSimple.reload();
		}
		return result;
	}

	public int updateSmallClassShowByBigId(int bigId, String class_show) {
		if (bigId < 1) {
			return -1;
		}
		SmallTableDAO smallTableDAO = new SmallTableDAOImpl();
		int result = smallTableDAO.update("small_class_show=?",
				"WHERE big_id=?", new Object[] { class_show, bigId });
		if (result > 0) {
			ICacheSimple<SmallTable> cacheSimple = SmallTableCache
					.getInstance();
			cacheSimple.reload();
		}
		return result;
	}

	public int updateByPk(int small_id, int big_id, String class_code,
			String class_name, String content, String order_id,
			String class_show) {
		if (small_id < 1) {
			return -1;
		}
		SmallTableDAO smallTableDAO = new SmallTableDAOImpl();
		int result = smallTableDAO
				.update(
						"small_name=?,big_id=?,small_order=?,content=?,small_code=?,small_class_show=?",
						"WHERE small_id=?", new Object[] { class_name, big_id,
								order_id, content, class_code, class_show,
								small_id });
		if (result > 0) {
			ICacheSimple<SmallTable> cacheSimple = SmallTableCache
					.getInstance();
			cacheSimple.reload();
		}
		return result;
	}
}
