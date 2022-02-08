package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import criteria.MultiCheckSearchCriteria;
import mapperInterface.SellerMapper;
import vo.ProductVO;
import vo.SellerVO;

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
public class SellerServiceImpl implements SellerService {
	
	//@Setter(onMethod = @Autowired) 
	// => onMethod 속성은 생성되는 setter에 @AutoWired 어노테이션을 추가해줌.
	@Autowired
	SellerMapper dao;
	// MemberMapper 의 인스턴스를 스프링이 생성 해주고 이를 주입받아 실행함
	// 단, 설정화일에 <mybatis-spring:scan base-package="mapperInterface"/> 추가해야함

	@Override
	public List<ProductVO> productList(SellerVO vo) {
		return dao.productList(vo);
	}
	
	@Override
	public List<SellerVO> checkList(MultiCheckSearchCriteria cri) {
		return dao.checkList(cri);
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
	public int updateLastAccess(SellerVO vo) {
		return dao.updateLastAccess(vo);
	}
	
	@Override
	public int changeStatus(SellerVO vo) {
		return dao.changeStatus(vo);
	}
	
	@Override
	public List<SellerVO> selectList() {
		return dao.selectList();
	} //selectList
	@Override
	public SellerVO selectOne(SellerVO vo) {
		return dao.selectOne(vo);
	} //selectOne

	@Override
	public int insert(SellerVO vo) {
		return dao.insert(vo) ;
	} //insert
	@Override
	public int update(SellerVO vo) {
		return dao.update(vo) ;
	} //update
	@Override
	public int delete(SellerVO vo) {
		return dao.delete(vo) ;
	} //delete
	
} //class
