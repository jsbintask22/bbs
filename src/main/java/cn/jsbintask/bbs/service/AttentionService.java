package cn.jsbintask.bbs.service;


import cn.jsbintask.bbs.po.Attention;

import java.util.List;

public interface AttentionService {
    public List<Attention> findAttentionByUserId(Integer user_id);

    public void cancelAttention(Integer user_id, Integer puser_id);

    public void attentionUser(Integer user_id, Integer puser_id);

    public Attention findOneAttention(Integer user_id, Integer puser_id);
}
