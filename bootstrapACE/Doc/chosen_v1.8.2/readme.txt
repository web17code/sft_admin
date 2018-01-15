
初始化引入chosen.js和chosen.css

$("#select").chosen(options)
options是初始化的参数，常用的如下，具体参考option.html文件
注：这个插件好是好，但是css样式不咋好看，
    将chosen.css放到ace.css的上边，用ace.css进行美化一下
    $(".chosen-select").chosen({
        disable_search_threshold:9,//当数据大于9出现搜索框
        no_results_text:"没匹配到",
        search_contains:true//允许从中间查找
    });
    $("#selectSchool").on('change',function(){
        alert($("#selectSchool").val())
    })
