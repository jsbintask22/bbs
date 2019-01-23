<%@ page import="cn.jsbintask.bbs.po.TopicVO" %>
<%@ page import="cn.jsbintask.bbs.po.User" %>
<%@ page import="cn.jsbintask.bbs.utils.PageUtil" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>所有帖子</title>
<!-- 设置一个变量 -->
<c:set value="${pageContext.request.contextPath}" var="path" scope="page"/>
<link rel="stylesheet" href="${path }/css/article/showTopics.css">
<link rel="stylesheet" href="${path }/css/article/loginDialog.css">
<link rel="stylesheet" href="${path }/css/bootstrap/bootstrap.min.css">
<script src="${path }/js/bootstrap/jquery-3.1.1.min.js"></script>
<script src="${path }/js/article/loginDialog.js"></script>
	<%
		if(request.getAttribute("message")!=null) {
			System.out.println("Message is not null");
			String msg = (String) request.getAttribute("message");
			out.write("<script>alert('" + msg + "');</script>");
		}
	%>
<script>
	window.onload = function() {
		var sort = document.getElementById('sort');
		var lis = sort.getElementsByTagName('li');
		for (var i = 0; i < lis.length; i++) {
			lis[i].onclick = function() {
				for (var j = 0; j < lis.length; j++) {
					lis[j].className = '';
				}
				this.className = 'active';
			}
		}
	}
</script>
</head>
<body>
<%
	//查看是否登录，将session中数据取出来
	User user = (User)session.getAttribute("user");
	String loginStr = "注册和登录";
	String login = "login";
	String hrefStr = "javascript:void(0);";
	String headImage = "defaultHead.png";
	if(user!=null&&user.getImgurl()!=null) {
	    headImage = user.getImgurl();
	}
	if(user!=null) {
		loginStr = "欢迎" + user.getUsername();
		login = "otherLogin";
		hrefStr = "/user/" + user.getUser_id();
	}

	//获得所有的帖子
	List<TopicVO> topicList = (List<TopicVO>) request.getAttribute("topics");
	if(topicList==null) {
	    return;
    }

