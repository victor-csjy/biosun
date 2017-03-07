package hk.com.biosun.service;

import hk.com.biosun.dao.impl.EnquiryAndBuyCartDAOImpl;
import hk.com.biosun.define.EnquiryAndBuyCart;

import java.util.List;

public class EnquiryAndBuyCartService {

	public int getCount(String exeCondition, List<Object> valuesList) {
		EnquiryAndBuyCartDAOImpl enquiryAndBuyCartDAOImpl = new EnquiryAndBuyCartDAOImpl();
		if (valuesList == null || valuesList.size() < 1) {
			return (int) enquiryAndBuyCartDAOImpl.count("*", exeCondition, null);
		}
		return (int) enquiryAndBuyCartDAOImpl.count("*", exeCondition, valuesList
				.toArray());
	}

	public List<EnquiryAndBuyCart> getList(String exeCondition,
			List<Object> valuesList, int pageSize, int pageNo) {
		if (pageSize > 500) {
			pageSize = 500;
		}
		EnquiryAndBuyCartDAOImpl enquiryAndBuyCartImpl = new EnquiryAndBuyCartDAOImpl();
		if (valuesList == null || valuesList.size() < 1 || exeCondition == null
				|| "".equals(exeCondition)) {
			return enquiryAndBuyCartImpl.getList(exeCondition, null, pageSize,
					pageNo);
		}
		return enquiryAndBuyCartImpl.getList(exeCondition,
				valuesList.toArray(), pageSize, pageNo);
	}

}
