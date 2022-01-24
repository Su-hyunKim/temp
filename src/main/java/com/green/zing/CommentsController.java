package com.green.zing;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import criteria.PageMaker;
import criteria.SearchCriteria;
import service.CommentsService;
import vo.CommentsVO;

@RestController
@RequestMapping("/comments")
public class CommentsController {
		
	@Autowired 
	CommentsService service;
		
	@RequestMapping(value = "/comment")
	public ModelAndView comment(ModelAndView mv) {
		mv.setViewName("board/commentForm");
		return mv;
	}

	//Reply Register
	@RequestMapping(value = "", method = RequestMethod.POST)
	public ResponseEntity<String> register(@RequestBody CommentsVO commentsVO){
		ResponseEntity<String> entity = null;
		try { 
			service.insert(commentsVO); 
			entity = new ResponseEntity<String>("regSuccess", HttpStatus.OK); 
		} catch (Exception e) { 
			e.printStackTrace(); 
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST); 
		}
		return entity;
	} 
	
	//Comments List
	@RequestMapping(value = "/all/{rootseq}", method = RequestMethod.GET)
	public ResponseEntity<List<CommentsVO>> selectList(@PathVariable("root_seq") Integer root_seq) {
		ResponseEntity<List<CommentsVO>> entity = null; 
		try { 
			entity = new ResponseEntity<List<CommentsVO>>(service.list(root_seq), HttpStatus.OK); 
		} catch (Exception e) { 
			e.printStackTrace(); 
			entity = new ResponseEntity<List<CommentsVO>>(HttpStatus.BAD_REQUEST); 
		} 
		return entity;
	} 
	
	//Comments Modify
	@RequestMapping(value = "/{replyseq}", method = {RequestMethod.PUT, RequestMethod.PATCH}) 
	public ResponseEntity<String> update(@PathVariable("reply_seq") Integer reply_seq, @RequestBody CommentsVO commentsVO) { 
		ResponseEntity<String> entity = null;
		try { 
			commentsVO.setReply_seq(reply_seq);
			service.update(commentsVO); 
			entity = new ResponseEntity<String>("modSuccess", HttpStatus.OK); 
		} catch (Exception e) { 
			e.printStackTrace(); 
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST); 
		} 
		return entity;
	} 
	
	//Comments Delete 
	@RequestMapping(value = "/{replyseq}", method = RequestMethod.DELETE) 
	public ResponseEntity<String> delete(@PathVariable("reply_seq") Integer reply_seq, @RequestBody CommentsVO commentsVO) { 
		ResponseEntity<String> entity = null; 
		try { 
			service.delete(commentsVO); 
			entity = new ResponseEntity<String>("delSuccess", HttpStatus.OK); 
		} catch (Exception e) { 
			e.printStackTrace(); 
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST); 
		} 
		return entity; 
	} 
	
	//Comments Paging List 
	@RequestMapping(value = "/{root_seq}/{page}", method = RequestMethod.GET) 
	public ResponseEntity<Map<String, Object>> listPaging(@PathVariable("root_seq") Integer root_seq, 
														  @PathVariable("currPage") Integer currPage) { 
		
		ResponseEntity<Map<String, Object>> entity = null; 
		try { 
			SearchCriteria criteria = new SearchCriteria(); 
			criteria.setCurrPage(currPage); 
			
			List<CommentsVO> comments = service.getCommentsPaging(root_seq, criteria); 
			int commentsCount = service.countComments(root_seq);
			
			PageMaker pageMaker = new PageMaker(); 
			pageMaker.setCri(criteria); 
			pageMaker.setTotalRowCount(commentsCount); 
			
			Map<String, Object> map = new HashMap<String, Object>(); 
			map.put("comments", comments); 
			map.put("pageMaker", pageMaker); 
			
			entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK); 
		} catch (Exception e) { 
			e.printStackTrace(); 
			entity = new ResponseEntity<Map<String, Object>>(HttpStatus.OK); 
		} 
		return entity; 
	}

	
} //Class
