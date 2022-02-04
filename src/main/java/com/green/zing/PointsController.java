package com.green.zing;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import service.PointsService;
import vo.PointsVO;

@Controller
public class PointsController {
		
	@Autowired 
	PointsService service;
	
	@RequestMapping(value = "/point")
	public ModelAndView point(ModelAndView mv) {
		mv.setViewName("point/pointsForm");
		return mv;
	}
	
	@RequestMapping(value = "/psend")
	public ModelAndView psend(ModelAndView mv, PointsVO vo, RedirectAttributes rttr) {
		
		String uri = "redirect:point";
		if ( service.send(vo) > 0 ) { 
    		rttr.addFlashAttribute("message", "포인트 전송 완료");
    	}else {
    		mv.addObject("message", "포인트 전송 실패");
    		uri = "point/pointsForm";
    	}
		mv.setViewName(uri);
		return mv;
	} //psend
	
} //Class
