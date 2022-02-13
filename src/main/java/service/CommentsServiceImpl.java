package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mapperInterface.CommentsMapper;
import vo.CommentsVO;

@Service
public class CommentsServiceImpl implements CommentsService{
	
	@Autowired
	CommentsMapper dao;
	
	@Override
	public int insert(CommentsVO vo) {
		return dao.insert(vo) ;
	}

	@Override
	public int update(CommentsVO vo) {
		return dao.update(vo) ;
	}

	@Override
	public int delete(CommentsVO vo) {
		return dao.delete(vo) ;
	}

	@Override
	public CommentsVO selectOne(CommentsVO vo) {
		return dao.selectOne(vo);
	}

	@Override
	public List<CommentsVO> selectList(CommentsVO vo) {
		return dao.selectList(vo);
	}

	@Override
	public List<CommentsVO> selectmyList(CommentsVO vo) {
		return dao.selectmyList(vo);
	}

}
