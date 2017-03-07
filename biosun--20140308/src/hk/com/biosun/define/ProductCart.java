package hk.com.biosun.define;

import java.io.Serializable;

public class ProductCart implements Serializable {
	private int pId;
	private int pCount;
	public int getPId() {
		return pId;
	}
	public void setPId(int id) {
		pId = id;
	}
	public int getPCount() {
		return pCount;
	}
	public void setPCount(int count) {
		pCount = count;
	}
}
