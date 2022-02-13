package com.green.zing;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import criteria.PageMaker;
import criteria.SearchCriteria;
import service.ProductService;
import vo.MemberVO;
import vo.PageVO;
import vo.ProductVO;

@Controller
public class ProductController {
	@Autowired
	ProductService service;
	
//		// ** Product Check List ******************************
//		@RequestMapping(value = "/pchecklist")
//		public ModelAndView pchecklist(ModelAndView mv, ProductVO vo) {
//			// ** @Log4j Test
//			//=> 로깅레벨 단계 준수함 ( log4j.xml 의 아래 logger Tag 의 level 확인)
//			//   TRACE > DEBUG > INFO > WARN > ERROR > FATAL(치명적인)
//			//	<logger name="com.ncs.green">
//			//		<level value="info" />
//			//	</logger>
//			log.info("** pchecklist => "+vo);
//			
//			// 1) Check_Box 처리
//			// 2) Service 실행
//			List<ProductVO> list = null;
//			if ( vo.getCheck() != null ) list = service.checkList(vo) ;
//			else list = service.selectList();
//			
//			// => Mapper 는 null 을 return 하지 않으므로 길이로 확인 
//			if ( list != null && list.size()>0 ) mv.addObject("banana", list);
//			else mv.addObject("message", "~~ 출력할 자료가 1건도 없습니다 ~~");
//			
//			mv.setViewName("product/pCheckList");
//			return mv;
//		} //pchecklist
	
		// ** Product PageList 2. SearchCriteria PageList
		@RequestMapping(value = "/pcplist")
		// ** ver02
		public ModelAndView pcplist(ModelAndView mv, SearchCriteria cri, PageMaker pageMaker) {	
			// 1) Criteria 처리 
			// => setCurrPage, setRowsPerPage 는 Parameter 로 전달되어,
			//    setCurrPage(..) , setRowsPerPage(..) 는 자동처리됨(스프링에 의해)
			//    -> cri.setCurrPage(Integer.parseInt(request.getParameter("currPage")))
			// => 그러므로 currPage 이용해서 sno, eno 계산만 하면됨
			cri.setSnoEno();
			
			// 2) 서비스처리
			// => List 처리, 
			mv.addObject("banana", service.searchList(cri));
			
			// 3) PageMaker 처리
			pageMaker.setCri(cri);
			pageMaker.setTotalRowCount(service.searchRowsCount(cri));
			
			mv.addObject("pageMaker", pageMaker);
			mv.setViewName("product/pCriList");
			return mv;
		} //pcplist
		
		// ** Board PageList 1.
		@RequestMapping(value = "/ppagelist")
		public ModelAndView ppagelist(ModelAndView mv, PageVO<ProductVO> pvo) {
			// 1) Paging 준비
			// => 한 Page당 출력할 Row 갯수 : PageVO 에 지정
			// => 요청 Page 확인 : currPage ( Parameter )
			// => sno , eno 계산후 List 읽어오기
			// => totalRowCount : 전체Page수 계산
			int currPage = 1;
			if (pvo.getCurrPage() > 1) currPage = pvo.getCurrPage();
			else pvo.setCurrPage(currPage) ;
			
			int sno = (currPage-1)*pvo.getRowsPerPage() + 1 ;
			int eno = sno + pvo.getRowsPerPage() - 1 ;
			pvo.setSno(sno);
			pvo.setEno(eno);
			
			// 2) Service 처리
			// => List 읽어오기, 전체Row수(totalRowCount) 
			// => 전체 PageNo 계산하기
			pvo = service.pageList(pvo) ;
			int totalPageNo = pvo.getTotalRowCount()/pvo.getRowsPerPage();
			// 20/3 -> 6 나머지 2 : 6 page 와 2개 -> 7page
			if ( pvo.getTotalRowCount()%pvo.getRowsPerPage() !=0 )
				totalPageNo +=1;
			
			// 3) View 처리
			// ** view02 
			// => PageBlock 기능 추가 : sPageNo, ePageNo
			// => 이를 위해 currPage, pageNoCount
			// => 유형 1) currPage 가 항상 중앙에 위치하도록 할때 (ex. 쿠팡)
			// int sPageNo = currPage - (pageNoCount/2) ;      
			// int ePageNo = currPage + (pageNoCount/2) ;
			
			// => 유형 2) 11번가의 상품List, Naver 카페글 유형
			// 예를들어 currPage=3 이고 pageNoCount 가 3 이면 1,2,3 page까지 출력 되어야 하므로
			// 아래 처럼 currPage-1 을 pageNoCount 으로 나눈후 다시 곱하고 +1
			// currPage=11 -> 10,11,12, => (11-1)/3 * 3 +1 = 10
			// 연습 ( pageNoCount=5 )
			// -> currPage=11 인경우 : 11,12,13,14,15 -> ((11-1)/5)*5 +1 : 11
			// -> currPage=7 인경우 : 6,7,8,9,10 -> ((7-1)/5)*5 +1 : 6
			int sPageNo = ((currPage-1)/pvo.getPageNoCount())*pvo.getPageNoCount() + 1 ;
			int ePageNo = sPageNo + pvo.getPageNoCount() - 1 ;
			// 계산으로 얻어진 ePageNo가 실제 LastPage 인 totalPageNo 보다 크면 수정 필요.
			if ( ePageNo > totalPageNo ) ePageNo = totalPageNo ;
			mv.addObject("sPageNo", sPageNo);
			mv.addObject("ePageNo", ePageNo);
			mv.addObject("pageNoCount", pvo.getPageNoCount());
			
			// ** view01
			mv.addObject("currPage",currPage);
			mv.addObject("totalPageNo",totalPageNo);
			mv.addObject("banana", pvo.getList());
			
			mv.setViewName("product/pagePList");
			return mv;
		}//ppagelist
		
