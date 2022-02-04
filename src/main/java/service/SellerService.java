package service;

import java.util.List;

import criteria.MultiCheckSearchCriteria;
import vo.AuthVO;
import vo.SellerVO;


public interface SellerService {
	List<AuthVO> authList(SellerVO vo);
	List<SellerVO> checkList(MultiCheckSearchCriteria cri);
	List<SellerVO> ascList(SellerVO vo);
	int updateLastAccess(SellerVO vo);
	int changeStatus(SellerVO vo);
		
	// 기본 CRUD
	List<SellerVO> selectList(); //selectList
	SellerVO selectOne(SellerVO vo); //selectOne
	int insert(SellerVO vo); //insert
	int update(SellerVO vo); //update
	int delete(SellerVO vo); //delete

}