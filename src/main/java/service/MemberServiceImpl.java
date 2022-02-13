package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import criteria.MultiCheckSearchCriteria;
import mapperInterface.MemberMapper;
import vo.AuthVO;
import vo.MemberVO;
import vo.RootVO;

//** interface 자동완성 
//=> Alt + Shift + T  
//=> 또는 마우스우클릭 PopUp Menu 의  Refactor - Extract Interface...

// ** Interface 를 이용한 Mapper 접근 
// => DAO 를 사용하지않고 interface MemberMapper 를 통해 MemberMapper 에 접근
// => 주의) 이전 DAO의 pageList 메서드 에서 totalRowCount() 와 pageList(pvo) 
//    처리하고 pvo 를 return 했지만, interface의 메서드는 mapper 의 id 
//    와 같은 이름으로 1:1 매칭되기 때문에 이부분을 ServiceImpl 에서 처리해야함
//    -> 아래 PageVO<MemberVO> pageList(PageVO<MemberVO> pvo) 확인 

@Service
public class MemberServiceImpl implements MemberService {
	
	//@Setter(onMethod = @Autowired) 
	// => onMethod 속성은 생성되는 setter에 @AutoWired 어노테이션을 추가해줌.
	@Autowired
	MemberMapper dao;
	// MemberMapper 의 인스턴스를 스프링이 생성 해주고 이를 주입받아 실행함
	// 단, 설정화일에 <mybatis-spring:scan base-package="mapperInterface"/> 추가해야함

	@Override
	public List<AuthVO> authList(MemberVO vo) {
		return dao.authList(vo);
	}
	
	@Override
	public List<RootVO> reviewList(MemberVO vo) {
		return dao.reviewList(vo);
	}
	
	@Override
	public List<MemberVO> checkList(MultiCheckSearchCriteria cri) {
		return dao.checkList(cri);
	}
	
	@Override
	public List<MemberVO> findIdByBirthday(MemberVO vo) {
		return dao.findIdByBirthday(vo);
	}
	
	@Override
	public List<MemberVO> followerList(MemberVO vo) {
		return dao.followerList(vo);
	}
	
	@Override
	public List<MemberVO> followingList(MemberVO vo) {
		return dao.followingList(vo);
	}
	
	@Override
	public List<MemberVO> findIdByEmail(MemberVO vo) {
		return dao.findIdByEmail(vo);
	}
	
	@Override
	public int searchRowsCount(MultiCheckSearchCriteria cri) {
		return dao.searchRowsCount(cri);
	}
	
	@Override
	public int totalRowCount() {
		return dao.totalRowCount();
	}
	
	@Override
	public int countFollower(MemberVO vo) {
		return dao.countFollower(vo);
	}
	
	@Override
	public int countFollowing(MemberVO vo) {
		return dao.countFollowing(vo);
	}
	
	@Override
	public int updateLastAccess(MemberVO vo) {
		return dao.updateLastAccess(vo);
	}
	
	@Override
	public int changeStatus(MemberVO vo) {
		return dao.changeStatus(vo);
	}
	
	@Override
	public int updatePassword(MemberVO vo) {
		return dao.updatePassword(vo);
	}
	
	@Override
	public int deleteSeller(MemberVO vo) {
		return dao.deleteSeller(vo);
	}
	
	@Override
	public List<MemberVO> selectList() {
		return dao.selectList();
	} //selectList
	@Override
	public MemberVO selectOne(MemberVO vo) {
		return dao.selectOne(vo);
	} //selectOne

	@Override
	public int insert(MemberVO vo) {
		return dao.insert(vo) ;
	} //insert
	@Override
	public int update(MemberVO vo) {
		return dao.update(vo) ;
	} //update
	@Override
	public int delete(MemberVO vo) {
		return dao.delete(vo) ;
	} //delete
	
} //class
