//package com.green.zing;
//
//
//import java.util.List;
//import java.util.logging.Logger;
//
//import org.apache.log4j.spi.LoggerFactory;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//import org.springframework.web.multipart.MultipartFile;
//import org.springframework.web.servlet.mvc.support.RedirectAttributes;
//
////import com.fasterxml.jackson.core.JsonProcessingException;
////import com.fasterxml.jackson.databind.ObjectMapper;
//
//import criteria.Criteria;
//import service.AdminService;
//import vo.PageVO;
//import vo.ProductVO;
//
//@Controller
////@RequestMapping("/admin")
//public class AdminController {
//
//	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
//	
//	@Autowired
//	private AdminService adminService;
//		
//	@PostMapping("/pregist")
//	public String pregistPost(ProductVO product, RedirectAttributes rttr) {
//		
//		logger.info("pregistPost..." + product);
//		
//		adminService.pregist(product);
//		
//		rttr.addFlashAttribute("regist_result",product.getProduct_name());
//		
//		return "redirect:/admin/pregistManage";
//	}
//	
//	/* 작가 검색 팝업창 */
//	@GetMapping("/sellerPop")
//	public void sellerPopGET(Criteria cri, Model model) throws Exception{
//		
//		logger.info("sellerPopGET.......");
//		
//		cri.setRowsPerPage(5);
//		
//		/* 게시물 출력 데이터 */
//		List list = sellerService.sellerGetList(cri);
//		
//		if(!list.isEmpty()) {
//			model.addAttribute("list",list);	// 작가 존재 경우
//		} else {
//			model.addAttribute("listCheck", "empty");	// 작가 존재하지 않을 경우
//		}
//		
//		
//		/* 페이지 이동 인터페이스 데이터 */
//		model.addAttribute("pageMaker", new PageVO(cri, sellerService.sellerGetTotal(cri)));	
//	
//	}
//	
//	/* 상품 관리(상품목록) 페이지 접속 */
//	@RequestMapping(value = "productManage", method = RequestMethod.GET)
//	public void productManageGET(Criteria cri, Model model) throws Exception{
//	
//		logger.info("상품 관리(상품목록) 페이지 접속");
//		
//		/* 상품 리스트 데이터 */
//		List list = adminService.productGetList(cri);
//		
//		if(!list.isEmpty()) {
//			model.addAttribute("list", list);
//		} else {
//			model.addAttribute("listCheck", "empty");
//			return;
//		}
//		
//		/* 페이지 인터페이스 데이터 */
//		model.addAttribute("PageMaker", new PageVO(cri, adminService.productGetTotal(cri)));
//	}
//	
//	// 상품등록 페이지 접속
//	@RequestMapping(value="pregistManage", method = RequestMethod.GET)
//	public void pregistManageGET(Model model) throws Exception{
//		
//		logger.info("상품등록 페이지 접속");
//		
//		ObjectMapper objm = new ObjectMapper();
//		
//		List list = adminService.procateList();
//		
//		String procateList = objm.writeValueAsString(list);
//		
//		model.addAttribute("cateList", procateList);
//		
//		logger.info("변경 전.........." + list);
//		logger.info("변경 후.........." + procateList);
//		
//	}
//	
//	/* 상품 조회 페이지 */
//	@GetMapping({"/productDetail","/productUpdate"})
//	public void productGetInfoGET(int product_id, Criteria cri, Model model) throws JsonProcessingException {
//		
//		logger.info("productGetInfo()........." + product_id);
//		
//		ObjectMapper mapper = new ObjectMapper();
//		
//		/* 카테고리 리스트 데이터 */
//		model.addAttribute("procateList", mapper.writeValueAsString(adminService.procateList()));
//		/* 목록 페이지 조건 정보 */
//		model.addAttribute("cri", cri);
//		
//		/* 조회 페이지 정보 */
//		model.addAttribute("productInfo", adminService.productGetDetail(product_id));
//		
//	}
//	
//	/* 상품 정보 수정 */
//	@PostMapping("/productUpdate")
//	public String productUpdatePOST(ProductVO vo, RedirectAttributes rttr) {
//		
//		logger.info("productUpdatePOST.........." + vo);
//		
//		int result = adminService.productUpdate(vo);
//		
//		rttr.addFlashAttribute("update_result", result);
//		
//		return "redirect:/admin/productManage";		
//		
//	}
//	
//	/* 상품 정보 삭제 */
//	@PostMapping("/productDelete")
//	public String productDeletePOST(int product_id, RedirectAttributes rttr) {
//		
//		logger.info("productDeletePOST..........");
//		
//		int result = adminService.productDelete(product_id);
//		
//		rttr.addFlashAttribute("delete_result", result);
//		
//		return "redirect:/admin/productManage";
//		
//	}
//	
//	/* 첨부 파일 업로드 */
//	@PostMapping("/uploadAjaxAction")
//	public void uploadAjaxActionPOST(MultipartFile[] uploadFile) {
//		
//		logger.info("uploadAjaxActionPOST..........");
//		String uploadFolder = "C:\\upload";
//		
//		// 향상된 for
//		for(MultipartFile multipartFile : uploadFile) {
//			logger.info("-----------------------------------------------");
//			logger.info("파일 이름 : " + multipartFile.getOriginalFilename());
//			logger.info("파일 타입 : " + multipartFile.getContentType());
//			logger.info("파일 크기 : " + multipartFile.getSize());			
//		}
//		
//		//기본 for
//		for(int i = 0; i < uploadFile.length; i++) {
//			logger.info("-----------------------------------------------");
//			logger.info("파일 이름 : " + uploadFile[i].getOriginalFilename());
//			logger.info("파일 타입 : " + uploadFile[i].getContentType());
//			logger.info("파일 크기 : " + uploadFile[i].getSize());			
//		}
//	}
// 
//		
//	
//} //class
