package lq.sc.dao.manager;

import java.util.List;
import java.util.Map;

import lq.sc.pojo.Manager;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

/**
 * 
*   
* 项目名称：SevenHotel  
* 类名称：ManagerMapper  
* 类描述：管理接口  
* 创建人：lhh  
* 创建时间：2018-10-27 下午6:29:47
* @version   
*   
 */
@Service
public interface ManagerMapper {
	/*
	 * ajax验证管理员是否存在
	 */
	public Manager manCodeExist(@Param("manCode")String manCode);
	/*
	 * 管理员登陆
	 */
	public Manager login(@Param("manCode")String manCode,@Param("manPassword")String manPassword);
	/*
	 * 根据id查询管理员
	 */
	public Manager selManageById(int id);
	/*
	 * 通过员工状态查询所有员工
	 */
	public List<Manager> selManagerByState(Map<String,Object> map)throws Exception;;
	/*
	 * 添加管理员
	 */
	public int addManager(Manager manager);
	/*
	 * 根据id修改管理员
	 */
	public int modifyManager_ById(Manager manager);
	/*
	 * 根据id删除管理员
	 */
	public int deleteManager_ById(int managerId);
}
