package com.green.zing;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

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
	
	@RequestMapping(value = "/joinf")
	public ModelAndView join(ModelAndView mv) {
		mv.setViewName("member/joinForm");
		return mv;
	}
	
	@RequestMapping(value = "/mypage")
	public ModelAndView mypage(ModelAndView mv, MemberVO vo) {
		System.out.println(vo);
		System.out.println(service);
		vo=service.selectOne(vo);
		mv.addObject("apple",vo);
		System.out.println(vo);
		mv.setViewName("member/memberDetail");
		return mv;
	}
}