	// ** Product CRUD *****
		@RequestMapping(value = "/plist")
		public ModelAndView plist(ModelAndView mv) {
			
			List<ProductVO> list = new ArrayList<ProductVO>();
	    	list = service.selectList();
	    	
	    	// => Mapper 는 null 을 return 하지 않으므로 길이로 확인 
	    	if ( list!=null && list.size()>0 ) mv.addObject("banana", list);
	    	else mv.addObject("message", "~~ 출력 자료가 없습니다 ~~");
			
	    	mv.setViewName("product/productList");
			return mv;
		} //plist
		
		@RequestMapping(value = "/pdetail")
		public ModelAndView pdetail(HttpServletRequest request, ModelAndView mv, ProductVO vo) {
			
			String uri = "product/productDetail";
			
			// ** Service 처리
	    	// => 조회수 증가 추가하기 ( 조회수 증가의 조건 )
	    	//    글보는이(loginID)와 글쓴이가 다를때 && jcode!="U" -> countUp 메서드
			
			vo = service.selectOne(vo);
	    	if ( vo!=null ) {
	    		// 조회수 증가 추가
	    		String loginID = (String)request.getSession().getAttribute("loginID") ;
	    		if ( !vo.getMember_id().equals(loginID) &&    
	    			 !"U".equals(request.getParameter("jcode")) ) {
	    			// 조회수 증가
	    			if ( service.countUp(vo) > 0 )
	    					vo.setCnt(vo.getCnt()+1) ;
	    		} //if
	    		
	    		mv.addObject("apple", vo);
	    		// 글 수정인지 확인
	    		if ( "U".equals(request.getParameter("jcode")) ) 
	    			uri = "product/pupdateForm";
	    	}else {
	    		mv.addObject("message", "~~ 글번호에 해당하는 자료가 없습니다 ~~");
	    	}
			
			mv.setViewName(uri);
			return mv;
		} //pdetail
		
		@RequestMapping(value = "/pidcheck")
		public ModelAndView pidcheck(ModelAndView mv, ProductVO vo) {
			// 입력한 newID 보관
			mv.addObject("newPID", vo.getProduct_id());
			if ( service.selectOne(vo) != null ) {
				mv.addObject("idUse", "F"); // 사용불가
			}else {
				mv.addObject("idUse", "T"); // 사용가능
			}
			mv.setViewName("product/pidDupCheck"); 
			return mv;
		} //pidcheck
		
