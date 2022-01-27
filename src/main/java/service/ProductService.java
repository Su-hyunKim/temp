package service;

import java.util.List;

import criteria.SearchCriteria;
import vo.PageVO;
import vo.ProductVO;

public interface ProductService {
	
	
	
	
	//기본 CRUD
	List<ProductVO> selectList(); //selectList
	ProductVO selectOne(ProductVO vo); //selectOne
	int insert(ProductVO vo); //insert
	int update(ProductVO vo); //update
	int delete(ProductVO vo); //delete

	int countUp(ProductVO vo);//cnt
	
	PageVO<ProductVO> pageList(PageVO<ProductVO> pvo); //ppageList

	List<ProductVO> searchList(SearchCriteria cri) ;
	int searchRowsCount(SearchCriteria cri); // searchCriteria PageList
	
	List<ProductVO> checkList(ProductVO vo); // Product Check List

	

}
