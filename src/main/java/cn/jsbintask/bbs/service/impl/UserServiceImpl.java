package cn.jsbintask.bbs.service.impl;

import cn.jsbintask.bbs.mapper.*;
import cn.jsbintask.bbs.po.Article;
import cn.jsbintask.bbs.po.User;
import cn.jsbintask.bbs.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service("userService")
public class UserServiceImpl implements UserService {

    private final UserMapper userMapper;
    private final TopicMapper topicMapper;
    private final ArticleMapper articleMapper;
    private final AttentionMapper attentionMapper;
    private final CollectMapper collectMapper;

    @Autowired
    public UserServiceImpl(UserMapper userMapper, TopicMapper topicMapper, ArticleMapper articleMapper, AttentionMapper attentionMapper, CollectMapper collectMapper) {
        this.userMapper = userMapper;
        this.topicMapper = topicMapper;
        this.articleMapper = articleMapper;
        this.attentionMapper = attentionMapper;
        this.collectMapper = collectMapper;
    }

    // 根据传进来的map进行查找，是否有该用户
    @Override
    public User findUserByNameAndPwd(String name, String password) {
        //根据传进来的条件构造一个map
        Map<String, String> account = new HashMap<>();
        account.put("account", name);
        account.put("password", password);
        User user = userMapper.findUserByNameAndPwd(account);
        //这样做的目的是为了把发帖数，回复也映射进去，因为User类中没有这两个属性，所以要判断空指针异常
        if (user != null) {
            return findUserById(user.getUser_id());
        } else {
            return user;
        }
    }

    private String getUserName() {
        String userName = "u";
        Random random = new Random();
        for (int i = 0; i < 6; i++) {
            char c = (char) (97 + random.nextInt(26));
            userName += c;
        }
        return userName;
    }

    //添加一个用户，（注册）
    @Override
    public void addUser(String sno, String password, String email) {
        User user = new User();
        user.setSno(sno);
        user.setPassword(password);
        user.setEmail(email);
        user.setUsername(getUserName());
        userMapper.addUser(user);
    }

    //根据邮箱查找用户
    @Override
    public User findUserByEmail(String email) {
        return userMapper.findUserByEmail(email);
    }


    //根据传进来的信息，插入一条帖子，更新用户的发帖数
    @Override
    @Transactional(rollbackFor = Exception.class) //有异常发生时回滚
    public void postTopic(Integer user_id, String topic, String content) {
        System.out.println("这是UserService中的user_id" + user_id);
        //用于更新用户发帖数的map
        Map<String, Object> typeAndUser_id = new HashMap<>();
        typeAndUser_id.put("user_id", user_id);
        typeAndUser_id.put("updateType", "article_num");
        //用户插入帖子的map
        Map<String, Object> topicMap = new HashMap<>();
        topicMap.put("user_id", user_id);
        topicMap.put("topic", topic);
        topicMap.put("content", content);
        //更新用户发帖数
        userMapper.updateUserArticleAndTopicNum(typeAndUser_id);
        //插入一条帖子
        topicMapper.postTopic(topicMap);
    }

    //用户进行回帖
    @Override
    @Transactional(rollbackFor = Exception.class) //有异常发生时回滚
    public void replyArticle(Article article) {
        Map<String, Object> typeAndUser_id = new HashMap<>();
        typeAndUser_id.put("user_id", article.getUser_id());
        typeAndUser_id.put("updateType", "reply_num");
        //更新回复数和插入一条回复
        //更新用户回帖数
        userMapper.updateUserArticleAndTopicNum(typeAndUser_id);
        //更新该帖帖子的回帖数
        topicMapper.updateReply_num(article.getTopic_id());
        //插入一条回复
        articleMapper.replyArticle(article);
    }

    //查找所有的用户
    @Override
    public List<User> findAllUser() {
        return userMapper.findAllUser();
    }

    //根据user的id号获取一个用户
    @Override
    public User findUserById(Integer user_id) {
        User user = userMapper.findUserById(user_id);
        int attention_num = attentionMapper.countAttention_num(user_id);
        int collect_num = collectMapper.countCollect_num(user_id);
        user.setCollect_num(collect_num);
        user.setAttention_num(attention_num);
        return user;
    }

    @Override
    public User findUserBySno(String sno) {
        return userMapper.findUserBySno(sno);
    }

    //批量更新用户状态
    @Override
    public void updateUsersStatus(Integer status, Integer[] user_ids) {
        Map<String, Object> user_idsAndStatus = new HashMap<>();
        if (status == 1 || status == 0) {
            user_idsAndStatus.put("status", status);
        }
        List<Integer> userIds = new ArrayList<>();
        for (Integer id : user_ids) {
            userIds.add(id);
        }
        user_idsAndStatus.put("user_ids", userIds);
        userMapper.updateUsersStatus(user_idsAndStatus);
    }

    //根据用户名模糊查找用户
    @Override
    public List<User> findUsersByLikeName(String username) {
        if (username != null && !username.isEmpty()) {
            return userMapper.findUsersByLikeName(username);
        }
        return null;
    }

    //得到所有被禁言了的用户
    @Override
    public List<User> findUsersByShuted() {
        return userMapper.findUsersByShuted();
    }

    //根据传进来的参数更新用户是否允许别人访问自己的空间
    @Override
    public void updateIsLockById(Integer user_id, Integer isLock) {
        Map<String, Integer> isLockAndUserId = new HashMap<>();
        isLockAndUserId.put("user_id", user_id);
        isLockAndUserId.put("isLock", isLock);
        userMapper.updateIsLockById(isLockAndUserId);
    }

    //更新一个用户信息
    @Override
    public void updateUserInfo(User user) {
        userMapper.updateUserInfo(user);
    }

    //更新用户的密码
    @Override
    public void updatePwdByUser_id(String password, Integer user_id) {
        Map<String, Object> pwdAndUserId = new HashMap<>();
        pwdAndUserId.put("password", password);
        pwdAndUserId.put("user_id", user_id);
        userMapper.updatePwdByUser_id(pwdAndUserId);
    }

    //检查密码是否正确
    @Override
    public User checkInitPwd(String initPwd, Integer user_id) {
        Map<String, Object> pwdAndUserId = new HashMap<>();
        pwdAndUserId.put("password", initPwd);
        pwdAndUserId.put("user_id", user_id);
        return userMapper.checkInitPwd(pwdAndUserId);
    }

}
