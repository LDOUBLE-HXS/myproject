package lq.sc.dao.room;

import java.util.List;

import lq.sc.pojo.Room;

import org.springframework.stereotype.Service;

/**
 * 
*   
* 项目名称：SevenHotel  
* 类名称：RoomMapper  
* 类描述：房间接口  
* 创建人：lhh  
* 创建时间：2018-11-3 下午3:05:07
* @version   
*   
 */
@Service
public interface RoomMapper {
	/*
	 * 查询房间的剩余数量
	 */
	public int selRoomCountByType(int roomTypeId);
	/*
	 * 修改房间状态
	 */
	public int modifyRoomState(Room room);
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
	public int addRoom(Room room);
	/*
	 * 根据id修改房间信息
	 */
	public int modifyRoom_ById(Room room);
	/*
	 * 根据id删除房间
	 */
	public int delRoom_ById(int roomId);
	/*
	 * 根据房型id删除房间
	 */
	public int delRoom_ByRoomTypeId(int roomTypeId);
	/*
	 * 根据房间号查询
	 */
	public int selRoom_ByRoomCode(int roomCode);
}
