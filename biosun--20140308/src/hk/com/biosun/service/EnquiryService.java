package hk.com.biosun.service;

import hk.com.biosun.dao.EnquiryDAO;
import hk.com.biosun.dao.impl.EnquiryDAOImpl;
import hk.com.biosun.model.Enquiry;

import java.util.List;

public class EnquiryService {

	public int add(Enquiry enquiry) {
		if (enquiry == null || enquiry.getEnId() == null
				|| enquiry.getEnId().equals("")) {
			return -1;
		}
		EnquiryDAO enquiryDAO = new EnquiryDAOImpl();
		return enquiryDAO.insert(enquiry);
	}

	public int delete(String enId) {
		if (enId == null || enId.equals("")) {
			return -1;
		}
		EnquiryDAO enquiryDAO = new EnquiryDAOImpl();
		return enquiryDAO.deleteByPK(enId);
	}

	public int deleteByUserId(String userId) {
		if (userId == null || "".equals(userId)) {
			return -1;
		}
		EnquiryDAO enquiryDAO = new EnquiryDAOImpl();
		return enquiryDAO.delete("WHERE user_id=?", new Object[]{userId});
	}

	public Enquiry getByPK(String enId) {
		if (enId == null || "".equals(enId)) {
			return null;
		}
		EnquiryDAO enquiryDAO = new EnquiryDAOImpl();
		return enquiryDAO.selectByPK(enId);
	}

	public int updateEnStatus(String enId, String enStatus) {
		if (enId == null || "".equals(enId)) {
			return -1;
		}
		EnquiryDAO enquiryDAO = new EnquiryDAOImpl();
		return enquiryDAO.update("en_status=?", "WHERE en_id=?", new Object[]{
				enStatus, enId});
	}
}
