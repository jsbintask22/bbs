package cn.jsbintask.bbs.controller;

import cn.jsbintask.bbs.mapper.CollectMapper;
import cn.jsbintask.bbs.service.TopicService;
import cn.jsbintask.bbs.service.UserService;
import cn.jsbintask.bbs.utils.PageUtil;
import cn.jsbintask.bbs.po.Collect;
import cn.jsbintask.bbs.po.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping(value = "/topic")
public class TopicController {
    private final TopicService topicService;
    private final UserService userService;
    private final CollectMapper collectMapper;

    @Autowired
    public TopicController(TopicService topicService, UserService userService, CollectMapper collectMapper) {
        this.topicService = topicService;
        this.userService = userService;
        this.collectMapper = collectMapper;
    }

    @RequestMapping(value = "detail/{topicId}")
    public ModelAndView showTopicDetailById(@PathVariable(value = "topicId") Integer topicId, ModelAndView mv, String sort, HttpServletRequest request) {
        ServletContext application = request.getServletContext();
        Integer viewCount = (Integer) application.getAttribute("" + topicId);
        if(viewCount==null) {
            application.setAttribute("" + topicId, 1);
        } else {
            int newCount = viewCount + 1;
            application.setAttribute("" + topicId, newCount);
        }
        mv.addObject("topicVO", topicService.findTopicById(topicId, sort));
        //转发到帖子细节的jsp页面
        mv.setViewName("/article/articleDetail");
        return mv;
    }

    //写一个访问首页的controller
    @RequestMapping(value = "/all")
    public ModelAndView showAllTopics(@RequestParam(value = "sort", required = false) String sort, @RequestParam(value = "topicName", required = false) String topicName, @RequestParam(value = "pageNum", required = false) Integer pageNum, HttpServletRequest request) {
        ModelAndView mv = new ModelAndView();
        //根据request获得页面的大小
        String pageSizeStr = request.getServletContext().getInitParameter("pageSize");
        Integer pageSize = Integer.parseInt(pageSizeStr);
        //初始化一个分页工具类
        PageUtil pageUtil = new PageUtil(topicService.findTopicTotal(), pageSize, pageNum);
        //将所有的主题放入
        mv.addObject("topics", topicService.findAllTopic(sort, topicName, pageUtil.getPagePosition(), pageUtil.getPageSize()));
        //把分页bean放入request
        mv.addObject("pageUtil", pageUtil);
        mv.setViewName("/article/showTopics");
        return mv;
    }

    //验证权限，然后转到发帖页面
    @RequestMapping(value = "/postTopic")
    public ModelAndView postTopic(HttpSession session, ModelAndView mv) {
        System.out.println("进入了发帖页面");
        if(session.getAttribute("user")==null) {
            //转发到上面的首页
            mv.addObject("message", "请先登录");
            mv.setViewName("redirect:all");
        } else {
            mv.setViewName("/article/postArticle");
        }
        return mv;
    }

    //接收发帖子的信息，并且进行更新
    @RequestMapping(value = "/postTopicInfo", method = {RequestMethod.POST})
    public ModelAndView postTopicInfo(HttpSession session,ModelAndView mv,@RequestParam(value = "myEditor") String content, String topic) {
        User user = (User)session.getAttribute("user");
        System.out.println(user.getUser_id());
        //发帖
        userService.postTopic(user.getUser_id(), topic, content);
        //发了帖子后进行转发
        mv.setViewName("redirect:all");
        return mv;
    }

    @RequestMapping("/collectTopic")
    public ModelAndView collectTopic(HttpSession session, Integer topic_id) {
        ModelAndView mv = new ModelAndView();
        User user =(User) session.getAttribute("user");
        Collect collect = collectMapper.findOneCollect(user.getUser_id(), topic_id);
        if(collect!=null) {
            mv.addObject("message", "收藏失败，该帖子已经在收藏列表中！");
        } else {
            collectMapper.collectTopic(user.getUser_id(), topic_id);
            mv.addObject("message", "收藏成功！");
        }
        //收藏成功后要更新User
        session.setAttribute("user", userService.findUserById(user.getUser_id()));
        mv.setViewName("forward:detail/" + topic_id);
        return mv;
    }
}
