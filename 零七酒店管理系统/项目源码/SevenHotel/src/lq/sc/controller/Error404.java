package lq.sc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 
*   
* 项目名称：SevenHotel  
* 类名称：Error404  
* 类描述：  404报错控制
* 创建人：lhh  
* 创建时间：2018-11-24 下午11:29:19
* @version   
*   
 */
@Controller
public class Error404 {
	/*
	 * 404页面
	 */
	@RequestMapping("*")
	public String fourZeroFour(){
		return "customer_404";
	}
}
