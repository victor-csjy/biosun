/*
 * 说明：对应数据库表user_inf的接口<br>
 * 修改数据库表结构,请修改该类以及相应的DAOImpl类
 * 
 * Datetime:Sat Mar 27 19:01:46 CST 2010
 * 
 * @author 
 * 
 */
package hk.com.biosun.model;

import java.io.Serializable;

public class UserInf implements Serializable  {
	private static final long serialVersionUID = 20100316L;
	private String id;
	private String password;
	private String question;
	private String answer;
	private String send;
	private String sex;
	private String person;
	private String jobTitle;
	private String company;
	private String countryCode;
	private String areaCode;
	private String tel;
	private String fCcode;
	private String fAcode;
	private String fax;
	private String email;
	private String ms;
	private String website;
	private String mailingAddress;
	private String aCity;
	private String aState;
	private String aZip;
	private String aCountry;
	private String di;
	private String ma;
	private String en;
	private String im1;
	private String im2;
	private String re;
	private String bu;
	private String br;
	private String pr;
	private String ot;
	private String invoice;
	private String otherMs;
	private String idGrage;
	private int enTimes;
	private int tradeTimes;
	private int loginTimes;
	private int usercomTimes;
	private String regDate;
	private String loginLog;

	public void setId(String id) {
		this.id = id;
	}

	public String getId() {
		return id;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPassword() {
		return password;
	}

	public void setQuestion(String question) {
		this.question = question;
	}

	public String getQuestion() {
		return question;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public String getAnswer() {
		return answer;
	}

	public void setSend(String send) {
		this.send = send;
	}

	public String getSend() {
		return send;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getSex() {
		return sex;
	}

	public void setPerson(String person) {
		this.person = person;
	}

	public String getPerson() {
		return person;
	}

	public void setJobTitle(String jobTitle) {
		this.jobTitle = jobTitle;
	}

	public String getJobTitle() {
		return jobTitle;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getCompany() {
		return company;
	}

	public void setCountryCode(String countryCode) {
		this.countryCode = countryCode;
	}

	public String getCountryCode() {
		return countryCode;
	}

	public void setAreaCode(String areaCode) {
		this.areaCode = areaCode;
	}

	public String getAreaCode() {
		return areaCode;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getTel() {
		return tel;
	}

	public void setFCcode(String fCcode) {
		this.fCcode = fCcode;
	}

	public String getFCcode() {
		return fCcode;
	}

	public void setFAcode(String fAcode) {
		this.fAcode = fAcode;
	}

	public String getFAcode() {
		return fAcode;
	}

	public void setFax(String fax) {
		this.fax = fax;
	}

	public String getFax() {
		return fax;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getEmail() {
		return email;
	}

	public void setMs(String ms) {
		this.ms = ms;
	}

	public String getMs() {
		return ms;
	}

	public void setWebsite(String website) {
		this.website = website;
	}

	public String getWebsite() {
		return website;
	}

	public void setMailingAddress(String mailingAddress) {
		this.mailingAddress = mailingAddress;
	}

	public String getMailingAddress() {
		return mailingAddress;
	}

	public void setACity(String aCity) {
		this.aCity = aCity;
	}

	public String getACity() {
		return aCity;
	}

	public void setAState(String aState) {
		this.aState = aState;
	}

	public String getAState() {
		return aState;
	}

	public void setAZip(String aZip) {
		this.aZip = aZip;
	}

	public String getAZip() {
		return aZip;
	}

	public void setACountry(String aCountry) {
		this.aCountry = aCountry;
	}

	public String getACountry() {
		return aCountry;
	}

	public void setDi(String di) {
		this.di = di;
	}

	public String getDi() {
		return di;
	}

	public void setMa(String ma) {
		this.ma = ma;
	}

	public String getMa() {
		return ma;
	}

	public void setEn(String en) {
		this.en = en;
	}

	public String getEn() {
		return en;
	}

	public void setIm1(String im1) {
		this.im1 = im1;
	}

	public String getIm1() {
		return im1;
	}

	public void setIm2(String im2) {
		this.im2 = im2;
	}

	public String getIm2() {
		return im2;
	}

	public void setRe(String re) {
		this.re = re;
	}

	public String getRe() {
		return re;
	}

	public void setBu(String bu) {
		this.bu = bu;
	}

	public String getBu() {
		return bu;
	}

	public void setBr(String br) {
		this.br = br;
	}

	public String getBr() {
		return br;
	}

	public void setPr(String pr) {
		this.pr = pr;
	}

	public String getPr() {
		return pr;
	}

	public void setOt(String ot) {
		this.ot = ot;
	}

	public String getOt() {
		return ot;
	}

	public void setInvoice(String invoice) {
		this.invoice = invoice;
	}

	public String getInvoice() {
		return invoice;
	}

	public void setOtherMs(String otherMs) {
		this.otherMs = otherMs;
	}

	public String getOtherMs() {
		return otherMs;
	}

	public void setIdGrage(String idGrage) {
		this.idGrage = idGrage;
	}

	public String getIdGrage() {
		return idGrage;
	}

	public void setEnTimes(int enTimes) {
		this.enTimes = enTimes;
	}

	public int getEnTimes() {
		return enTimes;
	}

	public void setTradeTimes(int tradeTimes) {
		this.tradeTimes = tradeTimes;
	}

	public int getTradeTimes() {
		return tradeTimes;
	}

	public void setLoginTimes(int loginTimes) {
		this.loginTimes = loginTimes;
	}

	public int getLoginTimes() {
		return loginTimes;
	}

	public void setUsercomTimes(int usercomTimes) {
		this.usercomTimes = usercomTimes;
	}

	public int getUsercomTimes() {
		return usercomTimes;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setLoginLog(String loginLog) {
		this.loginLog = loginLog;
	}

	public String getLoginLog() {
		return loginLog;
	}

}