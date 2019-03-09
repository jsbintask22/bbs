package cn.jsbintask.bbs.service;

import cn.jsbintask.bbs.po.Admin;

/**
 * Created by Administrator on 2017/6/13.
 */
public interface AdminService {
    //通过帐号找到一个用户
    public Admin findAdmin(String account, String passwrod);

    //更新管理员密码
    public void updatePwd(Integer admin_id, String newPwd, String initPwd);

    //验证密码
    public Admin findAdminByInitPwd(Integer admin_id, String initPwd);
}
