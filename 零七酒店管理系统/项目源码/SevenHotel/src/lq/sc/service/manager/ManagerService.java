package lq.sc.service.manager;


import java.util.List;

import lq.sc.pojo.Manager;


/**
 * 
*   
* 项目名称：SevenHotel  
* 类名称：ManagerService  
* 类描述： 管理员业务层
* 创建人：lhh  
* 创建时间：2018-10-27 下午6:34:21
* @version   
*   
 */
public interface ManagerService {
	/*
	 * ajax验证管理员是否存在
	 */
	public Manager manCodeExist(String manCode);
	/*
	 * 管理员登陆
	 */
	public Manager login(String manCode,String manPassword);
	/*
	 * 根据id查询管理员
	 */
	public Manager selManageById(int id);
	/*
	 * 通过员工状态查询所有员工
	 */
	public List<Manager> selManagerByState(int manState)throws Exception;
	/*
	 * 添加管理员
	 */
	public boolean addManager(Manager manager);
	/*
	 * 根据id修改管理员
	 */
	public boolean modifyManager_ById(Manager manager);
	/*
	 * 根据id删除管理员
	 */
	public boolean deleteManager_ById(int managerId);
}
