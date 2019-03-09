<%@ page import="cn.jsbintask.bbs.po.TopicVO" %>
<%@ page import="java.util.List" %>
<%@ page import="cn.jsbintask.bbs.po.ArticleVO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="cn.jsbintask.bbs.po.User" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<!-- 设置一个变量 -->
<c:set value="${pageContext.request.contextPath}" var="path" scope="page"/>
<!-- 定义一个加载编辑器的变量 -->
<c:set value="${path}" var="umPath" scope="page"/>
<head>
    <meta charset="UTF-8">
    <title>帖子详情</title>
    <link rel="stylesheet" href="${path }/css/article/box.css">
    <link rel="stylesheet" href="${path }/css/bootstrap/bootstrap.min.css">
    <script src="${path }/js/bootstrap/jquery-3.1.1.min.js"></script>

    <!--umeditorjs文件：-->
    <link href="${umPath }/umeditor/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
    <script type="text/javascript" src="${umPath }/umeditor/third-party/jquery.min.js"></script>
    <script type="text/javascript" src="${umPath }/umeditor/third-party/template.min.js"></script>
    <script type="text/javascript" charset="utf-8" src="${umPath }/umeditor/umeditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="${umPath }/umeditor/umeditor.min.js"></script>
    <script type="text/javascript" src="${umPath }/umeditor/lang/zh-cn/zh-cn.js"></script>

    <script>
        $(function () {
            $(".header_nav ul li").each(function () {
                $(this).click(function () {
                    $(this).siblings().removeClass("active");
                    $(this).addClass("active");
                });
            });

            $(".msg_content img, .ref_msg img").each(function (index) {
                if($(this).width() > 730) {
                    $(this).width(700 + 'px');
                }
            });

        })
        //回复用的函数，参数分别为被回复的人id和是否引用
        function replyArticle(puser_id, arefid) {
            $("#puser_id").val(puser_id);
            $("#arefid").val(arefid);
            //编辑器获得焦点
            $(window).scrollTop($(window).height + 250);
            UM.getEditor('myEditor').focus();
        }

        function confirmReply() {
            if(UM.getEditor('myEditor').hasContents()==false) {
                alert('请输入内容');
                return false;
            }
            if($.trim(UE.getEditor('editor').getPlainTxt())=='') {
                alert('内容不能为空');
                return false;
            }
            return true;
        }
    </script>

    <%
        if(request.getAttribute("message")!=null) {
            System.out.println("Message is not null");
            String msg = (String) request.getAttribute("message");
            out.write("<script>alert('" + msg + "');</script>");
        }
    %>

</head>
<%
    //首先获得属性
    TopicVO topicVO = (TopicVO) request.getAttribute("topicVO");
    System.out.println("这是articleDetail页面的主题号：" + topicVO.getTopic_id());
    User user = (User) session.getAttribute("user");
    String hrefStr = "javascript:void(0);";
    String headImage = "defaultHead.png";
    if(user!=null&&user.getImgurl()!=null) {
        headImage = user.getImgurl();
    }
    if(user!=null) {
        hrefStr = "/user/" + user.getUser_id();
    }
    //头像信息
    if(user!=null&&user.getImgurl()!=null) {
        headImage = user.getImgurl();
    }
    //做一个时间转化的对象
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm");
    if(topicVO == null) {
        return;
    }
%>
<body>

