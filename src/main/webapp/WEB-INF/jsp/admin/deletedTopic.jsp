<%@ page import="java.util.List" %>
<%@ page import="cn.jsbintask.bbs.po.TopicVO" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
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
</head>
<%
    if(request.getAttribute("message")!=null) {
        System.out.println("Message is not null");
        String msg = (String) request.getAttribute("message");
        out.write("<script>alert('" + msg + "');</script>");
    }

    List<TopicVO> topicList = (List<TopicVO>) request.getAttribute("topicList");
    if(topicList==null) {
        return;
    }

%>
<body>
<form method="post" action="" id="listform">
    <input type="hidden" id="type" name="type">
    <input type="hidden" id="orderBy" name="orderBy">
    <!--写一个隐藏于，恢复完帖子后再从这里回来-->
    <input type="hidden" name="initUrl" value="deletedTopic">
    <input type="hidden" name="st">
    <div class="panel admin-panel">
        <div class="panel-head"><strong class="icon-reorder"> 所有帖子</strong>
        </div>
        <div class="padding border-bottom">
            <ul class="search" style="padding-left:10px;">

                <li>
                    <input type="text" placeholder="请输入帖子关键字" name="keywords" class="input"
                           style="width:250px; line-height:17px;display:inline-block"/>
                    <a class="button border-main icon-search" onclick="changesearch()"> 搜索</a>
                </li>  <!--搜索帖子结束啦-->
            </ul>
        </div>
        <table class="table table-hover text-center">
            <tr>
                <th width="6%" style="text-align:left; padding-left:20px;">序号</th>
                <th width="8%">作者</th>
                <th width="6%">回复数</th>
                <th width="33%">主题</th>
                <th width="8%">属性</th>
                <th width="8%">状态</th>
                <th width="20%">发帖时间</th>
                <th width="auto">操作</th>
            </tr>
            <volist name="list" id="vo">
                <%
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
                    for (int i = 0; i < topicList.size(); i++) {
                        TopicVO topicVO = topicList.get(i);
                        String index = topicVO.getIndex() == 1 ? "置顶" : "普通";
                        String flag = topicVO.getFlag() == 1? "正常" : "被删除";
                %>
                <tr>
                    <td style="text-align:left; padding-left:20px;">
                        <input type="checkbox" name="id[]" value="<%=topicVO.getTopic_id()%>">
                        <%=i + 1%>
                    </td>
                    <td><%=topicVO.getUser().getUsername()%>
                    </td>
                    <td width="10%"><%=topicVO.getReply_number()%>
                    </td>
                    <td><a href="/topic/detail/<%=topicVO.getTopic_id()%>" target="_blank"><%=topicVO.getTopic()%>
                    </a></td>
                    <td><a href="#"><%=index%></a></td>
                    <td><a href="#"><%=flag%></a></td>
                    <td><%=sdf.format(topicVO.getCreate_time())%></td>
                    <td>
                        <div class="button-group">
                            <a class="button border-red" href="javascript:void(0)" onclick="return del()">
                                <span class="icon-trash-o"></span> 恢复</a>
                        </div>
                    </td>
                </tr> <!--一条帖子结束啦-->
                <%
                    }
                %>

                <tr>
                    <td style="text-align:left; padding:19px 0;padding-left:20px;">
                        <input type="checkbox" id="checkall"/>全选
                    </td>
                    <td colspan="7" style="text-align:left;padding-left:20px;">
                        <a href="javascript:void(0)" class="button border-red icon-trash-o" style="padding:5px 15px;"
                           onclick="delBatch()"> 批量恢复</a>
                        <a href="javascript:void(0)" style="padding:5px 15px; margin:0 10px;"
                           class="button border-blue icon-edit" onclick="indexBatch()"> 取消置顶</a></td>
                    </td>
                </tr> <!--批量操作结束啦-->

                <tr>
                    <td colspan="8">
                        <div class="pagelist"><a href="">上一页</a> <span class="current">1</span><a href="">2</a>
                            <a href="">3</a><a href="">下一页</a><a href="">尾页</a></div>
                    </td>
                </tr> <!-- 分页区结束啦-->
            </volist>
        </table>
    </div>
</form>
<script type="text/javascript">

    //搜索
    function changesearch() {
        alert("..");
    }

    //单个删除
    function del() {
        if (confirm("您确定要恢复该条帖子吗?")) {
            $("input[name='st']").val("1");
            $("input[name='type']").val("flag");
            $("#listform").attr("action", "/admin/updateTopicStatus");
            $("#listform").submit();
        }
    }

    //批量删除
    function delBatch() {
        var Checkbox = false;
        $("input[name='id[]']").each(function () {
            if (this.checked == true) {
                Checkbox = true;
            }
        });
        if (Checkbox) {
            var t = confirm("您确认要恢复选中的所有帖子吗？");
            if (t == false) return false;
            $("input[name='st']").val("1");
            $("input[name='type']").val("flag");
            $("#listform").attr("action", "/admin/updateTopicStatus");
            $("#listform").submit();
        }
        else {
            alert("请选择您要恢复的帖子!");
            return false;
        }
    }

    //批量置顶
    function indexBatch() {
        var Checkbox = false;
        $("input[name='id[]']").each(function () {
            if (this.checked == true) {
                Checkbox = true;
            }
        });
        if (Checkbox) {
            var t = confirm("您确认取消置顶所有内容吗？");
            if (t == false) return false;
            $("#type").val("index");
            $("#status").val("0");
            $("#listform").submit();
        }
        else {
            alert("请选择要操作的内容!");
            return false;
        }
    }

    //全选
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


</script>
</body>
</html>