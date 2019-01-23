<%@ page import="cn.jsbintask.bbs.po.User" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>修改密码</title>
    <link rel="stylesheet" href="/css/bootstrap/bootstrap.css">
    <script src="/js/bootstrap/jquery-3.1.1.min.js"></script>
</head>

<%
    if (request.getAttribute("message") != null) {
        System.out.println("Message is not null");
        String msg = (String) request.getAttribute("message");
        out.write("<script>alert('" + msg + "');</script>");
    }
    //从session中取出用户信息
    User user = (User) session.getAttribute("user");
    if (user == null) {
        return;
    }
%>
<body>

<div class="panel panel-danger">
    <div class="panel-heading" style="background-color: darkseagreen">
        <h2 class="panel-title" style="color: whitesmoke; margin-left: 25px; font-size: 21px">修改密码</h2>
    </div>
    <div class="panel-body">
        <form class="form-inline" style="margin: 25px" action="/user/changePwdInfo">
            <!--一个隐藏域，用于修改方便使用：-->
            <input name="user_id" value="<%=user.getUser_id()%>" type="hidden">

            <strong>原密码：</strong>
            <input name="initPwd" type="password" class="form-control" required><span id="msg"></span>
            <br/><br/>

            <strong>新密码：</strong>
            <input name="password" type="password" class="form-control" required minlength="6"><br/><br/>

            <strong>又一遍：</strong>
            <input name="repassword" type="password" class="form-control" minlength="6"><br/><br/>

            <input class="btn btn-danger" type="submit" id="submit" value="确认修改"/>
        </form>
    </div>
</div>

</body>
<script>
    $(function () {
        $("input[name='initPwd']").blur(function () {
            $.ajax({
                type: 'GET',
                url: '/user/checkInitPwd?user_id=' + $("input[name='user_id']").val() + '&initPwd=' + $("input[name='initPwd']").val(),
                success: function (data) {
                    if (data == 'false') {
                        $("#msg").text("初始密码错误，请重试").css({
                            "color": "red",
                            "font-size":"18px"
                        })
                    } else {
                        $("#msg").text("密码正确").css({
                            "color":"green",
                            "font-size":"19px"
                        })
                    }
                }
            });
        });

        $("#submit").click(function () {
            var newpwd = $("input[name='password']").val();
            var repwd = $("input[name='repassword']").val();
            if (newpwd != repwd) {
                alert("两次密码不一致");
                return false;
            } else {
                if (newpwd.length < 6) {
                    return false;
                } else {
                    $("form").submit();
                }
            }
        });
    })
</script>
</html>