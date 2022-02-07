package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import criteria.SearchCriteria;
import mapperInterface.ProductMapper;
import mapperInterface.PurchaseMapper;
import vo.PageVO;
import vo.PurchaseVO;
	
	@Service
	public class PurchaseServiceImpl implements PurchaseService {
		
		@Autowired
		PurchaseMapper dao;
		
		
		//기본 CRUD
		@Override
		public List<PurchaseVO> selectList() {
			return dao.selectList();
		} //selectList
		@Override
		public PurchaseVO selectOne(PurchaseVO vo) {
			return dao.selectOne(vo);
		} //selectOne
		@Override
		public int insert(PurchaseVO vo) {
			return dao.insert(vo) ;
		} //insert
		@Override
		public int update(PurchaseVO vo) {
			return dao.update(vo) ;
		} //update
		@Override
		public int delete(PurchaseVO vo) {
			return dao.delete(vo) ;
		} //delete
		/*
		 * @Override public int countUp(PurchaseVO vo) { return dao.countUp(vo) ; }
		 * //cnt
		 * 
		 * // ** PageList1.
		 * 
		 * @Override public PageVO<PurchaseVO> pageList(PageVO<PurchaseVO> pvo) {
		 * pvo.setTotalRowCount(dao.totalRowCount()); pvo.setList(dao.pageList(pvo));
		 * return pvo; } //pageList
		 * 
		 * // ** PageList 2. SearchCriteria PageList
		 * 
		 * @Override public int searchRowsCount(SearchCriteria cri) { return
		 * dao.searchRowsCount(cri); }
		 * 
		 * @Override public List<ProductVO> searchList(SearchCriteria cri) { return
		 * dao.searchList(cri) ; }
		 * 
		 * 
		 * @Override public List<ProductVO> checkList(ProductVO vo) { return
		 * dao.checkList(vo); }
		 */
	} //class

