package service;

import java.util.List;

import criteria.MultiCheckSearchCriteria;
import vo.AuthVO;
import vo.MemberVO;

public interface MemberService {
	List<AuthVO> authList(MemberVO vo);
	List<MemberVO> checkList(MultiCheckSearchCriteria cri);
	int searchRowsCount(MultiCheckSearchCriteria cri);
	int totalRowCount();
	int updateLastAccess(MemberVO vo);
	int changeStatus(MemberVO vo);
	int updatePassword(MemberVO vo);
	int deleteSeller(MemberVO vo);
		
	// 기본 CRUD
	List<MemberVO> selectList(); //selectList
	MemberVO selectOne(MemberVO vo); //selectOne
	int insert(MemberVO vo); //insert
	int update(MemberVO vo); //update
	int delete(MemberVO vo); //delete

}