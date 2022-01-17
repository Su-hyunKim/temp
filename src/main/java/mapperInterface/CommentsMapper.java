package mapperInterface;

import java.util.List;

import critetia.SearchCriteria;
import vo.CommentsVO;
import vo.PageVO;

public interface CommentsMapper {
	
	// ** Comments Check List
	List<CommentsVO> checkList(CommentsVO vo);
	
	// ** Ajax id_CommentsList
	List<CommentsVO> aidBList(CommentsVO vo) ;

	// ** PageList 2. SearchCriteria PageList
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
	// ** 조회수증가
	int countUp(CommentsVO vo); //countUp
	// ** 답글입력
	int rinsert(CommentsVO vo);
	
} //interface
