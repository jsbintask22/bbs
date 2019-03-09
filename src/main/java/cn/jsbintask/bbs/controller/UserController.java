package cn.jsbintask.bbs.controller;


import cn.jsbintask.bbs.po.User;
import cn.jsbintask.bbs.service.AttentionService;
import cn.jsbintask.bbs.service.CollectService;
import cn.jsbintask.bbs.service.TopicService;
import cn.jsbintask.bbs.service.UserService;
import cn.jsbintask.bbs.utils.EmailUtil;
import cn.jsbintask.bbs.utils.PageUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;

@Controller
@RequestMapping(value = "/user")
public class UserController {
    private final UserService userService;
    private final TopicService topicService;
    private final CollectService collectService;
    private final AttentionService attentionService;

    @Autowired
    public UserController(UserService userService, TopicService topicService, CollectService collectService, AttentionService attentionService) {
        this.userService = userService;
        this.topicService = topicService;
        this.collectService = collectService;
        this.attentionService = attentionService;
    }

    //转到用户信息页面，并且将基本信息显示出来
    @RequestMapping("/{user_id}")
    public String mySpace(@PathVariable(value = "user_id") Integer user_id) {
        return "/myInfo/mySpace";
    }

    //转到自己的用户信息主页面
    @RequestMapping("/myInfo")
    public String myInfo() {
        return "/myInfo/myInfo";
    }

    //用户注销
    @RequestMapping("/userCancel")
    public ModelAndView userCancel(ModelAndView mv, HttpSession session) {
        session.invalidate();
        //注销用户后，重定向回到主界面
        mv.setViewName("forward:/topic/all");
        mv.addObject("message", "注销成功，请重新登录！");
        return mv;
    }

    //用户设置别人禁止访问自己的空间,因为用户信息是从session中取出来的，所以要将session信息更新才行
    @RequestMapping("setIsLock")
    public ModelAndView setIsLock(ModelAndView mv, Integer user_id, Integer isLock, HttpSession session) {
        userService.updateIsLockById(user_id, isLock);
        //再回到自己的空间
        mv.setViewName("forward:" + user_id);
        session.setAttribute("user", userService.findUserById(user_id));
        if (isLock == 1) {
            mv.addObject("message", "禁止访问设置成功");
        } else {
            mv.addObject("message", "已设置为允许别人访问");
        }
        return mv;
    }

    // 根据传进来的条件查找用户，只能使用post的方式
    @RequestMapping(value = "/showTopics", method = {RequestMethod.POST})
    public ModelAndView findUserByNameAndPwd(String userName, String password, Integer flag, HttpSession session, HttpServletRequest request) {
        ModelAndView mv = new ModelAndView();
        String pageSizeStr = request.getServletContext().getInitParameter("pageSize");
        Integer pageSize = Integer.parseInt(pageSizeStr);
        //一个分页bean
        PageUtil pageUtil = new PageUtil(topicService.findTopicTotal(), pageSize, 1);
        mv.addObject("pageUtil", pageUtil);
        // 首先为传进来的条件判断
        if (userName == null || userName.equals("") || password == null || "".equals(password)) {
            mv.addObject("message", "用户名或密码为空");
            //判断这些登录信息是从哪来的，1表示首页，其他表示登录页面
            if (flag == 2) {
                mv.setViewName("forward:userLogin");
            } else {
                //因为是从登录界面登录的，所以分也开始位置为0就可以了
                mv.addObject("topics", topicService.findAllTopic(null, null, 0, pageSize));
                mv.setViewName("/article/showTopics");
            }
        } else {
            // 符合基本条件了在去查找是否能查找出用户
            User user = userService.findUserByNameAndPwd(userName, password);
            if (user == null) {
                if (flag == 2) {
                    mv.setViewName("forward:userLogin");
                } else {
                    mv.addObject("topics", topicService.findAllTopic(null, null, 0, pageSize));
                    mv.setViewName("/article/showTopics");
                }
                mv.addObject("message", "用户名或密码错误！");
            } else {
                //登陆成功了，将user信息添加到session域里面
                session.setAttribute("user", user);
                //默认填充到request域，如果不是转发过去的，就填充到参数信息
                mv.addObject("topics", topicService.findAllTopic(null, null, 0, pageSize));
                mv.setViewName("/article/showTopics");
            }
        }
        return mv;
    }