<div class="header">

    <div class="logo">
        <div class="logo_img">
            <a href="/topic/all"><img src="${path }/images/article/article_bg.png" alt="点击图片返回首页"
                                           title="点击图片返回首页"></a>
        </div><!--左边图片logo区结束了-->

        <div class="logo_info">
            <a href="<%=hrefStr%>"><img class="img-circle" src="${path }/pic/heads/<%=headImage%>"></a>
        </div><!--右边头像，信息区-->
    </div><!--最上面logo区结束了-->

    <%
        String sort = request.getParameter("sort");
        String activeName = "active";
        String normal = "";
        if(sort!=null) {
            if (sort.equals("reverse")) {
                activeName = "";
                normal = "active";
            }
        }
    %>

    <div class="header_nav">
        <ul class="nav nav-pills">
            <li class="<%=activeName%>"><a href="/topic/detail/<%=topicVO.getTopic_id()%>?sort=time">最新回复</a></li>
            <li class="<%=normal%>"><a href="/topic/detail/<%=topicVO.getTopic_id()%>?sort=reverse">倒序查看</a></li>
        </ul><!--帖子排导航区结束了-->
        <div class="nav_btn">
            <!--回复楼主的按钮，把用户信息的值注入到应该的地方 -->
            <a class="btn btn-success" href="javascript:void(0);" onclick="replyArticle(<%=topicVO.getUser_id()%>, null)">回复楼主</a>
            <a class="btn btn-success" style="width: 80px" href="javascript:void(0);" onclick="javascript:window.history.go(0);">刷新</a>
        </div>
    </div><!--导航区结束了-->

</div><!--顶部信息区结束了-->

<!--楼主的信息（必有）：-->
<div class="article_topic">
    <strong>主题：</strong><%=topicVO.getTopic()%>&nbsp;&nbsp;&nbsp;&nbsp;<a class="btn btn-danger" href="/topic/collectTopic?topic_id=<%=topicVO.getTopic_id()%>">收藏此贴</a>
</div>

<div class="box">
    <div class="user_info">
        <img src="${path }/pic/heads/<%=topicVO.getUser().getImgurl()%>" class="img-circle"/>
        <h5 class="h5">
            <a href="/otherSpace/<%=topicVO.getUser_id()%>"><%=topicVO.getUser().getUsername()%></a>
        </h5>
        <p>
            累计发帖：<%=topicVO.getUser().getArticle_num()%>
        </p>
        <p style="color: goldenrod">回帖积分：<%=topicVO.getUser().getReply_num()*20%></p>
    </div>
    <div class="message">
        <div class="msg_header">
            <mark>楼主</mark>
            <span class="bg-success time">发帖时间：<%=sdf.format(topicVO.getCreate_time())%></span>
        </div>
        <div class="msg_content">
                <%=topicVO.getContent()%>
        </div>
        <div class="msg_footer">
            <a class="btn btn-success" href="javascript:void(0);" onclick="replyArticle(<%=topicVO.getUser_id()%>, null)">回复</a>
        </div>
    </div>
</div> <!--楼主的信息结束了-->

