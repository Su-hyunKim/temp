package mapperInterface;

import java.util.List;

import vo.MemberVO;

public interface MemberMapper {
	
	List<MemberVO> checkList(MemberVO vo);
	
	int updateLastAccess(MemberVO vo);
	
	// 기본 CRUD
	List<MemberVO> selectList(); //selectList
	MemberVO selectOne(MemberVO vo); //selectOne
	int insert(MemberVO vo); //insert
	int update(MemberVO vo); //update
	int delete(MemberVO vo); //delete

} //interface
