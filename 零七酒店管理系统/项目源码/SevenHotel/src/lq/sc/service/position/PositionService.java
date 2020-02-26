package lq.sc.service.position;

import java.util.List;


import lq.sc.pojo.Position;

/**
 * 
*   
* 项目名称：SevenHotel  
* 类名称：PositionService  
* 类描述： 职位业务层 
* 创建人：lhh  
* 创建时间：2018-11-21 下午4:59:53
* @version   
*   
 */
public interface PositionService {
	/*
	 * 查询所有职位
	 */
	public List<Position> selAllPosition();
}
