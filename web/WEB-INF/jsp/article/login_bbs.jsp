<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<c:set value="${pageContext.request.contextPath}" var="path" scope="page"/>
<head>
    <title>BBS登录</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <script type="text/javascript" src="${path }/js/bootstrap/jquery-3.1.1.js"></script>
    <script type="text/javascript" src="${path }/js/article/login_bbs.js"></script>
    <link href="${path }/css/article/login_bbs.css" rel="stylesheet" type="text/css"/>

    <%
        if(request.getAttribute("message")!=null) {
            String msg = (String) request.getAttribute("message");
            out.write("<script>alert('" + msg + "');</script>");
        }
    %>
</head>
<!-- 根据是否有信息，弹出信息 -->
<body>
<a href="/topic/all" title="点击返回主页"><h1>BBS社区登录<sup>V2019</sup></h1></a>

<div class="login" style="margin-top:50px;">

    <div class="header">
        <div class="switch" id="switch">
            <a class="switch_btn_focus" id="switch_qlogin" href="javascript:void(0);" tabindex="7">快速登录</a>
            <a class="switch_btn" id="switch_login" href="javascript:void(0);" tabindex="8">快速注册</a>
            <div class="switch_bottom" id="switch_bottom" style="position: absolute; width: 64px; left: 154px;"></div> <!--底部滑动条结束啦-->
        </div>
    </div><!--头部的切换按钮结束啦-->


    <div class="web_qr_login" id="web_qr_login" style="display: none; height: 235px;">
        <!--登录-->
        <div class="web_login" id="web_login">
            <div class="login-box">

                <div class="login_form">
                    <form action="/user/showTopics" name="loginform" accept-charset="utf-8" id="login_form" class="loginForm" method="post">
                        <input type="hidden" name="flag" value="2"/>
                        <div class="uinArea" id="uinArea">
                            <label class="input-tips" for="u">帐号：</label>  <!--帐号标签-->
                            <div class="inputOuter" id="uArea">
                                <input type="text" id="u" required="required" name=userName class="inputstyle" placeholder="邮箱或者学号"/><!--用户名-->
                            </div>
                        </div>

                        <div class="pwdArea" id="pwdArea">
                            <label class="input-tips" for="p">密码：</label>
                            <div class="inputOuter" id="pArea">

                                <input type="password" id="p" required="required" name="password" class="inputstyle"/><!--密码-->
                            </div>
                        </div>

                        <div style="padding-left:50px;margin-top:20px;">
                            <input type="submit" value="登 录" style="width:150px;" class="button_blue"/><!--登录按钮-->
                        </div>
                    </form><!--表单结束啦-->
                </div>
            </div>
        </div>
        <!--登录end-->
    </div>

    <!--注册-->
    <div class="qlogin" id="qlogin" style="display: block; ">
        <div class="web_login">
            <form name="form2" id="regUser" accept-charset="utf-8" action="/user/userRegister" method="post">
                <input type="hidden" name="to" value="reg"/>
                <input type="hidden" name="did" value="0"/><!--两个隐藏于-->

                <ul class="reg_form" id="reg-ul">
                    <div id="userCue" class="cue">快速注册请注意格式</div>
                    <!--邮箱： -->
                    <li>
                        <label for="user" class="input-tips2">邮箱：</label>
                        <div class="inputOuter2">
                            <input type="email" id="user" required="required" name="email" maxlength="20" class="inputstyle2" placeholder="请填写准确的邮箱"/><br> <!--邮箱-->
                        </div>
                    </li>

                    <!--验证码： -->
                    <li>
                        <label for="checkCode" class="input-tips2">验证码：</label>
                        <div class="inputOuter2">
                            <input type="text" id="checkCode" required="required" name="checkCode" maxlength="6" class="inputstyle2" /><br> <!--验证码-->
                        </div>
                    </li>
                    <!--学号： -->
                    <li>
                        <label for="qq" class="input-tips2">学号：</label>
                        <div class="inputOuter2">
                            <input type="number" id="qq" name="sno" maxlength="11" required="required" placeholder="请填写正确的学号" class="inputstyle2"/>  <!--学号-->
                        </div>
                    </li>

                    <!--密码： -->
                    <li>
                        <label for="passwd" class="input-tips2">密码：</label>
                        <div class="inputOuter2">
                            <input type="password" id="passwd" required="required" name="password" maxlength="16" minlength="6" placeholder="最少长度为6位"  class="inputstyle2"/><!-- 密码-->
                        </div>
                    </li>

                    <!--确认密码： -->
                    <li>
                        <label for="passwd2" class="input-tips2">确认密码：</label>
                        <div class="inputOuter2">
                            <input type="password" id="passwd2" name="" required="required" maxlength="16" minlength="6" class="inputstyle2"/>  <!--重复密码-->
                        </div>
                    </li>

                    <li>
                        <div class="inputArea">
                            <input type="button" id="reg" style="margin-top:10px;margin-left:85px;" class="button_blue" value="同意协议并且注册"/><!--注册按钮-->
                        </div>
                    </li>
                    <div class="cl"></div>
                </ul>
            </form>
        </div>
    </div><!--注册div结束啦-->
</div>
<div class="jianyi">*推荐您使用IE10及以上，或者火狐，谷歌浏览器，避免造成兼容问题</div>
</body>

<script>
    $("#user").blur(function () {
        var regEmail = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/ ;
        if(!regEmail.test($('#user').val())) {
            $('#userCue').html("<span style='color: red'><b>×邮箱格式不正确</b></span>");
            $('#reg').attr('disabled', true);
        } else {
            $.ajax({
                type: 'GET',
                url: '/user/verifyEmail?email=' + $('#user').val(),
                success: function (data) {
                    if (data == 'false') {
                        $('#userCue').html("<span style='color: red'><b>×该邮箱已被注册！</b></span>");
                        $('#reg').attr('disabled', true);
                    } else if(data=='true'){
                        $('#userCue').html("<span style='color: green'><b>邮箱名可用！验证码已发送</b></span>");
                        $('#reg').attr('disabled', false);
                    }
                }
            });
        }
    });

    $("#checkCode").blur(function () {
        $.ajax({
            type: 'GET',
            url: '/user/verifyCheckCode?checkCode=' + $('#checkCode').val(),
            success: function (data) {
                if (data == 'false') {
                    $('#userCue').html("<span style='color: red'><b>×验证码错误！</b></span>");
                    $('#reg').attr('disabled', true);
                } else if(data=='true'){
                    $('#userCue').html("<span style='color: green'><b>✔验证码正确！</b></span>");
                    $('#reg').attr('disabled', false);
                }
            }
        });
    })

    $("#qq").blur(function () {
        if($("#qq").val().length!=11) {
            $('#userCue').html("<span style='color: red'><b>×学号格式错误！</b></span>");
            $('#reg').attr('disabled', true);
            $("#qq").focus();
        } else {
            $.ajax({
                type: 'GET',
                url: '/user/verifySno?sno=' + $('#qq').val(),
                success: function (data) {
                    if (data == 'false') {
                        $('#userCue').html("<span style='color: red'><b>×该学号已被激活！</b></span>");
                        $('#reg').attr('disabled', true);
                    } else if(data=='true'){
                        $('#userCue').html("<span style='color: green'><b>✔学号匹配正确！</b></span>");
                        $('#reg').attr('disabled', false);
                    }
                }
            });
        }
    })
</script>

</html>