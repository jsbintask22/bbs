package cn.jsbintask.bbs.service;


import cn.jsbintask.bbs.po.Article;
import cn.jsbintask.bbs.po.User;

import java.util.List;

public interface UserService {
	public User findUserByNameAndPwd(String name, String password);
	
	public void addUser(String sno, String password, String email);
	
	public User findUserByEmail(String email);

	public User findUserById(Integer user_id);

	public User findUserBySno(String sno);

	public void postTopic(Integer user_id, String topic, String content);

	public void replyArticle(Article article);

	public List<User> findAllUser();

	public void updateUsersStatus(Integer status, Integer[] user_ids);

	public List<User> findUsersByLikeName(String username);

	public List<User> findUsersByShuted();

	public void updateIsLockById(Integer user_id, Integer isLock);

	public void  updateUserInfo(User user);

	public void updatePwdByUser_id(String password, Integer user_id);

	public User checkInitPwd(String initPwd, Integer user_id);

}
