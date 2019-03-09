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
    if (request.getAttribute("message") != null) {
        System.out.println("Message is not null");
        String msg = (String) request.getAttribute("message");
        out.write("<script>alert('" + msg + "');</script>");
    }
    List<TopicVO> topicVOList = (List<TopicVO>) request.getAttribute("topicVOList");
    if (topicVOList == null) {
        return;
    }

%>
<body>
<form method="post" action="/admin/updateTopicStatus" id="updateForm">
    <input id="sort" type="hidden" name="sort">
    <input type="hidden" name="type" id="type">
    <input type="hidden" name="st" id="status">
    <div class="panel admin-panel">
        <div class="panel-head"><strong class="icon-reorder"> 所有帖子</strong>
        </div>
        <div class="padding border-bottom">
            <ul class="search" style="padding-left:10px;">

                <if condition="$iscid eq 1">
                    <li>
                        <select name="cid" id="option1" class="input" style="width:200px; line-height:17px;"
                                onchange="optionChange()">
                            <option value="time">时间排序</option>
                            <option value="fire">倒序人气</option>
                        </select>
                    </li>
                </if> <!--排序div结束啦-->
                <li>
                    <input type="text" placeholder="请输入帖子关键字" required name="topicName" class="input"
                           style="width:250px; line-height:17px;display:inline-block"/>
                    <a class="button border-main icon-search" href="javascript:void(0);" onclick="changesearch()"> 搜索</a>
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
                    for (int i = 0; i < topicVOList.size(); i++) {
                        TopicVO topicVO = topicVOList.get(i);
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
                                <span class="icon-trash-o"></span> 删除</a>
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
                           onclick="delBatch()"> 批量删除</a>
                        <a href="javascript:void(0)" style="padding:5px 15px; margin:0 10px;"
                           class="button border-blue icon-edit" onclick="indexBatch()"> 批量置顶</a></td>
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
    function optionChange() {
        $("#sort").val($("#option1").val());
        $("#updateForm").attr("action", "/admin/allTopic");
        $("#updateForm").submit();
    }

    //搜索
    function changesearch() {
        $("#updateForm").attr("action", "/admin/allTopic");
        $("#updateForm").submit();
    }

    //单个删除
    function del() {
        if (confirm("您确定要删除吗?")) {
            $("#type").val("flag");
            $("#status").val("0");
            $("#updateForm").submit();
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
            var t = confirm("您确认要置顶所有内容吗？");
            if (t == false) return false;
            $("#type").val("index");
            $("#status").val("1");
            $("#updateForm").submit();
        }
        else {
            alert("请选择要操作的内容!");
            return false;
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
            var t = confirm("您确认要删除选中的内容吗？");
            if (t == false) return false;
            $("#type").val("flag");
            $("#status").val("0");
            $("#updateForm").submit();
        }
        else {
            alert("请选择您要删除的内容!");
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