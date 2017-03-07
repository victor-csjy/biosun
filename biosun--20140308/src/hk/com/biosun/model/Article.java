/*
 * 说明：对应数据库表article的接口<br>
 * 修改数据库表结构,请修改该类以及相应的DAOImpl类
 * 
 * Datetime:Sat Mar 27 19:01:45 CST 2010
 * 
 * @author 
 * 
 */
package hk.com.biosun.model;

import java.io.Serializable;

public class Article implements Serializable  {
	private static final long serialVersionUID = 20100316L;
	private int articleId;
	private String title;
	private String articleType;
	private String articleDate;
	private String isShow;
	private String orderId;
	private String content;
	private int browseTimes;

	public void setArticleId(int articleId) {
		this.articleId = articleId;
	}

	public int getArticleId() {
		return articleId;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getTitle() {
		return title;
	}

	public void setArticleType(String articleType) {
		this.articleType = articleType;
	}

	public String getArticleType() {
		return articleType;
	}

	public void setArticleDate(String articleDate) {
		this.articleDate = articleDate;
	}

	public String getArticleDate() {
		return articleDate;
	}

	public void setIsShow(String isShow) {
		this.isShow = isShow;
	}

	public String getIsShow() {
		return isShow;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getContent() {
		return content;
	}

	public void setBrowseTimes(int browseTimes) {
		this.browseTimes = browseTimes;
	}

	public int getBrowseTimes() {
		return browseTimes;
	}

}