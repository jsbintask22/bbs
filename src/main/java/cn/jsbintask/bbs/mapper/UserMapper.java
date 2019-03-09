package cn.jsbintask.bbs.mapper;

import cn.jsbintask.bbs.po.User;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

@Component
public interface UserMapper {

	public User findUserByNameAndPwd(Map<String, String> account);
	
	public void addUser(User user);
	
	public User findUserByEmail(String email);

	public User findUserBySno(String sno);

	public User findUserById(Integer user_id);

	public void updateUserArticleAndTopicNum(Map<String, Object> tpyeAndUser_id);

	public List<User> findAllUser();

	public void updateUsersStatus(Map<String, Object> user_idsAndStatus);

	public List<User> findUsersByLikeName(String username);

	public List<User> findUsersByShuted();

	public void updateIsLockById(Map<String, Integer> isLockAndUserId);

	public void updateUserInfo(User user);

	public void updatePwdByUser_id(Map<String, Object> pwdAndUserId);

	public User checkInitPwd(Map<String, Object> pwdAndUserId);

}
