package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import criteria.SearchCriteria;
import mapperInterface.RootMapper;
import vo.RootVO;
import vo.PageVO;

//** interface 자동완성 
//=> Alt + Shift + T  
//=> 또는 마우스우클릭 PopUp Menu 의  Refactor - Extract Interface...

//** Interface 를 이용한 Mapper 접근 
//=> DAO 를 사용하지않고 interface MemberMapper 를 통해 MemberMapper 에 접근
//=> 주의) 이전 DAO의 pageList 메서드 에서 totalRowCount() 와 pageList(pvo) 
// 처리하고 pvo 를 return 했지만, interface의 메서드는 mapper 의 id 
// 와 같은 이름으로 1:1 매칭되기 때문에 이부분을 ServiceImpl 에서 처리해야함
// -> 아래 PageVO<MemberVO> pageList(PageVO<MemberVO> pvo) 확인

@Service
public class RootServiceImpl implements RootService {
	
	@Autowired
	RootMapper dao;
	
	// ** Board Check List
	@Override
	public List<RootVO> checkList(RootVO vo) {
		return dao.checkList(vo);
	}
	
	//** Ajax id_BoardList
	@Override
	public List<RootVO> aidBList(RootVO vo) {
		return dao.aidBList(vo);
	}
	
	// ** PageList 2. SearchCriteria PageList
	@Override
	public int searchRowsCount(SearchCriteria cri) {
		return dao.searchRowsCount(cri);
	} 
	@Override
	public List<RootVO> searchList(SearchCriteria cri) {
		return dao.searchList(cri) ;
	}
	// ** PageList1.
	@Override
	public PageVO<RootVO> pageList(PageVO<RootVO> pvo) {
		pvo.setTotalRowCount(dao.totalRowCount());
		pvo.setList(dao.pageList(pvo));
		return pvo;
	} //pageList

	@Override
	public List<RootVO> typeList(RootVO vo) {
		return dao.typeList(vo);
	} //selectList
	
	@Override
	public List<RootVO> selectList() {
		return dao.selectList();
	} //selectList
	
	@Override
	public RootVO selectOne(RootVO vo) {
		return dao.selectOne(vo);
	} //selectOne

	@Override
	public int insert(RootVO vo) {
		return dao.insert(vo) ;
	} //insert
	@Override
	public int update(RootVO vo) {
		return dao.update(vo) ;
	} //update
	@Override
	public int delete(RootVO vo) {
		return dao.delete(vo) ;
	} //delete
	
	// ** 조회수증가
	@Override
	public int countUp(RootVO vo) {
		return dao.countUp(vo) ;
	} //countUp
	
	// ** 답글입력
	/*
	 * @Override public int rinsert(RootVO vo) { return dao.rinsert(vo); }
	 */
} //class

