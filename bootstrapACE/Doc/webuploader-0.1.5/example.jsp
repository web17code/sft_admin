<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />

<%@ include file="/WEB-INF/pages/include/jstl.jsp"%>
<%@ include file="/WEB-INF/pages/include/bootstrapHead.jsp"%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resource/lib/bootstrap-3.3.7/Widget/webuploader/0.1.5/webuploader.css" />
<link href="${pageContext.request.contextPath}/resource/lib/bootstrap-3.3.7/assets/css/codemirror.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/resource/lib/bootstrap-3.3.7/assets/js/typeahead-bs2.min.js"></script>   
<script src="${pageContext.request.contextPath}/resource/lib/bootstrap-3.3.7/js/lrtk.js" type="text/javascript" ></script>		
<script src="${pageContext.request.contextPath}/resource/lib/bootstrap-3.3.7/assets/js/jquery.dataTables.min.js"></script>
<script src="${pageContext.request.contextPath}/resource/lib/bootstrap-3.3.7/assets/js/jquery.dataTables.bootstrap.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resource/lib/bootstrap-3.3.7/Widget/webuploader/0.1.5/webuploader.min.js"></script>
<title>分类管理</title>
</head>

<body>
<div class="page-content clearfix">
		<div class="sort_style">
			<div class="border clearfix">
				<span class="l_f">
					<a href="javascript:void(0)" id="sort_add" class="btn btn-warning">
						<i class="fa fa-plus"></i> 添加安卓包
					</a>
					<a href="javascript:void(0)" id="ios_add" class="btn btn-warning">
						<i class="fa fa-plus"></i> 添加ios信息
					</a>
				</span> <span class="r_f">共：<b>5</b>类
				</span>
			</div>
			<div class="sort_list">
				<table class="table table-striped table-bordered table-hover"
					id="sample-table">
					<thead>
						<tr>
							<th width="25px"><label><input type="checkbox"
									class="ace"><span class="lbl"></span></label></th>
							<th width="50px">ID</th>
							<th width="120px">创建时间</th>
							<th width="190px">下载地址</th>
							<th width="350px">描述</th>
							<th width="180px">类型</th>
							<th width="70px">版本号</th>
							<th width="100px">操作</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="list" items="${installList}">
							<tr>
								<td><label><input type="checkbox" class="ace"><span
											class="lbl"></span></label></td>
								<td>${list.id }</td>
								<td><fmt:formatDate value="${list.createTime }" pattern="yyyy-MM-dd  HH:mm:ss" /> </td>
								<td>${list.dlUrl }</td>
								<td>${list.explain }</td>
								<td class="td-status">
										<c:choose>
											 <c:when test="${list.type == '1' }">  
											 		<span class="label label-info radius">安卓</span>
											</c:when>
											 <c:otherwise> 
													 <span class="label label-success radius">苹果</span>
											 </c:otherwise>
										</c:choose>
								</td>
								<td >${list.version }</td>
								<td class="td-manage">
									 <button class="btn btn-danger" data-toggle="button"  onclick="deletePack('${list.id}','${list.type }' ,'${list.dlUrl }')">删除</button>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	
	
	<!--android上传部分-->
	<div class="sort_style_add margin" id="sort_style_add"
		style="visibility: hidden;">
		<ul>
			<!-- 包的大小 -->
			<input type="hidden" id="packSize_android"/>
			<!-- 链接 -->
			<input type="hidden" id="dlUrl_android"/>
			<!-- android默认填1 -->
			<input type="hidden" id="type_android" value="1" />
			<li>
				<label class="label_name">选择文件</label>
				<div id="uploader" class="col-sm-9">
					<!--用来存放文件信息-->
					<div id="thelist" class="uploader-list"></div>
					<div class="btns">
						<div id="picker">选择文件</div>
						<button id="ctlBtn" class="btn btn-default">开始上传</button>
					</div>
				</div>
			</li>
			<li>
				<label class="label_name">版本号</label>
				<div class="col-sm-9">
					<input name="版本号"  type="text" id="version_android" placeholder=""
						class="col-xs-10 col-sm-5" style="margin-left:0;">
					<span style="color:red;font-size:12px;">&nbsp;&nbsp;
						<c:choose>
							 <c:when test="${installAndroid.version == '' || installAndroid.version == null }">  
							</c:when>
							 <c:otherwise> 
									 当前版本号：${installAndroid.version }
							 </c:otherwise>
						</c:choose>
					</span>	
				</div>
			</li>
			<li><label class="label_name">分类说明</label>
				<div class="col-sm-9">
					<textarea name="分类说明" class="form-control" id="explain_android"
						placeholder="" onkeyup="checkLength(this);"></textarea>
					<span class="wordage">剩余字数：<span id="sy" style="color: Red;">200</span>字
					</span>
				</div></li>
		</ul>
	</div>
	<!-- ios上传模态框 -->
	<div class="sort_style_add margin" id="ios_style_add"
		style="visibility: hidden;">
		<ul>
			<!-- ios默认填2 -->
			<input type="hidden" id="type_ios" value="2" />
			<li>
				<label class="label_name">版本号</label>
				<div class="col-sm-9">
					<input name="版本号" type="text" id="version_ios" placeholder=""
						class="col-xs-10 col-sm-5" style="margin-left:0;">
					<span style="color:red;font-size:12px;">&nbsp;&nbsp;
						<c:choose>
							 <c:when test="${installIos.version == '' || installIos.version == null }">  
							</c:when>
							 <c:otherwise> 
									 当前版本号：${installIos.version }
							 </c:otherwise>
						</c:choose>
					</span>	
				</div>
			</li>
			<li>
				<label class="label_name">包链接</label>
				<div class="col-sm-9">
					<input name="包链接" type="text" id="dlUrl_ios" placeholder=""
						class="col-xs-10 col-sm-5" style="margin-left:0;">
				</div>
			</li>
			<li><label class="label_name">分类说明</label>
				<div class="col-sm-9">
					<textarea name="分类说明" class="form-control" id="explain_ios"
						placeholder="" onkeyup="checkLength(this);"></textarea>
					<span class="wordage">剩余字数：<span id="sy" style="color: Red;">200</span>字
					</span>
				</div></li>
		</ul>
	</div>
	
	
	<script type="text/javascript">
		/*init webuploader*/
		var $list = $("#thelist"); //这几个初始化全局的百度文档上没说明，好蛋疼。  
		var $btn = $("#ctlBtn"); //开始上传  
		var thumbnailWidth = 100; //缩略图高度和宽度 （单位是像素），当宽高度是0~1的时候，是按照百分比计算，具体可以看api文档  
		var thumbnailHeight = 100;

		var uploader = WebUploader.create({
			// 选完文件后，是否自动上传。  
			auto : false,

			// swf文件路径  
			swf : '${ctxStatic }/webupload/Uploader.swf',

			// 文件接收服务端。  
			server : '${pageContext.request.contextPath}/message/upload',

			// 选择文件的按钮。可选。  
			// 内部根据当前运行时创建，可能是input元素，也可能是flash.  
			pick : '#picker',
			//上传的参数在sendbefore函数中设置
			// 只允许选择图片文件。  
			accept : {
				title : '安卓安装包',
				extensions : 'apk',
				mimeTypes : 'application/vnd.android.package-archive'
			},
			method : 'POST',
			multiple : false,//多文件上传，否
			duplicate : true
		//允许重复上传，是
		});
		/* uploader.on( 'uploadBeforeSend', function( block, data ) {  
		    // block为分块数据。  
		  
		    // file为分块对应的file对象。  
		    var file = block.file;  
		    // 修改data可以控制发送哪些携带数据。  
		    data.appName = $("#appName").val();  
		}); */
		//文件加入队列前出发改事件
		uploader.on('beforeFileQueued', function(file) {
			if(file.ext.toLowerCase()!="apk"){
				layer.alert("请选择安卓安装包！\r\n", {
					title : '提示框',
					icon : 0,
				});
				return false;
			}
			//判断是否是安卓安装包
			///\.apk$/i.test()
			//清空之前的队列，并清除之前的文件选择等
			uploader.reset();
			//清除之前的Dom
			$("div.webupload_showTxt.item").remove();

		});

		uploader.on('fileQueued',function(file) {
							$list.append('<div id="' + file.id + '" class="item webupload_showTxt">'
											+ '<h4 class="info">'
											+ file.name
											+ '</h4>'
											+ '<p class="state">等待上传...</p>'
											+ '</div>');
		});

		uploader.on('uploadProgress',function(file, percentage) {
							var $li = $('#' + file.id), $percent = $li.find('.progress .progress-bar');

							// 避免重复创建
							if (!$percent.length) {
								$percent = $(
										'<div class="progress progress-striped active">'
												+ '<div class="progress-bar" role="progressbar" style="width: 0%">'
												+ '</div>' + '</div>')
										.appendTo($li).find('.progress-bar');
							}

							$li.find('p.state').text('上传中');

							$percent.css('width', percentage * 100 + '%');
						});
		// 文件上传成功，给item添加成功class, 用样式标记上传成功。  
		uploader.on('uploadSuccess', function(file, respone) {
			if(respone.status=="0000"){
				$('#packSize_android').val(respone.data.fileSize);
				$('#dlUrl_android').val(respone.data.filePath);
				$('#' + file.id).addClass('upload-state-done');
			}
		});

		// 文件上传失败，显示上传出错。  
		uploader.on('uploadError', function(file) {
			console.log(file);
			var $li = $('#' + file.id), $error = $li.find('div.error');

			// 避免重复创建  
			if (!$error.length) {
				$error = $('<div class="error"></div>').appendTo($li);
			}
			$error.text('上传失败');
		});

		// 完成上传完了，成功或者失败，先删除进度条。  
		uploader.on('uploadComplete', function(file) {
			$('#' + file.id).find('.progress').remove();
			$("#" + file.id).find('p.state').html("上传完成！");
		});
		$btn.on('click', function() {
			uploader.upload();
		});
	</script>
