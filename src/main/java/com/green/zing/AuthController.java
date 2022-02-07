package com.green.zing;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import service.AuthService;
import vo.AuthVO;

@Controller
public class AuthController {
	@Autowired
	AuthService service;
	
	@RequestMapping(value = "/authjoin")
	public ModelAndView authjoin(ModelAndView mv, HttpServletRequest request, AuthVO vo) {
		vo.setAuthority("ROLE_USER");
		service.insert(vo);
		mv.addObject("message","회원가입에 성공했습니다. 로그인 후 이용해주세요.");
		mv.setViewName("home");
		return mv;
	}
	
	@RequestMapping(value = "/authsreg")
	public ModelAndView authsreg(ModelAndView mv, HttpServletRequest request, AuthVO vo) {
		vo.setAuthority("ROLE_SELLER");
		service.insert(vo);
		mv.addObject("message","판매자 전환에 성공했습니다.");
		mv.setViewName("home");
		return mv;
	}
	
	@RequestMapping(value = "/srwithdraw")
	public ModelAndView srwithdraw(ModelAndView mv, AuthVO vo) {
		vo.setAuthority("ROLE_SELLER");
		service.delete(vo);
		mv.addObject("message","판매자계정이 취소되었습니다. 판매자 정보가 삭제되었습니다. 언제든 다시 판매자전환이 가능합니다.");
		mv.setViewName("home");
		return mv;
	}

	@RequestMapping(value = "/mrwithdraw")
	public ModelAndView mrwithdraw(ModelAndView mv, AuthVO vo) {
		service.deleteMember(vo);
		mv.addObject("message","회원탈퇴에 성공했습니다.");
		mv.setViewName("home");
		return mv;
	}
}
