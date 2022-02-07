package service;

import java.util.List;

import vo.PurchaseVO;

public interface PurchaseService {

	
	List<PurchaseVO> selectList(); //selectList
	PurchaseVO selectOne(PurchaseVO vo); //selectOne
	int insert(PurchaseVO vo); //insert
	int update(PurchaseVO vo); //update
	int delete(PurchaseVO vo); //delete

}