    //转到用户更改密码的界面
    @RequestMapping("/changePwd")
    public String changePwd() {
        return "/myInfo/changePwd";
    }

    //更新用户的密码
    @RequestMapping("/changePwdInfo")
    public ModelAndView changePwdInfo(String password, Integer user_id) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("message", "更改密码成功");
        if (password == null || user_id == null) {
            mv.addObject("message", "新密码不能为空");
        } else {
            userService.updatePwdByUser_id(password, user_id);
        }
        mv.setViewName("forward:changePwd");
        return mv;
    }

    //ajax请求用户初始密码是否正确
    @RequestMapping("/checkInitPwd")
    public void checkInitPwd(HttpServletResponse response, String initPwd, Integer user_id) throws IOException {
        User user = userService.checkInitPwd(initPwd, user_id);
        if (user == null) {
            response.getWriter().write("false");
        }
    }

    //根据用户id得到该用户的所有的帖子，并且展示
    @RequestMapping("/myArticles")
    public ModelAndView myArticles(ModelAndView mv, Integer user_id) {
        mv.addObject("topicList", topicService.findTopicByUserId(user_id));
        mv.setViewName("/myInfo/myArticles");
        return mv;
    }

    //用户自己进行帖子删除时，不能再转到管理员界面去了，因为管理的Controller都需要拦截器认证，所以只能自己写一个
    @RequestMapping("/delMyArticles")
    public ModelAndView delMyArticles(Integer user_id, String type, Integer st, @RequestParam("id[]") Integer[] ids) {
        ModelAndView mv = new ModelAndView();
        topicService.updateTopicsStatus(type, st, ids);
        mv.addObject("topicList", topicService.findTopicByUserId(user_id));
        mv.addObject("message", "删除成功！");
        mv.setViewName("/myInfo/myArticles");
        return mv;
    }

    //转到收藏页面，并且展示收藏的帖子
    @RequestMapping("/myCollect")
    public ModelAndView myCollect(Integer user_id) {
        System.out.println("这是收藏页面的用户id = " + user_id);
        ModelAndView mv = new ModelAndView();
        mv.addObject("collectList", collectService.findCollectsByUserId(user_id));
        mv.setViewName("/myInfo/myCollect");
        return mv;
    }

    //取消收藏（并且取消后回到原来的界面
    @RequestMapping("/cancelMyCollect")
    public String cancelMyCollect(Model model, Integer user_id, Integer topic_id, HttpSession session) {
        collectService.cancelCollect(user_id, topic_id);
        //每次取消一条关注后都应该更新session
        session.setAttribute("user", userService.findUserById(user_id));
        model.addAttribute("message", "已取消该条收藏");
        return "forward:myCollect";
    }

    //根据用户id得到该用户所有关注的用户，并且展示
    @RequestMapping("/myAttention")
    public ModelAndView myAttention(HttpSession session) {
        ModelAndView mv = new ModelAndView();
        User user = (User) session.getAttribute("user");
        Integer user_id = user.getUser_id();
        //每次取消关注后都会转到这里，所以需要更新一下session
        session.setAttribute("user", userService.findUserById(user_id));
        mv.addObject("attentionList", attentionService.findAttentionByUserId(user_id));
        mv.setViewName("/myInfo/myAttention");
        return mv;
    }

    //取消关注（删除一条记录）
    @RequestMapping("/cancelAttention")
    public String cancelAttention(Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        User otherUser = (User) session.getAttribute("otherUser");
        Integer user_id = user.getUser_id();
        Integer puser_id = otherUser.getUser_id();
        attentionService.cancelAttention(user_id, puser_id);
        model.addAttribute("message", "取消关注成功");
        return "forward:myAttention";
    }

    // 添加一个用户
    @RequestMapping(value = "/userRegister", method = {RequestMethod.POST})
    public String addUser(String sno, String password, String email, Model model, String checkCode, HttpSession session) {
        //首先验证验证码是否正确
        if(checkCode.equals((String) session.getAttribute("checkCode"))) {
            if (sno == null || "".equals(sno) || password == null || "".equals(password) || email == null
                    || "".equals(email)) {
                model.addAttribute("message", "用户名或密码，邮箱不能为空");
            } else {
                userService.addUser(sno, password, email);
                model.addAttribute("message", "注册成功！");
            }
        } else {
            model.addAttribute("message", "验证码不正确");
        }
        return "forward:userLogin";
    }

    // 验证邮箱是否存在
    @RequestMapping(value = "/verifyEmail")
    public void verifyEmail(String email, HttpServletResponse response, HttpSession session) throws IOException {
        User user = userService.findUserByEmail(email);
        System.out.println(email);
        if (user != null) {
            System.out.println("The email is not null");
            System.out.println("该邮箱已经被注册了！");
            response.getWriter().write("false");
        } else {
            System.out.println("Send Email");
            String checkCode = EmailUtil.getCheckCode();
            session.setAttribute("checkCode", checkCode);
            try {
                EmailUtil.sendMessage(email, checkCode);
            } catch (Exception e) {
                e.printStackTrace();
            }
            response.getWriter().write("true");
        }
    }

    // 验证验证码是否正确
    @RequestMapping(value = "/verifyCheckCode")
    public void verifyCheckCode(String checkCode, HttpServletResponse response, HttpSession session)
            throws IOException {
        if (checkCode.equals(session.getAttribute("checkCode"))) {
            response.getWriter().write("true");
        } else {
            response.getWriter().write("false");
        }
    }

    // 验证验证码是否正确
    @RequestMapping(value = "/verifySno")
    public void verifySno(String sno, HttpServletResponse response)
            throws IOException {
        User user = userService.findUserBySno(sno);
        System.out.println(sno);
        if (user != null) {
            System.out.println("该学号已经激活！");
            response.getWriter().write("false");
        } else {
            response.getWriter().write("true");
        }
    }

    @RequestMapping(value = "/userLogin")
    public String login() {
        return "/article/login_bbs";
    }


    //跳转到信息编辑页面
    @RequestMapping("/editMyInfo")
    public String editMyInfo() {
        return "/myInfo/editMyInfo";
    }

    @RequestMapping("/myInfoUpdate")
    public ModelAndView myInfoUpdate(@RequestParam("imgUrl") MultipartFile imgUrl, Integer user_id, HttpServletRequest request, String username, String sex, String phone, String sdept, String clazz, String sign) throws IOException {
        ModelAndView mv = new ModelAndView();
        User user = new User();
        user.setUsername(username);
        user.setClazz(clazz);
        user.setPhone(phone);
        user.setSdept(sdept);
        user.setSex(sex);
        user.setSign(sign);
        user.setUser_id(user_id);
        if (imgUrl != null) {
            if (!imgUrl.isEmpty()) {
                String initFileName = imgUrl.getOriginalFilename();
                String path = request.getServletContext().getInitParameter("path");
                String newFileName = System.currentTimeMillis() + initFileName;
                imgUrl.transferTo(new File(path, newFileName));
                user.setImgUrl(newFileName);
            }
        }
        userService.updateUserInfo(user);
        mv.addObject("message", "用户信息更新成功");
        mv.setViewName("forward:myInfo");
        request.getSession().setAttribute("user", userService.findUserById(user_id));
        return mv;
    }

}
