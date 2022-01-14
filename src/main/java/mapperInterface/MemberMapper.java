package mapperInterface;

import java.util.List;

import vo.MemberVO;

public interface MemberMapper {
	
	List<MemberVO> selectList(); //selectList
	MemberVO selectOne(MemberVO vo); //selectOne
	int insert(MemberVO vo); //insert
	int update(MemberVO vo); //update
	int delete(MemberVO vo); //delete	

} //interface
