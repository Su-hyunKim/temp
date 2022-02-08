package mapperInterface;

import java.util.List;

import vo.FollowVO;


public interface FollowMapper {

	
	//기본 CRUD
	List<FollowVO> followingselectList(); //followingselectList
	List<FollowVO> followerselectList(); //followerselectList
	FollowVO selectOne(FollowVO vo); //selectOne
	int insert(FollowVO vo); //insert
	
	int delete(FollowVO vo); //delete

	int countfollowing(FollowVO vo);
	int countfollower(FollowVO vo);

	List<FollowVO> checkList(FollowVO vo);
	
} //interface