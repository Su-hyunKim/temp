//package service;
//
//import java.util.List;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//
//import criteria.Criteria;
//import criteria.PageMaker;
//import lombok.extern.log4j.Log4j;
//import mapperInterface.AdminMapper;
//import vo.ProcateVO;
//import vo.ProductVO;
//
//@Service
//@Log4j
//public class AdminServiceImpl implements AdminService {
//
//	@Autowired
//	private AdminMapper adminMapper;
//	
//	// 상품등록
//	@Override
//	public void pregist(ProductVO product) {
//		
//		log.info("(service)pregist...");
//		
//		adminMapper.pregist(product);
//	}
//	
//	// 카테고리 리스트
//	@Override
//	public List<ProcateVO> procateList() {
//		
//		log.info("(service)procateList........");
//		
//		return adminMapper.procateList();
//	}
//	
//	// 상품 리스트
//	@Override
//	public List<ProductVO> productGetList(Criteria cri) {
//		log.info("productGetTotalList()..........");
//		return adminMapper.productGetList(cri);
//	}
//
//	// 상품 총 갯수
//	public int productGetTotal(Criteria cri) {
//		log.info("productGetTotal().........");
//		return adminMapper.productGetTotal(cri);
//	}	
//	
//	// 상품 조회 페이지
//	@Override
//	public ProductVO productGetDetail(int product_id) {
//		
//		log.info("(service)productGetDetail......." + product_id);
//		
//		return adminMapper.productGetDetail(product_id);
//	}	
//	
//	// 상품 수정
//	@Override
//	public int productUpdate(ProductVO vo) {
//		
//		log.info("productUpdate........");
//		
//		return adminMapper.productUpdate(vo);
//		
//	}
//	
//	// 상품 정보 삭제
//	@Override
//	public int productDelete(int product_id) {
//
//		log.info("productDelete..........");
//		
//		return adminMapper.productDelete(product_id);
//	}		
//} //class
//
