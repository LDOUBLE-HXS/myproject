package lq.sc.service.checkIn;

import java.util.List;

import lq.sc.pojo.CheckIn;

/**
 * 
*   
* 项目名称：SevenHotel  
* 类名称：CheckInService  
* 类描述： 入住业务层 
* 创建人：lhh  
* 创建时间：2018-11-10 下午9:45:54
* @version   
*   
 */
public interface CheckInService {
	/*
	 * 处理订单添加入住
	 */
	public boolean addCheckIn(CheckIn checkIn);
	/*
	 * 通过id查询已入住的房间
	 */
	public List<CheckIn> selRoomById(int roomId);
	/*
	 * 根据id更改入住状态
	 */
	public boolean modifyCheckStateById(int checkState,int checkId);
	/*
	 * 根据用户id分页查询入住
	 */
	public List<CheckIn> selCheckInByCustomerId(int customerId,int currentPageNo,int pageSize);
	/*
	 * 根据用户id查询入住总条数
	 */
	public int selCountByCustomerId(int customerId);
	/*
	 * 根据入住id删除
	 */
	public boolean deleteCheckInById(int checkId);
	/*
	 * 根据订单id删除
	 */
	public boolean deleteCheckInByOrderId(int orderId);
}
