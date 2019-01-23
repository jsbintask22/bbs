package cn.jsbintask.bbs.interceptor;

import cn.jsbintask.bbs.po.User;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//实现一个拦截器，进行用户的权限控制
public class PostTopicInter implements HandlerInterceptor{
    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        System.out.println("进入了拦截器页面");
        boolean flag = false;
        User user = (User) httpServletRequest.getSession().getAttribute("user");
        if(user!=null) {
            if(user.getStatus()==0) {
                httpServletRequest.setAttribute("message", "对不起，您已被管理员禁言，请联系管理员进行处理");
                httpServletRequest.getRequestDispatcher("/topic/all").forward(httpServletRequest, httpServletResponse);
            } else {
                flag  =  true;
            }
        } else  {
            httpServletRequest.setAttribute("message", "请先登录再进行操作");
            httpServletRequest.getRequestDispatcher("/user/userLogin").forward(httpServletRequest, httpServletResponse);
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
