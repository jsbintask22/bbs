package cn.jsbintask.bbs.mapper;

import cn.jsbintask.bbs.po.Collect;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public interface CollectMapper {

    public List<Collect> findCollectsByUserId(Integer user_id);

    public  void  cancelCollect(@Param("user_id") Integer user_id, @Param("topic_id") Integer topic_id);

    public void collectTopic(@Param("user_id") Integer user_id, @Param("topic_id") Integer topic_id);

    public int countCollect_num(Integer user_id);

    public Collect findOneCollect(@Param("user_id") Integer user_id, @Param("topic_id") Integer topic_id);
}
