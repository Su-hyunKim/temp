package mapperInterface;

import java.util.List;

import criteria.SearchCriteria;
import vo.RootVO;
import vo.PageVO;

public interface RootMapper {
	
	// ** Board Check List
	List<RootVO> checkList(RootVO vo);
	
	// ** Ajax id_BoardList
	List<RootVO> aidBList(RootVO vo) ;

	// ** PageList 2. SearchCriteria PageList
	int searchRowsCount(SearchCriteria cri) ;
	List<RootVO> searchList(SearchCriteria cri) ;
	// ** PageList1.
	int totalRowCount();
	List<RootVO> pageList(PageVO<RootVO> pvo);  
	List<RootVO> typeList(RootVO vo); //selectList
	// **  CRUD
	List<RootVO> selectList(); //selectList
	RootVO selectOne(RootVO vo); //selectOne
	int insert(RootVO vo); //insert
	int update(RootVO vo); //update
	int delete(RootVO vo); //delete
	// ** 조회수증가
	int countUp(RootVO vo); //countUp
	
} //interface
