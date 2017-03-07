package hk.com.biosun.service;

import hk.com.biosun.dao.AdminLogDAO;
import hk.com.biosun.dao.impl.AdminLogDAOImpl;
import hk.com.biosun.model.AdminLog;

import java.util.List;

import com.aokle.util.DateUtil;

public class AdminLogService {

	public int delete(long id) {
		if (id < 1) {
			return -1;
		}
		AdminLogDAO adminLogDAO = new AdminLogDAOImpl();
		return adminLogDAO.deleteByPK(id);
	}

	public int delete() {
		AdminLogDAO adminLogDAO = new AdminLogDAOImpl();
		AdminLog adminLog = adminLogDAO
				.select("ORDER BY login_date DESC LIMIT 50000,1");
		return adminLogDAO.delete("WHERE login_date<?", new Object[]{adminLog
				.getLoginDate()});
	}

	public List<AdminLog> getList(int pageNo, int pageSize) {
		if (pageNo < 1) {
			pageNo = 1;
		}
		if (pageSize > 500) {
			pageSize = 500;
		}
		AdminLogDAO adminLogDAO = new AdminLogDAOImpl();
		return adminLogDAO
				.getList("ORDER BY login_date DESC", pageSize, pageNo);
	}

	public int getCount() {
		AdminLogDAO adminLogDAO = new AdminLogDAOImpl();
		return (int) adminLogDAO.count();
	}

	public int add(AdminLog adminLog) {
		if (adminLog == null) {
			return -1;
		}
		if (adminLog.getLoginDate() == null
				|| adminLog.getLoginDate().equals("")) {
			adminLog.setLoginDate(DateUtil.formatDate(System
					.currentTimeMillis(), 2));
		}
		AdminLogDAO adminLogDAO = new AdminLogDAOImpl();
		return adminLogDAO.insert(adminLog);

	}
}
