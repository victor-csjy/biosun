/*
 * 说明：对应数据库表buy_car的接口<br>
 * 修改数据库表结构,请修改该类以及相应的DAOImpl类
 * 
 * Datetime:Sat Mar 27 19:01:45 CST 2010
 * 
 * @author 
 * 
 */
package hk.com.biosun.model;

import java.io.Serializable;

/**
 * @author qinyongcai
 * @version 1.0.0.0
 * @datetime Mar 29, 2010
 * 
 */
public class BuyCar implements Serializable {
	private static final long serialVersionUID = 20100316L;
	private String enId;
	private int pId;
	private int pCount;
	private String userId;
	private String pModel;
	private String pPic;
	private String pName;

	public void setEnId(String enId) {
		this.enId = enId;
	}

	public String getEnId() {
		return enId;
	}

	public void setPId(int pId) {
		this.pId = pId;
	}

	public int getPId() {
		return pId;
	}

	public void setPCount(int pCount) {
		this.pCount = pCount;
	}

	public int getPCount() {
		return pCount;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getPModel() {
		return pModel;
	}

	public void setPModel(String model) {
		pModel = model;
	}

	public String getPPic() {
		return pPic;
	}

	public void setPPic(String pic) {
		pPic = pic;
	}

	public String getPName() {
		return pName;
	}

	public void setPName(String name) {
		pName = name;
	}

}