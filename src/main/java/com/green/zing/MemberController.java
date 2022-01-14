package com.green.zing;

import java.io.IOException;

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
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, MemberVO vo) {
	      
	// ** jsonView 사용시 response 의 한글 처리
	response.setContentType("text/html; charset=UTF-8");
	      
	// 1) request 처리
	String id = vo.getMember_id();
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
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response, ModelAndView mv)
			throws ServletException, IOException {
		
		// ** jsonView 사용시 response 의 한글 처리
		response.setContentType("text/html; charset=UTF-8");
		
		// ** session 인스턴스 정의 후 삭제하기
    	// => 매개변수: 없거나, true, false
    	// => false : session 이 없을때 null 을 return;
		HttpSession session = request.getSession(false);
    	if (session!=null) session.invalidate();
    	mv.addObject("message", "~~ 로그아웃 되었습니다 ~~");
    	mv.setViewName("jsonView");
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
}
