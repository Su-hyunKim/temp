package service;

import java.util.List;

import vo.AuthVO;
import vo.MemberVO;


public interface MemberService {
	List<AuthVO> authList(MemberVO vo);
	List<MemberVO> checkList(MemberVO vo);
	int updateLastAccess(MemberVO vo);
	
	// 기본 CRUD
	List<MemberVO> selectList(); //selectList
	MemberVO selectOne(MemberVO vo); //selectOne
	int insert(MemberVO vo); //insert
	int update(MemberVO vo); //update
	int delete(MemberVO vo); //delete

}