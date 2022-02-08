package service;

import java.util.List;

import vo.FollowVO;


public interface FollowService {
	
	
	//기본 CRUD
	//List<FollowVO> selectList(); //selectList
	List<FollowVO> followingselectList(); //followingselectList
	List<FollowVO> followerselectList(); //followerselectList
	FollowVO selectOne(FollowVO vo); //selectOne
	int insert(FollowVO vo); //insert
	//int update(FollowVO vo); //update
	int delete(FollowVO vo); //delete
	//int countUp(FollowVO vo); //countUp

	int countfollowing(FollowVO vo);
	int countfollower(FollowVO vo);
	List<FollowVO> checkList(FollowVO vo); // Follow Check List

}
