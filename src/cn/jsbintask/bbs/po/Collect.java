package cn.jsbintask.bbs.po;

import java.sql.Timestamp;

public class Collect {

	// 收藏的人
	private User user;
	//收藏的人的id
	private Integer user_id;

	public Timestamp getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Timestamp create_time) {
		this.create_time = create_time;
	}

	//收藏时间
	private Timestamp create_time;

	// 被收藏的帖子主题
	private TopicVO topicVO;

	public Integer getUser_id() {
		return user_id;
	}

	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}

	public TopicVO getTopicVO() {
		return topicVO;
	}

	public void setTopicVO(TopicVO topicVO) {
		this.topicVO = topicVO;
	}

	public Integer getTopic_id() {
		return topic_id;
	}

	public void setTopic_id(Integer topic_id) {
		this.topic_id = topic_id;
	}

	//被收藏的帖子的id
	private Integer topic_id;


	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}



}
