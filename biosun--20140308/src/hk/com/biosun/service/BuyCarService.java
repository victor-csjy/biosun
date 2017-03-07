package hk.com.biosun.service;

import hk.com.biosun.dao.BuyCarDAO;
import hk.com.biosun.dao.impl.BuyCarDAOImpl;
import hk.com.biosun.model.BuyCar;

public class BuyCarService {
	public int add(BuyCar buyCar) {
		if (buyCar == null || buyCar.getEnId() == null
				|| buyCar.getEnId().equals("") || buyCar.getPId() < 1) {
			return -1;
		}
		BuyCarDAO buyCarDAO = new BuyCarDAOImpl();
		return buyCarDAO.insert(buyCar);
	}

	public int deleteByUserId(String userId) {
		if (userId == null || "".equals(userId)) {
			return -1;
		}
		BuyCarDAO buyCarDAO = new BuyCarDAOImpl();
		return buyCarDAO.delete("WHERE userId=?", new Object[]{userId});
	}

	public int deleteByEnId(String enId) {
		if (enId == null || "".equals(enId)) {
			return -1;
		}
		BuyCarDAO buyCarDAO = new BuyCarDAOImpl();
		return buyCarDAO.delete("WHERE en_Id=?", new Object[]{enId});
	}
}
