package hk.com.biosun.service;

import hk.com.biosun.dao.ComTableDAO;
import hk.com.biosun.dao.impl.ComTableDAOImpl;
import hk.com.biosun.model.ComTable;
import java.util.List;
import com.aokle.util.DateUtil;

public class ComTableService {
	public int add(int pId, String comContent, String needFb, String statusFb,
			String userId, String p_model, String p_name,String p_pic) {
		ComTable comTable = new ComTable();
		comTable.setPId(pId);
		comTable.setComContent(comContent);
		comTable.setNeedFb(needFb);
		comTable.setStatusFb(statusFb);
		comTable.setUserId(userId);
		comTable.setComDate(DateUtil.formatDate(System.currentTimeMillis(), 2));
		comTable.setPModel(p_model);
		comTable.setPName(p_name);
		comTable.setPPic(p_pic);
		ComTableDAO comTableDAO = new ComTableDAOImpl();
		return comTableDAO.insert(comTable);
	}

	public int updateStatusFb(int comId, String statusFb) {
		if (comId < 1 || statusFb == null) {
			return -1;
		}
		ComTableDAO comTableDAO = new ComTableDAOImpl();
		return comTableDAO.update("status_fb=?", "WHERE com_id=?",
				new Object[]{statusFb, comId});
	}

	public ComTable getByPK(int comId) {
		if (comId < 1) {
			return null;
		}
		ComTableDAO comTableDAO = new ComTableDAOImpl();
		return comTableDAO.selectByPK(comId);
	}
	
	public int deleteByPK(int comId) {
		if (comId < 1) {
			return -1;
		}
		ComTableDAO comTableDAO = new ComTableDAOImpl();
		return comTableDAO.deleteByPK(comId);
	}
	
	public int getCount(String exeCondition, List<Object> valuesList) {
		ComTableDAO comTableDAO = new ComTableDAOImpl();
		if (valuesList == null || valuesList.size() < 1) {
			return (int) comTableDAO.count("*", exeCondition);
		}
		return (int) comTableDAO.count("*", exeCondition, valuesList.toArray());

	}

	public List<ComTable> getList(String exeCondition, List<Object> valuesList,int pageSize,int pageNo) {
		ComTableDAO comTableDAO = new ComTableDAOImpl();
		if(pageSize>500){
			pageSize=500;
		}
		if (valuesList == null || valuesList.size() < 1 || exeCondition == null
				|| "".equals(exeCondition)) {
			return comTableDAO.getList(exeCondition,null,pageSize,pageNo);
		}
		return comTableDAO.getList(exeCondition, valuesList.toArray(),pageSize,pageNo);
	}
}
