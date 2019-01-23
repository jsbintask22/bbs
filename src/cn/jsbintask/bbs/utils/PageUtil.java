package cn.jsbintask.bbs.utils;


public class PageUtil {
    //一共多少条帖子
    private int totalTopic;
    //每页放置多少条帖子
    private int pageSize;
    //一共多少页
    private int maxPage;
    //当前是第几页
    private int pageNum;
    //分页的起始位置
    private int pagePosition;

    public int getTotalTopic() {
        return totalTopic;
    }

    public void setTotalTopic(int totalTopic) {
        this.totalTopic = totalTopic;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getMaxPage() {
        return maxPage;
    }

    public void setMaxPage(int maxPage) {
        this.maxPage = maxPage;
    }

    public int getPageNum() {
        return pageNum;
    }

    public void setPageNum(int pageNum) {
        this.pageNum = pageNum;
    }

    public int getPagePosition() {
        return pagePosition;
    }

    public void setPagePosition(int pagePosition) {
        this.pagePosition = pagePosition;
    }

    public PageUtil(int totalTopic, Integer pageSize, Integer pageNum) {
        this.totalTopic = totalTopic;
        this.pageSize = pageSize;
        if(pageNum==null) {
            this.pageNum = 1;
        } else {
            this.pageNum = pageNum;
        }
        initMaxPage();
        initPagePosition();
    }

    private void initMaxPage() {
        if (totalTopic == 0) {
            maxPage = 1;
        } else {
            this.maxPage = totalTopic % pageSize == 0 ? totalTopic / pageSize : totalTopic / pageSize + 1;
        }
        //如果传进来的页号大于最大页，就让他等于最大页
        if(pageNum > maxPage) {
            pageNum = maxPage;
        }
        if(pageNum < 1) {
            pageNum = 1;
        }
    }

    private void initPagePosition() {
        pagePosition = (pageNum - 1) * pageSize;
        if(pagePosition < 0) {
            pagePosition = 0;
        }
    }
}
