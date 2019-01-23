package cn.jsbintask.bbs.po;

import java.io.Serializable;
import java.sql.Timestamp;

public class Article implements Serializable{

	private Integer article_id;
	// 该条帖子是谁发的，本来是user_id
    private Integer user_id;
	private User user;
	// 引用别人的时候用，被回复的人的user_id
	private User puser;

	public User getPuser() {
		return puser;
	}

	public void setPuser(User puser) {
		this.puser = puser;
	}

	private Integer puser_id;

	public Integer getTopic_id() {
		return topic_id;
	}

	public void setTopic_id(Integer topic_id) {
		this.topic_id = topic_id;
	}

	//该帖帖子是属于那个主题的
	private Integer topic_id;

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

	// 回复时间
	private Timestamp reply_time;
	// 该条帖子是属于哪个主题帖子
	private Topic topic;
	private String content;

	public Integer getArefid() {
		return arefid;
	}

	public void setArefid(Integer arefid) {
		this.arefid = arefid;
	}

	// 回复的是哪条帖子，默认为null，表示回复的是主题帖子，如果为引用别人的回复，则为那条帖子对象
	private Integer arefid;

	public Integer getArticle_id() {
		return article_id;
	}

	public void setArticle_id(Integer article_id) {
		this.article_id = article_id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}



	public Timestamp getReply_time() {
		return reply_time;
	}

	public void setReply_time(Timestamp reply_time) {
		this.reply_time = reply_time;
	}

	public Topic getTopic() {
		return topic;
	}

	public void setTopic(Topic topic) {
		this.topic = topic;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

}
