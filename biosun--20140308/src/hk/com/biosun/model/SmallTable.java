/*
 * 说明：对应数据库表small_table的接口<br>
 * 修改数据库表结构,请修改该类以及相应的DAOImpl类
 * 
 * Datetime:Sat Mar 27 19:01:46 CST 2010
 * 
 * @author 
 * 
 */
package hk.com.biosun.model;

import java.io.Serializable;

public class SmallTable implements Serializable  {
	private static final long serialVersionUID = 20100316L;
	private int smallId;
	private String smallName;
	private int bigId;
	private String smallOrder;
	private String content;
	private String smallCode;
	private String smallClassShow;

	public void setSmallId(int smallId) {
		this.smallId = smallId;
	}

	public int getSmallId() {
		return smallId;
	}

	public void setSmallName(String smallName) {
		this.smallName = smallName;
	}

	public String getSmallName() {
		return smallName;
	}

	public void setBigId(int bigId) {
		this.bigId = bigId;
	}

	public int getBigId() {
		return bigId;
	}

	public void setSmallOrder(String smallOrder) {
		this.smallOrder = smallOrder;
	}

	public String getSmallOrder() {
		return smallOrder;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getContent() {
		return content;
	}

	public void setSmallCode(String smallCode) {
		this.smallCode = smallCode;
	}

	public String getSmallCode() {
		return smallCode;
	}

	public void setSmallClassShow(String smallClassShow) {
		this.smallClassShow = smallClassShow;
	}

	public String getSmallClassShow() {
		return smallClassShow;
	}

}