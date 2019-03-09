package cn.jsbintask.bbs.service.impl;

import cn.jsbintask.bbs.mapper.AdminMapper;
import cn.jsbintask.bbs.po.Admin;
import cn.jsbintask.bbs.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service("adminService")
public class AdminServiceImpl implements AdminService{

    private final AdminMapper adminMapper;

    @Autowired
    public AdminServiceImpl(AdminMapper adminMapper) {
        this.adminMapper = adminMapper;
    }

    @Override
    public Admin findAdmin(String account, String passwrod) {
        Map<String ,String> admin = new HashMap<>();
        if(account!=null && passwrod!=null) {
            admin.put("account", account);
            admin.put("password", passwrod);
        }
        return adminMapper.findAdmin(admin);
    }

    //更新管理员密码
    @Override
    public void updatePwd(Integer admin_id, String newPwd, String initPwd) {
        Map<String ,Object> admin = new HashMap<>();
        admin.put("admin_id", admin_id);
        admin.put("newPwd", newPwd);
        admin.put("initPwd", initPwd);
        adminMapper.updatePwd(admin);
    }

    @Override
    public Admin findAdminByInitPwd(Integer admin_id, String initPwd) {
        Map<String ,Object> admin = new HashMap<>();
        admin.put("admin_id", admin_id);
        admin.put("initPwd", initPwd);
        return adminMapper.findAdminByInitPwd(admin);
    }
}
