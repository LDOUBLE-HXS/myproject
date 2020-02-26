package lq.sc.service.room;

import java.util.List;

import lq.sc.pojo.Room;


/**
 * 
*   
* 项目名称：SevenHotel  
* 类名称：RoomService  
* 类描述：  房间服务层
* 创建人：lhh  
* 创建时间：2018-11-3 下午3:09:39
* @version   
*   
 */
public interface RoomService {
	/*
	 * 查询房间的剩余数量
	 */
	public int selRoomCountByType(int roomTypeId);
	/*
	 * 修改房间状态
	 */
	public boolean modifyRoomState(Room room);
	/*
	 * 根据房型查询剩余可用房间
	 */
	public List<Room> selRoomByRoomTypeId(int roomTypeId); 
	/*
	 * 查询所有房间
	 */
	public List<Room> selAllRoom();
	/*
	 * 根据id查看房间信息
	 */
	public Room selRoom_ById(int roomId);
	/*
	 * 添加房间
	 */
	public boolean addRoom(Room room);
	/*
	 * 根据id修改房间信息
	 */
	public boolean modifyRoom_ById(Room room);
	/*
	 * 根据id删除房间
	 */
	public boolean delRoom_ById(int roomId);
	/*
	 * 根据房型id删除房间
	 */
	public boolean delRoom_ByRoomTypeId(int roomTypeId);
	/*
	 * 根据房间号查询
	 */
	public boolean selRoom_ByRoomCode(int roomCode);
}
