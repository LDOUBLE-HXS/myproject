$(function(){
	var roomImgFile=null;
	var dragImgUpload = new DragImgUpload("#drop_area",{
		callback:function (files) {
			//回调函数，可以传递给后台等等
			var file = files[0];
			var fileName= files[0].name;
			//获取文件名
			if(fileName!=null){
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
					roomImgFile=null;
					//延时事件
					setTimeout(function(){
						 window.location.reload();//刷新
						},1000);
				}else{
					roomImgFile=file;
				}
			}
		}
	});
	layui.use('layer', function(){
		var layer = layui.layer;
		//添加房间类型
		$(".addRoomType").on('click',function(){
			var id=$(this).attr("roomTypeId");
			layer.open({
				content:$("#roomTypeDiv"), //内容
				area:'320px',
				resize:false,// 不允许拉伸
				btn: '添加',
				btnAlign: 'c',
				anim: 1,// 显示风格
				title: ['添加房间类型', 'font-size:18px;'],// 标题
				type: 1, 
				offset: '20px',// 离上50px水平居中
				success: function(layero, index){
					//图片
					layero.children(".layui-layer-content").children()
					.children().children().eq(0)
					.children("#drop_area").children()
					.children().attr("src",path+"/static/admin/images/upload.png");
					roomImgFile=null;
					//房型类型
					layero.children(".layui-layer-content").children()
					.children().children().eq(1)
					.children("#roomTypeNameModify").val("");
					//房间简介
					layero.children(".layui-layer-content").children()
					.children().children().eq(2)
					.children("#sketchModify").val("");
					//房间价格
					layero.children(".layui-layer-content").children()
					.children().children().eq(3)
					.children("#typePriceModify").val("");
					//房间详情
					layero.children(".layui-layer-content").children()
					.children().children().eq(4)
					.children("#describeModify").val("");
				},
				yes: function(){//添加
					var formdata = new FormData();
					if(roomImgFile==null){
						layer.msg('请添加房间图片！',{
				            offset: '150px',
				            time: 3000,
				            icon:7,
				            shade: [0.3, '#393D49']
						});
					}else if($("#roomTypeNameModify").val()==null||$("#roomTypeNameModify").val()==""){
						layer.msg('请输入房间类型！',{
				            offset: '150px',
				            time: 3000,
				            icon:7,
				            shade: [0.3, '#393D49']
						});
					}else if($("#sketchModify").val()==null||$("#sketchModify").val()==""){
						layer.msg('请简述房间类型！',{
				            offset: '150px',
				            time: 3000,
				            icon:7,
				            shade: [0.3, '#393D49']
						});
					}else if($("#typePriceModify").val()==null||$("#typePriceModify").val()==""){
						layer.msg('请输入价格！',{
				            offset: '150px',
				            time: 3000,
				            icon:7,
				            shade: [0.3, '#393D49']
						});
					}else if($("#describeModify").val()==null||$("#describeModify").val()==""){
						layer.msg('请详情描述！',{
				            offset: '150px',
				            time: 3000,
				            icon:7,
				            shade: [0.3, '#393D49']
						});
					}else{
						formdata.append('roomTypeId', id);
						formdata.append('roomImgFile', roomImgFile);
						formdata.append('roomTypeName',$("#roomTypeNameModify").val());
						formdata.append('sketch',$("#sketchModify").val());
						formdata.append('describe',$("#describeModify").val());
						formdata.append('typePrice',$("#typePriceModify").val());
						$.ajax({
		                    type: 'POST',
		                    url: path+'/room/addRoomTypeAjax',
		                    contentType : false,
		                    data : formdata,
		                    processData : false,
		                    dataType: "json",
		                    success: function (data) {
		                        if(data.result=="true"){
		                        	layer.msg('添加成功！',{
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
		                        	layer.msg('添加失败！',{
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
		});
		//修改房间类型
		$(".edit_btn").on('click',function(){
			var id=$(this).attr("roomTypeId");
			layer.open({
				content:$("#roomTypeDiv"), //内容
				area:'320px',
				resize:false,// 不允许拉伸
				btn: '保存',
				btnAlign: 'c',
				anim: 1,// 显示风格
				title: ['修改房间类型', 'font-size:18px;'],// 标题
				type: 1, 
				offset: '0px',// 离上50px水平居中
				success: function(layero, index){
					$.ajax({
						type:"GET",
						url:path+"/room/selRoomTypeById",
						data:{roomTypeId:id},
						dataType:"json",
						success:function(result){
							//图片
							layero.children(".layui-layer-content").children()
							.children().children().eq(0)
							.children("#drop_area").children()
							.children().attr("src",path+"/"+result.roomImg);
							//房型类型
							layero.children(".layui-layer-content").children()
							.children().children().eq(1)
							.children("#roomTypeNameModify").val(result.roomTypeName);
							//房间简介
							layero.children(".layui-layer-content").children()
							.children().children().eq(2)
							.children("#sketchModify").val(result.sketch);
							//房间价格
							layero.children(".layui-layer-content").children()
							.children().children().eq(3)
							.children("#typePriceModify").val(result.typePrice);
							//房间详情
							layero.children(".layui-layer-content").children()
							.children().children().eq(4)
							.children("#describeModify").text(result.describe);
						}
					});
				},
				yes: function(){//修改
					var formdata = new FormData();
					if($("#roomTypeNameModify").val()==null||$("#roomTypeNameModify").val()==""){
						layer.msg('请输入房间类型！',{
				            offset: '150px',
				            time: 3000,
				            icon:7,
				            shade: [0.3, '#393D49']
						});
					}else if($("#sketchModify").val()==null||$("#sketchModify").val()==""){
						layer.msg('请简述房间类型！',{
				            offset: '150px',
				            time: 3000,
				            icon:7,
				            shade: [0.3, '#393D49']
						});
					}else if($("#typePriceModify").val()==null||$("#typePriceModify").val()==""){
						layer.msg('请输入价格！',{
				            offset: '150px',
				            time: 3000,
				            icon:7,
				            shade: [0.3, '#393D49']
						});
					}else if($("#describeModify").val()==null||$("#describeModify").val()==""){
						layer.msg('请详情描述！',{
				            offset: '150px',
				            time: 3000,
				            icon:7,
				            shade: [0.3, '#393D49']
						});
					}else{
						formdata.append('roomTypeId', id);
						formdata.append('roomImgFile', roomImgFile);
						formdata.append('roomTypeName',$("#roomTypeNameModify").val());
						formdata.append('sketch',$("#sketchModify").val());
						formdata.append('describe',$("#describeModify").val());
						formdata.append('typePrice',$("#typePriceModify").val());
						$.ajax({
		                    type: 'POST',
		                    url: path+'/room/modifyRoomTypeAjax',
		                    contentType : false,
		                    data : formdata,
		                    processData : false,
		                    dataType: "json",
		                    success: function (data) {
		                        if(data.result=="true"){
		                        	layer.msg('修改成功！',{
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
		                        	layer.msg('修改失败！',{
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
		});
		//删除房间类型
		$(".del_btn").on('click',function(){
			//得到房间类型号
			var id=$(this).attr("roomTypeId");
			layer.msg('确定删除该房型吗？',{
	            offset: '100px',
	            icon:3,
	            time: 10000000,
	            shade: [0.3, '#393D49'],
	            btn:["确定","取消"],
	            yes:function(){
	            	$.ajax({
						type:"GET",
						url:path+"/room/delRoomTypeAjax",
						data:{roomTypeId:id},
						dataType:"json",
						success:function(data){
							if(data.result=="true"){
								layer.msg('删除成功！',{
						            offset: '200px',
						            icon:1,
						            time: 2000,
						            shade: [0.3, '#393D49']
								});
								//延时事件
								setTimeout(function(){
									 window.location.reload();//刷新
									},1000);
							}else if(data.result=="false"){
								layer.msg('删除失败！',{
						            offset: '200px',
						            icon:2,
						            time: 2000,
						            shade: [0.3, '#393D49']
								});
							}
						}
	            	});
	            }
			});
		});
	});
});
function DragImgUpload(id,options) {
    this.me = $(id);
    var defaultOpt = {
        boxWidth:'200px',
        boxHeight:'150px'
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