package cn.jsbintask.bbs.controller;

import cn.jsbintask.bbs.po.Article;
import cn.jsbintask.bbs.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/article", method = {RequestMethod.POST})
public class ArticleController {
    @Autowired
    private UserService userService;

    //这个方法会在其他方法之前被调用
    @ModelAttribute("article")
    public Article setArticle(@RequestParam(value = "myEditor") String content, Integer user_id, Integer puser_id, Integer topic_id, Integer arefid) {
        System.out.println(content + "  " + puser_id + "  " + user_id + "  " + topic_id + "  " + arefid);
        Article article = new Article();
        article.setArefid(arefid);
        article.setUser_id(user_id);
        article.setPuser_id(puser_id);
        article.setContent(content);
        article.setTopic_id(topic_id);
        return article;
    }

    //用户发帖会送到这里
    @RequestMapping(value = "/postArticle")
    public ModelAndView postAticle(@ModelAttribute("article") Article article, ModelAndView mv) {
        userService.replyArticle(article);
        //回复完了以后就回到原来的页面
        mv.setViewName("redirect:/topic/detail/" + article.getTopic_id());
        return mv;
    }

}
