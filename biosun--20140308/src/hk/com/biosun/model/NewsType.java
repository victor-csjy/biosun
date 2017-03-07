/*
 * 说明：对应数据库表news_type的接口<br>
 * 修改数据库表结构,请修改该类以及相应的DAOImpl类
 * 
 * Datetime:Sat Mar 27 19:01:46 CST 2010
 * 
 * @author 
 * 
 */
package hk.com.biosun.model;

import java.io.Serializable;

public class NewsType implements Serializable  {
	private static final long serialVersionUID = 20100316L;
	private int newsType;
	private String orderId;
	private String newsName;

	public void setNewsType(int newsType) {
		this.newsType = newsType;
	}

	public int getNewsType() {
		return newsType;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setNewsName(String newsName) {
		this.newsName = newsName;
	}

	public String getNewsName() {
		return newsName;
	}

}