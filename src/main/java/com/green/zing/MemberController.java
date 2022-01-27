package com.green.zing;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import service.MemberMailSendService;
import service.MemberService;
import vo.AuthVO;
import vo.MemberVO;

//=> Mapper 는 null 을 return 하지 않으므로 길이로 확인 

@Controller
public class MemberController {
	@Autowired
	MemberService service;
	@Autowired
	PasswordEncoder passwordEncoder;
	@Autowired
	MemberMailSendService mailsender;
	
	@RequestMapping(value = "/loginf")
	public ModelAndView loginf(ModelAndView mv, HttpServletRequest request) {
		if("login".equals(request.getParameter("R"))) {
			mv.addObject("R","login");
			mv.setViewName("home");
		}else mv.setViewName("member/loginForm");
		return mv;
	}
		
//	// ** JSON Login	
//	@RequestMapping(value = "/login")
//	public ModelAndView login(HttpServletRequest request, MemberVO vo,
//			HttpServletResponse response, ModelAndView mv) {
//		// ** jsonView 사용시 response 의 한글 처리
//		response.setContentType("text/html; charset=UTF-8");
//		
//		// ** 마지막 접속시간 update service.updateLastAccess(vo);
//		
//		// 1) request 처리
//		String id =vo.getMember_id();
//		String password = vo.getPassword();
//		// 2) service 처리
//		vo = service.selectOne(vo);
//		if ( vo != null ) { // ID 는 일치 -> Password 확인
//			if ( passwordEncoder.matches(password, vo.getPassword()) ) {
//				// Login 성공 -> login 정보 session에 보관, home (새로고침)
//				mv.addObject("loginSuccess", "T");
//				request.getSession().setAttribute("loginID", id);
//				request.getSession().setAttribute("loginName", vo.getName());
//			}else { //Password 오류 -> 재로그인 유도 (loginForm 으로)
//				mv.addObject("loginSuccess", "F");
//				mv.addObject("message", "~~ Password 오류,  다시 하세요 ~~");
//			}
//		}else { // ID 오류 -> 재로그인 유도 (loginForm 으로)
//			mv.addObject("loginSuccess", "F");
//			mv.addObject("message", "~~ ID 오류,  다시 하세요 ~~");
//		} //else
//		mv.setViewName("jsonView");
//		return mv; // => /WEB-INF/views/jsonView.jsp -> 안되도록 servlet-context.xml 설정
//	}//login
	 	
	
//	@RequestMapping(value = "/logout")
//	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response,
//			ModelAndView mv, MemberVO vo) throws ServletException, IOException {	
//		// ** jsonView 사용시 response 의 한글 처리
//		response.setContentType("text/html; charset=UTF-8");
//		
//		// ** 마지막 접속시간 update
//		service.updateLastAccess(vo);
//		
//		// ** session 인스턴스 정의 후 삭제하기
//		// => 매개변수: 없거나, true, false
//		// => false : session 이 없을때 null 을 return;
//		HttpSession session = request.getSession(false);
//		if (session!=null) session.invalidate();
//		mv.addObject("message", "~~ 로그아웃 되었습니다 ~~");
//		mv.setViewName("jsonView");
//		return mv;
//	} //logout	
	
	//SSLogoutf => post 방식으로 처리하기위해 ssLogoutForm 사용 Test	
	@RequestMapping(value = "/logoutf")
	public ModelAndView logoutf(ModelAndView mv, MemberVO vo) {
		// ** 마지막 접속시간 update
		service.updateLastAccess(vo);		
		mv.setViewName("member/logoutForm");
		return mv;
	} //logoutf

	// ** Member Check List ******************************
	@RequestMapping(value = "/mlist")
	public ModelAndView mchecklist(ModelAndView mv, MemberVO vo) {		
		// 1) Check_Box 처리
		// String[] check = request.getParameterValues("check");
		// => vo 에 배열 Type의 check 컬럼을 추가하면 편리
			
		// 2) Service 실행
		// => 선택하지 않은경우 : selectList() 
		// => 선택을 한 경우 : 조건별 검색 checkList(vo) -> 추가
		List<MemberVO> list = null;
			
		//if ( vo.getCheck() != null && vo.getCheck().length > 0 ) {...}
		// => 배열Type의 경우 선택하지 않으면 check=null 이므로 길이 비교 필요없음. 
		if ( vo.getCheck() != null ) list = service.checkList(vo) ;
		else list = service.selectList();
			
		// => Mapper 는 null 을 return 하지 않으므로 길이로 확인 
		if ( list != null && list.size()>0 ) mv.addObject("banana", list);
		else mv.addObject("message", "~~ 출력할 자료가 1건도 없습니다 ~~");
		
		//mv.setViewName("member/memberList");
		mv.setViewName("member/memberList");
		return mv;
	} //mchecklist
	
