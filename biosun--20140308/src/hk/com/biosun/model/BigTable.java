/*
 * 说明：对应数据库表big_table的接口<br>
 * 修改数据库表结构,请修改该类以及相应的DAOImpl类
 * 
 * Datetime:Sat Mar 27 19:01:45 CST 2010
 * 
 * @author 
 * 
 */
package hk.com.biosun.model;

import java.io.Serializable;

public class BigTable implements Serializable  {
	private static final long serialVersionUID = 20100316L;
	private String bigCode;
	private int bigId;
	private String bigName;
	private String content;
	private String bigOrder;
	private String bigClassShow;

	public void setBigCode(String bigCode) {
		this.bigCode = bigCode;
	}

	public String getBigCode() {
		return bigCode;
	}

	public void setBigId(int bigId) {
		this.bigId = bigId;
	}

	public int getBigId() {
		return bigId;
	}

	public void setBigName(String bigName) {
		this.bigName = bigName;
	}

	public String getBigName() {
		return bigName;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getContent() {
		return content;
	}

	public void setBigOrder(String bigOrder) {
		this.bigOrder = bigOrder;
	}

	public String getBigOrder() {
		return bigOrder;
	}

	public void setBigClassShow(String bigClassShow) {
		this.bigClassShow = bigClassShow;
	}

	public String getBigClassShow() {
		return bigClassShow;
	}

}