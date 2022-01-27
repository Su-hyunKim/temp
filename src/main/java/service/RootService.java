package service;

import java.util.List;

import criteria.SearchCriteria;
import vo.RootVO;
import vo.PageVO;

public interface RootService {
	
	// ** Board Check List
	List<RootVO> checkList(RootVO vo);
	
	// ** Ajax id_BoardList
	List<RootVO> aidBList(RootVO vo);
	
	// ** PageList 2. SearchCriteria PageList
	int searchRowsCount(SearchCriteria cri) ;
	List<RootVO> searchList(SearchCriteria cri) ;
	// ** PageList1.
	PageVO<RootVO> pageList(PageVO<RootVO> pvo); // pageList 1 
	// **  CRUD
	List<RootVO> selectList(); //selectList
	RootVO selectOne(RootVO vo); //selectOne
	int insert(RootVO vo); //insert
	int update(RootVO vo); //update
	int delete(RootVO vo); //delete
	// ** 조회수증가
	int countUp(RootVO vo); //countUp
	
}