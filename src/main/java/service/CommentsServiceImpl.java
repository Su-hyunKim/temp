package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import criteria.Criteria;
import mapperInterface.CommentsMapper;
import vo.CommentsVO;

@Service
public class CommentsServiceImpl implements CommentsService{
	
	@Autowired
	CommentsMapper dao;
	
	@Override
	public List<CommentsVO> getCommentsPaging(Integer root_seq, Criteria criteria) {
		
		Map<String, Object> 
		paramMap = new HashMap<>(); 
		paramMap.put("root_seq", root_seq); 
		paramMap.put("criteria", criteria);

		return dao.listPaging(paramMap);
	}

	@Override
	public int countComments(Integer root_seq) {
		return dao.countComments(root_seq);
	}

	@Override
	public List<CommentsVO> list(Integer root_seq) {
		return dao.list(root_seq);
	}

	@Override
	public int insert(CommentsVO commentsVo) {
		return dao.insert(commentsVo) ;
	}

	@Override
	public int update(CommentsVO commentsVo) {
		return dao.update(commentsVo) ;
	}

	@Override
	public int delete(CommentsVO commentsVo) {
		return dao.delete(commentsVo) ;
	}

}
