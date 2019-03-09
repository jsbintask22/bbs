<%@ page import="cn.jsbintask.bbs.po.User" %>
<%@ page import="cn.jsbintask.bbs.po.Attention" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>我关注的人</title>
    <link rel="stylesheet" href="/css/myinfo/myAttention.css">
    <link rel="stylesheet" href="/css/bootstrap/bootstrap.css">
    <script src="${pageContext.request.contextPath}/js/bootstrap/jquery-3.1.1.min.js"></script>

</head>
<%
    if(request.getAttribute("message")!=null) {
        System.out.println("Message is not null");
        String msg = (String) request.getAttribute("message");
        out.write("<script>alert('" + msg + "');</script>");
    }
    //从session中取出用户信息
    User user = (User) session.getAttribute("user");
    if(user==null) {
        return;
    }
%>
<body>
<div class="panel panel-primary">
    <div class="panel-heading">
        我的关注
    </div>
    <div class="panel-body" style="padding-left: 55px">
        <form action="${pageContext.request.contextPath}/user/cancelAttention">
            <input type="hidden" name="user_id" value="<%=user.getUser_id()%>">
            <input type="hidden" name="puser_id">
        </form>

        <%
            List<Attention> attentionList = (List<Attention>) request.getAttribute("attentionList");
            for(Attention attention : attentionList) {
        %>
          <div class="attention">
             <ul class="nav_att">
                 <li><img class="img-circle" src="/pic/heads/<%=attention.getpUser().getImgurl()%>" width="120px" height="120px"></li>
                 <li><a href="/otherSpace/<%=attention.getpUser().getUser_id()%>" target="_blank"><strong style="font-size: 20px"><%=attention.getpUser().getUsername()%></strong></a></li>
                 <li><button class="btn btn-success" onclick="cancelAtt(<%=attention.getpUser().getUser_id()%>)">取消关注</button></li>
             </ul>
          </div><!--一个关注用户的信息结束了-->

        <%
            }
        %>
    </div>
    <script>
        function cancelAtt(puser_id) {
            $("input[name='puser_id']").val(puser_id);
            $("form").submit();
        }
    </script>
</div>
</body>
</html>