/*
 * ˵������Ӧ���ݿ��admin�Ľӿ�<br>
 * �޸����ݿ��ṹ,���޸ĸ����Լ���Ӧ��DAOImpl��
 * 
 * Datetime:Sat Mar 27 19:01:44 CST 2010
 * 
 * @author 
 * 
 */
package hk.com.biosun.model;

import java.io.Serializable;

public class Admin implements Serializable  {
	private static final long serialVersionUID = 20100316L;
	private String adminName;
	private String adminPw;

	public void setAdminName(String adminName) {
		this.adminName = adminName;
	}

	public String getAdminName() {
		return adminName;
	}

	public void setAdminPw(String adminPw) {
		this.adminPw = adminPw;
	}

	public String getAdminPw() {
		return adminPw;
	}

}