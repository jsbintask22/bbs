package cn.jsbintask.bbs.po;

import java.sql.Timestamp;
import java.util.List;

/**
 * Created by Administrator on 2017/6/11.
 */
public class TopicVO extends Topic{

    private String lastReplyName;
    private Timestamp lastReplyTime;
    private Integer lastReplyUserId;

    public List<ArticleVO> getOneToArticles() {
        return oneToArticles;
    }

    public void setOneToArticles(List<ArticleVO> oneToArticles) {
        this.oneToArticles = oneToArticles;
    }

    //帖子细节扩展的list属性，比如说一个主题对应多个回复
    private List<ArticleVO> oneToArticles;

    public String getLastReplyName() {
        return lastReplyName;
    }

    public void setLastReplyName(String lastReplyName) {
        this.lastReplyName = lastReplyName;
    }

    public Timestamp getLastReplyTime() {
        return lastReplyTime;
    }

    public void setLastReplyTime(Timestamp lastReplyTime) {
        this.lastReplyTime = lastReplyTime;
    }

    public Integer getLastReplyUserId() {
        return lastReplyUserId;
    }

    public void setLastReplyUserId(Integer lastReplyUserId) {
        this.lastReplyUserId = lastReplyUserId;
    }
}
