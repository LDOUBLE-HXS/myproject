$(function(){
	var commentValue=0;
	var commentFile=null;//评论图片
	var dragImgUpload = new DragImgUpload("#drop_area",{
		callback:function (files) {
			//回调函数，可以传递给后台等等
			var file = files[0];
			//获取文件名
			var fileName= files[0].name;
			var extStart = fileName.lastIndexOf('.'),
            ext = fileName.substring(extStart, fileName.length).toUpperCase();
			//判断是否选择的是图片
			if (ext !== '.PNG' && ext !== '.JPG' && ext !== '.JPEG' && ext !== '.GIF') {
				layer.msg('请上传正确的图片！', {
					offset : '200px',
					icon : 7,
					time : 2000,
					shade: [0.3, '#393D49']
				});
				commentFile=null;
				//延时事件
				setTimeout(function(){
					 window.location.reload();//刷新
					},1000);
			}else{
				commentFile=file;
			}
		}
	});
	layui.use('layer', function() {
		var layer = layui.layer;
		//评分
		layui.use('rate', function(){
		    var rate = layui.rate;
		    //渲染
		    var commentStar = rate.render({
		    	elem: '#commentStar' , //绑定元素
		    	setText: function(value){
		    		var arrs = {
		    				'0':'(请评星)'
		    				,'1': '(极差)'
		    				,'2': '(差)'
		    				,'3': '(中等)'
		    				,'4': '(好)'
		    				,'5': '(非常棒)'
		    		};
		    		this.span.text(arrs[value]);
		    		commentValue=value;
		    	},
		    	text:true,
		    });
		  });
		//渲染已评论的按钮
		$(".addcomment").each(function(index, element){
			var li=$(this);
			$.ajax({
                type: 'GET',
                url: path+'/order/selCommentByOrderIdAjax',
                data : {orderId:li.attr("orderId")},
                dataType: "json",
                success: function (data) {
                	if(data.result=="true"){
                		li.html("已评论");
                		li.css({"background-color":"gray"});
                	}
                }
			});
		});
		//评论
		$(".addcomment").on('click',function(){
			//订单id
			var orderId=$(this).attr("orderId");
			if($(this).html()=="已评论"){
				layer.msg('该订单已评论！',{
		            offset: '100px',
		            icon:7,
		            time: 2000,
		            shade: [0.3, '#393D49']
				});
			}else{
				layer.open({
					content:$("#commentDiv"), //内容
					area:'600px',
					resize:false,// 不允许拉伸
					anim: 1,// 显示风格
					title: ['评论', 'font-size:18px;'],// 标题
					type: 1, 
					btn:['评论'],
					btnAlign: 'r',
					offset: '0',// 离上10px水平居中
					cancel: function(index, layero){
						window.location.reload();//刷新
					},
					yes:function(){
						var formdata = new FormData();//form表单
						if(commentFile==null){
							layer.msg('请选择评论图片！',{
					            offset: '100px',
					            icon:7,
					            time: 2000,
					            shade: [0.3, '#393D49']
							});
						}else if(commentValue==0){
							layer.msg('请给订单评星！',{
					            offset: '100px',
					            icon:7,
					            time: 2000,
					            shade: [0.3, '#393D49']
							});
						}else if($("#commentContext").val()==null||$("#commentContext").val()==""){
							layer.msg('请写评论内容！',{
					            offset: '100px',
					            icon:7,
					            time: 2000,
					            shade: [0.3, '#393D49']
							});
						}else{
							formdata.append('commentFile', commentFile);
							formdata.append('orderId', orderId);
							formdata.append('commentStar', commentValue);
							formdata.append('commentContext', $("#commentContext").val());
							$.ajax({
			                    type: 'POST',
			                    url: path+'/user/addCommentAjax',
			                    contentType : false,
			                    data : formdata,
			                    processData : false,
			                    dataType: "json",
			                    success: function (data) {
			                        if(data.result=="true"){
			                        	layer.msg('评论成功,可到个人中心中查看我的评论！',{
			    				            offset: '150px',
			    				            time: 3000,
			    				            icon:1,
			    				            shade: [0.3, '#393D49']
			    						});
			                        	//延时事件
			    						setTimeout(function(){
			    							 window.location.reload();//刷新
			    							},1000);
			                        }else if(data.result=="false"){
			                        	layer.msg('评论失败！',{
			    				            offset: '150px',
			    				            time: 3000,
			    				            icon:1,
			    				            shade: [0.3, '#393D49']
			    						});
			                        }
			                    },
			                    error : function(data) {
			                        alert('上传失败！');
			                    }
			                });
						}
					}
				});
			}
		});
	});
});
function DragImgUpload(id,options) {
    this.me = $(id);
    var defaultOpt = {
        boxWidth:'90px',
        boxHeight:'68px'
    }
    this.preview = $('<div id="preview"><img src="'+path+'/static/admin/images/upload.png" class="img-responsive"  style="width: 100%;height: auto;" alt="" title=""> </div>');
    this.opts=$.extend(true, defaultOpt,{
    }, options);
    this.init();
    this.callback = this.opts.callback;
}

