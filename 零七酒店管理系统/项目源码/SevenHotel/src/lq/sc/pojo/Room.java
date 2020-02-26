package lq.sc.pojo;
/** 
*   
* 项目名称：SevenHotel  
* 类名称：Room  
* 类描述： 房间信息的实体类
* 创建人：lhh
* 创建时间：2018-10-16 上午8:08:13   
* @version   
*   
*/
public class Room {
	private int id; //房间主键id
	private String roomCode; //客房编号
	private String roomFloor; //客房楼层
	private int roomState; //客房状态(0:维修。1:可用)
	private int roomTypeId; //关联客房种类id
	private RoomType roomtype; //客房类型
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getRoomCode() {
		return roomCode;
	}
	public void setRoomCode(String roomCode) {
		this.roomCode = roomCode;
	}
	public String getRoomFloor() {
		return roomFloor;
	}
	public void setRoomFloor(String roomFloor) {
		this.roomFloor = roomFloor;
	}
	public int getRoomState() {
		return roomState;
	}
	public void setRoomState(int roomState) {
		this.roomState = roomState;
	}
	public int getRoomTypeId() {
		return roomTypeId;
	}
	public void setRoomTypeId(int roomTypeId) {
		this.roomTypeId = roomTypeId;
	}
	public RoomType getRoomtype() {
		return roomtype;
	}
	public void setRoomtype(RoomType roomtype) {
		this.roomtype = roomtype;
	}
}
