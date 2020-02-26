package lq.sc.service.comment;

import java.util.List;

import javax.annotation.Resource;

import lq.sc.dao.comment.CommentMapper;
import lq.sc.pojo.Comment;

import org.springframework.stereotype.Service;

/**
 * 
*   
* 项目名称：SevenHotel  
* 类名称：CommonServiceImpl  
* 类描述：  评论业务实现层
* 创建人：lhh  
* 创建时间：2019-6-20 下午2:11:35
* @version   
*   
 */
@Service
public class CommentServiceImpl implements CommentService{
	@Resource
	private CommentMapper commentMapper;
	//用户添加评论
	public boolean addComment(Comment comment) {
		if(commentMapper.addComment(comment)>0){
			return true;
		}else{
			return false;
		}
	}
	//根据订单查询评论是否已有
	public boolean selCommentCount_ByOrderId(int orderId) {
		if(commentMapper.selCommentCount_ByOrderId(orderId)>0){
			return true;
		}else{
			return false;
		}
	}
	//根据用户id查询评论
	public List<Comment> selComment_ByCustomerId(int CustomerId) {
		return commentMapper.selComment_ByCustomerId(CustomerId);
	}
	//根据评论id删除评论
	public boolean deleteComment(int commentId) {
		if(commentMapper.deleteComment(commentId)>0){
			return true;
		}else{
			return false;
		}
	}
	public List<Comment> selAllComment() {
		return commentMapper.selAllComment();
	}
	//根据评论id查询评论
	public Comment selComment_ById(int id) {
		return commentMapper.selComment_ById(id);
	}
}