<%
    List<ArticleVO> articleList = topicVO.getOneToArticles();
    for(int i = 0; i < articleList.size(); i++) {
        ArticleVO articleVO = articleList.get(i);
        if(articleVO.getArefid()==null) {
%>
<!--为了下面能隔开，做一个过渡的div-->
<div style="clear: both"></div>
<div class="box">
    <div class="user_info">
        <img src="${path }/pic/heads/<%=articleVO.getUser().getImgurl()%>" class="img-circle"/>
        <h5 class="h5">
            <a href="/otherSpace/<%=articleVO.getUser_id()%>"><%=articleVO.getUser().getUsername()%></a>
        </h5>
        <p>
            累计发帖：<%=articleVO.getUser().getArticle_num()%>
        </p>
        <p style="color: goldenrod">回帖积分：<%=articleVO.getUser().getReply_num()*20%></p>
    </div>
    <div class="message">
        <div class="msg_header">
            <mark><%=articleVO.getLevel()%> 楼</mark>
            <span class="bg-success time">回复时间：<%=sdf.format(articleVO.getReply_time())%></span>
        </div>
        <div class="msg_content">
                <%=articleVO.getContent()%>
        </div>
        <div class="msg_footer">
            <a class="btn btn-success" href="javascript:void(0);" onclick="replyArticle(<%=articleVO.getUser_id()%>, <%=articleVO.getArticle_id()%>)">引用</a>
        </div>
    </div>
</div> <!--回复楼主的信息结束了-->

<%
    } else {
            ArticleVO refArticleVO = articleVO.getRefArticleVO();
            System.out.println("ArticleVO里面arefId的值是： " + articleVO.getArefid());
%>


<!--为了下面能隔开，做一个过渡的div-->
<div style="clear: both"></div>

<div class="box">
    <div class="user_info">
        <img src="${path }/pic/heads/<%=articleVO.getUser().getImgurl()%>" class="img-circle"/>
        <h5 class="h5">
            <a href="/otherSpace/<%=articleVO.getUser_id()%>"><%=articleVO.getUser().getUsername()%></a>
        </h5>
        <p>累计发帖：<%=articleVO.getUser().getArticle_num()%></p>
        <p style="color: goldenrod">回帖积分：<%=articleVO.getUser().getReply_num()*20%></p>
    </div><!--左边用户头像和基本信息-->
    <div class="message">
        <div class="msg_header">
            <mark><%=articleVO.getLevel()%> 楼</mark>
            <span class="bg-success time">回复时间：<%=sdf.format(articleVO.getReply_time())%></span>
        </div>
        <div class="ref_msg">
            <form>
                <fieldset>
                    <legend style="font-size: 18px">
                        引用 <span style="color: lightseagreen"><%=refArticleVO.getLevel()%>楼  <a href="/otherSpace/<%=refArticleVO.getUser_id()%>"><%=refArticleVO.getUser().getUsername()%></a></span> 的回复：
                    </legend>
                    <%=refArticleVO.getContent()%>
                </fieldset>
            </form>
        </div>
        <div class="msg_content">
                <%=articleVO.getContent()%>
        </div>
        <div class="msg_footer">
            <a class="btn btn-success" href="javascript:void(0);" onclick="replyArticle(<%=articleVO.getUser_id()%>, <%=articleVO.getArticle_id()%>)">引用</a>
        </div>
    </div>
</div> <!--引用别人的回复信息区结束啦-->

<%
    }
    }
%>

<!--为了下面能隔开，做一个过渡的div-->
<div style="clear: both"></div>

<!--umeditor: -->
<!--style给定宽度可以影响编辑器的最终宽度-->
<div class="umeditor">
    <form class="form-group-lg" action="/article/postArticle" method="post" onsubmit="return confirmReply();">
        <%if(user!=null){%>
            <input type="hidden"  name="user_id" value="<%=user.getUser_id()%>"/>
        <%} else {%>
            <input type="hidden"  name="user_id"/>
        <%}%>
        <input type="hidden" name="puser_id" id="puser_id" value="<%=topicVO.getUser_id()%>"/>
        <input type="hidden" name="arefid" id="arefid"/>
        <input type="hidden" value="<%=topicVO.getTopic_id()%>" name="topic_id"/>
        <script type="text/plain" id="myEditor" name="myEditor" style="width:955px;min-height:210px;">
            <p></p>

        </script>

        <input type="submit" class="btn btn-info" value="确认回复"/>
            </form>
</div>

<!--编辑器结束了-->
<!--实例化编辑器的代码，不能少-->
<script type="text/javascript">
    //实例化编辑器
    var um = UM.getEditor('myEditor');
</script>

<div class="footer">
    <div class="footer_main">
        <p>
            地址：中华人名共和国 邮编：414006 电话：0730-86001 投稿邮箱：jsbintask@gmail.com<br> Copyright jsbintask 2010-2019
            . All Rights Reserved. ICP备05005891号 教QS3-200505-000078
        </p>
    </div>
    <div class="footer_right">
        <ul>
            <li><img src="${path }/images/article/weibo.png"></li>
            <li>微博</li>
        </ul>
        <ul>
            <li><img src="${path }/images/article/app.png"></li>
            <li>app</li>
        </ul>
        <ul>
            <li><img src="${path }/images/article/wechat.png"></li>
            <li>微信</li>
        </ul>
    </div>
</div><!--底部信息展示区结束了-->
</body>
</html>