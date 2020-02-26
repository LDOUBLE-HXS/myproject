package lq.sc.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import lq.sc.tools.Constants;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 * 
*   
* 项目名称：SevenHotel  
* 类名称：UserInterceptor  
* 类描述：用户拦截器  
* 创建人：lhh  
* 创建时间：2018-11-24 下午9:46:17
* @version   
*   
 */
public class UserInterceptor extends  HandlerInterceptorAdapter{
    @Override
    public boolean preHandle(HttpServletRequest request,
    		HttpServletResponse response, Object handler) throws Exception {
    	if(request.getSession().getAttribute(Constants.USER_SESSION)!=null){
    		return true;
    	}
    	response.sendRedirect(request.getServletContext().getContextPath()+"/user401.jsp");
    	return false;
    }
}
