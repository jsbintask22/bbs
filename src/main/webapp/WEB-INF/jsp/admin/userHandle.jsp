<%@ page import="cn.jsbintask.bbs.po.User" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta name="renderer" content="webkit">
    <title></title>
    <link rel="stylesheet" href="/css/admin/pintuer.css">
    <link rel="stylesheet" href="/css/admin/admin.css">
    <script src="/js/admin/jquery.js"></script>
    <script src="/js/admin/pintuer.js"></script>
    <%
        if(request.getAttribute("message")!=null) {
            System.out.println("Message is not null");
            String msg = (String) request.getAttribute("message");
            out.write("<script>alert('" + msg + "');</script>");
        }
        List<User> userList = (List<User>) request.getAttribute("userList");
        if(userList==null) {
            return;
        }
    %>
</head>
<body>
<form method="post" action="/admin/usersStatusUpdate" id="form">
    <input type="hidden" value="0" name="st"/>
    <div class="panel admin-panel">
        <div class="panel-head"><strong class="icon-reorder"> 用户操作</strong></div>
        <div class="padding border-bottom">
            <ul class="search">
                <li>
                    <button type="button" class="button border-green" id="checkall"><span class="icon-check"></span> 全选
                    </button>
                    <button type="submit" class="button border-red" id="shutupBatch"><span class="icon-trash-o"></span>
                        批量禁言
                    </button>
                </li>
                <li>
                    <%
                        String username = "";
                        if(request.getAttribute("username")!=null) {
                            username = (String) request.getAttribute("username");
                        }
                    %>
                    <input type="text" placeholder="请输入用户名关键字" value="<%=username%>" name="keywords" class="input"
                           style="width:250px; line-height:19px;display:inline-block"/>
                    <a href="javascript:void(0)" class="button border-main icon-search" onclick="javascript:searchUsers();"> 搜索</a>
                </li>
            </ul>
        </div>
        <table class="table table-hover text-center">
            <tr>
                <th >ID</th>
                <th>用户名</th>
                <th>电话</th>
                <th>邮箱</th>
                <th>学院</th>
                <th >状态</th>
                <th>学号</th>
                <th >发帖数</th>
                <th>操作</th>
            </tr> <!--表格头结束啦-->

            <%
                for(int i = 0;i < userList.size();i++) {
                    User user = userList.get(i);
                    String flag = user.getStatus()==0? "禁言中" :  "正常";

            %>
            <tr>
                <td><input type="checkbox" name="id[]" value="<%=user.getUser_id()%>"/>
                    <%=i+1%>
                </td>
                <td><a href="/user/<%=user.getUser_id()%>" target="_blank"><%=user.getUsername()%></a></td>
                <td><%=user.getPhone()%></td>
                <td><%=user.getEmail()%></td>
                <td><%=user.getSdept()%></td>
                <td><%=flag%></td>
                <td><%=user.getSno()%></td>
                <td><%=user.getArticle_num()%></td>
                <td>
                    <div class="button-group"><a class="button border-red" href="javascript:void(0)"
                                                 onclick="return shutup(<%=user.getUser_id()%>)"><span class="icon-trash-o"></span> 禁言</a></div>
                </td>
            </tr> <!--一个用户结束啦-->

            <%
                }
            %>

            <tr>
                <td colspan="8">
                    <div class="pagelist"><a href="">上一页</a> <span class="current">1</span><a href="">2</a><a
                            href="">3</a><a href="">下一页</a><a href="">尾页</a></div>
                </td>
            </tr> <!--分页结束啦-->
        </table>
    </div>
</form>
<script type="text/javascript">

    function searchUsers() {
        $("#form").attr("action", "/admin/findUsersByLikeName");
        $("#form").submit();
    }

    function shutup(user_id) {
        if (confirm("您确定要禁言吗?")) {
            $("#form").submit();
        }
    }

    $("#checkall").click(function () {
        $("input[name='id[]']").each(function () {
            if (this.checked) {
                this.checked = false;
            }
            else {
                this.checked = true;
            }
        });
    })

    $("#shutupBatch").click(function() {
        var Checkbox = false;
        $("input[name='id[]']").each(function () {
            if (this.checked == true) {
                Checkbox = true;
            }
        });
        if (Checkbox) {
            var t = confirm("您确认要禁言选中的用户吗？");
            if (t == false) return false;
            $("form").submit();
        }
        else {
            alert("请选择您要禁言的用户!");
            return false;
        }
    });

</script>
</body>
</html>