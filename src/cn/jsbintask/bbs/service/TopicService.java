package cn.jsbintask.bbs.service;

import cn.jsbintask.bbs.po.TopicVO;

import java.util.List;

public interface TopicService {
    //查找所有的主题帖子
    public List<TopicVO> findAllTopic(String sort, String topicName, Integer topicPosition, Integer pageSize);

    //根据id得到该帖帖子及该条帖子所有的回复
    public TopicVO findTopicById(Integer topic_id, String sort);

    //根据传进来的更新类型，要更新的状态，以及帖子的ids来决定怎么更新
    public void updateTopicsStatus(String type, Integer status, Integer[] ids);

    //根据传进来的参数，选择是根据什么类型的排序，怎么样排序
    public List<TopicVO> findDeletedTopic(String type, String orderBy);

    //根据用户id查找用户所有的帖子
    public List<TopicVO> findTopicByUserId(Integer user_id);

    //得到所有的发帖数
    public int findTopicTotal();


}
