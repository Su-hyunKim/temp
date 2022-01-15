package com.green.zing;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class BoardController {
		
	@RequestMapping(value = "/comment")
	public ModelAndView comment(ModelAndView mv) {
		mv.setViewName("board/commentForm");
		return mv;
	}

} //Class