	// ** Check 오름차순 List
	@RequestMapping(value = "/masclist")
	public ModelAndView masclist(ModelAndView mv, MemberVO vo) {		
		// ** Check_Box
		// String[] check = request.getParameterValues("check");
		// => vo 에 배열 Type의 check 컬럼을 추가하면 편리
		
		// 2) Service 실행
		// => 선택하지 않은 경우 : selectList()
		// => 선택을 한 경우 : 조건별 검색 checkList() -> 추가
		List<MemberVO> list = null;
		
		if(vo.getCheck()!=null) list = service.ascList(vo);
		else list = service.selectList();
		
		if(list!=null && list.size()>0) mv.addObject("banana",list);
		else mv.addObject("message","~~ 출력할 자료가 1건도 없습니다 ~~");
		mv.setViewName("member/mCheckList");
		return mv;
	} //masclist
	
	@RequestMapping(value = "/mdetail")
	public ModelAndView mdetail(ModelAndView mv, MemberVO vo, RedirectAttributes rttr) {
		String uri = "member/memberDetail";
		String id = vo.getMember_id();
		List<AuthVO> list = service.authList(vo);
		if(id==null) id = "";
		vo=service.selectOne(vo);
		if (vo != null && list!=null && list.size()>0 ) {
			vo.setAuthList(list);
			mv.addObject("apple", vo);	
		}else {
			rttr.addFlashAttribute("message","~~ "+id+"님의 자료는 존재하지 않습니다 ~~");
			uri = "redirect:home";
		}
		mv.setViewName(uri);
		return mv;
	}
	
	@RequestMapping(value = "/mypage")
	public ModelAndView mypage(ModelAndView mv, MemberVO vo, RedirectAttributes rttr) {
		// ** 마지막 접속시간 update
		service.updateLastAccess(vo);
		
		String uri = "member/mypage";
		String id = vo.getMember_id();
		vo=service.selectOne(vo);
		if (vo != null) {
			mv.addObject("apple", vo);	
		}else {
			rttr.addFlashAttribute("message","~~ "+id+"님의 자료는 존재하지 않습니다 ~~");
			uri = "redirect:home";
		}
		mv.setViewName(uri);
		return mv;
	}

	@RequestMapping(value = "/joinf")
	public ModelAndView joinf(ModelAndView mv, HttpServletRequest request) {
		if("joinf".equals(request.getParameter("R"))) {
			mv.addObject("R","joinf");
			mv.setViewName("home");
		}else mv.setViewName("member/joinForm");
		return mv;
	}
	
	@RequestMapping(value = "/midcheck")
	public ModelAndView midcheck(ModelAndView mv, MemberVO vo) {
		// 입력한 newID 보관
		mv.addObject("newID", vo.getMember_id());
		if ( service.selectOne(vo) != null ) {
			mv.addObject("idUse", "F"); // 사용불가
		}else {
			mv.addObject("idUse", "T"); // 사용가능
		}
		mv.setViewName("member/idDupCheck"); 
		return mv;
	} //midcheck
	
	// ** Join
	// Spring AOP Transaction 적용됨
	@RequestMapping(value = "/join")
	public ModelAndView join(HttpServletRequest request, ModelAndView mv, MemberVO vo,
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
	//		realPath = "C:/MTest/MyWork/Project/src/main/webapp/resources/uploadImage/";
		else realPath += "resources\\uploadImage\\";
		
		// ** 폴더 만들기 (File 클래스활용)
		// => 위의 저장경로에 폴더가 없는 경우 (uploadImage가 없는경우)  만들어 준다
		File f1 = new File(realPath);
		if ( !f1.exists() ) f1.mkdir();
		// realPath 디렉터리가 존재하는지 검사 (uploadImage 폴더 존재 확인)
		// => 존재하지 않으면 디렉토리 생성
		
		// ** 기본 이미지 지정하기 
		String file1, file2="resources/uploadImage/basicman.png";
		
		// ** MultipartFile
		// => 업로드한 파일에 대한 모든 정보를 가지고 있으며 이의 처리를 위한 메서드를 제공한다.
		//    -> String getOriginalFilename(), 
		//    -> void transferTo(File destFile),
		//    -> boolean isEmpty()
		
		MultipartFile profilef = vo.getProfilef();
		if ( profilef !=null && !profilef.isEmpty() ) {
			// Image 를 선택했음 -> Image 처리 (realPath+화일명)
			// 1) 물리적 위치에 Image 저장 
			file1=realPath + profilef.getOriginalFilename(); //  전송된File명 추출 & 연결
			profilef.transferTo(new File(file1)); // real 위치에 전송된 File 붙여넣기
			// 2) Table 저장위한 경로 
			file2 = "resources/uploadImage/"+ profilef.getOriginalFilename();
		}
		vo.setProfile(file2);
		
		// ** Password 암호화
		// => BCryptPasswordEncoder 적용
		//    encode(rawData) -> digest 생성 & vo 에 set
		vo.setPassword(passwordEncoder.encode(vo.getPassword()));
		
		// 2. Service 처리
		String uri = "redirect:home";  
		
		if(vo.getCheck()!=null) vo.setInterest(String.join("#",vo.getCheck()));
		
	if ( service.insert(vo) > 0 ) { // insert 성공
		// 인증 email 발송
		String key = mailsender.mailSendWithMemberKey(vo.getEmail(),vo.getMember_id(),request);
		if(key==null) key="";	
		mv.addObject("key",key);
		// member_id값 저장(인증실패시 delete를 하기위함)
		mv.addObject("member_id",vo.getMember_id());
		uri = "member/emailAuth";
		//rttr.addFlashAttribute("message", "~~ 회원가입 완료!!, 이메일 인증 후 이용해 해주세요 ~~");
		//rttr.addFlashAttribute("R","login"); // 성공시 홈으로 이동 후 로그인 form 클릭
	}else { 
		// insert 실패
		rttr.addFlashAttribute("message", "~~ 회원가입 실패!!, 다시 하세요 ~~");
		rttr.addFlashAttribute("R","loginf");
	}
		mv.setViewName(uri);
		return mv;
	} //join
	
