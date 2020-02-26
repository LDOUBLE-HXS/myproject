package lq.sc.pojo;
/** 
*   
* 项目名称：SevenHotel  
* 类名称：Roomtype  
* 类描述： 房间类型的实体类
* 创建人：lhh
* 创建时间：2018-10-16 上午8:08:13   
* @version   
*   
*/
public class RoomType {
	private int id; //房间类型主键id
	private String roomTypeName; //房间类型名
	private String roomImg;//房间类型的图片路径
	private String sketch;//简述房间类型
	private String describe; //房间类型简述，如可住人数，房间特点
	private double typePrice; //房价
	public String getRoomImg() {
		return roomImg;
	}
	public void setRoomImg(String roomImg) {
		this.roomImg = roomImg;
	}
	public String getSketch() {
		return sketch;
	}
	public void setSketch(String sketch) {
		this.sketch = sketch;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getRoomTypeName() {
		return roomTypeName;
	}
	public void setRoomTypeName(String roomTypeName) {
		this.roomTypeName = roomTypeName;
	}
	public String getDescribe() {
		return describe;
	}
	public void setDescribe(String describe) {
		this.describe = describe;
	}
	public double getTypePrice() {
		return typePrice;
	}
	public void setTypePrice(double typePrice) {
		this.typePrice = typePrice;
	}

}
