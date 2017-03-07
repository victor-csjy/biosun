package hk.com.biosun.service;

import hk.com.biosun.dao.ConTableDAO;
import hk.com.biosun.dao.impl.ConTableDAOImpl;
import hk.com.biosun.model.ConTable;

import java.util.List;

public class ConTableService {

	public ConTable getByPK(int conId) {
		if (conId < 1) {
			return null;
		}
		ConTableDAO conTableDAO = new ConTableDAOImpl();
		return conTableDAO.selectByPK(conId);
	}

	public int deleteBySupplyId(int supplyId) {
		if (supplyId < 1) {
			return -1;
		}
		ConTableDAO conTableDAO = new ConTableDAOImpl();
		return conTableDAO.delete("WHERE supply_id=?", new Object[]{supplyId});
	}

	public int delete(int conId) {
		if (conId < 1) {
			return -1;
		}
		ConTableDAO conTableDAO = new ConTableDAOImpl();
		return conTableDAO.deleteByPK(conId);
	}

	public int add(int supply_id, String con_name, String con_tel,
			String con_fax, String con_cell, String con_ms, String con_zhw,
			String con_mail, String con_other, String con_addr) {
		ConTable conTable = new ConTable();
		// con_ms con_zhw con_mail con_other con_addr
		conTable.setSupplyId(supply_id);
		conTable.setConName(con_name);
		conTable.setConTel(con_tel);
		conTable.setConFax(con_fax);
		conTable.setConCell(con_cell);
		conTable.setConMs(con_ms);
		conTable.setConZhw(con_zhw);
		conTable.setConMail(con_mail);
		conTable.setConOther(con_other);
		conTable.setConAddr(con_addr);
		ConTableDAO conTableDAO = new ConTableDAOImpl();
		return conTableDAO.insert(conTable);
	}

	public int update(int con_id, String con_name,
			String con_tel, String con_fax, String con_cell, String con_ms,
			String con_zhw, String con_mail, String con_other, String con_addr) {
		if (con_id < 1) {
			return -1;
		}

		ConTableDAO conTableDAO = new ConTableDAOImpl();
		return conTableDAO
				.update(
						"con_name=?,con_tel=?, con_fax=?, con_cell=?, con_ms=?, con_zhw=?, con_mail=?,con_other=?, con_addr=?",
						"WHERE con_id=?", new Object[]{con_name,
								con_tel, con_fax, con_cell, con_ms, con_zhw,
								con_mail, con_other, con_addr, con_id});
	}
	

	public int getCount(String exeCondition, List<Object> valuesList) {
		ConTableDAO conTableDAO = new ConTableDAOImpl();
		if (valuesList == null || valuesList.size() < 1) {
			return (int) conTableDAO.count("*", exeCondition);
		}
		return (int) conTableDAO.count("*", exeCondition, valuesList.toArray());

	}

	public List<ConTable> getList(String exeCondition, List<Object> valuesList,int pageSize,int pageNo) {
		ConTableDAO conTableDAO = new ConTableDAOImpl();
		if(pageSize>500){
			pageSize=500;
		}
		if (valuesList == null || valuesList.size() < 1 || exeCondition == null
				|| "".equals(exeCondition)) {
			return conTableDAO.getList(exeCondition,null,pageSize,pageNo);
		}
		return conTableDAO.getList(exeCondition, valuesList.toArray(),pageSize,pageNo);
	}

}
