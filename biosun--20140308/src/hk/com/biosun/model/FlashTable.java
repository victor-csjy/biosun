/*
 * 说明：对应数据库表flash_table的接口<br>
 * 修改数据库表结构,请修改该类以及相应的DAOImpl类
 * 
 * Datetime:Sat Mar 27 19:01:45 CST 2010
 * 
 * @author 
 * 
 */
package hk.com.biosun.model;

import java.io.Serializable;

public class FlashTable implements Serializable  {
	private static final long serialVersionUID = 20100316L;
	private String id;
	private int flashHeight;

	public void setId(String id) {
		this.id = id;
	}

	public String getId() {
		return id;
	}

	public void setFlashHeight(int flashHeight) {
		this.flashHeight = flashHeight;
	}

	public int getFlashHeight() {
		return flashHeight;
	}

}