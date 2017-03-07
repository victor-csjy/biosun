/*
 * 说明：对应数据库表com_table的接口<br>
 * 修改数据库表结构,请修改该类以及相应的DAOImpl类
 * 
 * Datetime:Sat Mar 27 19:01:45 CST 2010
 * 
 * @author 
 * 
 */
package hk.com.biosun.model;

import java.io.Serializable;

public class ComTable implements Serializable  {
	private static final long serialVersionUID = 20100316L;
	private int comId;
	private int pId;
	private String comContent;
	private String needFb;
	private String statusFb;
	private String userId;
	private String comDate;
	private String pModel;
	private String pName;
	private String pPic;
	
	public void setComId(int comId) {
		this.comId = comId;
	}

	public int getComId() {
		return comId;
	}

	public void setPId(int pId) {
		this.pId = pId;
	}

	public int getPId() {
		return pId;
	}

	public void setComContent(String comContent) {
		this.comContent = comContent;
	}

	public String getComContent() {
		return comContent;
	}

	public void setNeedFb(String needFb) {
		this.needFb = needFb;
	}

	public String getNeedFb() {
		return needFb;
	}

	public void setStatusFb(String statusFb) {
		this.statusFb = statusFb;
	}

	public String getStatusFb() {
		return statusFb;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserId() {
		return userId;
	}

	public void setComDate(String comDate) {
		this.comDate = comDate;
	}

	public String getComDate() {
		return comDate;
	}

	public String getPModel() {
		return pModel;
	}

	public void setPModel(String model) {
		pModel = model;
	}

	public String getPName() {
		return pName;
	}

	public void setPName(String name) {
		pName = name;
	}

	public String getPPic() {
		return pPic;
	}

	public void setPPic(String pic) {
		pPic = pic;
	}
}