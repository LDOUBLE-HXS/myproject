package lq.sc.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import lq.sc.tools.Constants;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 * 
*   
* 项目名称：SevenHotel  
* 类名称：AdminInterceptor  
* 类描述：管理员拦截器  
* 创建人：lhh  
* 创建时间：2018-11-24 下午9:46:17
* @version   
*   
 */
public class AdminInterceptor extends  HandlerInterceptorAdapter{
    @Override
    public boolean preHandle(HttpServletRequest request,
    		HttpServletResponse response, Object handler) throws Exception {
    	if(request.getSession().getAttribute(Constants.ADMIN_SESSION)!=null){
    		return true;
    	}
    	response.sendRedirect(request.getServletContext().getContextPath()+"/admin401.jsp");
    	return false;
    }
}
