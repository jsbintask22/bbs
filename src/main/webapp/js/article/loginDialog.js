/**
 * Created by Administrator on 2017/5/31.
 */
$(function ($) {
    //弹出登录
    $("#login").hover(function () {
        $(this).stop().animate({
            opacity: '1'
        }, 600);
    }, function () {
        $(this).stop().animate({
            opacity: '0.6'
        }, 1000);
    }).on('click', function () {
        $("body").append("<div id='mask'></div>");
        $("#mask").addClass("mask").fadeIn("slow");
        $("#LoginBox").fadeIn("slow");
    });
    //
    //按钮的透明度
    $("#loginbtn").hover(function () {
        $(this).stop().animate({
            opacity: '1'
        }, 600);
    }, function () {
        $(this).stop().animate({
            opacity: '0.8'
        }, 1000);
    });
    //文本框不允许为空---按钮触发
    $("#loginbtn").on('click', function () {
        var txtName = $("#txtName").val();
        var txtPwd = $("#txtPwd").val();
        if (txtName == "" || txtName == undefined || txtName == null) {
            if (txtPwd == "" || txtPwd == undefined || txtPwd == null) {
                $(".warning").css({ display: 'block' });
            }
            else {
                $("#warn").css({ display: 'block' });
                $("#warn2").css({ display: 'none' });
            }
        }
        else {
            if (txtPwd == "" || txtPwd == undefined || txtPwd == null) {
                $("#warn").css({ display: 'none' });
                $(".warn2").css({ display: 'block' });
            }
            else {
                $(".warning").css({ display: 'none' });
            }
        }
    });
    //文本框不允许为空---单个文本触发
    $("#txtName").on('blur', function () {
        var txtName = $("#txtName").val();
        if (txtName == "" || txtName == undefined || txtName == null) {
            $("#warn").css({ display: 'block' });
        }
        else {
            $("#warn").css({ display: 'none' });
        }
    });
    $("#txtName").on('focus', function () {
        $("#warn").css({ display: 'none' });
    });
    //
    $("#txtPwd").on('blur', function () {
        var txtName = $("#txtPwd").val();
        if (txtName == "" || txtName == undefined || txtName == null) {
            $("#warn2").css({ display: 'block' });
        }
        else {
            $("#warn2").css({ display: 'none' });
        }
    });
    $("#txtPwd").on('focus', function () {
        $("#warn2").css({ display: 'none' });
    });
    //关闭
    $(".close_btn").hover(function () { $(this).css({ color: 'black' }) }, function () { $(this).css({ color: '#999' }) }).on('click', function () {
        $("#LoginBox").fadeOut("fast");
        $("#mask").css({ display: 'none' });
    });
});
