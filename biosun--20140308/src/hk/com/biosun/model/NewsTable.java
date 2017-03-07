/*
 * 说明：对应数据库表news_table的接口<br>
 * 修改数据库表结构,请修改该类以及相应的DAOImpl类
 * 
 * Datetime:Sat Mar 27 19:01:46 CST 2010
 * 
 * @author 
 * 
 */
package hk.com.biosun.model;

import java.io.Serializable;

public class NewsTable implements Serializable  {
	private static final long serialVersionUID = 20100316L;
	private int newsId;
	private String newsTitle;
	private int newsType;
	private String newsDate;
	private String isShow;
	private String isRoll;
	private String orderId;
	private String content;
	private int browseTimes;

	public void setNewsId(int newsId) {
		this.newsId = newsId;
	}

	public int getNewsId() {
		return newsId;
	}

	public void setNewsTitle(String newsTitle) {
		this.newsTitle = newsTitle;
	}

	public String getNewsTitle() {
		return newsTitle;
	}

	public void setNewsType(int newsType) {
		this.newsType = newsType;
	}

	public int getNewsType() {
		return newsType;
	}

	public void setNewsDate(String newsDate) {
		this.newsDate = newsDate;
	}

	public String getNewsDate() {
		return newsDate;
	}

	public void setIsShow(String isShow) {
		this.isShow = isShow;
	}

	public String getIsShow() {
		return isShow;
	}

	public void setIsRoll(String isRoll) {
		this.isRoll = isRoll;
	}

	public String getIsRoll() {
		return isRoll;
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