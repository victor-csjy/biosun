/*
 * 说明：对应数据库表supply_table的接口<br>
 * 修改数据库表结构,请修改该类以及相应的DAOImpl类
 * 
 * Datetime:Sat Mar 27 19:01:46 CST 2010
 * 
 * @author 
 * 
 */
package hk.com.biosun.model;

import java.io.Serializable;

public class SupplyTable implements Serializable  {
	private static final long serialVersionUID = 20100316L;
	private int supplyId;
	private String supplyName;
	private String supplyHttp;
	private String supplyMan;
	private String supplyZhw;
	private String supplyTel;
	private String supplyFax;
	private String supplyMail;
	private String supplyAddr;
	private String supplyOther;
	private String supplyDate;

	public void setSupplyId(int supplyId) {
		this.supplyId = supplyId;
	}

	public int getSupplyId() {
		return supplyId;
	}

	public void setSupplyName(String supplyName) {
		this.supplyName = supplyName;
	}

	public String getSupplyName() {
		return supplyName;
	}

	public void setSupplyHttp(String supplyHttp) {
		this.supplyHttp = supplyHttp;
	}

	public String getSupplyHttp() {
		return supplyHttp;
	}

	public void setSupplyMan(String supplyMan) {
		this.supplyMan = supplyMan;
	}

	public String getSupplyMan() {
		return supplyMan;
	}

	public void setSupplyZhw(String supplyZhw) {
		this.supplyZhw = supplyZhw;
	}

	public String getSupplyZhw() {
		return supplyZhw;
	}

	public void setSupplyTel(String supplyTel) {
		this.supplyTel = supplyTel;
	}

	public String getSupplyTel() {
		return supplyTel;
	}

	public void setSupplyFax(String supplyFax) {
		this.supplyFax = supplyFax;
	}

	public String getSupplyFax() {
		return supplyFax;
	}

	public void setSupplyMail(String supplyMail) {
		this.supplyMail = supplyMail;
	}

	public String getSupplyMail() {
		return supplyMail;
	}

	public void setSupplyAddr(String supplyAddr) {
		this.supplyAddr = supplyAddr;
	}

	public String getSupplyAddr() {
		return supplyAddr;
	}

	public void setSupplyOther(String supplyOther) {
		this.supplyOther = supplyOther;
	}

	public String getSupplyOther() {
		return supplyOther;
	}

	public void setSupplyDate(String supplyDate) {
		this.supplyDate = supplyDate;
	}

	public String getSupplyDate() {
		return supplyDate;
	}

}