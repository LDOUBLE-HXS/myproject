$(function(){
	layui.use('layer', function(){
		var layer = layui.layer;
		$(".read-more").on('click',function(){
			var commentId=$(this).attr("commentId");
			layer.msg('确定删除该评论吗?',{
	            offset: '100px',
	            icon:3,
	            time: 200000000,
	            shade: [0.3, '#393D49'],
	            btn:['确定','取消'],
	            yes:function(){
	            	$.ajax({
	    				type:"GET",
	    				url:path+"/user/deleteCommentAjax",
	    				data:{commentId:commentId},
	    				dataType:"json",
	    				success:function(data){
	    					if(data.result=="true"){
	    						layer.msg('删除成功！',{
	    				            offset: '50px',
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
	    				            offset: '50px',
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