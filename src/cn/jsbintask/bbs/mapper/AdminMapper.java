package cn.jsbintask.bbs.mapper;

import cn.jsbintask.bbs.po.Admin;
import org.springframework.stereotype.Component;

import java.util.Map;

/**
 * Created by Administrator on 2017/6/13.
 */
@Component
public interface AdminMapper {

    public Admin findAdmin(Map<String, String> admin);

    public void updatePwd(Map<String, Object> admin);

    public Admin findAdminByInitPwd(Map<String, Object> admin);

}
