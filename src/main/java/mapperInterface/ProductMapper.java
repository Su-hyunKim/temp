package mapperInterface;

import java.util.List;

import criteria.SearchCriteria;
import vo.PageVO;
import vo.ProductVO;


public interface ProductMapper {

	List<ProductVO> checkList(ProductVO vo);
	
	//기본 CRUD
	List<ProductVO> selectList(); //selectList
	ProductVO selectOne(ProductVO vo); //selectOne
	int insert(ProductVO vo); //insert
	int update(ProductVO vo); //update
	int delete(ProductVO vo); //delete

	int countUp(ProductVO vo); //cnt

	int totalRowCount();
	List<ProductVO> pageList(PageVO<ProductVO> pvo);
	int searchRowsCount(SearchCriteria cri);
	
	List<ProductVO> searchList(SearchCriteria cri);
	
} //interface