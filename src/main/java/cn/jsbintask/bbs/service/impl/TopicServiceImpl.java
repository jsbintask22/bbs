package cn.jsbintask.bbs.service.impl;

import cn.jsbintask.bbs.mapper.ArticleMapper;
import cn.jsbintask.bbs.mapper.TopicMapper;
import cn.jsbintask.bbs.po.Article;
import cn.jsbintask.bbs.po.ArticleVO;
import cn.jsbintask.bbs.po.TopicVO;
import cn.jsbintask.bbs.service.TopicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;


@Service(value = "topicService")
public class TopicServiceImpl implements TopicService {
    private final TopicMapper topicMapper;
    private final ArticleMapper articleMapper;

    @Autowired
    public TopicServiceImpl(TopicMapper topicMapper, ArticleMapper articleMapper) {
        this.topicMapper = topicMapper;
        this.articleMapper = articleMapper;
    }

    //得到帖子以及他的回复
    @Override
    public TopicVO findTopicById(Integer topic_id, String sort) {
        TopicVO topicVO = topicMapper.findTopicVOById(topic_id);
        if (topicVO != null && topicVO.getOneToArticles() != null) {
            //获得该主题的所有回复，将属性楼层，以及如果是引用的话另作处理
            List<ArticleVO> articleVOList = topicVO.getOneToArticles();
            for (int i = 1; i <= articleVOList.size(); i++) {
                //获得一条回复
                ArticleVO articleVO = articleVOList.get(i - 1);
                //设置楼层1
                articleVO.setLevel(i);
                //该条回复是否引用了别人的回复，如果是，就将那条回复注入该回复
                if (articleVO.getArefid() != null) {
                    //得到被引用回复的回复id
                    int aRefId = articleVO.getArefid();
                    //搜出该条回复的内容
                    for (ArticleVO refArticleVO : articleVOList) {
                        //找到了被引用的回复了
                        if (refArticleVO.getArticle_id() == aRefId) {
                            articleVO.setRefArticleVO(refArticleVO);
                            break;
                        }
                    }
                }
            }
            //反正顺序
            if(sort!=null&&sort.equals("reverse")) {
                Collections.reverse(articleVOList);
            }
        }
        return topicVO;
    }

    //更新帖子的置顶，或者删除状态等
    @Override
    public void updateTopicsStatus(String type, Integer status, Integer[] ids) {
        Map<String, Object> typeAndStatusAndIds = new HashMap<>();
        typeAndStatusAndIds.put("status", status);
        typeAndStatusAndIds.put("type", type);
        List<Integer> topic_ids = new ArrayList<>();
        //推荐使用该用法(idea)自动推荐
        Collections.addAll(topic_ids, ids);
        System.out.println("Type , status , ids " + type + "  , " + status + " " + ids[0]);
        typeAndStatusAndIds.put("topic_ids", topic_ids);
        topicMapper.updateTopicsStatus(typeAndStatusAndIds);
    }

    //获得所有被删除的用户
    @Override
    public List<TopicVO> findDeletedTopic(String type, String orderBy) {
        Map<String, Object> typeAndOrderBy = new HashMap<>();
        //如果参数为空，直接返回空值
        if (type == null || type.isEmpty() || orderBy == null || orderBy.isEmpty()) {
            type = "time";
            orderBy = "DESC";
        }
        typeAndOrderBy.put("type", type);
        typeAndOrderBy.put("orderBy", orderBy);
        return topicMapper.findDeletedTopic(typeAndOrderBy);
    }

    //获得该用户所有的帖子
    @Override
    public List<TopicVO> findTopicByUserId(Integer user_id) {
        return topicMapper.findTopicByUserId(user_id);
    }

    //获得发帖数
    @Override
    public int findTopicTotal() {
        return topicMapper.findTopicTotal();
    }


    //如果传了帖子名字的值，就进行模糊查找
    @Override
    public List<TopicVO> findAllTopic(String sort, String topicName, Integer topicPosition, Integer pageSize) {
        //如果传进来的排序是根据人气排序的，那就改变排序规则
        List<TopicVO> topiclist;
        //新添加的分页的参数
        Map<String, Object> limitAndSort = new HashMap<>();
        //将分页起点和分页大小添加进去
        limitAndSort.put("topicPosition", topicPosition);
        limitAndSort.put("pageSize", pageSize);
        //如果传进来的帖子名不是空，就进行模糊查找。
        if (topicName != null && !topicName.equals("")) {
            topiclist = topicMapper.findTopicByLikeName(topicName);
        } else {
            if (sort != null && sort.equals("fire")) {
                //根据人气得到帖子
                limitAndSort.put("sortType", "reply_number");
                topiclist = topicMapper.findAllTopic(limitAndSort);
            } else {
                //根据时间得到帖子（默认）
                limitAndSort.put("sortType", null);
                topiclist = topicMapper.findAllTopic(limitAndSort);
            }
        }
        List<Integer> topic_ids = new ArrayList<>();
        for (TopicVO topicVO : topiclist) {
            topic_ids.add(topicVO.getTopic_id());
        }
        //由于如果里面没有参数，会导致mybatis错误，所以添加一个
        if(topic_ids.size()==0) {
            topic_ids.add(-1);
        }
        List<Article> articleList = articleMapper.findLastArticle(topic_ids);
        //将最后回复的人的姓名，id号通过对比topicid封装到一个类里面
        for (TopicVO topicVO : topiclist) {
            for (Article article : articleList) {
                if (topicVO.getTopic_id().intValue() == article.getTopic().getTopic_id().intValue()) {
                    topicVO.setLastReplyName(article.getUser().getUsername());
                    topicVO.setLastReplyUserId(article.getUser().getUser_id());
                    topicVO.setLastReplyTime(article.getReply_time());
                    //一旦匹配，跳出循环
                    break;
                }
            }
        }
        //没有找到的（即没有人回复该条帖子，将自己的用户名作为最后的回复时间）
        for (TopicVO topicVO : topiclist) {
            if (topicVO.getLastReplyTime() == null) {
                topicVO.setLastReplyName(topicVO.getUser().getUsername());
                topicVO.setLastReplyUserId(topicVO.getUser().getUser_id());
                topicVO.setLastReplyTime(topicVO.getCreate_time());
            }
        }
        return topiclist;
    }
}
