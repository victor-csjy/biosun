/*
 * 说明：对应数据库表mail_table的接口<br>
 * 修改数据库表结构,请修改该类以及相应的DAOImpl类
 * 
 * Datetime:Sat Mar 27 19:01:45 CST 2010
 * 
 * @author 
 * 
 */
package hk.com.biosun.model;

import java.io.Serializable;

public class MailTable implements Serializable  {
	private static final long serialVersionUID = 20100316L;
	private String mailService;
	private String mailAddress;
	private String mailUser;
	private String mailId;
	private String website;
	private String mailPw;
	private String mailPrefix;
	private String mailSuffix;

	public void setMailService(String mailService) {
		this.mailService = mailService;
	}

	public String getMailService() {
		return mailService;
	}

	public void setMailAddress(String mailAddress) {
		this.mailAddress = mailAddress;
	}

	public String getMailAddress() {
		return mailAddress;
	}

	public void setMailUser(String mailUser) {
		this.mailUser = mailUser;
	}

	public String getMailUser() {
		return mailUser;
	}

	public void setMailId(String mailId) {
		this.mailId = mailId;
	}

	public String getMailId() {
		return mailId;
	}

	public void setWebsite(String website) {
		this.website = website;
	}

	public String getWebsite() {
		return website;
	}

	public void setMailPw(String mailPw) {
		this.mailPw = mailPw;
	}

	public String getMailPw() {
		return mailPw;
	}

	public void setMailPrefix(String mailPrefix) {
		this.mailPrefix = mailPrefix;
	}

	public String getMailPrefix() {
		return mailPrefix;
	}

	public void setMailSuffix(String mailSuffix) {
		this.mailSuffix = mailSuffix;
	}

	public String getMailSuffix() {
		return mailSuffix;
	}

}