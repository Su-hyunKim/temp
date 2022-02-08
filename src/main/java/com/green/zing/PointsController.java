package com.green.zing;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import service.MemberService;
import service.PointsService;
import vo.PointsVO;

@Controller
public class PointsController {
		
	@Autowired 
	PointsService service;
	@Autowired
	MemberService mservice;
	
	@RequestMapping(value = "/point")
	public ModelAndView point(HttpServletRequest request, PointsVO pvo, ModelAndView mv) {
		mv.addObject("mypoint", service.mypoint(pvo));
		mv.setViewName("point/pointsForm");
		return mv;
	}
	
	@RequestMapping(value = "/psend")
	public ModelAndView psend(ModelAndView mv, PointsVO pvo, RedirectAttributes rttr) {
		String uri = "redirect:point?giver="+pvo.getGiver();
		
		if (pvo.getPoint() > pvo.getMypoint()) { 
			rttr.addFlashAttribute("message","보유 포인트가 보내는 포인트보다 적습니다."); 
		} else {
			if (service.updategrantee(pvo)>0) {
				service.updategiver(pvo);
				rttr.addFlashAttribute("message", "포인트 전송 완료");
			} else {
				rttr.addFlashAttribute("message","포인트 전송 실패 => 받으실 분의 아이디를 확인해 주세요.");
			}
		}
		
		mv.setViewName(uri);
		return mv;
	} //psend
	
} //Class
