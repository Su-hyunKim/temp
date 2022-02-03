package service;

import java.util.List;

import vo.CommentsVO;

public interface CommentsService {
	
	// **  CRUD
	List<CommentsVO> selectList();
	CommentsVO selectOne(CommentsVO vo);
	int insert(CommentsVO vo); //insert
	int update(CommentsVO vo); //update
	int delete(CommentsVO vo); //delete
	
}