package hk.com.biosun.service;

import hk.com.biosun.dao.AdminDAO;
import hk.com.biosun.dao.impl.AdminDAOImpl;
import hk.com.biosun.model.Admin;

import com.aokle.util.MD5;

public class AdminService {

	public Admin getByPK(String adminName) {
		if (adminName == null || adminName.equals("")) {
			return null;
		} else {
			AdminDAO adminDAO = new AdminDAOImpl();
			return adminDAO.selectByPK(adminName);
		}
	}
	public int updatePassWord(String adminId, String pwNew, String pwOld) {
		if (adminId == null || "".equals(adminId) || pwNew == null
				|| "".equals(pwNew) || pwOld == null || "".equals(pwOld)) {
			return -1;
		}
		if (pwNew.equals(pwOld)) {
			return 1;
		}
		pwNew = MD5.encrypt(MD5.encrypt(pwNew) + "-biosun");
		pwOld = MD5.encrypt(MD5.encrypt(pwOld) + "-biosun");
		AdminDAO adminDAO = new AdminDAOImpl();
		return adminDAO.update("admin_pw=?",
				"WHERE admin_name=? AND admin_pw=?", new Object[]{pwNew,
						adminId, pwOld});
	}

}
