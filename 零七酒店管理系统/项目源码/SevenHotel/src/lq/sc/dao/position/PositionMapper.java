package lq.sc.dao.position;

import java.util.List;

import lq.sc.pojo.Position;

import org.springframework.stereotype.Service;

/**
 * 
*   
* 项目名称：SevenHotel  
* 类名称：PositionMapper  
* 类描述：  职位接口
* 创建人：lhh  
* 创建时间：2018-11-21 下午4:58:54
* @version   
*   
 */
@Service
public interface PositionMapper {
	/*
	 * 查询所有职位
	 */
	public List<Position> selAllPosition();
}
