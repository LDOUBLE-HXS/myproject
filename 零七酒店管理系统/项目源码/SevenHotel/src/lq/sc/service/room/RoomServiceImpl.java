package lq.sc.service.room;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import lq.sc.dao.room.RoomMapper;
import lq.sc.pojo.Room;

/**
 * 
*   
* 项目名称：SevenHotel  
* 类名称：RoomServiceImpl  
* 类描述：  房间服务层实现类
* 创建人：Administrator  
* 创建时间：2019-6-3 下午3:10:07
* @version   
*   
 */
@Service
public class RoomServiceImpl implements RoomService{
	@Resource
	private RoomMapper roomMapper;
	//查询房间的剩余数量
	public int selRoomCountByType(int roomTypeId) {
		return roomMapper.selRoomCountByType(roomTypeId);
	}
	//修改房间状态
	public boolean modifyRoomState(Room room) {
		if(roomMapper.modifyRoomState(room)>0){
			return true;
		}else{
			return false;
		}
	}
	//根据房型查询剩余可用房间
	public List<Room> selRoomByRoomTypeId(int roomTypeId) {
		return roomMapper.selRoomByRoomTypeId(roomTypeId);
	}
	//查询所有房间
	public List<Room> selAllRoom() {
		return roomMapper.selAllRoom();
	}
	//添加房间
	public boolean addRoom(Room room) {
		if(roomMapper.addRoom(room)>0){
			return true;
		}else{
			return false;
		}
	}
	//根据id修改房间信息
	public boolean modifyRoom_ById(Room room) {
		if(roomMapper.modifyRoom_ById(room)>0){
			return true;
		}else{
			return false;
		}
	}
	//根据id删除房间
	public boolean delRoom_ById(int roomId) {
		if(roomMapper.delRoom_ById(roomId)>0){
			return true;
		}else{
			return false;
		}
	}
	//根据id查看房间信息
	public Room selRoom_ById(int roomId) {
		return roomMapper.selRoom_ById(roomId);
	}
	//根据房型id删除房间
	public boolean delRoom_ByRoomTypeId(int roomTypeId) {
		if(roomMapper.delRoom_ByRoomTypeId(roomTypeId)>0){
			return true;
		}else{
			return false;
		}
	}
	//根据房间号查看
	public boolean selRoom_ByRoomCode(int roomCode) {
		if(roomMapper.selRoom_ByRoomCode(roomCode)>0){
			return true;
		}else{
			return false;
		}
	}
}
