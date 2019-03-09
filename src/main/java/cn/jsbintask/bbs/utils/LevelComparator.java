package cn.jsbintask.bbs.utils;

import cn.jsbintask.bbs.po.ArticleVO;

import java.util.Comparator;

public class LevelComparator implements Comparator<ArticleVO> {


    @Override
    public int compare(ArticleVO o1, ArticleVO o2) {
        int l1 = o1.getLevel();
        int l2 = o2.getLevel();
        if (l1 < l2) {
            return 1;
        }
        if (l1 == l2) {
            return 0;
        }
        if (l1 > l2) {
            return -1;
        }
        return -1;
    }

    @Override
    public Comparator<ArticleVO> reversed() {
        return null;
    }
}
