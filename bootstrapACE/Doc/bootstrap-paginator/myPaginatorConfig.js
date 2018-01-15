/**
 * Created by web17code on 2017/12/12.
 */
var PageOptions = {
    currentPage: 1,
    totalPages: 10,
    size:"normal",//分页组件大小
    //bootstrapMajorVersion:2,bootstrap的版本用二就行，html以div初始化，3以ul初始化
    alignment:"right",//分页组件靠右
    numberOfPages:7,//最多显示有多少个页码
    //设置显示分页的文字
    itemTexts: function (type, page, current) {
        switch (type) {
            case "first":
                return "首页";
            case "prev":
                return "上一页";
            case "next":
                return "下一页";
            case "last":
                return "尾页";
            case "page":
                return page;
        }
    },
    //去掉悬浮的title
    tooltipTitles: function (type, page, current) {
        switch (type) {
            case "first":
                return "";
            case "prev":
                return "";
            case "next":
                return "";
            case "last":
                return "";
            case "page":
                return "";
        }
    },
    //控制页面项目的存在
    shouldShowPage:function(type, page, current){
        switch(type)
        {
            case "first":
            case "last":
                return true;
            default:
                return true;
        }
    },
    //点击某页触发
    /*onPageClicked: function(e,originalEvent,type,page){
    },*/
    //跳页才触发
    onPageChanged: function(e,oldPage,newPage){
        console.log("Current page changed, old: "+oldPage+" new: "+newPage);
        //更新数据
        gopage(e,oldPage,newPage);
    }
}