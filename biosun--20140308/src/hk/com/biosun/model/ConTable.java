/*
 * 说明：对应数据库表con_table的接口<br>
 * 修改数据库表结构,请修改该类以及相应的DAOImpl类
 * 
 * Datetime:Sat Mar 27 19:01:45 CST 2010
 * 
 * @author 
 * 
 */
package hk.com.biosun.model;

import java.io.Serializable;

public class ConTable implements Serializable  {
	private static final long serialVersionUID = 20100316L;
	private int conId;
	private int supplyId;
	private String conName;
	private String conTel;
	private String conFax;
	private String conCell;
	private String conMs;
	private String conZhw;
	private String conMail;
	private String conOther;
	private String conAddr;

	public void setConId(int conId) {
		this.conId = conId;
	}

	public int getConId() {
		return conId;
	}

	public void setSupplyId(int supplyId) {
		this.supplyId = supplyId;
	}

	public int getSupplyId() {
		return supplyId;
	}

	public void setConName(String conName) {
		this.conName = conName;
	}

	public String getConName() {
		return conName;
	}

	public void setConTel(String conTel) {
		this.conTel = conTel;
	}

	public String getConTel() {
		return conTel;
	}

	public void setConFax(String conFax) {
		this.conFax = conFax;
	}

	public String getConFax() {
		return conFax;
	}

	public void setConCell(String conCell) {
		this.conCell = conCell;
	}

	public String getConCell() {
		return conCell;
	}

	public void setConMs(String conMs) {
		this.conMs = conMs;
	}

	public String getConMs() {
		return conMs;
	}

	public void setConZhw(String conZhw) {
		this.conZhw = conZhw;
	}

	public String getConZhw() {
		return conZhw;
	}

	public void setConMail(String conMail) {
		this.conMail = conMail;
	}

	public String getConMail() {
		return conMail;
	}

	public void setConOther(String conOther) {
		this.conOther = conOther;
	}

	public String getConOther() {
		return conOther;
	}

	public void setConAddr(String conAddr) {
		this.conAddr = conAddr;
	}

	public String getConAddr() {
		return conAddr;
	}

}