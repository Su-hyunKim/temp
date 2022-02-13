package mapperInterface;

import java.util.List;

import criteria.MultiCheckSearchCriteria;
import vo.AuthVO;
import vo.MemberVO;
import vo.RootVO;

public interface MemberMapper {
	
	List<AuthVO> authList(MemberVO vo);
	List<RootVO> reviewList(MemberVO vo);
	List<MemberVO> checkList(MultiCheckSearchCriteria cri);	
	List<MemberVO> findIdByBirthday(MemberVO vo);
	List<MemberVO> findIdByEmail(MemberVO vo);
	List<MemberVO> followerList(MemberVO vo);
	List<MemberVO> followingList(MemberVO vo);
	int searchRowsCount(MultiCheckSearchCriteria cri);
	int totalRowCount();
	int countFollower(MemberVO vo);
	int countFollowing(MemberVO vo);
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

} //interface
