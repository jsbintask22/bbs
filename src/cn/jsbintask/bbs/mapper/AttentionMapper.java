package cn.jsbintask.bbs.mapper;


import cn.jsbintask.bbs.po.Attention;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public interface AttentionMapper {

    public List<Attention> findAttentionByUserId(Integer user_id);

    public void cancelAttention(@Param("user_id") Integer user_id, @Param("puser_id") Integer puser_id);

    public void attentionUser(@Param("user_id") Integer user_id, @Param("puser_id") Integer puser_id);

    public int countAttention_num(Integer user_id);

    public Attention findOneAttention(@Param("user_id") Integer user_id, @Param("puser_id") Integer puser_id);

}
