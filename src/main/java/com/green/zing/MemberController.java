package com.green.zing;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import service.MemberService;
import vo.MemberVO;

@Controller
public class MemberController {
	@Autowired
	MemberService service;
	
	@RequestMapping(value = "/loginf")
	public ModelAndView loginf(ModelAndView mv) {
		mv.setViewName("member/loginForm");
		return mv;
	}
	
	// ** JSON Login
	@RequestMapping(value = "/login")
	public ModelAndView login(HttpServletRequest request, MemberVO vo, HttpServletResponse response, ModelAndView mv) {	      
		// ** jsonView 사용시 response 의 한글 처리
		response.setContentType("text/html; charset=UTF-8");
		
		// ** 마지막 접속시간 update
		service.updateLastAccess(vo);
		
		// 1) request 처리
		String id =vo.getMember_id();
		String password = vo.getPassword();      
		// 2) service 처리
		vo = service.selectOne(vo);
		if ( vo != null ) { 
		// ID 는 일치 -> Password 확인
			if ( vo.getPassword().equals(password) ) {
				// Login 성공 -> login 정보 session에 보관, home (새로고침)
				mv.addObject("loginSuccess", "T");
				request.getSession().setAttribute("loginID", id);
				request.getSession().setAttribute("loginName", vo.getName());
			}else {
				// Password 오류 -> 재로그인 유도 (loginForm 으로)
				mv.addObject("loginSuccess", "F");
				mv.addObject("message", "~~ Password 오류,  다시 하세요 ~~");
			}
		}else {   // ID 오류 -> 재로그인 유도 (loginForm 으로)
		         mv.addObject("loginSuccess", "F");
		         mv.addObject("message", "~~ ID 오류,  다시 하세요 ~~");
		} //else	      
		mv.setViewName("jsonView");
		return mv;
		// => /WEB-INF/views/jsonView.jsp -> 안 되도록 servlet-context.xml 설정
	} //jslogin
	
	@RequestMapping(value = "/logout")
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mv, MemberVO vo)
			throws ServletException, IOException {
		
		// ** jsonView 사용시 response 의 한글 처리
		response.setContentType("text/html; charset=UTF-8");
		
		// ** 마지막 접속시간 update
		service.updateLastAccess(vo);
		
		// ** session 인스턴스 정의 후 삭제하기
    	// => 매개변수: 없거나, true, false
    	// => false : session 이 없을때 null 을 return;
		HttpSession session = request.getSession(false);
    	if (session!=null) session.invalidate();
    	mv.addObject("message", "~~ 로그아웃 되었습니다 ~~");
    	mv.setViewName("home");
		return mv;
	} //logout	
	
	@RequestMapping(value = "/joinf")
	public ModelAndView join(ModelAndView mv) {
		mv.setViewName("member/joinForm");
		return mv;
	}
	
	@RequestMapping(value = "/mdetail")
	public ModelAndView mypage(ModelAndView mv, MemberVO vo, RedirectAttributes rttr) {
		String uri = "member/memberDetail";
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

	@RequestMapping(value = "/mlist")
	public ModelAndView mlist(ModelAndView mv) {		
		List<MemberVO> list = service.selectList();
		if(list != null) mv.addObject("banana",list);
		else mv.addObject("message","~~ 출력할 자료가 1건도 없습니다 ~~");
		mv.setViewName("member/memberList");
		return mv;
	} //mlist
	
	// ** Member Check List ******************************
	@RequestMapping(value = "/mchecklist")
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
}
