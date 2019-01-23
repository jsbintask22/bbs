package cn.jsbintask.bbs.service.impl;

import cn.jsbintask.bbs.mapper.CollectMapper;
import cn.jsbintask.bbs.service.CollectService;
import cn.jsbintask.bbs.po.Collect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("collectService")
public class CollectServiceImpl implements CollectService {
    private final CollectMapper collectMapper;

    @Autowired
    public CollectServiceImpl(CollectMapper collectMapper) {
        this.collectMapper = collectMapper;
    }

    @Override
    public List<Collect> findCollectsByUserId(Integer user_id) {
        return collectMapper.findCollectsByUserId(user_id);
    }

    @Override
    public void cancelCollect(Integer user_id, Integer topic_id) {
        collectMapper.cancelCollect(user_id, topic_id);
    }

    //收藏一条帖子
    @Override
    public void collectTopic(Integer user_id, Integer topic_id) {
        collectMapper.collectTopic(user_id, topic_id);
    }

    //得到一条收藏
    @Override
    public Collect findOneCollect(Integer user_id, Integer topic_id) {

        return collectMapper.findOneCollect(user_id, topic_id);
    }
}
