<%@ page import="cn.jsbintask.bbs.po.Admin" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="renderer" content="webkit">
    <title>修改密码</title>
    <link rel="stylesheet" href="/css/admin/pintuer.css">
    <link rel="stylesheet" href="/css/admin/admin.css">
    <script src="/js/admin/jquery.js"></script>
    <script src="/js/admin/pintuer.js"></script>
    <%
        Admin admin = (Admin) session.getAttribute("admin");
        if(admin==null) {
            return;
        }
        if(request.getAttribute("message")!=null) {
            System.out.println("Message is not null");
            String msg = (String) request.getAttribute("message");
            out.write("<script>alert('" + msg + "');</script>");
        }
    %>
</head>
<body>
<div class="panel admin-panel">
    <div class="panel-head"><strong><span class="icon-key"></span> 修改管理员密码</strong></div>
    <div class="body-content">
        <form method="post" class="form-x" action="/admin/changePwdInfo" id="sitename">
            <!--设置一个隐藏域，管理员id-->
            <input type="hidden" id="admin_id" name="admin_id" value="<%=admin.getId()%>">
            <div class="form-group">
                <div class="label">
                    <label for="sitename">管理员帐号：</label>
                </div>
                <div class="field">
                    <label style="line-height:33px;">
                        <%=admin.getAccount()%>
                    </label>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label for="sitename">原始密码：</label>
                </div>
                <div class="field">
                    <input type="password" class="input w50" id="initPwd" name="initPwd" size="50" placeholder="请输入原始密码"
                           data-validate="required:请输入原始密码"/>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label for="sitename">新密码：</label>
                </div>
                <div class="field">
                    <input type="password" class="input w50" name="newPwd" size="50" placeholder="请输入新密码"
                           data-validate="required:请输入新密码,length#>=5:新密码不能小于5位"/>
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label for="sitename">确认新密码：</label>
                </div>
                <div class="field">
                    <input type="password" class="input w50" name="reNewPwd" size="50" placeholder="请再次输入新密码"
                           />
                </div>
            </div>
            <div class="form-group">
                <div class="label">
                    <label></label>
                </div>
                <div class="field">
                    <button class="button bg-main icon-check-square-o" type="submit" id="submit"> 提交</button>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
<script>
    $(function () {
        $("#initPwd").blur(function () {
            $.ajax({
                type : 'GET',
                url: '/admin/checkInitPwd?admin_id=' + $("#admin_id").val() + '&initPwd=' + $("#initPwd").val() ,
                success: function (data) {
                    if(data=='false') {
                        alert('初始密码错误');
                    }
                }
            });
        })
    })
    $("#submit").click(function () {
        var newpwd = $("input[name='newPwd']").val();
        var repwd = $("input[name='reNewPwd']").val();
        if (newpwd != repwd) {
            alert("两次密码不一致");
            return false;
        } else {
            if(newpwd.length < 5) {
                return false;
            } else {
                $("#sitename").submit();
            }
        }
    });
</script>
</html>