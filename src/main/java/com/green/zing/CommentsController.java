package com.green.zing;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import service.CommentsService;
import vo.CommentsVO;
import vo.PageVO;

@Controller
public class CommentsController {
		
	@Autowired 
	CommentsService service;
		
	@RequestMapping(value = "/comment")
	public ModelAndView comment(ModelAndView mv, CommentsVO vo) {
		List<CommentsVO> list = new ArrayList<CommentsVO>();
    	list = service.selectList(vo);
    	
    	if ( list!=null && list.size()>0 ) mv.addObject("banana", list);
		mv.setViewName("board/commentsForm");
		return mv;
	}
	
	@RequestMapping(value = "/cdetail")
	public ModelAndView cdetail(HttpServletRequest request, ModelAndView mv, CommentsVO vo) {
		
		String uri = "board/commentsupdateForm";
		
		vo = service.selectOne(vo);
		mv.addObject("apple", vo);
    	if ( vo!=null ) {
    		// 글 수정인지 확인
    		if ( "U".equals(request.getParameter("jcode")) ) 
    			uri = "board/commentsupdateForm";
    	}else {
    		mv.addObject("message", "~~ 글번호에 해당하는 자료가 없습니다 ~~");
    	}
		
		mv.setViewName(uri);
		return mv;
	} //cdetail
	
	@RequestMapping(value = "/cmydetail")
	public ModelAndView cmydetail(HttpServletRequest request, ModelAndView mv, CommentsVO vo) {
		
		String uri = "board/commentsMyupdateForm";
		
		vo = service.selectOne(vo);
		mv.addObject("apple", vo);
    	if ( vo!=null ) {
    		// 글 수정인지 확인
    		if ( "U".equals(request.getParameter("jcode")) ) 
    			uri = "board/commentsMyupdateForm";
    	}else {
    		mv.addObject("message", "~~ 글번호에 해당하는 자료가 없습니다 ~~");
    	}
		
		mv.setViewName(uri);
		return mv;
	} //cdetail
	
	@RequestMapping(value = "/clist")
	public ModelAndView clist(HttpServletRequest request, ModelAndView mv, PageVO<CommentsVO> pvo, CommentsVO vo) {
		
		List<CommentsVO> list = new ArrayList<CommentsVO>();
    	list = service.selectList(vo);
    	
    	if ( list!=null && list.size()>0 ) mv.addObject("banana", list);
    	else mv.addObject("message", "~~ 출력 자료가 없습니다 ~~");
		
    	mv.setViewName("board/commentsList");
		return mv;
	} //clist
	
	@RequestMapping(value = "/cmylist")
	public ModelAndView cmylist(HttpServletRequest request, ModelAndView mv, PageVO<CommentsVO> pvo, CommentsVO vo) {
		
		List<CommentsVO> list = new ArrayList<CommentsVO>();
		vo.setMember_id((String)request.getSession().getAttribute("loginID") );
    	list = service.selectmyList(vo);
    	
    	if ( list!=null && list.size()>0 ) mv.addObject("banana", list);
    	else mv.addObject("message", "~~ 출력 자료가 없습니다 ~~");
		
    	mv.setViewName("board/commentsMyList");
		return mv;
	} //clist
	
	@RequestMapping(value = "/cinsert")
	public ModelAndView cinsert(ModelAndView mv, CommentsVO vo, HttpServletRequest request, RedirectAttributes rttr) {
		
		String uri = "redirect:rdetail?root_seq="+vo.getRoot_seq()+"&follower="+request.getSession()+"&following="+request.getAttribute("loginID");
		
		if (vo.getRating()==null) {
			rttr.addFlashAttribute("message", "별점을 선택해 주세요.");
		} else {
			if ( service.insert(vo) > 0 ) { 
	    		rttr.addFlashAttribute("message", "~~ 새글 등록 완료 !!! ~~");
	    	}else {
	    		mv.addObject("message", "~~ 새글 등록 실패 !!! ~~");
	    		uri = "board/commentsForm";
	    	}
		}
		/*
		 * if ( service.insert(vo) > 0 ) { rttr.addFlashAttribute("message",
		 * "~~ 새글 등록 완료 !!! ~~"); }else { mv.addObject("message", "~~ 새글 등록 실패 !!! ~~");
		 * uri = "board/commentsForm"; }
		 */
		mv.setViewName(uri);
		return mv;
	} //cinsert
	
	@RequestMapping(value = "/cupdate")
	public ModelAndView cupdate(ModelAndView mv, CommentsVO vo, HttpServletRequest request, RedirectAttributes rttr) {
		
		String uri = "redirect:rdetail?root_seq="+vo.getRoot_seq()+"&follower="+request.getSession()+"&following="+request.getAttribute("loginID");
		
		if (vo.getRating()==null) {
			rttr.addFlashAttribute("message", "별점을 선택해 주세요.");
			uri = "redirect:cdetail?reply_seq="+vo.getReply_seq();
		} else {
			if ( service.update(vo) > 0 ) { 
	    		rttr.addFlashAttribute("message", "~~ 글수정 성공 !!! ~~");
	    	}else {
	    		rttr.addFlashAttribute("message", "~~ 글수정 실패 !!! 다시 하세요 ~~");
	    		uri = "redirect:cdetail?jcode=U&seq="+vo.getRoot_seq();
	    	}
		}
		mv.setViewName(uri);
		return mv;
	} //cupdate
	
	@RequestMapping(value = "/cmyupdate")
	public ModelAndView cmyupdate(ModelAndView mv, CommentsVO vo, HttpServletRequest request, RedirectAttributes rttr) {
		
		String uri = "redirect:cmylist";
		
		if (vo.getRating()==null) {
			rttr.addFlashAttribute("message", "별점을 선택해 주세요.");
			uri = "redirect:cmydetail?reply_seq="+vo.getReply_seq();
		} else {
			if ( service.update(vo) > 0 ) { 
	    		rttr.addFlashAttribute("message", "~~ 글수정 성공 !!! ~~");
	    	}else {
	    		rttr.addFlashAttribute("message", "~~ 글수정 실패 !!! 다시 하세요 ~~");
	    		uri = "redirect:cdetail?jcode=U&seq="+vo.getRoot_seq();
	    	}
		}
		mv.setViewName(uri);
		return mv;
	} //cupdate
	
	@RequestMapping(value = "/cdelete")
	public ModelAndView cdelete(ModelAndView mv, CommentsVO vo, HttpServletRequest request, RedirectAttributes rttr) {
		
		String uri = "redirect:rlist";
		if ( service.delete(vo) > 0 ) { 
			rttr.addFlashAttribute("message", "~~ 글삭제 성공 !!! ~~");
    	}else {
    		rttr.addFlashAttribute("message", "~~ 글삭제 실패 !!! ~~");
    		uri = "redirect:cdetail?seq="+vo.getRoot_seq();
    	}
		mv.setViewName(uri);
		return mv;
	} //cdelete	
	
	@RequestMapping(value = "/cmydelete")
	public ModelAndView cmydelete(ModelAndView mv, CommentsVO vo, HttpServletRequest request, RedirectAttributes rttr) {
		
		String uri = "redirect:cmylist";
		if ( service.delete(vo) > 0 ) { 
			rttr.addFlashAttribute("message", "~~ 글삭제 성공 !!! ~~");
    	}else {
    		rttr.addFlashAttribute("message", "~~ 글삭제 실패 !!! ~~");
    		uri = "redirect:cdetail?seq="+vo.getRoot_seq();
    	}
		mv.setViewName(uri);
		return mv;
	} //cdelete	

	
} //Class
