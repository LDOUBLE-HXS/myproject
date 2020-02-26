package lq.sc.dao.checkIn;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import lq.sc.pojo.CheckIn;
/**
 * 
*   
* 项目名称：SevenHotel  
* 类名称：CheckInMapper  
* 类描述：入住mapper接口  
* 创建人：lhh  
* 创建时间：2018-11-10 下午9:45:05
* @version   
*   
 */
@Service
public interface CheckInMapper {
	/*
	 * 处理订单添加入住
	 */
	public int addCheckIn(CheckIn checkIn);
	/*
	 * 通过id查询已入住的房间
	 */
	public List<CheckIn> selRoomById(int roomId);
	/*
	 * 根据id更改入住状态
	 */
	public int modifyCheckStateById(@Param("checkState")int checkState,@Param("checkId")int checkId);
	/*
	 * 根据用户id查询入住
	 */
	public List<CheckIn> selCheckInByCustomerId(@Param("customerId")int customerId,@Param("currentPageNo")int currentPageNo,@Param("pageSize")int pageSize);
	/*
	 * 根据用户id查询入住总条数
	 */
	public int selCountByCustomerId(int customerId);
	/*
	 * 根据入住id删除
	 */
	public int deleteCheckInById(int checkId);
	/*
	 * 根据订单id删除
	 */
	public int deleteCheckInByOrderId(int orderId);
	
}
