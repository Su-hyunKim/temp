package com.green.zing;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import criteria.MultiCheckSearchCriteria;
import criteria.PageMakerE;
import service.MemberMailSendService;
import service.SellerService;
import vo.ProductVO;
import vo.SellerVO;

//=> Mapper 는 null 을 return 하지 않으므로 길이로 확인 

@Controller
public class SellerController {
	@Autowired
	SellerService service;
	@Autowired
	MemberMailSendService mailsender;
	
	@RequestMapping(value = "/slist")
	public ModelAndView slist(ModelAndView mv, MultiCheckSearchCriteria cri, PageMakerE pageMaker) {
		cri.setRowsPerPage(1);
		cri.setSnoEno();
		List<SellerVO> list = service.checkList(cri);
		// => Mapper 는 null 을 return 하지 않으므로 길이로 확인 
		if ( list != null && list.size()>0 ) mv.addObject("banana", list);
		else mv.addObject("message", "~~ 출력할 자료가 1건도 없습니다 ~~");	
		pageMaker.setCri(cri);
		pageMaker.setTotalRowCount(service.searchRowsCount(cri));
		mv.addObject("pageMaker", pageMaker);
		mv.setViewName("seller/sellerList");
		return mv;
	} //slist
	
	@RequestMapping(value = "/sdetail")
	public ModelAndView mdetail(ModelAndView mv, SellerVO vo, RedirectAttributes rttr) {
		String uri = "seller/sellerDetail";
		String id = vo.getMember_id();
		List<ProductVO> list = service.productList(vo);
		if(id==null) id = "";
		vo=service.selectOne(vo);
		if (vo!=null) {
			if ( list!=null && list.size()>0 ) vo.setProductList(list);
			mv.addObject("apple", vo);	
		}else {
			rttr.addFlashAttribute("message","~~ "+id+"님의 자료는 존재하지 않습니다 ~~");
			uri = "redirect:home";
		}
		mv.setViewName(uri);
		return mv;
	}

	@RequestMapping(value = "/sregf")
	public ModelAndView joinf(ModelAndView mv, HttpServletRequest request) {
		if("sregf".equals(request.getParameter("R"))) {
			mv.addObject("R","sregf");
			mv.setViewName("home");
		}else mv.setViewName("seller/registerForm");
		return mv;
	}
	
	// ** 판매자전환
	// Spring AOP Transaction 적용됨
	@RequestMapping(value = "/sreg")
	public ModelAndView sreg(HttpServletRequest request, ModelAndView mv, SellerVO vo,
			RedirectAttributes rttr) throws IOException {	
		// ** 거래중지 회원 확인
		if("6".equals(vo.getStatus())){
			service.delete(vo);
			mv.addObject("message","거래중지 회원입니다.");
			mv.setViewName("home");
			return mv;
		}
		
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
	//		 realPath = "D:/MTest/MyWork/Project/src/main/webapp/resources/uploadImage/";
			realPath = "C:/MTest/MyWork/Project/src/main/webapp/resources/uploadImage/";
		else realPath += "resources\\uploadImage\\";
		
		// ** 폴더 만들기 (File 클래스활용)
		// => 위의 저장경로에 폴더가 없는 경우 (uploadImage가 없는경우)  만들어 준다
		File f1 = new File(realPath);
		if ( !f1.exists() ) f1.mkdir();
		// realPath 디렉터리가 존재하는지 검사 (uploadImage 폴더 존재 확인)
		// => 존재하지 않으면 디렉토리 생성
		
		// ** 기본 이미지 지정하기 
		String file1, file2="resources/uploadImage/logo.png";
		
		// ** MultipartFile
		// => 업로드한 파일에 대한 모든 정보를 가지고 있으며 이의 처리를 위한 메서드를 제공한다.
		//    -> String getOriginalFilename(), 
		//    -> void transferTo(File destFile),
		//    -> boolean isEmpty()
		
		MultipartFile logof = vo.getLogof();
		if ( logof !=null && !logof.isEmpty() ) {
			// Image 를 선택했음 -> Image 처리 (realPath+화일명)
			// 1) 물리적 위치에 Image 저장 
			file1=realPath + vo.getMember_id() + "_" + vo.getEmployer_id()
				+ logof.getOriginalFilename().substring(logof.getOriginalFilename().lastIndexOf("."));
			logof.transferTo(new File(file1)); // real 위치에 전송된 File 붙여넣기
			// 2) Table 저장위한 경로 
			file2 = "resources/uploadImage/" + vo.getMember_id() + "_" + vo.getEmployer_id()
				+ logof.getOriginalFilename().substring(logof.getOriginalFilename().lastIndexOf("."));
		}
		vo.setLogo(file2);
		
		// 2. Service 처리
		String uri = "redirect:home";  
			
		if ( service.insert(vo) > 0 ) { // insert 성공
			// 인증 email 발송
			String key = mailsender.mailSendWithMemberKey(vo.getBusiness_email(),vo.getMember_id(),request);
			if(key==null) key="";	
			mv.addObject("key",key);
			mv.addObject("R","sreg");
			// member_id값 저장(인증실패시 seller등록 취소를 하기위함)
			mv.addObject("member_id",vo.getMember_id());
			uri = "member/emailAuth";
			//rttr.addFlashAttribute("message", "~~ 회원가입 완료!!, 이메일 인증 후 이용해 해주세요 ~~");
			//rttr.addFlashAttribute("R","login"); // 성공시 홈으로 이동 후 로그인 form 클릭
		}else { 
			// insert 실패
			rttr.addFlashAttribute("message", "~~ 판매자전환 실패!!, 다시 하세요 ~~");
			rttr.addFlashAttribute("R","sregf");
		}
			mv.setViewName(uri);
			return mv;
	} //sreg
	
