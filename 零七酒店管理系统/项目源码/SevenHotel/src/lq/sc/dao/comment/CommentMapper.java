package lq.sc.dao.comment;

import java.util.List;

import org.springframework.stereotype.Service;

import lq.sc.pojo.Comment;


/**
 * 
*   
* 项目名称：SevenHotel  
* 类名称：CommonMapper  
* 类描述：  评论mapper接口
* 创建人：lhh  
* 创建时间：2018-11-20 下午2:09:10
* @version   
*   
 */
@Service
public interface CommentMapper {
	/*
	 * 用户添加评论
	 */
	public int addComment(Comment comment);
	/*
	 * 根据订单查询评论是否已有
	 */
	public int selCommentCount_ByOrderId(int orderId);
	/*
	 * 根据用户id查询评论
	 */
	public List<Comment> selComment_ByCustomerId(int customerId);
	/*
	 * 根据评论id删除评论
	 */
	public int deleteComment(int commentId);
	/*
	 * 查询所有评论
	 */
	public List<Comment> selAllComment();
	/*
	 * 根据评论id查询评论
	 */
	public Comment selComment_ById(int id);
}
