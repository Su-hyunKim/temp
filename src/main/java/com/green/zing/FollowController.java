package com.green.zing;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import lombok.extern.log4j.Log4j;

import service.FollowService;
import service.FollowServiceImpl;
import vo.FollowVO;

@Controller
public class FollowController {
	@Autowired
	FollowService service;

	@RequestMapping(value = "/followMember")
	public ModelAndView followMember(ModelAndView mv, HttpServletRequest request, FollowVO vo) {
		
		System.out.println("***vo->"+vo);
		int cnt = 0;
		if ("delete".equals(vo.getTag())) {
			cnt=service.delete(vo);
		}else {
			cnt=service.insert(vo);
		}
		if(cnt>0) {
			mv.addObject("success","T");
		}else {
			mv.addObject("success","F");
		}
		//mv.addObject("following",service.countfollowing(vo));
		//mv.addObject("follower",service.countfollower(vo));
		mv.setViewName("jsonView");
		return mv;
	}
	/*
	 * @RequestMapping(value = "/followChkMember") public boolean
	 * followChkMember(HttpServletRequest request, FollowVO vo) { boolean result =
	 * false; FollowVO followVO = service.selectOne(vo); if (followVO != null) {
	 * result = false; }else { result = true; } return result; }
	 */
	
	@RequestMapping(value = "/followinglist")
	public ModelAndView followinglist(ModelAndView mv, FollowVO vo) {
		
		List<FollowVO> followinglist = new ArrayList<FollowVO>();
    	followinglist = service.followingselectList(vo);
    	
    	// => Mapper 는 null 을 return 하지 않으므로 길이로 확인 
    	if ( followinglist!=null && followinglist.size()>0 ) mv.addObject("apple", followinglist);
    	else mv.addObject("message", "~~ 출력 자료가 없습니다 ~~");
		
    	mv.setViewName("board/followingList");
		return mv;
	} //followinglist
	
	@RequestMapping(value = "/followerlist")
	public ModelAndView followerlist(ModelAndView mv, FollowVO vo) {
		
		List<FollowVO> followerlist = new ArrayList<FollowVO>();
    	followerlist = service.followerselectList(vo);
    	
    	// => Mapper 는 null 을 return 하지 않으므로 길이로 확인 
    	if ( followerlist!=null && followerlist.size()>0 ) mv.addObject("apple", followerlist);
    	else mv.addObject("message", "~~ 출력 자료가 없습니다 ~~");
		
    	mv.setViewName("board/followerList");
		return mv;
	} //followerlist
	
	@RequestMapping(value = "/countfollow")
	public ModelAndView countfollow(ModelAndView mv, HttpServletRequest request, FollowVO vo) {
		mv.addObject("following",service.countfollowing(vo));
		mv.addObject("follower",service.countfollower(vo));
		mv.setViewName("jsonView");
		return mv;
	}
	@RequestMapping(value = "/countmyfollow")
	public ModelAndView countmyfollow(ModelAndView mv, HttpServletRequest request, FollowVO vo) {
		mv.addObject("myfollowing",service.countmyfollowing(vo));
		mv.addObject("myfollower",service.countmyfollower(vo));
		mv.setViewName("jsonView");
		return mv;
	}

} //class
