package lq.sc.service.comment;

import java.util.List;

import lq.sc.pojo.Comment;

/**
 * 
*   
* 项目名称：SevenHotel  
* 类名称：CommonService  
* 类描述：评论业务层  
* 创建人：lhh  
* 创建时间：2018-11-20 下午2:11:21
* @version   
*   
 */
public interface CommentService{
	/*
	 * 用户添加评论
	 */
	public boolean addComment(Comment comment);
	/*
	 * 根据订单查询评论是否已有
	 */
	public boolean selCommentCount_ByOrderId(int orderId);
	/*
	 * 根据用户id查询评论
	 */
	public List<Comment> selComment_ByCustomerId(int CustomerId);
	/*
	 * 根据评论id删除评论
	 */
	public boolean deleteComment(int commentId);
	/*
	 * 查询所有评论
	 */
	public List<Comment> selAllComment();
	/*
	 * 根据评论id查询评论
	 */
	public Comment selComment_ById(int id);
}
