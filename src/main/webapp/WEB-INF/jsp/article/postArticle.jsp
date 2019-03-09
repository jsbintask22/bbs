<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set value="${pageContext.request.contextPath }" var="path" scope="page"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>发表新帖</title>
    <link rel="stylesheet" href="${path }/css/article/box.css">
    <link rel="stylesheet" href="${path }/css/bootstrap/bootstrap.min.css">
    <script src="${path }/js/bootstrap/jquery-3.1.1.min.js"></script>
    <link rel="stylesheet" href="${path }/css/article/postArticle.css">


    <!--umeditorjs文件：-->
    <link href="${path }/umeditor/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
    <script type="text/javascript" src="${path }/umeditor/third-party/jquery.min.js"></script>
    <script type="text/javascript" src="${path }/umeditor/third-party/template.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="${path }/umeditor/umeditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="${path }/umeditor/umeditor.min.js"></script>
    <script type="text/javascript" src="${path }/umeditor/lang/zh-cn/zh-cn.js"></script>
</head>
<body>
<div class="header">

    <div class="logo">
        <div class="logo_img">
            <a href="/topic/all"><img src="/images/article/article_bg.png" alt="点击图片返回首页" title="点击图片返回首页"></a>
        </div><!--左边图片logo区结束了-->

        <div class="logo_info">
            <img class="img-circle" src="${path}/images/article/gril.jpg">
        </div><!--右边头像，信息区-->
    </div><!--最上面logo区结束了-->

    <div class="header_nav">
        <ul class="nav nav-pills">
            <li class="active"><a href="javascript:void(0);" onclick="window.history.back();">返回上级</a></li>
            <li><a href="/topic/postTopic">清除内容</a></li>
        </ul><!--帖子排导航区结束了-->
        <div class="nav_btn">
            <a class="btn btn-danger" href="/user/userCancel">安全注销</a>
        </div>
    </div><!--导航区结束了-->

</div><!--顶部信息区结束了-->

<form action="/topic/postTopicInfo" method="post">
    <div class="form-group-lg has-success">
        <strong style="display: inline">主题：</strong>
        <input type="text" class="form-control" name="topic" maxlength="40" width="250px" placeholder="请输入标题">
    </div>
    <strong>内容：</strong>
    <!--umeditor: -->
    <!--style给定宽度可以影响编辑器的最终宽度-->
    <script type="text/plain" id="myEditor" name="myEditor" style="width:1000px;min-height:210px;">
    <p>在此写上您的内容</p>




    </script>
    <input type="submit" class="btn btn-info" value="确认发帖">

    <script type="text/javascript">
        //实例化编辑器
        var um = UM.getEditor('myEditor');
    </script>
</form>
</body>
</html>