package service;

import java.util.List;

import critetia.SearchCriteria;
import vo.CommentsVO;
import vo.PageVO;

public interface CommentsService {
	
	// ** PageList 2. SearchCriteria PageList
	int searchRowsCount(SearchCriteria cri) ;
	List<CommentsVO> searchList(SearchCriteria cri) ;
	// ** PageList1.
	PageVO<CommentsVO> pageList(PageVO<CommentsVO> pvo); // pageList 1 
	// **  CRUD
	List<CommentsVO> selectList(); //selectList
	CommentsVO selectOne(CommentsVO vo); //selectOne
	int insert(CommentsVO vo); //insert
	int update(CommentsVO vo); //update
	int delete(CommentsVO vo); //delete

}