</body>
</html>

<script type="text/javascript">
	$('#sort_add').on(
			'click',
			function() {
				layer.open({
					type : 1,
					title : '添加分类',
					maxmin : true,
					shadeClose : false, //点击遮罩关闭层
					area : [ '750px', '' ],
					content : $('#sort_style_add'),
					btn : [ '提交', '取消' ],
					yes : function(index, layero) {
						var num = 0;
						var str = "";
						$("#sort_style_add input[type='text']").each(
								function(n) {
									if ($(this).val() == "") {
								console.log(123)
										layer.alert(str += ""
												+ $(this).attr("name")
												+ "不能为空！\r\n", {
											title : '提示框',
											icon : 0,
										});
										num++;
										return false;
									}
								});
						if (num > 0) {
							return false;
						} 
						console.log($('#dlUrl_android').val()+"656")
						if($('#dlUrl_android').val()==""){
							layer.alert("上传安装包后再提交！\r\n", {
								title : '提示框',
								icon : 0,
							});
							return false;
						}	
						//通过以上判断发送请求
						$.post("${pageContext.request.contextPath}/message/upload/save", 
								{ 	"dlUrl": $('#dlUrl_android').val(),
									"packSize": $('#packSize_android').val(),
									"version":$('#version_android').val(),
									"type":1,
									"explain":$('#explain_android').val()}, 
								function (data) {
							        if (data.status == "0000") {
							        	location.href="${pageContext.request.contextPath}/message/upload/list";
							        }else{
							        	layer.alert(data.msg, {
											title : '提示框',
											icon : 0,
										});
							        }
					  	})
					}
				});
				$('#sort_style_add').css({
					"visibility" : "visible"
				});
	})
	
	/* ios模态框 */
	$('#ios_add').on(
			'click',
			function() {
				layer.open({
					type : 1,
					title : '添加ios信息',
					maxmin : true,
					shadeClose : false, //点击遮罩关闭层
					area : [ '750px', '' ],
					content : $('#ios_style_add'),
					btn : [ '提交', '取消' ],
					yes : function(index, layero) {
						var num = 0;
						var str = "";
						$("#ios_style_add input[type='text']").each(
								function(n) {
									if ($(this).val() == "") {

										layer.alert(str += ""
												+ $(this).attr("name")
												+ "不能为空！\r\n", {
											title : '提示框',
											icon : 0,
										});
										num++;
										return false;
									}
								});
						if (num > 0) {
							return false;
						} 
						//通过以上判断发送请求
						$.post("${pageContext.request.contextPath}/message/upload/save", 
								{ 	"dlUrl": $('#dlUrl_ios').val(),
									"version":$('#version_ios').val(),
									"type":2,
									"explain":$('#explain_ios').val()}, 
								function (data) {
							        if (data.status == "0000") {
							        	location.href="${pageContext.request.contextPath}/message/upload/list";
							        }else{
							        	layer.alert(data.msg, {
											title : '提示框',
											icon : 0,
										});
							        }
					  	})
					}
				});
				$('#ios_style_add').css({
					"visibility" : "visible"
				});
	})

	function checkLength(which) {
		var maxChars = 200; //
		if (which.value.length > maxChars) {
			layer.open({
				icon : 2,
				title : '提示框',
				content : '您出入的字数超多限制!',
			});
			// 超过限制的字数了就将 文本框中的内容按规定的字数 截取
			which.value = which.value.substring(0, maxChars);
			return false;
		} else {
			var curr = maxChars - which.value.length; //250 减去 当前输入的
			document.getElementById("sy").innerHTML = curr.toString();
			return true;
		}
	};
	
	//面包屑返回值
	var index = parent.layer.getFrameIndex(window.name);
	parent.layer.iframeAuto(index);
	$('.Order_form ,.ads_link').on('click', function() {
		var cname = $(this).attr("title");
		var cnames = parent.$('.Current_page').html();
		var herf = parent.$("#iframe").attr("src");
		parent.$('#parentIframe span').html(cname);
		parent.$('#parentIframe').css("display", "inline-block");
		parent.$('.Current_page').attr("name", herf).css({
			"color" : "#4c8fbd",
			"cursor" : "pointer"
		});
		//parent.$('.Current_page').html("<a href='javascript:void(0)' name="+herf+">" + cnames + "</a>");
		parent.layer.close(index);

	});
	function AdlistOrders(id) {
		window.location.href = "Ads_list.html?=" + id;
	};
