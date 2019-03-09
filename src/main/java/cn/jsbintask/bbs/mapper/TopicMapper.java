package cn.jsbintask.bbs.mapper;

import cn.jsbintask.bbs.po.TopicVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface TopicMapper {

    public List<TopicVO> findAllTopic(Map<String, Object> limitAndSort);

    public List<TopicVO> findTopicByLikeName(String topicName);

    public TopicVO findTopicVOById(Integer topic_id);

    public void postTopic(Map<String, Object> topicMap);

    public void updateTopicsStatus(Map<String, Object> typeAndStatusAndIds);

    public List<TopicVO> findDeletedTopic(Map<String, Object> typeAndOrderBy);

    public void updateReply_num(Integer topic_id);

    public List<TopicVO> findTopicByUserId(Integer user_id);

    public int findTopicTotal();
}
