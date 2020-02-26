package lq.sc.service.checkIn;

import java.util.List;

import javax.annotation.Resource;

import lq.sc.dao.checkIn.CheckInMapper;
import lq.sc.pojo.CheckIn;

import org.springframework.stereotype.Service;

/**
 * 
*   
* 项目名称：SevenHotel  
* 类名称：CheckInServiceImpl  
* 类描述：入住业务实现层  
* 创建人：Administrator  
* 创建时间：2019-6-10 下午9:46:26
* @version   
*   
 */
@Service
public class CheckInServiceImpl implements CheckInService{
	@Resource
	private CheckInMapper checkInMapper;
	//处理订单添加入住
	public boolean addCheckIn(CheckIn checkIn) {
		if(checkInMapper.addCheckIn(checkIn)>0){
			return true;
		}else{
			return false;
		}
	}
	//通过id查询已入住的房间
	public List<CheckIn> selRoomById(int roomId) {
		return checkInMapper.selRoomById(roomId);
	}
	//根据id更改入住状态
	public boolean modifyCheckStateById(int checkState,int checkId) {
		if(checkInMapper.modifyCheckStateById(checkState, checkId)>0){
			return true;
		}else{
			return false;
		}
	}
	//根据用户id查询入住
	public List<CheckIn> selCheckInByCustomerId(int customerId,int currentPageNo,int pageSize) {
		return checkInMapper.selCheckInByCustomerId(customerId, currentPageNo, pageSize);
	}
	//根据入住id删除
	public boolean deleteCheckInById(int checkId) {
		if(checkInMapper.deleteCheckInById(checkId)>0){
			return true;
		}else{
			return false;
		}
	}
	//根据用户id查询入住总条数
	public int selCountByCustomerId(int customerId) {
		return checkInMapper.selCountByCustomerId(customerId);
	}
	public boolean deleteCheckInByOrderId(int orderId) {
		if(checkInMapper.deleteCheckInByOrderId(orderId)>0){
			return true;
		}else{
			return false;
		}
	}
}
