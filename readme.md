# bbs
很久以前做的一个简单的论坛系统，使用SSM开发，前端使用主要用jquery+bootstrap开发，并且集成了百度 UEditor，可方便用于毕业，课程设计。 欢迎fork和star

## 系统展示
1. 用户主界面：
![mark](https://raw.githubusercontent.com/jsbintask22/static/master/bbs-resources/main.png)
2. 用户登录注册和邮箱验证码发送
![mark](https://raw.githubusercontent.com/jsbintask22/static/master/bbs-resources/user-login.png)
![mark](https://raw.githubusercontent.com/jsbintask22/static/master/bbs-resources/user-register.png)
![mark](https://raw.githubusercontent.com/jsbintask22/static/master/bbs-resources/checkCode.png)
3. 用户个人信息，查看自己的帖子，收藏，关注用户
![mark](https://raw.githubusercontent.com/jsbintask22/static/master/bbs-resources/personal-info.png)
![mark](https://raw.githubusercontent.com/jsbintask22/static/master/bbs-resources/info.png)
4. 发帖，回帖，帖子详情
![mark](https://raw.githubusercontent.com/jsbintask22/static/master/bbs-resources/post.png)
![mark](https://raw.githubusercontent.com/jsbintask22/static/master/bbs-resources/reply.png)
![mark](https://raw.githubusercontent.com/jsbintask22/static/master/bbs-resources/article-detail.png)
5. 管理员登录，后台主界面
![mark](https://raw.githubusercontent.com/jsbintask22/static/master/bbs-resources/admin-login.png)
![mark](https://raw.githubusercontent.com/jsbintask22/static/master/bbs-resources/admin-main.png)

## 环境搭建
注意点：添加tomcat虚拟目录：
idea：
1. 如下图，然后选择项目中的 bbs_imgs路劲，设置虚拟访问路劲为 /pic
![mark](https://raw.githubusercontent.com/jsbintask22/static/master/bbs-resources/demo1.png)
![mark](https://raw.githubusercontent.com/jsbintask22/static/master/bbs-resources/demo2.png)
2. 修改web.xml中的头像存放路径为刚刚配置的虚拟路径下的heads，如图：
![mark](https://raw.githubusercontent.com/jsbintask22/static/master/bbs-resources/demo3.png)
3. 添加 jar包
![mark](https://raw.githubusercontent.com/jsbintask22/static/master/bbs-resources/demo4.png)
![mark](https://raw.githubusercontent.com/jsbintask22/static/master/bbs-resources/demo5.png)
4. 修改EmailUtil.java中的用户名密码为你自己的用户名密码（注册时使用该邮箱发送验证码）
![mark](https://raw.githubusercontent.com/jsbintask22/static/master/bbs-resources/demo6.png)







