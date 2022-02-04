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
}
