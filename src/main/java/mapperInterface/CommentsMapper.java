package mapperInterface;

import java.util.List;

import critetia.SearchCriteria;
import vo.CommentsVO;
import vo.PageVO;

public interface CommentsMapper {
	
	int searchRowsCount(SearchCriteria cri) ;
	List<CommentsVO> searchList(SearchCriteria cri) ;
	// ** PageList1.
	int totalRowCount();
	List<CommentsVO> pageList(PageVO<CommentsVO> pvo);  
	// **  CRUD
	List<CommentsVO> selectList(); //selectList
	CommentsVO selectOne(CommentsVO vo); //selectOne
	int insert(CommentsVO vo); //insert
	int update(CommentsVO vo); //update
	int delete(CommentsVO vo); //delete
	
} //interface