//定义原型方法
DragImgUpload.prototype = {
    init:function () {
        this.me.append(this.preview);
        this.me.append(this.fileupload);
        this.cssInit();
        this.eventClickInit();
    },
    cssInit:function () {
        this.me.css({
            'width':this.opts.boxWidth,
            'height':this.opts.boxHeight,
            'border':'1px solid #cccccc',
            'padding':'10px',
            'cursor':'pointer'
        })
        this.preview.css({
            'height':'100%',
            'overflow':'hidden'
        })

    },
    onDragover:function (e) {
        e.stopPropagation();
        e.preventDefault();
        e.dataTransfer.dropEffect = 'copy';
    },
    onDrop:function (e) {
        var self = this;
        e.stopPropagation();
        e.preventDefault();
        var fileList = e.dataTransfer.files; //获取文件对象
        // do something upload
        if(fileList.length == 0){
            return false;
        }
        //检测文件是不是图片
        if(fileList[0].type.indexOf('image') === -1){
            alert("您拖的不是图片！");
            return false;
        }
        //拖拉图片到浏览器，可以实现预览功能
        var img = window.URL.createObjectURL(fileList[0]);
        var filename = fileList[0].name; //图片名称
        var filesize = Math.floor((fileList[0].size)/1024);
        if(filesize>500){
            alert("上传大小不能超过500K.");
            return false;
        }

        self.me.find("img").attr("src",img);
        self.me.find("img").attr("title",filename);
        if(this.callback){
            this.callback(fileList);
        }
    },
    eventClickInit:function () {
        var self = this;
        this.me.unbind().click(function () {
            self.createImageUploadDialog();
        })
        var dp = this.me[0];
        dp.addEventListener('dragover', function(e) {
            self.onDragover(e);
        });
        dp.addEventListener("drop", function(e) {
            self.onDrop(e);
        });
    },
    onChangeUploadFile:function () {
        var fileInput = this.fileInput;
        var files = fileInput.files;
        var file = files[0];
        var img = window.URL.createObjectURL(file);
        var filename = file.name;
        this.me.find("img").attr("src",img);
        this.me.find("img").attr("title",filename);
        if(this.callback){
            this.callback(files);
        }
    },
    createImageUploadDialog:function () {
        var fileInput = this.fileInput;
        if (!fileInput) {
            //创建临时input元素
            fileInput = document.createElement('input');
            //设置input type为文件类型
            fileInput.type = 'file';
            //设置文件name
            fileInput.name = 'ime-images';
            //允许上传多个文件
            fileInput.multiple = true;
            fileInput.onchange  = this.onChangeUploadFile.bind(this);
            this.fileInput = fileInput;
        }
        //触发点击input点击事件，弹出选择文件对话框
        fileInput.click();
    }
}