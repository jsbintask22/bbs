package cn.jsbintask.bbs.po;

/**
 * Created by Administrator on 2017/6/12.
 */
public class ArticleVO extends Article{
    //这条回复是几楼的
    private int level;

    public ArticleVO getRefArticleVO() {
        return refArticleVO;
    }

    public void setRefArticleVO(ArticleVO refArticleVO) {
        this.refArticleVO = refArticleVO;
    }

    //被引用的帖子
    private ArticleVO refArticleVO;

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    //这条回复的那条帖子的名字
    private String topic;
}
