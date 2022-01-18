package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import criteria.SearchCriteria;
import mapperInterface.CommentsMapper;
import vo.CommentsVO;
import vo.PageVO;

@Service
public class CommentsServiceimpl implements CommentsService{
	
	@Autowired
	CommentsMapper dao;
	
	@Override
	public int searchRowsCount(SearchCriteria cri) {
		return dao.searchRowsCount(cri);
	}

	@Override
	public List<CommentsVO> searchList(SearchCriteria cri) {
		return dao.searchList(cri) ;
	} 

	@Override
	public PageVO<CommentsVO> pageList(PageVO<CommentsVO> pvo) {
		pvo.setTotalRowCount(dao.totalRowCount());
		pvo.setList(dao.pageList(pvo));
		return pvo;
	}

	@Override
	public List<CommentsVO> selectList() {
		return dao.selectList();
	}

	@Override
	public CommentsVO selectOne(CommentsVO vo) {
		return dao.selectOne(vo);
	}

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

}
