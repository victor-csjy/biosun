package hk.com.biosun.service;

import hk.com.biosun.dao.ArticleDAO;
import hk.com.biosun.dao.impl.ArticleDAOImpl;
import hk.com.biosun.model.Article;

import java.util.List;

public class ArticleService {

	public Article getByPKFront(int articleId, String articleType) {
		ArticleDAO articleDAO = new ArticleDAOImpl();
		String exeCondition;
		Object[] values = new Object[1];
		if (articleId < 1) {
			values[0] = "".equals(articleType) ? "about_us" : articleType;
			exeCondition = "WHERE article_type=? AND is_show='1' ORDER BY  order_id,article_date DESC LIMIT 1";
			return articleDAO.select(exeCondition, values);
		} else {
			exeCondition = "WHERE article_id=? AND is_show='1'";
			values[0] = articleId;
			return articleDAO.select(exeCondition, values);
		}
	}

	public List<Article> getListFront(String articleType) {
		return getListFront(articleType, 5000);
	}

	public List<Article> getListFront(String articleType, int qautityMax) {
		if (articleType == null || articleType.equals("")) {
			return null;
		}
		if (qautityMax < 1) {
			qautityMax = 1;
		}
		if (qautityMax > 5000) {
			qautityMax = 5000;
		}
		ArticleDAO articleDAO = new ArticleDAOImpl();
		Object[] values = { articleType, qautityMax };
		String exeCondition = "WHERE article_type=? AND is_show='1' ORDER BY  order_id,article_date DESC LIMIT ?";
		return articleDAO.getList(exeCondition, values);
	}

	public Article getByPK(int articleId) {
		if (articleId < 1) {
			return null;
		} else {
			ArticleDAO articleDAO = new ArticleDAOImpl();
			return articleDAO.selectByPK(articleId);
		}
	}

	public int updateBrowseTimes(int articleId, int span) {
		if (articleId < 1) {
			return -1;
		}
		String sql;
		Object[] values = { span, articleId };
		ArticleDAO articleDAO = new ArticleDAOImpl();
		sql = "UPDATE article SET browse_times=browse_times+? WHERE article_id=?";
		return articleDAO.update(sql, values);
	}

	public int updateProductNum(int articleId, int browseTimes) {
		if (articleId < 1) {
			return -1;
		}
		String sql;
		Object[] values = { browseTimes, articleId };
		ArticleDAO articleDAO = new ArticleDAOImpl();
		sql = "UPDATE article SET browse_times=? WHERE article_id=?";
		return articleDAO.update(sql, values);
	}

	public int update(String columns, String exeCondition,
			List<Object> valuesList) {
		if (columns == null || "".equals(columns) || valuesList == null
				|| valuesList.size() < 1) {
			return -1;
		}
		ArticleDAO articleDAO = new ArticleDAOImpl();
		return articleDAO.update(columns, exeCondition, valuesList.toArray());
	}

	public int delete(int articleId) {
		if (articleId < 1) {
			return -1;
		}
		ArticleDAO articleDAO = new ArticleDAOImpl();
		return articleDAO.deleteByPK(articleId);
	}

	public int getCount(String exeCondition, List<Object> valuesList) {
		ArticleDAO articleDAO = new ArticleDAOImpl();
		if (valuesList == null || valuesList.size() < 1) {
			return (int) articleDAO.count("*", exeCondition);
		}
		return (int) articleDAO.count("*", exeCondition, valuesList.toArray());
	}

	public List<Article> getList(String exeCondition, List<Object> valuesList,
			int pageSize, int pageNo) {
		if (pageSize > 500) {
			pageSize = 500;
		}
		if (pageNo < 1) {
			pageNo = 1;
		}
		ArticleDAO articleDAO = new ArticleDAOImpl();
		return articleDAO.getList(exeCondition,
				(valuesList != null && valuesList.size() > 0) ? valuesList
						.toArray() : null, pageSize, pageNo);
	}

	public int add(String title, String content, String article_type,
			String article_date, String is_show, String order_id) {
		ArticleDAO articleDAO = new ArticleDAOImpl();
		Article article = new Article();
		article.setTitle(title);
		article.setArticleType(article_type);
		article.setArticleDate(article_date);
		article.setIsShow(is_show);
		article.setOrderId(order_id);
		article.setContent(content);
		article.setBrowseTimes(0);
		return articleDAO.insert(article);
	}

	public static void main(String[] args) {
		ArticleDAOImpl articleDAOImpl = new ArticleDAOImpl();
		Article article = articleDAOImpl.selectByPK(5);
		if (article == null) {
			System.out.println("5 article==null");
		} else {
			System.out.println("Title=" + article.getTitle());
		}
		article = articleDAOImpl.selectByPK(6);
		if (article == null) {
			System.out.println("6 article==null");
		} else {
			System.out.println("Title=" + article.getTitle());
		}
	}
}
