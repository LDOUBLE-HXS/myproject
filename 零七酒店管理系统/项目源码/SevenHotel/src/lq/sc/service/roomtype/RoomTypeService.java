package lq.sc.service.roomtype;

import java.util.List;

import lq.sc.pojo.RoomType;

/**
 * 
*   
* 项目名称：SevenHotel  
* 类名称：RoomTypeService  
* 类描述：房间类型服务层  
* 创建人：lhh  
* 创建时间：2018-10-21 上午7:54:04
* @version   
*   
 */
public interface RoomTypeService {
	/*
	 * 查询所有房间类型
	 */
	public List<RoomType> selAllRoomType();
	/*
	 * 查询标准间
	 */
	public List<RoomType> selBZRoom();
	/*
	 * 查询豪华间
	 */
	public List<RoomType> selHHRoom();
	/*
	 * 查询其他类型房间
	 */
	public List<RoomType> selOtherRoom();
	/*
	 * 根据id查询房间类型
	 */
	public RoomType selRoomType_ById(int roomTypeId);
	/*
	 * 根据id修改房间类型
	 */
	public boolean modifyRoomType_ById(RoomType roomType);
	/*
	 * 添加房间类型
	 */
	public boolean addRoomType(RoomType roomType);
	/*
	 * 根据id删除房间类型
	 */
	public boolean delRoomType_ById(int roomTypeId);
}
