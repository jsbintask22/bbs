<%@ page import="cn.jsbintask.bbs.po.User" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>编辑用户信息</title>
    <link rel="stylesheet" href="/css/bootstrap/bootstrap.css">
    <link rel="stylesheet" href="/css/myinfo/mySpace.css">
    <script src="/js/bootstrap/jquery-3.1.1.min.js"></script>

    <script>
        window.onload = function () {
            document.getElementById('imgUrl').onchange = function (evt) {
                // 如果浏览器不支持FileReader，则不处理
                if (!window.FileReader) return;
                var files = evt.target.files;
                for (var i = 0, f; f = files[i]; i++) {
                    if (!f.type.match('image.*')) {
                        continue;
                    }
                    var reader = new FileReader();
                    reader.onload = (function (theFile) {
                        return function (e) {
                            // images 元
                            document.getElementById('ImgPr').src = e.target.result;
                        };
                    })(f);
                    reader.readAsDataURL(f);
                }
            }
        }
    </script>

    <%
        if (request.getAttribute("message") != null) {
            System.out.println("Message is not null");
            String msg = (String) request.getAttribute("message");
            out.write("<script>alert('" + msg + "');</script>");
        }
        //从session中取出用户信息
        User user = (User) session.getAttribute("user");
        if (user == null) {
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
        <h3 class="panel-title">编辑信息</h3>
    </div>
    <div class="panel-body">
        <form class="form-inline" method="post" action="/user/myInfoUpdate" enctype="multipart/form-data">
            <input type="hidden" value="<%=user.getUser_id()%>" name="user_id">
            <span class="text-info">用户名：</span>
            <input class="form-control" value="<%=user.getUsername()%>" name="username"><br/><br/>

            <span class="text-info">性&nbsp;&nbsp; 别：</span>
            <label class="checkbox-inline">
                <input type="radio" name="sex" value="男" checked>男 </label>
            <label class="checkbox-inline">
                <input type="radio" name="sex" value="女"> 女</label><br/><br/>

            <span class="text-info">学&nbsp;&nbsp; 院：</span>
            <input class="form-control"  name="sdept" value="<%=user.getSdept()%>"><br/><br/>

            <span class="text-info">班&nbsp;&nbsp; 级：</span>
            <input class="form-control" name="clazz" value="<%=user.getClazz()%>"><br/><br/>

            <span class="text-info">手&nbsp;&nbsp; 机：</span>
            <input class="form-control" name="phone" value="<%=user.getPhone()%>" pattern="^1[0-9]{10}$"><br/><br/>

            <span class="text-info">头&nbsp;&nbsp; 像：</span>
            <input class="form-control" name="imgUrl" id="imgUrl" type="file"
                   accept="image/jpeg,image/png,image/jpg"><br/><br/>

            <img class="img-circle" id="ImgPr" src="${path }/pic/heads/<%=headImage%>" width="110px"
                 height="110px"><br/><br/>

            <span class="text-info">签&nbsp;&nbsp;名：</span>
            <input class="form-control" value="<%=user.getSign()%>" name="sign"><br/><br/>

            <input class="btn btn-success" type="submit" value="确认修改"/>
        </form>
    </div>
</div>
</body>
</html>