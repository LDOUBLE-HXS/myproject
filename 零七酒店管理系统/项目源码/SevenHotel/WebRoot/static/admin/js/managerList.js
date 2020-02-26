$(function(){
	var workImgFile=null;
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
					workImgFile=null;
					//延时事件
					setTimeout(function(){
						 window.location.reload();//刷新
						},1000);
				}else{
					workImgFile=file;
				}
			}
		}
	});
	layui.use('layer', function(){
		var layer = layui.layer;
		//修改员工
		$(".edit_btn").on('click',function(){
			var id=$(this).attr("manId");
			layer.open({
				content:$("#modifyManagerDiv"), //内容
				area:'380px',
				resize:false,// 不允许拉伸
				btn: '修改',
				btnAlign: 'c',
				anim: 1,// 显示风格
				title: ['员工详情', 'font-size:18px;'],// 标题
				type: 1, 
				offset: '0px',// 离上100px水平居中
				success: function(layero, index){
					//弹出框显示出基本信息
					$.ajax({
						type:"POST",
						url:path+"/manager/selManagerAjax",
						data:{id:id},
						dataType:"json",
						success:function(data){
							//管理员工照
							layero.children(".layui-layer-content").children()
							.children().children().eq(0)
							.children("#drop_area").children()
							.children().attr("src",data.workPicPath);
							//管理员账号不能更改
							layero.children(".layui-layer-content").children()
							.children().children().eq(1)
							.children("#manCode").html(data.manCode);
							//管理员姓名
							layero.children(".layui-layer-content").children()
							.children().children().eq(2)
							.children("#manName").val(data.manName);
							//管理员联系方式
							layero.children(".layui-layer-content").children()
							.children().children().eq(3)
							.children("#manPhone").val(data.manPhone);
							//管理员性别
							if(data.manSex=="1"){
								layero.children(".layui-layer-content").children()
								.children().children().eq(4)
								.children("#manSex").html("女");
							}else{
								layero.children(".layui-layer-content").children()
								.children().children().eq(4)
								.children("#manSex").html("男");
							}
							//职务
							layero.children(".layui-layer-content").children()
							.children().children().eq(5)
							.children("#position").children("option[value='"+data.positionId+"']").attr("selected","selected");
							//工资
							layero.children(".layui-layer-content").children()
							.children().children().eq(6)
							.children("#salary").html(data.position.salary);
							//入职时间
							layero.children(".layui-layer-content").children()
							.children().children().eq(7)
							.children("#creationDate").html(data.creationDate);
							//上岗状态
							layero.children(".layui-layer-content").children()
							.children().children().eq(8)
							.children("#manState").children("option[value='"+data.manState+"']").attr("selected","selected");
						}
					});
				},
				yes:function(){
					//表单
					var formdata = new FormData();
					//手机正则
					var patrn=/^(1[0-9][0-9]|15[0-9]|18[0-9])\d{8}$/;
					if($("#manName").val()==null||$("#manName").val()==""){
						layer.msg('姓名不能为空！', {
							offset : '200px',
							icon : 7,
							time : 2000,
							shade: [0.3, '#393D49']
						});
					}else if(!$("#manPhone").val().match(patrn)){
						layer.msg('手机格式不正确！', {
							offset : '200px',
							icon : 7,
							time : 2000,
							shade: [0.3, '#393D49']
						});
					}else{
						//进行修改
						formdata.append('managerId', id);
						formdata.append('workImgFile', workImgFile);
						formdata.append('manName',$("#manName").val());
						formdata.append('manPhone',$("#manPhone").val());
						formdata.append('positionId',$("#position option:selected").val());
						formdata.append('manState',$("#manState option:selected").val());
						$.ajax({
							type:"POST",
							url:path+"/manager/modifyManagerAjax",
							contentType : false,
		                    data : formdata,
		                    processData : false,
		                    dataType: "json",
							success:function(result){
								if (result.result == "true") {
									layer.msg('修改成功！', {
										offset : '200px',
										icon : 1,
										time : 2000,
										shade: [0.3, '#393D49']
									});
									// 延时事件
									setTimeout(function() {
										window.location.reload();// 刷新
									}, 1000);
								} else if (result.result == "false") {
									layer.msg('修改失败！', {
										offset : '200px',
										icon : 2,
										time : 2000,
										shade: [0.3, '#393D49']
									});
								}
							}
						});
					}
				},
				cancel:function(){
					window.location.reload();
				}
			});
		});
		//删除员工
		$(".del_btn").on('click',function(){
			var id=$(this).attr("manId");
			//判断是否在岗
			if($(this).parent().parent().children().eq(7).html()=="在岗"){
				layer.msg('不可删除在岗员工！', {
					offset : '200px',
					icon : 7,
					time : 2000,
					shade: [0.3, '#393D49']
				});
			}else{
				$.ajax({
					type:"GET",
					url:path+"/manager/deleteManagerAjax",
                    data : {managerId:id},
                    dataType: "json",
					success:function(result){
						if (result.result == "true") {
							layer.msg('删除成功！', {
								offset : '200px',
								icon : 1,
								time : 2000,
								shade: [0.3, '#393D49']
							});
							// 延时事件
							setTimeout(function() {
								window.location.reload();// 刷新
							}, 1000);
						} else if (result.result == "false") {
							layer.msg('删除失败！', {
								offset : '200px',
								icon : 2,
								time : 2000,
								shade: [0.3, '#393D49']
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
        boxWidth:'100px',
        boxHeight:'100px'
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