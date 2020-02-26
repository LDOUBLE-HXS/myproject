package lq.sc.service.roomtype;

import java.util.List;

import javax.annotation.Resource;

import lq.sc.dao.roomtype.RoomTypeMapper;
import lq.sc.pojo.RoomType;

import org.springframework.stereotype.Service;

/**
 * 
*   
* 项目名称：SevenHotel  
* 类名称：RoomTypeServiceImpl  
* 类描述：房间类型服务层实现类  
* 创建人：Administrator  
* 创建时间：2019-5-21 上午7:55:07
* @version   
*   
 */
@Service
public class RoomTypeServiceImpl implements RoomTypeService{
	@Resource
	private RoomTypeMapper roomTypeMapper;
	//查询所有房间
	public List<RoomType> selAllRoomType() {
		return roomTypeMapper.selAllRoomType();
	}

	//查询标准间
	public List<RoomType> selBZRoom() {
		return roomTypeMapper.selBZRoom();
	}

	//查询豪华间
	public List<RoomType> selHHRoom() {
		return roomTypeMapper.selHHRoom();
	}

	//查询其他类型房间
	public List<RoomType> selOtherRoom() {
		return roomTypeMapper.selOtherRoom();
	}

	//通过id查询房间类型
	public RoomType selRoomType_ById(int roomTypeId) {
		return roomTypeMapper.selRoomType_ById(roomTypeId);
	}

	//根据id修改房间类型
	public boolean modifyRoomType_ById(RoomType roomType) {
		if(roomTypeMapper.modifyRoomType_ById(roomType)>0){
			return true;
		}else{
			return false;
		}
	}

	//添加房间类型
	public boolean addRoomType(RoomType roomType) {
		if(roomTypeMapper.addRoomType(roomType)>0){
			return true;
		}else{
			return false;
		}
	}

	//根据id删除房间类型
	public boolean delRoomType_ById(int roomTypeId) {
		if(roomTypeMapper.delRoomType_ById(roomTypeId)>0){
			return true;
		}else{
			return false;
		}
	}
	
}
