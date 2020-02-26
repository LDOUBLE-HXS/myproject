package lq.sc.service.position;

import java.util.List;

import javax.annotation.Resource;

import lq.sc.dao.position.PositionMapper;
import lq.sc.pojo.Position;

import org.springframework.stereotype.Service;

/**
 * 
*   
* 项目名称：SevenHotel  
* 类名称：PositionServiceImpl  
* 类描述：  职位业务实现层
* 创建人：lhh  
* 创建时间：2019-6-21 下午5:00:05
* @version   
*   
 */
@Service
public class PositionServiceImpl implements PositionService{
	@Resource
	private PositionMapper positionMapper;

	//查询所有职位
	public List<Position> selAllPosition() {
		return positionMapper.selAllPosition();
	}
	
}