	@RequestMapping(value = "/emailauth")
	public ModelAndView emailauth(ModelAndView mv, MemberVO vo, HttpServletRequest request) {
		String url;
		String key= request.getParameter("key");
		
		System.out.println("key => "+key);
			
		vo = service.selectOne(vo);
		if( (vo!=null) && key.length()!=0 && key.equals(request.getParameter("auth_no")) ) {
			vo.setStatus("1");
			vo.setEnabled(true);
			service.changeStatus(vo);
			url = "redirect:authjoin?member_id="+vo.getMember_id();
		}else {
			if(vo!=null) service.delete(vo);
			mv.addObject("message","인증에 실패했습니다.");
			url = "home";
		}		
		mv.setViewName(url); 
		return mv;
	} //emailauth
	
	@RequestMapping(value = "/mupdatef")
	public ModelAndView mupdatef(ModelAndView mv, HttpServletRequest request, MemberVO vo) {
		// ** 마지막 접속시간 update
		service.updateLastAccess(vo);
		vo = service.selectOne(vo);
		mv.addObject("apple",vo);
		mv.setViewName("member/updateForm");
		return mv;
	}
	
	// ** Member Update(비밀번호 수정은 별개) **
	@RequestMapping(value = "/mupdate")
	public ModelAndView mupdate(HttpServletRequest request, 
			ModelAndView mv, MemberVO vo, RedirectAttributes rttr) throws IOException {
		String uri = null; 
		// ** Service 
		// => 성공후 
		//		-> 수정된 정보확인 : memberList.jsp (출력가능하도록 요청)
		//		-> name 수정한 경우도 있을수있으므로 session 에 보관중인 loginName도 변경
		// => 실패후 -> 다시 수정하기 : 수정가능한 폼 출력
		
		// ** ImageUpload 추가
		// => Image 수정여부 확인
		// 	  -> 수정하지않은경우 : vo에 전달된 uploadfile 값을 사용 
		// 	  -> 수정시에만 처리
		MultipartFile profilef = vo.getProfilef();
		String file1, file2;
		if ( profilef != null && !profilef.isEmpty() ) {
			// 1) 저장폴더지정
			String realPath = request.getRealPath("/");
			if (realPath.contains(".eclipse."))
				realPath = "D:/MTest/MyWork/Project/src/main/webapp/resources/uploadImage/";
				//realPath = "C:/MTest/MyWork/Project/src/main/webapp/resources/uploadImage/";
			else realPath += "resources\\uploadImage\\"; // 배포환경
			File f1 = new File(realPath);
			if ( !f1.exists() ) f1.mkdir();
			// 2) 전송된 file 처리
			// 2.1) Image 붙여넣기
			file1 = realPath + profilef.getOriginalFilename();
			profilef.transferTo(new File(file1));
			// 2.2) Table 저장위한 값 set
			file2 = "resources/uploadImage/" + profilef.getOriginalFilename();
			vo.setProfile(file2);
		}
		
		// ** Password 암호화
		// => BCryptPasswordEncoder 적용
		//    encode(rawData) -> digest 생성 & vo 에 set
		//vo.setPassword(passwordEncoder.encode(vo.getPassword()));		
		
		if ( service.update(vo) > 0 ) {
			 // update 성공
			 rttr.addFlashAttribute("message", "~~ 회원정보 수정 완료 !!!  ~~") ; 
			 // => redirect시 message 전달가능
			 
			 //request.getSession().setAttribute("loginName", vo.getName());
			 uri = "redirect:mdetail";  // redirect 로 처리함 (재요청처리)
		 }else { 
			 // update 실패 : 수정가능한 폼 출력할수있도록 요청 
			 rttr.addFlashAttribute("message", "~~ 회원정보 수정 실패!!, 다시 하세요 ~~");
			 uri="redirect:mupdate?member_id="+vo.getMember_id();
		 }
		
		mv.setViewName(uri); 
		return mv;
	} //mupdate
}
