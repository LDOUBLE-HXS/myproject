package lq.sc.pojo;

import java.util.Date;

/** 
*   
* 项目名称：SevenHotel  
* 类名称：Storehouse  
* 类描述： 房间物品信息的实体类
* 创建人：lhh
* 创建时间：2018-10-16 上午8:08:13   
* @version   
*   
*/
public class StoreHouse {
	private int id; //物品编号
	private String storeName; //物品名称
	private int storeTypeId; //物品类别，关联仓库类型别
	private double storePriceIn; //购入价
	private double storePriceOut; //出售价
	private int stock; //库存
	private int createBy; //入库人
	private Date creationDate; //入库时间
	private int modifyBy; //修改人
	private Date modifyDate; //修改时间
	private StoreType storetype; //物品类别
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getStoreName() {
		return storeName;
	}
	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}
	public int getStoreTypeId() {
		return storeTypeId;
	}
	public void setStoreTypeId(int storeTypeId) {
		this.storeTypeId = storeTypeId;
	}
	public double getStorePriceIn() {
		return storePriceIn;
	}
	public void setStorePriceIn(double storePriceIn) {
		this.storePriceIn = storePriceIn;
	}
	public double getStorePriceOut() {
		return storePriceOut;
	}
	public void setStorePriceOut(double storePriceOut) {
		this.storePriceOut = storePriceOut;
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	public int getCreateBy() {
		return createBy;
	}
	public void setCreateBy(int createBy) {
		this.createBy = createBy;
	}
	public Date getCreationDate() {
		return creationDate;
	}
	public void setCreationDate(Date creationDate) {
		this.creationDate = creationDate;
	}
	public int getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(int modifyBy) {
		this.modifyBy = modifyBy;
	}
	public Date getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}
	public StoreType getStoretype() {
		return storetype;
	}
	public void setStoretype(StoreType storetype) {
		this.storetype = storetype;
	}

}