%>

	<form method="post" action="${pageContext.request.contextPath}/user/showTopics">
		<input type="hidden" name="flag" value="1">
		<div id="LoginBox" class="form-inline">
			<div class="row1">
				帐号登陆
				<a href="javascript:void(0)" title="关闭窗口" class="close_btn" id="closeBtn">×</a>
			</div>
			<div class="loginRow">
				用户名: <input class="form-control" id="txtName" name="userName" style="width: 230px;" maxlength="20"
					placeholder="邮箱或者学号" />
				<a href="javascript:void(0)" title="提示" class="warning" id="warn">*</a>
			</div>
			<div class="loginRow">
				密&nbsp;&nbsp;&nbsp;码: <input type="password" id="txtPwd" name="password" class="form-control" style="width: 230px;"
					placeholder="密码" maxlength="15" />
				<a href="javascript:void(0)" title="提示" class="warning" id="warn2">*</a>
			</div>
			<div class="loginRow">
				<input type="submit" id="loginbtn" class="btn btn-info" value="登录" />
				<a href="${pageContext.request.contextPath}/user/userLogin" target="_blank" class="text-success" style="font-size: 12px">没有账号？</a>
			</div>
		</div>
		<!--登录弹出层结束了-->
	</form>
	<!--登录表单结束啦-->

	<div class="header">
		<div class="logo">
			<div class="logo_img">
				<a href="${pageContext.request.contextPath}/topic/all">
					<img src="${path }/images/article/article_bg.png">
				</a>
			</div>
			<!--左边图片logo区结束了-->

			<div class="logo_info">
				<a href="<%=hrefStr%>">
					<img class="img-circle" src="${path }/pic/heads/<%=headImage%>" title="点击查看个人信息">
				</a>
			</div>
			<!--右边头像，信息区-->
		</div>
		<!--最上面logo区结束了-->

		<%
			 String sort = request.getParameter("sort");
			 String activeName = "active";
			 String normal = "";
			 if(sort!=null) {
				 if (sort.equals("fire")) {
					 activeName = "";
					 normal = "active";
				 }
			 }
		%>
		<div class="header_nav">
			<ul class="nav nav-pills" id="sort">
				<li class="<%=activeName%>"><a href="${pageContext.request.contextPath}/topic/all">
						<span class="glyphicon glyphicon-time"></span> 最新帖子
					</a></li>
				<li class="<%=normal%>"><a href="${pageContext.request.contextPath}/topic/all?sort=fire">
						<span class="glyphicon glyphicon-fire"></span> 人气帖子
					</a></li>
			</ul>
			<!--帖子排导航区结束了-->
			<div class="nav_btn">
				<a class="btn btn-success" href="${pageContext.request.contextPath}/topic/postTopic">
					<span class="glyphicon glyphicon-share"></span> 我要发帖
				</a>
				<a class="btn btn-success" style="width: 80px" href="${pageContext.request.contextPath}/topic/all">
					<span class="glyphicon glyphicon-refresh"></span> 刷新
				</a>
			</div>
		</div>
		<!--导航区结束了-->

		<%
			PageUtil pu = (PageUtil) request.getAttribute("pageUtil");
			int pageNum = pu.getPageNum();
			String sortType = "";
			if(normal.equals("active")) {
			    sortType = "fire";
			}
		%>
		<!--分页区-->
		<div class="page_header">
			<ul class="pagination">
				<li><a href="${pageContext.request.contextPath}/topic/all?pageNum=<%=pageNum-1%>&sort=<%=sortType%>">&laquo;</a></li>
				<%
					for(int i = 0; i< pu.getMaxPage();i++) {
				%>
				<li class=""><a href="${pageContext.request.contextPath}/topic/all?pageNum=<%=i+1%>&sort=<%=sortType%>"><%=i+1%></a></li>

				<%
					}
				%>
				<li><a href="${pageContext.request.contextPath}/topic/all?pageNum=<%=pageNum+1%>&sort=<%=sortType%>">&raquo;</a></li>
			</ul>

			<script>
				$(".pagination li").each(function () {
					var html = $(this).text();
					if(html == <%=pageNum%>) {
					    $(this).addClass("active");
					}
                })
			</script>

			<!--显示用户信息区域-->
			<a class="btn btn-info rigister" id="<%=login%>" href="<%=hrefStr%>">
				<span class="glyphicon glyphicon-user"></span> <%=loginStr%>
			</a>

			<!--模糊查找区域-->
			<form class="form-inline article_search" method="post" action="${pageContext.request.contextPath}/topic/all">
				<input class="form-control" placeholder="查找帖子" name="topicName" style="width: 250px;">
				<input class="btn btn-danger" type="submit" value="搜索" style="width: 80px">
			</form>
			<!--查找帖子区结束了-->
		</div>
		<!--分页区结束了-->

	</div>
	<!--顶部信息区结束了-->


	<div class="main">
		<table class="table table-hover table-striped">
			<thead class="bg-info">
				<th style="width: 8%">置顶</th>
				<th style="width: 8%">浏览数</th>
				<th style="width: 45%">主题</th>
				<th style="width: 8%">作者</th>
				<th style="width: 8%">回复数</th>
				<th style="width: 15%">发帖时间</th>
				<th style="width: 10%">最后回复</th>
			</thead>
			<tbody class="">
			<%
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                for (TopicVO topic : topicList) {
                    String className = topic.getIndex() == 1 ? "danger" : "";
                    String fontGlyp = "glyphicon-leaf";
                    String flash = "";
                    if (topic.getIndex() == 1) {
                        fontGlyp = "glyphicon-thumbs-up";
                        flash = "glyphicon glyphicon-flash";
                    }
                    Integer viewCount = (Integer) application.getAttribute("" + topic.getTopic_id().intValue());
                    int view = 0;
                    if (viewCount != null) {
                        view = viewCount;
                    }
            %>
            <tr class="<%=className%>">
                <td><span class="glyphicon <%=fontGlyp%>"></span></td>
                <td><%=view%>
                </td>
                <td><a href="/topic/detail/<%=topic.getTopic_id()%>" title="精品帖子">
                    <span class="<%=flash%>"></span> <%=topic.getTopic()%>
                </a></td>
                <td><%=topic.getUser().getUsername()%>
                </td>
                <td><%=topic.getReply_number()%>
                </td>
                <td><%=sdf.format(topic.getCreate_time())%>
                </td>
                <td><span class="glyphicon glyphicon-user"></span> <%=topic.getLastReplyName()%>
                </td>
            </tr>
            <%
                }
            %>

			</tbody>
		</table>
	</div>
	<!--中间帖子展示区结束了-->
	<div class="footer">
		<div class="footer_main">
			<p>
				地址：中华人名共和国 邮编：414006 电话：0730-86001 投稿邮箱：jsbintask@gmail.com<br> Copyright jsbintask 2010-2019
				. All Rights Reserved. ICP备05005891号 教QS3-200505-000078
			</p>
		</div>
		<div class="footer_right">
			<ul>
				<li><img src="${path}/images/article/weibo.png"></li>
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
	</div>
	<!--底部信息展示区结束了-->
</body>
</html>