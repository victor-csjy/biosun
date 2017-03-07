package hk.com.biosun.service;

import hk.com.biosun.cache.ICacheSimple;
import hk.com.biosun.cache.NewsTypeCache;
import hk.com.biosun.dao.NewsTypeDAO;
import hk.com.biosun.dao.impl.NewsTypeDAOImpl;
import hk.com.biosun.model.NewsType;

import java.util.List;

public class NewsTypeService {

	public NewsType getByPK(int newsType) {
		if (newsType < 1) {
			return null;
		} else {
			ICacheSimple<NewsType> cacheSimple = NewsTypeCache.getInstance();
			return cacheSimple.get(String.valueOf(newsType));
		}
	}

	public List<NewsType> getList() {
		ICacheSimple<NewsType> cacheSimple = NewsTypeCache.getInstance();
		return cacheSimple.getList();
	}

	public int add(String newsName, String orderId) {
		if (newsName == null) {
			return -1;
		}
		NewsType newsType = new NewsType();
		newsType.setNewsName(newsName);
		newsType.setOrderId(orderId);
		NewsTypeDAO newsTypeDAO = new NewsTypeDAOImpl();
		int result = newsTypeDAO.insert(newsType);
		if (result > 0) {
			ICacheSimple<NewsType> cacheSimple = NewsTypeCache.getInstance();
			cacheSimple.reload();
		}
		return result;
	}

	public int delete(int newsType) {
		if (newsType < 1) {
			return -1;
		}
		NewsTypeDAO newsTypeDAO = new NewsTypeDAOImpl();
		int result = newsTypeDAO.deleteByPK(newsType);
		if (result > 0) {
			// 删除news_table 表中的相关信息
			NewsTableService newsTableService = new NewsTableService();
			newsTableService.deleteByNewsType(newsType);
			ICacheSimple<NewsType> cacheSimple = NewsTypeCache.getInstance();
			cacheSimple.reload();
		}
		return result;
	}

	public int update(int newsTypeId, String newsName, String orderId) {
		if (newsTypeId < 1 || newsName == null || orderId == null) {
			return -1;
		}
		NewsTypeDAO newsTypeDAO = new NewsTypeDAOImpl();
		int result = newsTypeDAO.update("news_name=?,order_id=?",
				"WHERE news_type=?",
				new Object[]{newsName, orderId, newsTypeId});
		if (result > 0) {
			ICacheSimple<NewsType> cacheSimple = NewsTypeCache.getInstance();
			cacheSimple.reload();
		}
		return result;
	}
}
