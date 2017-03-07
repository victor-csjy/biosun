package hk.com.biosun.service;

import hk.com.biosun.cache.ICacheSimple;
import hk.com.biosun.cache.SupplyTableCache;
import hk.com.biosun.dao.SupplyTableDAO;
import hk.com.biosun.dao.impl.SupplyTableDAOImpl;
import hk.com.biosun.model.SupplyTable;

import java.util.List;

public class SupplyTableService {

	public SupplyTable getByPK(int supplyId) {
		if (supplyId < 1) {
			return null;
		}
		ICacheSimple<SupplyTable> cacheSimple = SupplyTableCache.getInstance();
		return cacheSimple.get(String.valueOf(supplyId));
	}

	public int delete(int supplyId) {
		if (supplyId < 1) {
			return -1;
		}
		SupplyTableDAO supplyTableDAO = new SupplyTableDAOImpl();
		int result = supplyTableDAO.deleteByPK(supplyId);
		if (result > 0) {
			ICacheSimple<SupplyTable> cacheSimple = SupplyTableCache
					.getInstance();
			cacheSimple.reload();
		}
		return result;
	}

	public int getCount(String exeCondition, List<Object> valuesList) {
		SupplyTableDAO supplyTableDAO = new SupplyTableDAOImpl();
		if (valuesList == null || valuesList.size() < 1) {
			return (int) supplyTableDAO.count("*", exeCondition);
		}
		return (int) supplyTableDAO.count("*", exeCondition, valuesList
				.toArray());

	}

	public List<SupplyTable> getList(String exeCondition,
			List<Object> valuesList) {
		SupplyTableDAO supplyTableDAO = new SupplyTableDAOImpl();
		if (valuesList == null || valuesList.size() < 1 || exeCondition == null
				|| "".equals(exeCondition)) {
			return supplyTableDAO.getList(exeCondition);
		}
		return supplyTableDAO.getList(exeCondition, valuesList.toArray());
	}

	public List<SupplyTable> getList() {
		return getList(null, null);
	}

	public int add(String supply_name, String supply_http, String supply_man,
			String supply_zhw, String supply_tel, String supply_fax,
			String supply_mail, String supply_addr, String supply_other,
			String supply_date) {
		SupplyTable supplyTable = new SupplyTable();
		supplyTable.setSupplyName(supply_name);
		supplyTable.setSupplyHttp(supply_http);
		supplyTable.setSupplyMan(supply_man);
		supplyTable.setSupplyZhw(supply_zhw);
		supplyTable.setSupplyTel(supply_tel);
		supplyTable.setSupplyFax(supply_fax);
		supplyTable.setSupplyMail(supply_mail);
		supplyTable.setSupplyAddr(supply_addr);
		supplyTable.setSupplyOther(supply_other);
		supplyTable.setSupplyDate(supply_date);
		SupplyTableDAO supplyTableDAO = new SupplyTableDAOImpl();
		int result = supplyTableDAO.insert(supplyTable);
		if (result > 0) {
			ICacheSimple<SupplyTable> cacheSimple = SupplyTableCache
					.getInstance();
			cacheSimple.reload();
		}

		return result;
	}

	public int update(int supply_id, String supply_name, String supply_http,
			String supply_man, String supply_zhw, String supply_tel,
			String supply_fax, String supply_mail, String supply_addr,
			String supply_other, String supply_date) {
		if (supply_id < 1) {
			return -1;
		}
		SupplyTableDAO supplyTableDAO = new SupplyTableDAOImpl();
		int result = supplyTableDAO
				.update(
						"supply_name=?,supply_http=?,supply_man=?,supply_zhw=?,supply_tel=?,supply_fax=?,supply_mail=?,supply_addr=?,supply_other=?,supply_date=?",
						"WHERE supply_id=?", new Object[] { supply_name,
								supply_http, supply_man, supply_zhw,
								supply_tel, supply_fax, supply_mail,
								supply_addr, supply_other, supply_date,
								supply_id });
		if (result > 0) {
			ICacheSimple<SupplyTable> cacheSimple = SupplyTableCache
					.getInstance();
			cacheSimple.reload();
		}

		return result;
	}
}
