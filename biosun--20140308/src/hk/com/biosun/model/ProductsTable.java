/*
 * 说明：对应数据库表products_table的接口<br>
 * 修改数据库表结构,请修改该类以及相应的DAOImpl类
 * 
 * Datetime:Sat Mar 27 19:01:46 CST 2010
 * 
 * @author 
 * 
 */
package hk.com.biosun.model;

import java.io.Serializable;

public class ProductsTable implements Serializable  {
	private static final long serialVersionUID = 20100316L;
	private int pId;
	private String pModel;
	private String pName;
	private int bigId;
	private int smallId;
	private String smallStrong;
	private String detail1;
	private String detail2;
	private String app;
	private String sc;
	private String oc;
	private String sp;
	private String ec1Word;
	private String ec1;
	private String ec2Word;
	private String ec2;
	private float publicPrice;
	private float bsPrice;
	private String supplyModel;
	private String modelName;
	private float bsCgPrice;
	private String pPic;
	private String keyWord;
	private String orderId;
	private String other;
	private int browse;
	private int askTimes;
	private int comTimes;
	private String isShow;
	private int supplyId;
	private String indexOrder;
	private String pDate;

	public void setPId(int pId) {
		this.pId = pId;
	}

	public int getPId() {
		return pId;
	}

	public void setPModel(String pModel) {
		this.pModel = pModel;
	}

	public String getPModel() {
		return pModel;
	}

	public void setPName(String pName) {
		this.pName = pName;
	}

	public String getPName() {
		return pName;
	}

	public void setBigId(int bigId) {
		this.bigId = bigId;
	}

	public int getBigId() {
		return bigId;
	}

	public void setSmallId(int smallId) {
		this.smallId = smallId;
	}

	public int getSmallId() {
		return smallId;
	}

	public void setSmallStrong(String smallStrong) {
		this.smallStrong = smallStrong;
	}

	public String getSmallStrong() {
		return smallStrong;
	}

	public void setDetail1(String detail1) {
		this.detail1 = detail1;
	}

	public String getDetail1() {
		return detail1;
	}

	public void setDetail2(String detail2) {
		this.detail2 = detail2;
	}

	public String getDetail2() {
		return detail2;
	}

	public void setApp(String app) {
		this.app = app;
	}

	public String getApp() {
		return app;
	}

	public void setSc(String sc) {
		this.sc = sc;
	}

	public String getSc() {
		return sc;
	}

	public void setOc(String oc) {
		this.oc = oc;
	}

	public String getOc() {
		return oc;
	}

	public void setSp(String sp) {
		this.sp = sp;
	}

	public String getSp() {
		return sp;
	}

	public void setEc1Word(String ec1Word) {
		this.ec1Word = ec1Word;
	}

	public String getEc1Word() {
		return ec1Word;
	}

	public void setEc1(String ec1) {
		this.ec1 = ec1;
	}

	public String getEc1() {
		return ec1;
	}

	public void setEc2Word(String ec2Word) {
		this.ec2Word = ec2Word;
	}

	public String getEc2Word() {
		return ec2Word;
	}

	public void setEc2(String ec2) {
		this.ec2 = ec2;
	}

	public String getEc2() {
		return ec2;
	}

	public void setPublicPrice(float publicPrice) {
		this.publicPrice = publicPrice;
	}

	public float getPublicPrice() {
		return publicPrice;
	}

	public void setBsPrice(float bsPrice) {
		this.bsPrice = bsPrice;
	}

	public float getBsPrice() {
		return bsPrice;
	}

	public void setSupplyModel(String supplyModel) {
		this.supplyModel = supplyModel;
	}

	public String getSupplyModel() {
		return supplyModel;
	}

	public void setModelName(String modelName) {
		this.modelName = modelName;
	}

	public String getModelName() {
		return modelName;
	}

	public void setBsCgPrice(float bsCgPrice) {
		this.bsCgPrice = bsCgPrice;
	}

	public float getBsCgPrice() {
		return bsCgPrice;
	}

	public void setPPic(String pPic) {
		this.pPic = pPic;
	}

	public String getPPic() {
		return pPic;
	}

	public void setKeyWord(String keyWord) {
		this.keyWord = keyWord;
	}

	public String getKeyWord() {
		return keyWord;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOther(String other) {
		this.other = other;
	}

	public String getOther() {
		return other;
	}

	public void setBrowse(int browse) {
		this.browse = browse;
	}

	public int getBrowse() {
		return browse;
	}

	public void setAskTimes(int askTimes) {
		this.askTimes = askTimes;
	}

	public int getAskTimes() {
		return askTimes;
	}

	public void setComTimes(int comTimes) {
		this.comTimes = comTimes;
	}

	public int getComTimes() {
		return comTimes;
	}

	public void setIsShow(String isShow) {
		this.isShow = isShow;
	}

	public String getIsShow() {
		return isShow;
	}

	public void setSupplyId(int supplyId) {
		this.supplyId = supplyId;
	}

	public int getSupplyId() {
		return supplyId;
	}

	public void setIndexOrder(String indexOrder) {
		this.indexOrder = indexOrder;
	}

	public String getIndexOrder() {
		return indexOrder;
	}

	public void setPDate(String pDate) {
		this.pDate = pDate;
	}

	public String getPDate() {
		return pDate;
	}

}