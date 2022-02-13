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
		public List<FollowVO> followingselectList(FollowVO vo) {
			return dao.followingselectList(vo);
		} //selectList
		@Override
		public List<FollowVO> followerselectList(FollowVO vo) {
			return dao.followerselectList(vo);
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
		} //countfollowing
		
		@Override
		public int countfollower(FollowVO vo) {
			return dao.countfollower(vo) ;
		} //countfollower
		@Override
		public int countmyfollowing(FollowVO vo) {
			return dao.countmyfollowing(vo) ;
		} //countmyfollowing
		
		@Override
		public int countmyfollower(FollowVO vo) {
			return dao.countmyfollower(vo) ;
		} //countmyfollower

		@Override
		public int followflag(FollowVO vo) {
			return dao.followflag(vo);
		}
		
		@Override
		public List<FollowVO> checkList(FollowVO vo) {
			return dao.checkList(vo);
		}//checkList
	} //class

