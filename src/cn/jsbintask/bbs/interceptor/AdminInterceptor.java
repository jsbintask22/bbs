package cn.jsbintask.bbs.interceptor;

import cn.jsbintask.bbs.po.Admin;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by Administrator on 2017/6/12.
 */
//实现一个拦截器，进行用户的权限控制
public class AdminInterceptor implements HandlerInterceptor{
    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        System.out.println("进入了管理员拦截器页面");
        boolean flag = false;
        Admin admin= (Admin) httpServletRequest.getSession().getAttribute("admin");
        if(admin!=null) {
            flag = true;
        } else  {
            httpServletRequest.setAttribute("message", "请先登录再操作");
            httpServletRequest.getRequestDispatcher("/admin/login").forward(httpServletRequest, httpServletResponse);
        }
        return flag;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