</script>


<script type="text/javascript">
	jQuery(function($) {
		var oTable1 = $('#sample-table').dataTable({
			"aaSorting" : [ [ 2, "desc" ] ],//默认第几个排序
			"bStateSave" : true,//状态保存
			"aoColumnDefs" : [
			//{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
			{
				"orderable" : false,
				"aTargets" : [ 0, 1, 3, 4, 7, ]
			} // 制定列不参与排序
			]
		});
		$('table th input:checkbox').on(
				'click',
				function() {
					var that = this;
					$(this).closest('table').find(
							'tr > td:first-child input:checkbox').each(
							function() {
								this.checked = that.checked;
								$(this).closest('tr').toggleClass('selected');
							});

				});
		$('[data-rel="tooltip"]').tooltip({
			placement : tooltip_placement
		});
		function tooltip_placement(context, source) {
			var $source = $(source);
			var $parent = $source.closest('table')
			var off1 = $parent.offset();
			var w1 = $parent.width();

			var off2 = $source.offset();
			var w2 = $source.width();

			if (parseInt(off2.left) < parseInt(off1.left) + parseInt(w1 / 2))
				return 'right';
			return 'left';
		}
	})
	
	/* 删除安装包 */
	function deletePack(id,type,dlUrl){
		layer.confirm('确定要删除吗？', {
			  btn: ['确定','取消'] //按钮
			}, function(){
				$.post("${pageContext.request.contextPath}/message/upload/delete", {"dlUrl": dlUrl,"id":id,"type":type}, function (data) {
					        if (data.status == "0000") {
					        	location.href="${pageContext.request.contextPath}/message/upload/list";
					        }else{
					        	layer.alert(data.msg, {
									title : '提示框',
									icon : 0,
								});
					        }
			  	});
			  
			}, function(){
			  
			});
	}
</script>