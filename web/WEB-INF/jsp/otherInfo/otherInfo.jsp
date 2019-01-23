<%@ page import="cn.jsbintask.bbs.po.User" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title></title>
    <link rel="stylesheet" href="/css/bootstrap/bootstrap.css">
    <script src="/js/bootstrap/jquery-3.1.1.min.js"></script>
    <style>
        span {
            margin-right: 20px;
        }
    </style>

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
        String headImage = "defaultHead.png";
        if(user!=null&&user.getImgurl()!=null) {
            headImage = user.getImgurl();
        }
    %>
    <c:set value="${pageContext.request.contextPath}" var="path" scope="page"/>
</head>
<body>
<div class="panel panel-primary">
    <div class="panel-heading">
        <h3 class="panel-title"><%=user.getUsername()%>的信息</h3>
    </div>
    <div class="panel-body">
        <span class="text-success" style="font-size: 18px">头&nbsp;&nbsp;像: </span>
        <img src="${path }/pic/heads/<%=headImage%>" class="img-circle" width="120px" height="120px"><br/><br/>

        <span class="text-success" style="font-size: 18px">邮&nbsp;&nbsp;箱: </span>
        <strong style="color: darkturquoise; font-size: 20px"><%=user.getEmail()%></strong><br/><br/>

        <span class="text-success" style="font-size: 18px">姓&nbsp;&nbsp;名: </span>
        <strong style="color: darkturquoise; font-size: 20px"><%=user.getUsername()%></strong><br/><br/>

        <span class="text-success" style="font-size: 18px">性&nbsp;&nbsp;别: </span>
        <strong style="color: darkturquoise; font-size: 20px"><%=user.getSex()%></strong><br/><br/>

        <span class="text-success" style="font-size: 18px">学&nbsp;&nbsp;号: </span>
        <strong style="color: darkturquoise; font-size: 20px"><%=user.getSno()%></strong><br/><br/>

        <span class="text-success" style="font-size: 18px">学&nbsp;&nbsp;院: </span>
        <strong style="color: darkturquoise; font-size: 20px"><%=user.getSdept()%></strong><br/><br/>

        <span class="text-success" style="font-size: 18px">班&nbsp;&nbsp;级: </span>
        <strong style="color: darkturquoise; font-size: 20px"><%=user.getClazz()%></strong><br/><br/>

        <span class="text-success" style="font-size: 18px">手&nbsp;&nbsp;机: </span>
        <strong style="color: darkturquoise; font-size: 20px"><%=user.getPhone()%></strong><br/><br/>

        <span class="text-success" style="font-size: 18px">签&nbsp;&nbsp;名: </span>
        <strong style="color: darkturquoise; font-size: 20px"><%=user.getSign()%></strong><br/><br/>
    </div>
</div>
</body>
</html>