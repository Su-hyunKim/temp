package mapperInterface;

import java.util.List;

import vo.FollowVO;


public interface FollowMapper {

	
	//기본 CRUD
	List<FollowVO> followingselectList(FollowVO vo); //followingselectList
	List<FollowVO> followerselectList(FollowVO vo); //followerselectList
	FollowVO selectOne(FollowVO vo); //selectOne
	int insert(FollowVO vo); //insert
	
	int delete(FollowVO vo); //delete

	int countfollowing(FollowVO vo);
	int countfollower(FollowVO vo);
	int countmyfollowing(FollowVO vo);
	int countmyfollower(FollowVO vo);
	int followflag(FollowVO vo);
	List<FollowVO> checkList(FollowVO vo);
	
} //interface