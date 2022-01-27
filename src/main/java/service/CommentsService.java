package service;

import java.util.List;

import criteria.Criteria;
import vo.CommentsVO;

public interface CommentsService {
	
	// ** PageList
	List<CommentsVO> getCommentsPaging(Integer root_seq, Criteria criteria);
	int countComments(Integer root_seq);
	// **  CRUD
	List<CommentsVO> list(Integer root_seq); //selectList
	int insert(CommentsVO commentsVo); //insert
	int update(CommentsVO commentsVo); //update
	int delete(CommentsVO commentsVo); //delete

}