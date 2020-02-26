$(function(){
	var createBy=null;//当前所选节点
	var modifyBy=null;
	var name=null;
	var id=0;
	layui.use('layer', function(){
		var layer = layui.layer;
		//创建者
		$(".createBy").on('mouseover',function(){
			//延时事件
			createBy=$(this);
			id=createBy.text();
			$.ajax({
				type:"POST",
				url:path+"/manager/selManagerAjax",
				data:{id:id},
				dataType:"json",
				success:function(result){
					if(result!=null){
						createBy.html(result.manName);
					}
				}
			});
		}).on('mouseout',function(){
			createBy.html(id);
		});
		//修改者
		$(".modifyBy").on('mouseover',function(){
			//延时事件
			modifyBy=$(this);
			id=modifyBy.text();
			$.ajax({
				type:"POST",
				url:path+"/manager/selManagerAjax",
				data:{id:id},
				dataType:"json",
				success:function(result){
					if(result!=null){
						modifyBy.html(result.manName);
					}
				}
			});
		}).on('mouseout',function(){
			modifyBy.html(id);
		});
		//添加会员福利
		$("#addMemberbutton").on('click',function(){
			$("#userMemberTypeInput").on('blur',function(){
				$.ajax({
					type:"POST",
					url:path+"/manager/selMemberAjax",
					data:{memberType:$("#userMemberTypeInput").val().trim()},
					dataType:"json",
					success:function(data){
						if(data.result=="true"){
							layer.msg('已存在该会员类别！',{
					            offset: '100px',
					            icon:2,
					            time: 2000,
					            shade: [0.3, '#393D49']
							});
							$("#userMemberTypeInput").val("");
						}
					}
				});
			});
			layer.open({
				content:$("#addMemberDiv"), //内容
				area:'340px',
				resize:false,// 不允许拉伸
				btn: '添加',
				btnAlign: 'c',
				anim: 1,// 显示风格
				title: ['添加会员福利', 'font-size:18px;'],// 标题
				type: 1, 
				offset: '100px',// 离上100px水平居中
				cancel: function(index, layero){ 
					$("#userMemberTypeInput").val("");
					$("#discountSelect").children("option[value='1.00']").attr("selected","selected");
				},
				yes:function(){
					if($("#userMemberTypeInput").val()==null||$("#userMemberTypeInput").val()==""){
						layer.msg('请输入会员类别！',{
				            offset: '100px',
				            icon:2,
				            time: 2000,
				            shade: [0.3, '#393D49']
						});
					}else if($("#discountSelect option:selected").val()=="0"){
						layer.msg('请选择折扣！',{
				            offset: '100px',
				            icon:2,
				            time: 2000,
				            shade: [0.3, '#393D49']
						});
					}else{
						$.ajax({
							type:"POST",
							url:path+"/manager/addMemberAjax",
							data:{memberType:$("#userMemberTypeInput").val().trim(),discount:$("#discountSelect option:selected").val()},
							dataType:"json",
							success:function(data){
								if(data.result=="true"){
									layer.msg('添加成功！',{
							            offset: '100px',
							            icon:1,
							            time: 2000,
							            shade: [0.3, '#393D49']
									});
									//延时事件
									setTimeout(function(){
										 window.location.reload();//刷新
										},1000);
								}else if(data.result=="false"){
									layer.msg('添加失败！',{
							            offset: '100px',
							            icon:2,
							            time: 2000,
							            shade: [0.3, '#393D49']
									});
								}
							}
						});
					}
				}
			});
		});
		//修改会员福利
		$(".modifyMember").on('click',function(){
			id=$(this).attr("memberid");
			layer.open({
				content:$("#modifyMember"), //内容
				area:'340px',
				resize:false,// 不允许拉伸
				btn: '修改',
				btnAlign: 'c',
				anim: 1,// 显示风格
				title: ['修改会员福利', 'font-size:18px;'],// 标题
				type: 1, 
				offset: '100px',// 离上100px水平居中
				success: function(layero, index){
					$.ajax({
						type:"GET",
						url:path+"/manager/selMemberByIdAjax",
						data:{id:id},
						dataType:"json",
						success:function(result){
							$("#userMemberType").on('blur',function(){
								if($("#userMemberType").val()!=result.memberType){
									$.ajax({
										type:"POST",
										url:path+"/manager/selMemberAjax",
										data:{memberType:$("#userMemberType").val().trim()},
										dataType:"json",
										success:function(data){
											if(data.result=="true"){
												layer.msg('已存在该会员类别！',{
										            offset: '100px',
										            icon:2,
										            time: 2000
												});
												layero.children(".layui-layer-content").children().children().children().children("#userMemberType").val(result.memberType);
											}
										}
									});
								}
							});
							layero.children(".layui-layer-content").children().children().children().children("#userMemberType").val(result.memberType);
							layero.children(".layui-layer-content").children().children().children().next().children("#discount").children("option[value='"+result.discount.toFixed(2)+"']").attr("selected","selected");
						}
					});
				},
				yes:function(){
					if($("#userMemberType").val()==null||$("#userMemberType").val()==""){
						layer.msg('请输入会员类别！',{
				            offset: '100px',
				            icon:2,
				            time: 2000
						});
					}else if($("#discount option:selected").val()=="0"){
						layer.msg('请选择折扣！',{
				            offset: '100px',
				            icon:2,
				            time: 2000
						});
					}else{
						$.ajax({
							type:"POST",
							url:path+"/manager/modifyMemberByIdAjax",
							data:{id:id,memberType:$("#userMemberType").val().trim(),discount:$("#discount option:selected").val()},
							dataType:"json",
							success:function(data){
								if(data.result=="true"){
									layer.msg('修改成功！',{
							            offset: '100px',
							            icon:1,
							            time: 2000
									});
									//延时事件
									setTimeout(function(){
										 window.location.reload();//刷新
										},1000);
								}else if(data.result=="false"){
									layer.msg('修改失败！',{
							            offset: '100px',
							            icon:2,
							            time: 2000
									});
								}
							}
						});
					}
				}
			});
		});
		//删除会员类别
		$(".deleteMember").on('click',function(){
			id=$(this).attr("memberid");
			layer.msg('确认删除吗？',{
	            offset: '200px',
	            icon:3,
	            time: 2000,
	            btn:["确定","取消"],
	            yes:function(){
	            	$.ajax({
						type:"GET",
						url:path+"/manager/deleteMemberByIdAjax",
						data:{id:id},
						dataType:"json",
						success:function(data){
							if(data.result=="true"){
								layer.msg('删除成功！',{
						            offset: '200px',
						            icon:1,
						            time: 2000,
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
								});
							}
						}
	            	});
	            }
			});
		});
	});
});