/*
 * ˵������Ӧ���ݿ��admin_log�Ľӿ�<br>
 * �޸����ݿ��ṹ,���޸ĸ����Լ���Ӧ��DAOImpl��
 * 
 * Datetime:Sat Mar 27 19:01:45 CST 2010
 * 
 * @author 
 * 
 */
package hk.com.biosun.model;

import java.io.Serializable;

public class AdminLog implements Serializable  {
	private static final long serialVersionUID = 20100316L;
	private long id;
	private String loginIp;
	private String loginStatus;
	private String loginDate;

	public void setId(long id) {
		this.id = id;
	}

	public long getId() {
		return id;
	}

	public void setLoginIp(String loginIp) {
		this.loginIp = loginIp;
	}

	public String getLoginIp() {
		return loginIp;
	}

	public void setLoginStatus(String loginStatus) {
		this.loginStatus = loginStatus;
	}

	public String getLoginStatus() {
		return loginStatus;
	}

	public void setLoginDate(String loginDate) {
		this.loginDate = loginDate;
	}

	public String getLoginDate() {
		return loginDate;
	}

}