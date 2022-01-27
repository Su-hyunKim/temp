package mapperInterface;

import java.util.List;
import java.util.Map;

import vo.CommentsVO;

public interface CommentsMapper {
	
	List<CommentsVO> listPaging(Map<String, Object> paramMap);
	int countComments(Integer root_seq);
	// **  CRUD
	List<CommentsVO> list(Integer root_seq); //selectList
	int insert(CommentsVO commentsVo); //insert
	int update(CommentsVO commentsVo); //update
	int delete(CommentsVO commentsVo); //delete
	
	
	
} //interface
