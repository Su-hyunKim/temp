package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mapperInterface.FollowMapper;
import vo.FollowVO;
	
	@Service
	public class FollowServiceImpl implements FollowService {
		
		@Autowired
		FollowMapper dao;
		
		//기본 CRUD
		@Override
		public List<FollowVO> followingselectList() {
			return dao.followingselectList();
		} //selectList
		@Override
		public List<FollowVO> followerselectList() {
			return dao.followerselectList();
		} //selectList
		@Override
		public FollowVO selectOne(FollowVO vo) {
			return dao.selectOne(vo);
		} //selectOne
		@Override
		public int insert(FollowVO vo) {
			return dao.insert(vo) ;
		} //insert
		
		@Override
		public int delete(FollowVO vo) {
			return dao.delete(vo) ;
		} //delete
		
		@Override
		public int countfollowing(FollowVO vo) {
			return dao.countfollowing(vo) ;
		} //cnt
		
		@Override
		public int countfollower(FollowVO vo) {
			return dao.countfollower(vo) ;
		} //cnt
				
		@Override
		public List<FollowVO> checkList(FollowVO vo) {
			return dao.checkList(vo);
		}
	} //class