		// ** Join
		// Spring AOP Transaction 적용됨
		@RequestMapping(value = "/pregist")
		public ModelAndView pregist(HttpServletRequest request, ModelAndView mv, ProductVO vo,
				RedirectAttributes rttr) 
						 	throws IOException {		
			// ** Uploadfile (Image) 처리
			// => MultipartFile 타입의 uploadfilef 의 정보에서 
			//    upload된 image 와 화일명을 get 처리,
			// => upload된 image 를 서버의 정해진 폴더 (물리적위치)에 저장 하고,  -> file1
			// => 이 위치에 대한 정보를 table에 저장 (vo의 UploadFile 에 set) -> file2
			// ** image 화일명 중복시 : 나중 이미지로 update 됨.  
			
			// ** Image 물리적위치 에 저장
			// 1) 현재 웹어플리케이션의 실행 위치 확인 : 
			// => eslipse 개발환경 (배포전)
			//    D:\MTest\MyWork\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Spring03\
			// => 톰캣서버에 배포 후 : 서버내에서의 위치가 됨
			//    D:\MTest\IDESet\apache-tomcat-9.0.41\webapps\Spring02\
			String realPath = request.getRealPath("/"); // deprecated Method
			System.out.println("** realPath => "+realPath);
			
			// 2) 위 의 값을 이용해서 실제저장위치 확인 
			// => 개발중인지, 배포했는지 에 따라 결정
			if (realPath.contains(".eclipse."))
				 realPath = "D:/MTest/MyWork/Project/src/main/webapp/resources/uploadImage/";
			else realPath += "resources\\uploadImage\\";
			
			// ** 폴더 만들기 (File 클래스활용)
			// => 위의 저장경로에 폴더가 없는 경우 (uploadImage가 없는경우)  만들어 준다
			File f1 = new File(realPath);
			if ( !f1.exists() ) f1.mkdir();
			// realPath 디렉터리가 존재하는지 검사 (uploadImage 폴더 존재 확인)
			// => 존재하지 않으면 디렉토리 생성
			
			// ** 기본 이미지 지정하기 
			String product_url, product_url2="resources/uploadImage/box.png";
			
			// ** MultipartFile
			// => 업로드한 파일에 대한 모든 정보를 가지고 있으며 이의 처리를 위한 메서드를 제공한다.
			//    -> String getOriginalFilename(), 
			//    -> void transferTo(File destFile),
			//    -> boolean isEmpty()
			
			MultipartFile product_imgfile = vo.getProduct_imgfile();
			if ( product_imgfile !=null && !product_imgfile.isEmpty() ) {
				// Image 를 선택했음 -> Image 처리 (realPath+화일명)
				// 1) 물리적 위치에 Image 저장 
				product_url=realPath + product_imgfile.getOriginalFilename(); //  전송된File명 추출 & 연결
				product_imgfile.transferTo(new File(product_url)); // real 위치에 전송된 File 붙여넣기
				// 2) Table 저장위한 경로 
				product_url2 = "resources/uploadImage/"+ product_imgfile.getOriginalFilename();
			}
			vo.setProfile(product_url2);
			
			
			
			// 2. Service 처리
			String uri = "redirect:home";
			String uri1 = "redirect:plist";
			
			int cnt = service.insert(vo);
			
		if ( cnt > 0 ) { // insert 성공
			rttr.addFlashAttribute("message", "~~ 상품등록 완료!!~~");
			mv.setViewName(uri1);
			return mv;
		}else { 
			// insert 실패
			rttr.addFlashAttribute("message", "~~ 상품등록 실패!!, 다시 하세요 ~~");
		}
			mv.setViewName(uri);
			return mv;
		} //regist
		
		@RequestMapping(value = "/pregistf")
		public ModelAndView joinf(ModelAndView mv, HttpServletRequest request) {
			mv.setViewName("product/productRegistForm");
			return mv;
		}
		
		
	
		
		@RequestMapping(value = "/pupdate")
		public ModelAndView pupdate(ModelAndView mv, ProductVO vo, RedirectAttributes rttr) {
			
			String uri = "redirect:plist";
			if ( service.update(vo) > 0 ) { 
	    		// 글수정 성공 -> plist : redirect
	    		rttr.addFlashAttribute("message", "~~ 상품 수정 성공 !!! ~~");
	    	}else {
	    		rttr.addFlashAttribute("message", "~~ 상품 수정 실패 !!! 다시 하세요 ~~");
	    		uri = "redirect:pdetail?jcode=U&product_id="+vo.getProduct_id();
	    	}
			mv.setViewName(uri);
			return mv;
		} //pupdate
		
		@RequestMapping(value = "/pdelete")
		public ModelAndView pdelete(ModelAndView mv, ProductVO vo, RedirectAttributes rttr) {
			
			String uri = "redirect:plist";
			if ( service.delete(vo) > 0 ) { 
	    		// 글삭제 성공 -> plist  : redirect
				rttr.addFlashAttribute("message", "~~ 상품 삭제 성공 !!! ~~");
	    	}else {
	    		rttr.addFlashAttribute("message", "~~ 상품 삭제 실패 !!! ~~");
	    		uri = "redirect:pdetail?product_id="+vo.getProduct_id();
	    	}
			mv.setViewName(uri);
			return mv;
		} //pdelete	

	
	/*
	 * @RequestMapping(value = "/pchecklist") public ModelAndView
	 * pchecklist(ModelAndView mv, ProductVO vo) { // 1) Check_Box 처리 // String[]
	 * check = request.getParameterValues("check"); // => vo 에 배열 Type의 check 컬럼을
	 * 추가하면 편리
	 * 
	 * // 2) Service 실행 // => 선택하지 않은경우 : selectList() // => 선택을 한 경우 : 조건별 검색
	 * checkList(vo) -> 추가 List<ProductVO> list = null;
	 * 
	 * //if ( vo.getCheck() != null && vo.getCheck().length > 0 ) {...} // =>
	 * 배열Type의 경우 선택하지 않으면 check=null 이므로 길이 비교 필요없음. if ( vo.getCheck() != null )
	 * list = service.checkList(vo) ; else list = service.selectList();
	 * 
	 * // => Mapper 는 null 을 return 하지 않으므로 길이로 확인 if ( list != null &&
	 * list.size()>0 ) mv.addObject("banana", list); else mv.addObject("message",
	 * "~~ 출력할 자료가 1건도 없습니다 ~~");
	 * 
	 * mv.setViewName("product/productList"); return mv; 
	 * }//pchecklist
	 */} //class
