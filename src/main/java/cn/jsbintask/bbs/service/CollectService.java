package cn.jsbintask.bbs.service;

import cn.jsbintask.bbs.po.Collect;

import java.util.List;


public interface CollectService {
    public List<Collect> findCollectsByUserId(Integer user_id);

    public void cancelCollect(Integer user_id, Integer topic_id);

    public void collectTopic(Integer user_id, Integer topic_id);

    public Collect findOneCollect(Integer user_id, Integer topic_id);
}
