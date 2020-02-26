$(function(){
	var workImgFile=null;
	var fileName=null
	var dragImgUpload = new DragImgUpload("#drop_area",{
		callback:function (files) {
			//回调函数，可以传递给后台等等
			var file = files[0];
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
				workImgFile=null;
				//延时事件
				setTimeout(function(){
					 window.location.reload();//刷新
					},1000);
			}else{
				workImgFile=file;
			}
		}
	});
	layui.use('layer', function(){
		var layer = layui.layer;
		$("#manCode").on("blur",function(){
				$.ajax({
					type:"POST",//请求类型
					url:path+"/manager/manCodeAjax",//请求的url
					data:{manCode:$("#manCode").val()},//请求参数
					dataType:"json",//ajax接口（请求url）返回的数据类型
					success:function(data){//data：返回数据（json对象）
						if(data!=null){
							validateTip($("#manCode").next(),{"color":"green"},"",false);
						}
					},
					error:function(data){//当访问时候，404，500 等非200的错误状态码
						validateTip($("#manCode").next(),{"color":"red"},"",true);
					}
				});
		});
		//添加
		$(".addBtn").on('click',function(){
			var patrn=/^(1[0-9][0-9]|15[0-9]|18[0-9])\d{8}$/;
			if(workImgFile==null){
				layer.msg('请添加工作照！', {
					offset : '200px',
					icon : 7,
					time : 2000,
					shade: [0.3, '#393D49']
				});
			}else if($("#manCode").val()==null||$("#manCode").val()==""){
				layer.msg('请输入员工账号！', {
					offset : '200px',
					icon : 7,
					time : 2000,
					shade: [0.3, '#393D49']
				});
			}else if($("#manCode").attr("validateStatus") != "true"){
				$("#manCode").val("");
				layer.msg('已存在的员工账号！', {
					offset : '200px',
					icon : 7,
					time : 2000,
					shade: [0.3, '#393D49']
				});
			}else if($("#manName").val()==null||$("#manName").val()==""){
				layer.msg('请输入员工姓名！', {
					offset : '200px',
					icon : 7,
					time : 2000,
					shade: [0.3, '#393D49']
				});
			}else if(!$("#manPhone").val().match(patrn)){
				layer.msg('员工手机格式不正确！', {
					offset : '200px',
					icon : 7,
					time : 2000,
					shade: [0.3, '#393D49']
				});
			}else if($("#manSex option:selected").val()==0){
				layer.msg('请选择性别！', {
					offset : '200px',
					icon : 7,
					time : 2000,
					shade: [0.3, '#393D49']
				});
			}else if($("#position option:selected").val()==0){
				layer.msg('请选择上任岗位！', {
					offset : '200px',
					icon : 7,
					time : 2000,
					shade: [0.3, '#393D49']
				});
			}else{
				//表单
				var formdata = new FormData();
				//进行添加
				formdata.append('workImgFile', workImgFile);
				formdata.append('manCode',$("#manCode").val());
				formdata.append('manName',$("#manName").val());
				formdata.append('manPhone',$("#manPhone").val());
				formdata.append('manSex',$("#manSex option:selected").val());
				formdata.append('positionId',$("#position option:selected").val());
				$.ajax({
					type:"POST",
					url:path+"/manager/addManagerAjax",
					contentType : false,
                    data : formdata,
                    processData : false,
                    dataType: "json",
					success:function(result){
						if (result.result == "true") {
							layer.msg('添加成功！可到员工列表查看', {
								offset : '200px',
								icon : 1,
								time : 2000,
								shade: [0.3, '#393D49']
							});
							// 延时事件
							setTimeout(function() {
								//跳到员工页面
								window.location.reload();
							}, 1000);
						} else if (result.result == "false") {
							layer.msg('添加失败！', {
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