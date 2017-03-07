package hk.com.biosun.service;

import hk.com.biosun.dao.NewsTableDAO;
import hk.com.biosun.dao.impl.NewsTableDAOImpl;
import hk.com.biosun.model.NewsTable;

import java.util.List;
import java.util.ArrayList;

public class NewsTableService {

	public NewsTable getByPKFront(int newsId) {
		if (newsId < 1) {
			return null;
		} else {
			NewsTable newsTable = getByPK(newsId);
			if (newsTable != null && !"1".equals(newsTable.getIsShow())) {
				return null;
			}
			return newsTable;
		}
	}

	public NewsTable getByPK(int newsId) {
		if (newsId < 1) {
			return null;
		} else {
			NewsTableDAO newsTableDAO = new NewsTableDAOImpl();
			return newsTableDAO.selectByPK(newsId);
		}
	}

	public int delete(int newsId) {
		if (newsId < 1) {
			return -1;
		}
		NewsTableDAO newsTableDAO = new NewsTableDAOImpl();
		return newsTableDAO.deleteByPK(newsId);
	}

	public int deleteByNewsType(int newsType) {
		if (newsType < 1) {
			return -1;
		}
		NewsTableDAO newsTableDAO = new NewsTableDAOImpl();
		return newsTableDAO.delete("WHERE news_type=?",
				new Object[] { newsType });
	}
	 
	 public int getCountFront(int newsTypeId) {
		 return getCountFront(newsTypeId,-1);
	 }
	public int getCountFront(int newsTypeId,int isRoll) {
		NewsTableDAO newsTableDAO = new NewsTableDAOImpl();
		StringBuffer exeConditionSB = new StringBuffer();

		List<Object> values = new ArrayList<Object>();
		if (newsTypeId >0) {
			exeConditionSB.append(" AND news_type=?");
			values.add(newsTypeId);
		}
		if (isRoll > -1) {
			exeConditionSB.append(" AND is_roll=?");
			values.add(isRoll);
		}
		exeConditionSB.append(" AND is_show='1'");
		exeConditionSB.delete(0, 4);
		exeConditionSB.insert(0, "WHERE");
		return (int) newsTableDAO.count("*", exeConditionSB.toString(), values!=null?values.toArray():null);
	}

	public List<NewsTable> getListFront(int newsTypeId, int pageSize, int pageNo) {
		return getListFront(newsTypeId, -1, pageSize, pageNo);
	}

	/**
	 * 前台使用的翻页
	 * 
	 * @param newsTypeId
	 * @param isShow
	 * @param isRoll
	 *            -1=全部 0=非滚动的 1=滚动的
	 * @param orderBy
	 * @param pageSize
	 * @param pageNo
	 * @return
	 */
	public List<NewsTable> getListFront(int newsTypeId, int isRoll,
			int pageSize, int pageNo) {
		if (pageSize < 1) {
			pageSize = 1;
		}
		if (pageSize > 200) {
			pageSize = 200;
		}

		if (pageNo < 1) {
			pageNo = 1;
		}
		NewsTableDAO newsTableDAO = new NewsTableDAOImpl();
		StringBuffer exeConditionSB = new StringBuffer();

		List<Object> values = new ArrayList<Object>();
		if (newsTypeId > 0) {
			exeConditionSB.append(" AND news_type=?");
			values.add(newsTypeId);
		}
		if (isRoll > -1) {
			exeConditionSB.append(" AND is_roll=?");
			values.add(isRoll);
		}
		exeConditionSB
				.append(" AND is_show='1' ORDER BY order_id,news_date DESC");
		exeConditionSB.delete(0, 4);
		exeConditionSB.insert(0, "WHERE");
		
		return newsTableDAO
				.getList(exeConditionSB.toString(), (values.size() > 0? values
						.toArray() : null), pageSize, pageNo);
	}

	public int updateBrowseTimes(int newsId, int span) {
		if (newsId < 1) {
			return -1;
		}
		String sql;
		Object[] values = { span, newsId };
		NewsTableDAO newsTableDAO = new NewsTableDAOImpl();
		sql = "UPDATE news_table SET browse_times=browse_times+? WHERE news_id=?";
		return newsTableDAO.update(sql, values);
	}

	public int getCount(String exeCondition, List<Object> valuesList) {
		NewsTableDAO newsTableDAO = new NewsTableDAOImpl();
		if (valuesList == null || valuesList.size() < 1) {
			return (int) newsTableDAO.count("*", exeCondition);
		}
		return (int) newsTableDAO
				.count("*", exeCondition, valuesList.toArray());
	}

	public List<NewsTable> getList(String exeCondition, List<Object> valuesList) {
		NewsTableDAO newsTableDAO = new NewsTableDAOImpl();
		if (valuesList == null || valuesList.size() < 1) {
			return newsTableDAO.getList(exeCondition);
		}
		return newsTableDAO.getList(exeCondition, valuesList.toArray());
	}

	public int add(String newsTitle, int newsType, String newsDate,
			String isShow, String isRoll, String orderId, String content) {
		NewsTableDAO newsTableDAO = new NewsTableDAOImpl();
		NewsTable newsTable = new NewsTable();
		newsTable.setNewsTitle(newsTitle);
		newsTable.setNewsType(newsType);
		newsTable.setNewsDate(newsDate);
		newsTable.setIsShow(isShow);
		newsTable.setIsRoll(isRoll);
		newsTable.setOrderId(orderId);
		newsTable.setContent(content);
		newsTable.setBrowseTimes(0);
		return newsTableDAO.insert(newsTable);
	}

	public int update(int newsId, String newsTitle, String content,
			int newsType, String newsDate, String isShow, String isRoll,
			String orderId) {
		if (newsId < 1) {
			return -1;
		}

		NewsTableDAO newsTableDAO = new NewsTableDAOImpl();
		return newsTableDAO
				.update(
						"news_title=?,content=?,news_type=?,news_date=?,is_show=?,is_roll=?,order_id=?",
						"WHERE news_id=?", new Object[] { newsTitle, content,
								newsType, newsDate, isShow, isRoll, orderId,
								newsId });
	}
}