	@RequestMapping(value = "/supdatef")
	public ModelAndView mupdatef(ModelAndView mv, HttpServletRequest request, SellerVO vo) {
		// ** 마지막 접속시간 update
		service.updateLastAccess(vo);
		
		vo = service.selectOne(vo);
		mv.addObject("apple",vo);
		mv.setViewName("seller/updateForm");
		return mv;
	}
	
	// ** Seller Update
	@RequestMapping(value = "/supdate")
	public ModelAndView mupdate(HttpServletRequest request, 
			ModelAndView mv, SellerVO vo, RedirectAttributes rttr) throws IOException {
		String uri = null; 

		MultipartFile logof = vo.getLogof();
		String file1, file2;
		if ( logof != null && !logof.isEmpty() ) {
			// 1) 저장폴더지정
			String realPath = request.getRealPath("/");
			if (realPath.contains(".eclipse."))
			//	realPath = "D:/MTest/MyWork/Project/src/main/webapp/resources/uploadImage/";
				realPath = "C:/MTest/MyWork/Project/src/main/webapp/resources/uploadImage/";
			else realPath += "resources\\uploadImage\\"; // 배포환경
			File f1 = new File(realPath);
			if ( !f1.exists() ) f1.mkdir();
			// 2) 전송된 file 처리
			// 2.1) Image 붙여넣기
			file1 = realPath + vo.getMember_id() + "_" + vo.getEmployer_id()
				+ logof.getOriginalFilename().substring(logof.getOriginalFilename().lastIndexOf("."));
			logof.transferTo(new File(file1));
			// 2.2) Table 저장위한 값 set
			file2 = "resources/uploadImage/" + vo.getMember_id() + "_" + vo.getEmployer_id()
				+ logof.getOriginalFilename().substring(logof.getOriginalFilename().lastIndexOf("."));
			vo.setLogo(file2);
		}	
		
		if ( service.update(vo) > 0 ) {
			 // update 성공
			 rttr.addFlashAttribute("message", "~~ 판매자정보 수정 완료 !!!  ~~") ; 
			 uri = "redirect:sdetail?member_id="+vo.getMember_id();  // redirect 로 처리함 (재요청처리)
		 }else { 
			 // update 실패 : 수정가능한 폼 출력할수있도록 요청 
			 rttr.addFlashAttribute("message", "~~ 판매자정보 수정 실패!!, 다시 해주세요 ~~");
			 uri="redirect:supdatef?member_id="+vo.getMember_id();
		 }		
		mv.setViewName(uri); 
		return mv;
	} //supdate
	
	@RequestMapping(value = "/swithdraw")
	public ModelAndView swithdraw(ModelAndView mv, SellerVO vo) {
		// ** 마지막 접속시간 update
		service.updateLastAccess(vo);
		service.delete(vo);
		mv.setViewName("redirect:srwithdraw?member_id="+vo.getMember_id());
		return mv;
	}
}
