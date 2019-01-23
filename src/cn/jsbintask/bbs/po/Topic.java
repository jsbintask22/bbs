package cn.jsbintask.bbs.po;

import java.io.Serializable;
import java.sql.Timestamp;

public class Topic implements Serializable{
    private Integer topic_id;
    private String topic;
    private String content;

    public Integer getReply_number() {
        return reply_number;
    }

    public void setReply_number(Integer reply_number) {
        this.reply_number = reply_number;
    }

    // 该条帖子回复数
    private Integer reply_number;

    public Integer getIndex() {
        return index;
    }

    public void setIndex(Integer index) {
        this.index = index;
    }

    // 该条帖子是谁的发的，本来是userid，这里直接写成User方便后面使用
    private User user;
    private Integer user_id;

    public Integer getUser_id() {
        return user_id;
    }

    public void setUser_id(Integer user_id) {
        this.user_id = user_id;
    }

    // 该条帖子是否是首页的帖子，1表示是，0表示不是，默认为0
    private Integer index;
    // 该条帖子的状态，0表示删除了（假删除），默认为1
    private Integer flag;


    public Timestamp getCreate_time() {
        return create_time;
    }

    public void setCreate_time(Timestamp create_time) {
        this.create_time = create_time;
    }

    // 该帖帖子所发的时间
    private Timestamp create_time;

    public Integer getTopic_id() {
        return topic_id;
    }

    public void setTopic_id(Integer topic_id) {
        this.topic_id = topic_id;
    }

    public String getTopic() {
        return topic;
    }

    public void setTopic(String topic) {
        this.topic = topic;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }



    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Integer getFlag() {
        return flag;
    }

    public void setFlag(Integer flag) {
        this.flag = flag;
    }


}
