package cn.jsbintask.bbs.controller;

import cn.jsbintask.bbs.po.Attention;
import cn.jsbintask.bbs.po.User;
import cn.jsbintask.bbs.service.AttentionService;
import cn.jsbintask.bbs.service.CollectService;
import cn.jsbintask.bbs.service.TopicService;
import cn.jsbintask.bbs.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/otherSpace")
public class OtherUserController {
    @Autowired
    private UserService userService;
    @Autowired
    private TopicService topicService;
    @Autowired
    private CollectService collectService;
    @Autowired
    private AttentionService attentionService;

    //转到别人的用户信息的主界面
    @RequestMapping("/{user_id}")
    public ModelAndView otherSpace(@PathVariable("user_id") Integer user_id, HttpSession session) {
        ModelAndView mv = new ModelAndView();
        User user = userService.findUserById(user_id);
        if(user.getIsLock() == 1) {
            mv.addObject("message", "对不起，该用户已禁止访问空间！");
        }
        session.setAttribute("otherUser", user);
        mv.setViewName("/otherInfo/otherSpace");
        return mv;
    }

    //显示用户信息
    @RequestMapping("/otherInfo")
    public String showOtherInfo() {
        return "/otherInfo/otherInfo";
    }

    //转到用户帖子页面
    @RequestMapping("/otherArticles")
    public ModelAndView otherArticles(ModelAndView mv, Integer user_id) {
        mv.addObject("topicList", topicService.findTopicByUserId(user_id));
        mv.setViewName("/otherInfo/otherArticles");
        return mv;
    }

    //转到用户的所有的收藏
    @RequestMapping("/otherCollect")
    public ModelAndView otherCollect(Integer user_id) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("collectList", collectService.findCollectsByUserId(user_id));
        mv.setViewName("/otherInfo/otherCollect");
        return mv;
    }

    //转到用户关注页面
    @RequestMapping("/otherAttention")
    public ModelAndView otherAttention(HttpSession session) {
        ModelAndView mv = new ModelAndView();
        User user = (User) session.getAttribute("otherUser");
        Integer user_id = user.getUser_id();
        //每次取消关注后都会转到这里，所以需要更新一下session
        session.setAttribute("otherUser", userService.findUserById(user_id));
        mv.addObject("attentionList", attentionService.findAttentionByUserId(user_id));
        mv.setViewName("/otherInfo/otherAttention");
        return mv;
    }

    //关注一个用户
    @RequestMapping("/attentionUser")
    public ModelAndView attentionUser(HttpSession session, Integer puser_id) {
        ModelAndView mv = new ModelAndView();
        //从sesssion中取出用户信息
        User user = (User) session.getAttribute("user");
        //被关注的用户id
        Integer user_id = user.getUser_id();
        Attention attention = attentionService.findOneAttention(user_id, puser_id);
        if(attention!=null) {
            mv.addObject("message", "关注失败，请不要重复关注!");
        } else {
            attentionService.attentionUser(user_id, puser_id);
            mv.addObject("message", "关注用户成功");
            //关注成功后更新session中的user
            session.setAttribute("user", userService.findUserById(user_id));
        }
        mv.setViewName("forward:/otherSpace/" + puser_id);
        return mv;
    }
}
