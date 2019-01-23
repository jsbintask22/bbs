package cn.jsbintask.bbs.po;

import java.sql.Timestamp;

public class Attention {

	// 关注的人的user对象
	private User user;
	private Integer user_id;
	// 被关注的人的User对象
	private User pUser;

	public Timestamp getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Timestamp create_time) {
		this.create_time = create_time;
	}

	private Timestamp create_time;

	public Integer getUser_id() {
		return user_id;
	}

	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}

	public Integer getPuser_id() {

		return puser_id;
	}

	public void setPuser_id(Integer puser_id) {
		this.puser_id = puser_id;
	}

	private Integer puser_id;

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public User getpUser() {
		return pUser;
	}

	public void setPuser(User pUser) {
		this.pUser = pUser;
	}

}
