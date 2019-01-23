package cn.jsbintask.bbs.service.impl;

import cn.jsbintask.bbs.mapper.AttentionMapper;
import cn.jsbintask.bbs.po.Attention;
import cn.jsbintask.bbs.service.AttentionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("attentionService")
public class AttentionServiceImpl implements AttentionService{


    private final AttentionMapper attentionMapper;

    @Autowired
    public AttentionServiceImpl(AttentionMapper attentionMapper) {
        this.attentionMapper = attentionMapper;
    }

    @Override
    public List<Attention> findAttentionByUserId(Integer user_id) {
        return attentionMapper.findAttentionByUserId(user_id);
    }

    //传入用户id和被关注的用户的id（取消关注）
    @Override
    public void cancelAttention(Integer user_id, Integer puser_id) {
        attentionMapper.cancelAttention(user_id, puser_id);
    }

    //关注一个用户
    public void attentionUser(Integer user_id, Integer puser_id) {
        attentionMapper.attentionUser(user_id, puser_id);
    }

    @Override
    public Attention findOneAttention(Integer user_id, Integer puser_id) {
        return attentionMapper.findOneAttention(user_id, puser_id);
    }
}
