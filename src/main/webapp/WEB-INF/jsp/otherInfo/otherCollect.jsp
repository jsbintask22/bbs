<%@ page import="cn.jsbintask.bbs.po.User" %>
<%@ page import="cn.jsbintask.bbs.po.Collect" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>我收藏的帖子</title>
    <link rel="stylesheet" href="/css/bootstrap/bootstrap.css">
    <script src="/js/bootstrap/jquery-3.1.1.min.js"></script>
    <style>
        .menu {
            position: absolute;
            display: none;
            width: 100px;
        }
    </style>
</head>

<%
    if(request.getAttribute("message")!=null) {
        System.out.println("Message is not null");
        String msg = (String) request.getAttribute("message");
        out.write("<script>alert('" + msg + "');</script>");
    }
    //从session中取出用户信息
    User user = (User) session.getAttribute("otherUser");
    if(user==null) {
        return;
    }
    List<Collect> collectList = (List<Collect>) request.getAttribute("collectList");
%>
<body>
<!--右击鼠标弹出取消收藏-->
<ul class="nav nav-pills nav-stacked menu">
    <li><a href="javascript:void(0);" onclick="cancelCollect();">取消关注</a></li>
</ul>

<form action="/user/cancelMyCollect">
    <input type="hidden" name="user_id" value="<%=user.getUser_id()%>">
    <input type="hidden" name="topic_id">
</form>

<div class="panel panel-primary">
    <div class="panel-heading">
        <h3 class="panel-title">我的收藏</h3>
    </div>
    <div class="panel-body">
        <%
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
            for(Collect collect : collectList) {

        %>
        <div style="margin: 25px; height: 90px; border: 1px solid darkcyan">
            <legend>主题：
                <mark><a href="/topic/detail/<%=collect.getTopic_id()%>" target="_blank" class="mark_a" onmousedown="mouseDown(window.event, <%=collect.getTopicVO().getTopic_id()%>)"><%=collect.getTopicVO().getTopic()%></a></mark>
                <strong style="float: right; margin-right: 35px">收藏时间： <%=sdf.format(collect.getCreate_time())%></strong>
            </legend>
            <div class="text-info" style="margin-left: 25px">
                <a href="/otherSpace/<%=collect.getTopicVO().getUser().getUser_id()%>" target="_blank"> <h4 style="display: inline; float: right; margin-right: 25px">-----&nbsp;&nbsp;<%=collect.getTopicVO().getUser().getUsername()%></h4></a></div>
        </div>

        <%
            }
        %>

    </div>
</div>
</body>
<script>
    //屏蔽默认事件
    $(".mark_a").bind("contextmenu", function (e) {
        return false;
    });

    function mouseDown(e, topic_id) {
        if(e.which == 3) {
            $(".menu").css({
                "left" : e.clientX,
                "top"  : e.clientY + 20,
                "background" : "#eaf0a9",
                "display" : "block"
            })
            $("input[name='topic_id']").val(topic_id);
        }
    }

    /* //鼠标右击事件
     $(".mark_a").mousedown(function (e, topic_id) {
     if(e.which == 3) {
     $(".menu").css({
     "left" : e.clientX,
     "top"  : e.clientY + 20,
     "background" : "#eaf0a9",
     "display" : "block"
     })
     }
     });*/

    //点击事件
    $(document).click(function () {
        $(".menu").css("display","none");
    })

    function cancelCollect() {
        $("form").submit();
    }
</script>
</html>