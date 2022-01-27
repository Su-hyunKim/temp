package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import criteria.SearchCriteria;
import mapperInterface.ProductMapper;
import vo.PageVO;
import vo.ProductVO;
	
	@Service
	public class ProductServiceImpl implements ProductService {
		
		@Autowired
		ProductMapper dao;
		
		
		//기본 CRUD
		@Override
		public List<ProductVO> selectList() {
			return dao.selectList();
		} //selectList
		@Override
		public ProductVO selectOne(ProductVO vo) {
			return dao.selectOne(vo);
		} //selectOne
		@Override
		public int insert(ProductVO vo) {
			return dao.insert(vo) ;
		} //insert
		@Override
		public int update(ProductVO vo) {
			return dao.update(vo) ;
		} //update
		@Override
		public int delete(ProductVO vo) {
			return dao.delete(vo) ;
		} //delete
		
		@Override
		public int countUp(ProductVO vo) {
			return dao.countUp(vo) ;
		} //cnt
		
		// ** PageList1.
		@Override
		public PageVO<ProductVO> pageList(PageVO<ProductVO> pvo) {
			pvo.setTotalRowCount(dao.totalRowCount());
			pvo.setList(dao.pageList(pvo));
			return pvo;
		} //pageList
				
		// ** PageList 2. SearchCriteria PageList
		@Override
		public int searchRowsCount(SearchCriteria cri) {
			return dao.searchRowsCount(cri);
		} 
		@Override
		public List<ProductVO> searchList(SearchCriteria cri) {
			return dao.searchList(cri) ;
		}
		
		
		@Override
		public List<ProductVO> checkList(ProductVO vo) {
			return dao.checkList(vo);
		}
	} //class

