/*
 * 说明：对应数据库表enquiry的接口<br>
 * 修改数据库表结构,请修改该类以及相应的DAOImpl类
 * 
 * Datetime:Sat Mar 27 19:01:45 CST 2010
 * 
 * @author 
 * 
 */
package hk.com.biosun.model;

import java.io.Serializable;

public class Enquiry implements Serializable  {
	private static final long serialVersionUID = 20100316L;
	private String enId;
	private String userId;
	private String enP;
	private String mi;
	private String de;
	private String inOk;
	private String sa;
	private String orderS;
	private String pIdS;
	private String accountInf;
	private String accountNum;
	private String otMs;
	private String enDate;
	private String enStatus;

	public void setEnId(String enId) {
		this.enId = enId;
	}

	public String getEnId() {
		return enId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserId() {
		return userId;
	}

	public void setEnP(String enP) {
		this.enP = enP;
	}

	public String getEnP() {
		return enP;
	}

	public void setMi(String mi) {
		this.mi = mi;
	}

	public String getMi() {
		return mi;
	}

	public void setDe(String de) {
		this.de = de;
	}

	public String getDe() {
		return de;
	}

	public void setInOk(String inOk) {
		this.inOk = inOk;
	}

	public String getInOk() {
		return inOk;
	}

	public void setSa(String sa) {
		this.sa = sa;
	}

	public String getSa() {
		return sa;
	}

	public void setOrderS(String orderS) {
		this.orderS = orderS;
	}

	public String getOrderS() {
		return orderS;
	}

	public void setPIdS(String pIdS) {
		this.pIdS = pIdS;
	}

	public String getPIdS() {
		return pIdS;
	}

	public void setAccountInf(String accountInf) {
		this.accountInf = accountInf;
	}

	public String getAccountInf() {
		return accountInf;
	}

	public void setAccountNum(String accountNum) {
		this.accountNum = accountNum;
	}

	public String getAccountNum() {
		return accountNum;
	}

	public void setOtMs(String otMs) {
		this.otMs = otMs;
	}

	public String getOtMs() {
		return otMs;
	}

	public void setEnDate(String enDate) {
		this.enDate = enDate;
	}

	public String getEnDate() {
		return enDate;
	}

	public void setEnStatus(String enStatus) {
		this.enStatus = enStatus;
	}

	public String getEnStatus() {
		return enStatus;
	}

}