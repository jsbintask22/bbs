<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="renderer" content="webkit">
    <title>后台管理中心</title>
    <link rel="stylesheet" href="/css/admin/pintuer.css">
    <link rel="stylesheet" href="/css/admin/admin.css">
    <script src="/js/admin/jquery.js"></script>
    <script src="/js/admin/pintuer.js"></script>
    </head>
    <body style="background-color:#f2f9fd;">
    <div class="header bg-main">
        <div class="logo margin-big-left fadein-top">
            <h1><img src="/images/admin/y.jpg" class="radius-circle rotate-hover" height="50" alt=""/>后台管理中心</h1>
        </div>
    <div class="head-l"><a class="button button-little bg-green" href="/topic/all" target="_blank"><span
            class="icon-home"></span> 论坛首页</a> &nbsp;&nbsp;
        <a href="##" class="button button-little bg-blue"><span class="icon-wrench"></span> 清除缓存</a> &nbsp;&nbsp;
        <a class="button button-little bg-red" href="/admin/cancel"><span class="icon-power-off"></span> 退出登录</a></div>
</div><!--头部结束了-->

<div class="leftnav">
    <div class="leftnav-title"><strong><span class="icon-list"></span>菜单列表</strong></div>
    <h2><span class="icon-user"></span>用户管理</h2>
    <ul style="display:block">
        <li><a href="/admin/changePwd" target="right"><span class="icon-caret-right"></span>密码修改</a></li>
        <li><a href="/admin/shutupedUser" target="right"><span class="icon-caret-right"></span>用户禁言</a></li>
        <li><a href="/admin/userHandlerInfo" target="right"><span class="icon-caret-right"></span>用户操作</a></li>
    </ul>
    <h2><span class="icon-pencil-square-o"></span>帖子管理</h2>
    <ul>
        <li><a href="/admin/allTopic" target="right"><span class="icon-caret-right"></span>所有帖子</a></li>
        <li><a href="/admin/deletedTopic" target="right"><span class="icon-caret-right"></span>删除帖子</a></li>
    </ul>
</div><!--左边导航结束了-->

<script type="text/javascript">
    $(function () {
        $(".leftnav h2").click(function () {
            $(this).next().slideToggle(200);
            $(this).toggleClass("on");
        })
        $(".leftnav ul li a").click(function () {
            $("#a_leader_txt").text($(this).text());
            $(".leftnav ul li a").removeClass("on");
            $(this).addClass("on");
        })
    });
</script>
<ul class="bread">
    <li><a href="{:U('Index/info')}" target="right" class="icon-home"> 首页</a></li>
    <li><a href="##" id="a_leader_txt">网站信息</a></li>
    <li><b>当前语言：</b><span style="color:red;">中文</span>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;切换语言：<a href="##">中文</a> &nbsp;&nbsp;<a href="##">英文</a></li>
</ul>
<div class="admin">
    <iframe scrolling="auto" rameborder="0" src="/admin/changePwd" name="right" width="100%" height="100%"></iframe>
</div>
</body>
</html>