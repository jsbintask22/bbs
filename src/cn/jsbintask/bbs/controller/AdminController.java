package cn.jsbintask.bbs.controller;

import cn.jsbintask.bbs.service.AdminService;
import cn.jsbintask.bbs.service.TopicService;
import cn.jsbintask.bbs.service.UserService;
import cn.jsbintask.bbs.po.Admin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Controller
@RequestMapping(value = "/admin")
public class AdminController {
    private final AdminService adminService;
    private final UserService userService;
    private final TopicService topicService;

    @Autowired
    public AdminController(AdminService adminService, UserService userService, TopicService topicService) {
        this.adminService = adminService;
        this.userService = userService;
        this.topicService = topicService;
    }


    //跳转到登录界面
    @RequestMapping("/login")
    public String login() {
        return "/admin/login";
    }

    //管理员退出登录
    @RequestMapping("/cancel")
    public String cancalAdmin(HttpSession session) {
        //消除所有信息
        session.invalidate();
        return "/admin/login";
    }

    //AJax检验密码是否正确
    @RequestMapping("checkInitPwd")
    public void checkInitPwd(HttpServletResponse response, String initPwd, Integer admin_id) {
        Admin admin = adminService.findAdminByInitPwd(admin_id, initPwd);
        if (admin == null) {
            try {
                response.getWriter().write("false");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    //跳转到修改密码界面
    @RequestMapping("/changePwd")
    public String changePwd() {
        return "/admin/changPwd";
    }

    //管理员密码修改信息接收
    @RequestMapping("/changePwdInfo")
    public ModelAndView changePwdInfo(Integer admin_id, String newPwd, String initPwd, ModelAndView mv) {
        System.out.println("这是修改密码的信息： " + newPwd + " , " + initPwd);
        if (admin_id == null || newPwd == null || initPwd == null) {
            mv.addObject("message", "密码不能为空");
        } else {
            mv.addObject("message", "密码修改成功");
            adminService.updatePwd(admin_id, newPwd, initPwd);
        }
        mv.setViewName("forward:changePwd");
        return mv;
    }


    //用户信息进行展示
    @RequestMapping("/userHandlerInfo")
    public ModelAndView userHandlerInfo(ModelAndView mv) {
        //获得所有用户
        mv.addObject("userList", userService.findAllUser());
        mv.setViewName("/admin/userHandle");
        return mv;
    }

    //用户状态进行更新
    @RequestMapping("/usersStatusUpdate")
    public ModelAndView usersStatusUpdate(@RequestParam("id[]") Integer[] user_ids, @RequestParam("st") Integer st, ModelAndView mv) {
        if (user_ids == null || st == null) {
            mv.addObject("message", "操作失败，请待会重试");
            mv.setViewName("forward:userHandlerInfo");
        } else {
            userService.updateUsersStatus(st, user_ids);
            mv.addObject("message", "更新成功");
            //为0说明是从管理界面来的请求，再回到管理界面
            if (st == 0) {
                mv.setViewName("forward:userHandlerInfo");
            } else {
                //说明是从用户禁言界面来的请求
                mv.setViewName("forward:shutupedUser");
            }
        }
        return mv;
    }

    //模糊查找用户
    @RequestMapping("/findUsersByLikeName")
    public ModelAndView findUsersByLikeName(@RequestParam("keywords") String username) {
        System.out.println(username);
        ModelAndView mv = new ModelAndView();
        mv.addObject("username", username);
        //一开始默认转到某个界面
        mv.setViewName("/admin/userHandle");
        if (username == null || username.isEmpty()) {
            mv.addObject("message", "用户名不能为空");
            //为了防止报错，做了一条假数据，一旦为空，直接转发到用户主界面
            mv.setViewName("forward:userHandlerInfo");
        } else {
            mv.addObject("userList", userService.findUsersByLikeName(username));
        }
        mv.addObject("username", username);
        return mv;
    }

    //跳转到被禁言的用户的界面，并且将信息显示出来
    @RequestMapping("/shutupedUser")
    public ModelAndView shutupedUser(ModelAndView mv) {
        mv.addObject("userList", userService.findUsersByShuted());
        mv.setViewName("/admin/shutupedUser");
        return mv;
    }

    //跳转到管理帖子的界面，并且显示信息
    @RequestMapping("/allTopic")
    public ModelAndView allTopic(ModelAndView mv, String sort, String topicName) {
        System.out.println(topicName);
        if(topicName!=null&&!topicName.trim().equals("")) {
            //后台管理不再做分页，所以直接写成0开始分页
            mv.addObject("topicVOList", topicService.findAllTopic(sort, topicName, 0, 100));
        } else {
            mv.addObject("topicVOList", topicService.findAllTopic(sort, null, 0, 100));
        }
        mv.setViewName("/admin/allTopic");
        return mv;
    }

    //更新帖子的状态，置顶
    @RequestMapping("/updateTopicStatus")
    public ModelAndView updateTopicStatus(ModelAndView mv, Integer st, String type, @RequestParam("id[]") Integer[] ids, @RequestParam(required = false) String initUrl) {
        System.out.println("更新帖子的参数： " + st + " ," + type + " , " + ids[0]);
        topicService.updateTopicsStatus(type, st, ids);
        mv.addObject("message", "更新成功");
        //默认是回到删除帖子的主页面
        mv.setViewName("forward:allTopic");
        if (initUrl!=null&&initUrl.equals("deletedTopic")) {
            //回到恢复帖子的界面
            mv.setViewName("forward:deletedTopic");
        }
        return mv;
    }

    //转到已经被删除掉的帖子，并且显示信息
    @RequestMapping("/deletedTopic")
    public ModelAndView deletedTopic(ModelAndView mv, String type, String orderBy) {
        if (type == null || orderBy == null) {
            mv.addObject("topicList", topicService.findDeletedTopic(type, orderBy));
        }
        mv.setViewName("/admin/deletedTopic");
        return mv;
    }

    //接收信息，是否允许登录
    @RequestMapping("/index")
    public ModelAndView checkAdminInfo(String account, String password, HttpSession session) {
        System.out.println("进入了验证信息 " + account + "  , " + password);
        ModelAndView mv = new ModelAndView();
        Admin admin = adminService.findAdmin(account, password);
        //首先满足基本条件
        if (account != null && !account.isEmpty() && password != null && !password.isEmpty()) {
            //不为空说明帐号密码正确
            if (admin != null) {
                session.setAttribute("admin", admin);
                mv.setViewName("/admin/index");
            } else {
                mv.addObject("message", "账号或密码不正确");
                mv.setViewName("forward:login");
            }
        } else {
            mv.addObject("message", "账号或密码不能为空");
            mv.setViewName("forward:login");
        }
        return mv;
    }


}
