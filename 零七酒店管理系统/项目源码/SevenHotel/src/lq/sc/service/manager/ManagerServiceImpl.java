package lq.sc.service.manager;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import lq.sc.dao.manager.ManagerMapper;
import lq.sc.pojo.Manager;

import org.springframework.stereotype.Service;

/**
 * 
*   
* 项目名称：SevenHotel  
* 类名称：ManagerServiceImpl  
* 类描述：  管理员业务实现层
* 创建人：lhh  
* 创建时间：2019-5-27 下午6:34:37
* @version   
*   
 */
@Service
public class ManagerServiceImpl implements ManagerService{
	@Resource
	private ManagerMapper managerMapper;
	//查询用户
	public Manager manCodeExist(String manCode) {
		return managerMapper.manCodeExist(manCode);
	}
	//管理员登陆
	public Manager login(String manCode, String manPassword) {
		return managerMapper.login(manCode, manPassword);
	}
	//根据id查询管理员
	public Manager selManageById(int id) {
		return managerMapper.selManageById(id);
	}
	//通过员工状态查询所有员工
	public List<Manager> selManagerByState(int manState) throws Exception{
		Map<String,Object> map=new HashMap<String, Object>();	
		map.put("manState", manState);
		List<Manager> managerList = managerMapper.selManagerByState(map);
		return managerList;
	}
	//添加管理员
	public boolean addManager(Manager manager) {
		if(managerMapper.addManager(manager)>0){
			return true;
		}else{
			return false;
		}
	}
	//根据id修改管理员
	public boolean modifyManager_ById(Manager manager) {
		if(managerMapper.modifyManager_ById(manager)>0){
			return true;
		}else{
			return false;
		}
	}
	//根据id删除管理员
	public boolean deleteManager_ById(int managerId) {
		if(managerMapper.deleteManager_ById(managerId)>0){
			return true;
		}else{
			return false;
		}
	}
}
