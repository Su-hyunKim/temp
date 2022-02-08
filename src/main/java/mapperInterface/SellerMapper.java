package mapperInterface;

import java.util.List;

import criteria.MultiCheckSearchCriteria;
import vo.ProductVO;
import vo.SellerVO;

public interface SellerMapper {
	
	List<ProductVO> productList(SellerVO vo);
	List<SellerVO> checkList(MultiCheckSearchCriteria cri);	
	int searchRowsCount(MultiCheckSearchCriteria cri);
	int totalRowCount();
	int updateLastAccess(SellerVO vo);
	int changeStatus(SellerVO vo);
	
	// 기본 CRUD
	List<SellerVO> selectList(); //selectList
	SellerVO selectOne(SellerVO vo); //selectOne
	int insert(SellerVO vo); //insert
	int update(SellerVO vo); //update
	int delete(SellerVO vo); //delete

} //interface
