package cn.jsbintask.bbs.mapper;

import cn.jsbintask.bbs.po.Article;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * Created by Administrator on 2017/6/11.
 */
@Component
public interface ArticleMapper {

    public List<Article> findLastArticle(List<Integer> topic_ids);

    public Article findArticleById(Integer article_id);

    public void replyArticle(Article article);
}
