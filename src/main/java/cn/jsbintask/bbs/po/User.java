package cn.jsbintask.bbs.po;

import java.io.Serializable;
import java.sql.Date;

public class User implements Serializable {

    private static final long serialVersionUID = 1L;
    private Integer user_id;
    private String sno;
    private String sex;
    private String sdept;
    private String clazz;
    private Integer article_num;
    private String imgUrl;
    //有多少条关注
    private Integer attention_num;

    public Integer getCollect_num() {
        return collect_num;
    }

    public void setCollect_num(Integer collect_num) {
        this.collect_num = collect_num;
    }

    //有多少个收藏
    private Integer collect_num;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    private String username;
    private String sign;
    private String password;
    private String email;
    private String phone;


    public Integer getUser_id() {
        return user_id;
    }

    public void setUser_id(Integer user_id) {
        this.user_id = user_id;
    }

    public String getSno() {
        return sno;
    }

    public void setSno(String sno) {
        this.sno = sno;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getSdept() {
        return sdept;
    }

    public void setSdept(String sdept) {
        this.sdept = sdept;
    }

    public String getClazz() {
        return clazz;
    }

    public void setClazz(String clazz) {
        this.clazz = clazz;
    }

    public Integer getArticle_num() {
        return article_num;
    }

    public void setArticle_num(Integer article_num) {
        this.article_num = article_num;
    }

    public String getImgurl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
    }


    public String getSign() {
        return sign;
    }

    public void setSign(String sign) {
        this.sign = sign;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Integer getIsLock() {
        return isLock;
    }

    public void setIsLock(Integer isLock) {
        this.isLock = isLock;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    // 用户控件是否被锁定
    private Integer isLock;
    // 用户状态，是否可以发言等等
    private Integer status;

    //用户注册时间，用户回帖数
    private Date register_date;

    public Date getRegister_date() {
        return register_date;
    }

    public void setRegister_date(Date register_date) {
        this.register_date = register_date;
    }

    public Integer getReply_num() {
        return reply_num;
    }

    public void setReply_num(Integer reply_num) {
        this.reply_num = reply_num;
    }

    private Integer reply_num;

    public Integer getAttention_num() {
        return attention_num;
    }

    public void setAttention_num(Integer attention_num) {
        this.attention_num = attention_num;
    }
}
