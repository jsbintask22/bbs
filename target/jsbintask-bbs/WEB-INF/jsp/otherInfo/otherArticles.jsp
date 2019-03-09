<%@ page import="cn.jsbintask.bbs.po.User" %>
<%@ page import="cn.jsbintask.bbs.po.TopicVO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>所发帖子</title>
    <link rel="stylesheet" href="/css/bootstrap/bootstrap.css">
    <script src="/js/bootstrap/jquery-3.1.1.min.js"></script>
</head>
<style>
    thead, th, tr {
        text-align: center;
    }
</style>
<body>
<%
    if (request.getAttribute("message") != null) {
        System.out.println("Message is not null");
        String msg = (String) request.getAttribute("message");
        out.write("<script>alert('" + msg + "');</script>");
    }
//从session中取出用户信息
    User user = (User) session.getAttribute("otherUser");
    if (user == null) {
        return;
    }
%>

<div class="panel panel-success">
    <div class="panel-heading">
        <h3 class="panel-title" style="font-size: 21px; margin-left: 5px">我的帖子</h3>
    </div>
    <div class="panel-body">
        <table class="table table-hover table-striped">
            <thead class="bg-info">
            <th style="width: 10%"><span class="glyphicon glyphicon-home" title="置顶"></span></th>
            <th style="width: 10%"><span class="glyphicon glyphicon-eye-open" title="浏览数"></span></th>
            <th style="width: 45%">主题</th>
            <th style="width: 10%">回复数</th>
            <th style="width: 15%">发帖时间</th>
            </thead>
            <tbody class="">
            <%
                List<TopicVO> topicList = (List<TopicVO>) request.getAttribute("topicList");
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                for (TopicVO topicVO : topicList) {
                    String className = topicVO.getIndex() == 1 ? "danger" : "";
                    String fontGlyp = "glyphicon-leaf";
                    String flash = "";
                    if (topicVO.getIndex() == 1) {
                        fontGlyp = "glyphicon-thumbs-up";
                        flash = "glyphicon glyphicon-flash";
                    }
                    Integer viewCount = (Integer) application.getAttribute("" + topicVO.getTopic_id().intValue());
                    int view = 0;
                    if(viewCount!=null) {
                        view = viewCount;
                    }
            %>

            <tr class="<%=className%>">
                <td><span class="glyphicon <%=fontGlyp%>"></span></td>
                <td><%=view%></td>
                <td><a href="/topic/detail/<%=topicVO.getTopic_id()%>" target="_blank"><%=topicVO.getTopic()%>
                </a></td>
                <td><%=topicVO.getReply_number()%>
                </td>
                <td><%=sdf.format(topicVO.getCreate_time())%>
                </td>
            </tr>

            <%
                }
            %>
            </tbody>
        </table>
    </div>
    <!--删除帖子的form -->
    <form action="/user/delMyArticles" id="delForm" method="post">
        <input type="hidden" id="topic_id" name="id[]">
        <input type="hidden" id="type" name="type" value="flag">
        <input type="hidden" id="st" name="st" value="0">
        <input type="hidden" name="user_id" value="<%=user.getUser_id()%>">
        <input type="hidden" name="initUrl" value="myArticles">
    </form>
</div>

</body>
</html>