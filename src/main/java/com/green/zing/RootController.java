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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import criteria.PageMaker;
import criteria.SearchCriteria;
import lombok.extern.log4j.Log4j;
import service.RootService;
import vo.CommentsVO;
import vo.FollowVO;
import vo.MemberVO;
import vo.PageVO;
import vo.RootVO;
import service.CommentsService;
import service.FollowService;

@Log4j
@Controller
public class RootController {
	@Autowired
	RootService service;
	@Autowired
	FollowService fservice;
	@Autowired 
	CommentsService cservice;

	// ** @Log4j Test
	@RequestMapping(value = "/logj")
	public ModelAndView logj(ModelAndView mv) {
		
		log.info("** @Log4j Test => info");
		log.warn("** @Log4j Test => warn");
		log.error("** @Log4j Test => error");
		log.trace("** @Log4j Test => trace");
		
		mv.setViewName("home");
		return mv;
	} //logj
	
	
	// ** Root Check List ******************************
	@RequestMapping(value = "/rchecklist")
	public ModelAndView rchecklist(ModelAndView mv, RootVO vo) {
		// ** @Log4j Test
		//=> 로깅레벨 단계 준수함 ( log4j.xml 의 아래 logger Tag 의 level 확인)
		//   TRACE > DEBUG > INFO > WARN > ERROR > FATAL(치명적인)
		//	<logger name="com.ncs.green">
		//		<level value="info" />
		//	</logger>
		log.info("** rchecklist => "+vo);
		
		// 1) Check_Box 처리
		// 2) Service 실행
		List<RootVO> list = null;
		if ( vo.getCheck() != null ) list = service.checkList(vo);
		else list = service.selectList();
		
		// => Mapper 는 null 을 return 하지 않으므로 길이로 확인 
		if ( list != null && list.size()>0 ) mv.addObject("banana", list);
		else mv.addObject("message", "~~ 출력할 자료가 1건도 없습니다 ~~");
		
		mv.setViewName("board/rCheckList");
		return mv;
	} //rchecklist
	
	// ** jsonView Board Detail 
	@RequestMapping(value = "/jsbdetail")
	public ModelAndView jsbdetail(HttpServletResponse response, ModelAndView mv, RootVO vo) {
		// jsonView 사용시 response 의 한글 처리
		response.setContentType("text/html; charset=UTF-8");
		
		vo = service.selectOne(vo);
		if ( vo != null ) mv.addObject("content", vo.getContent());
		else mv.addObject("content", "~~ 글번호에 해당하는 자료가 없습니다. ~~");
		
		mv.setViewName("jsonView");
		return mv;
	} //jsbdetail
	
	// ** Ajax id_BoardList 
	@RequestMapping(value = "/aidblist")
	public ModelAndView aidblist(ModelAndView mv, RootVO vo) {
		List<RootVO> list = service.aidBList(vo);
		
		// => Mapper 는 null 을 return 하지 않으므로 길이로 확인 
		if ( list != null && list.size()>0 ) {
			mv.addObject("banana", list);
		}else {
			mv.addObject("message", "~~ 출력할 자료가 1건도 없습니다. ~~");
		}
		mv.setViewName("board/rootList");
		return mv;
	} //aidblist
	
	// ** Ajax BoardList 
	/*
	 * @RequestMapping(value = "/axblist") public ModelAndView axblist(ModelAndView
	 * mv) { List<RootVO> list = service.selectList(); // => Mapper 는 null 을 return
	 * 하지 않으므로 길이로 확인 if (list != null && list.size()>0 ) { mv.addObject("banana",
	 * list); }else { mv.addObject("message", "~~ 출력할 자료가 1건도 없습니다. ~~"); }
	 * mv.setViewName("axTest/axBoardList"); return mv; } //axblist
	 */	// **********************************************************
	
	/*
	 * // ** Member PageList 2. SearchCriteria PageList
	 * 
	 * @RequestMapping(value = "/bcplist") // ** ver02 public ModelAndView
	 * bcplist(ModelAndView mv, SearchCriteria cri, PageMaker pageMaker) { // 1)
	 * Criteria 처리 // => setCurrPage, setRowsPerPage 는 Parameter 로 전달되어, //
	 * setCurrPage(..) , setRowsPerPage(..) 는 자동처리됨(스프링에 의해) // ->
	 * cri.setCurrPage(Integer.parseInt(request.getParameter("currPage"))) // =>
	 * 그러므로 currPage 이용해서 sno, eno 계산만 하면됨 cri.setSnoEno();
	 * 
	 * // 2) 서비스처리 // => List 처리, mv.addObject("banana", service.searchList(cri));
	 * 
	 * // 3) PageMaker 처리 pageMaker.setCri(cri);
	 * pageMaker.setTotalRowCount(service.searchRowsCount(cri));
	 * 
	 * mv.addObject("pageMaker", pageMaker); mv.setViewName("board/rCriList");
	 * return mv; } //rcplist
	 */	
	// ** Board PageList 1.
	/*
	 * @RequestMapping(value = "/rpagelist") public ModelAndView
	 * rpagelist(ModelAndView mv, PageVO<RootVO> pvo) { // 1) Paging 준비 // => 한
	 * Page당 출력할 Row 갯수 : PageVO 에 지정 // => 요청 Page 확인 : currPage ( Parameter ) //
	 * => sno , eno 계산후 List 읽어오기 // => totalRowCount : 전체Page수 계산 int currPage = 1;
	 * if (pvo.getCurrPage() > 1) currPage = pvo.getCurrPage(); else
	 * pvo.setCurrPage(currPage) ;
	 * 
	 * int sno = (currPage-1)*pvo.getRowsPerPage() + 1 ; int eno = sno +
	 * pvo.getRowsPerPage() - 1 ; pvo.setSno(sno); pvo.setEno(eno);
	 * 
	 * // 2) Service 처리 // => List 읽어오기, 전체Row수(totalRowCount) // => 전체 PageNo 계산하기
	 * pvo = service.pageList(pvo) ; int totalPageNo =
	 * pvo.getTotalRowCount()/pvo.getRowsPerPage(); // 20/3 -> 6 나머지 2 : 6 page 와 2개
	 * -> 7page if ( pvo.getTotalRowCount()%pvo.getRowsPerPage() !=0 ) totalPageNo
	 * +=1;
	 * 
	 * // 3) View 처리 // ** view02 // => PageBlock 기능 추가 : sPageNo, ePageNo // => 이를
	 * 위해 currPage, pageNoCount // => 유형 1) currPage 가 항상 중앙에 위치하도록 할때 (ex. 쿠팡) //
	 * int sPageNo = currPage - (pageNoCount/2) ; // int ePageNo = currPage +
	 * (pageNoCount/2) ;
	 * 
	 * // => 유형 2) 11번가의 상품List, Naver 카페글 유형 // 예를들어 currPage=3 이고 pageNoCount 가 3
	 * 이면 1,2,3 page까지 출력 되어야 하므로 // 아래 처럼 currPage-1 을 pageNoCount 으로 나눈후 다시 곱하고 +1
	 * // currPage=11 -> 10,11,12, => (11-1)/3 * 3 +1 = 10 // 연습 ( pageNoCount=5 )
	 * // -> currPage=11 인경우 : 11,12,13,14,15 -> ((11-1)/5)*5 +1 : 11 // ->
	 * currPage=7 인경우 : 6,7,8,9,10 -> ((7-1)/5)*5 +1 : 6 int sPageNo =
	 * ((currPage-1)/pvo.getPageNoCount())*pvo.getPageNoCount() + 1 ; int ePageNo =
	 * sPageNo + pvo.getPageNoCount() - 1 ; // 계산으로 얻어진 ePageNo가 실제 LastPage 인
	 * totalPageNo 보다 크면 수정 필요. if ( ePageNo > totalPageNo ) ePageNo = totalPageNo ;
	 * mv.addObject("sPageNo", sPageNo); mv.addObject("ePageNo", ePageNo);
	 * mv.addObject("pageNoCount", pvo.getPageNoCount());
	 * 
	 * // ** view01 mv.addObject("currPage",currPage);
	 * mv.addObject("totalPageNo",totalPageNo); mv.addObject("banana",
	 * pvo.getList());
	 * 
	 * mv.setViewName("board/pageRList"); return mv; }//rpagelist
	 */
	/*
	 * // ** Reply Insert **
	 * 
	 * @RequestMapping(value = "/rinsertf") public ModelAndView
	 * rinsertf(ModelAndView mv, RootVO vo) { // => vo 에는 전달된 부모글의 root, step,
	 * indent 가 담겨있음 // => 매핑메서드의 인자로 정의된 vo 는 request.setAttribute 와 동일 scope // 단,
	 * 클래스명의 첫글자를 소문자로 ... ${boardVO.root} mv.setViewName("Root/rinsertForm");
	 * return mv; } //rinsertf
	 * 
	 * @RequestMapping(value = "/rinsert") public ModelAndView rinsert(ModelAndView
	 * mv, RootVO vo, RedirectAttributes rttr) { // ** 답글 입력 Service // => 성공 :
	 * blist // => 실패 : 재입력 유도 (rinsertForm)
	 * 
	 * // => 전달된 vo 에 담겨있는 value // : id, title, content, // + 추가적으로 필요한 value :
	 * 부모글의 root, step, indent // root : 부모글의 root와 동일 // step : 부모글의 step+1 // (기존
	 * 답글의 step 값이 현재 계산된 이값보다 같거나 큰값들은 +1씩 모두증가 : sql 에서 처리) // indent: 부모글의
	 * indent+1 // => 이를 위해 boardDetail 에서 요청시 퀴리스트링으로 전달 -> rinsertf // => 부모글의
	 * root, step, indent 를 replyForm 에서 hidden으로 처리한 후 // 전달된 vo 에는 이 값이 담겨있으므로
	 * step, indent만 1씩 증가해주면 됨.
	 * 
	 * String uri="redirect:blist"; vo.setStep(vo.getStep()+1);
	 * vo.setIndent(vo.getIndent()+1);
	 * 
	 * if (service.rinsert(vo) > 0) { // 답글 입력 성공 -> blist
	 * rttr.addFlashAttribute("message","~~ 답글 입력 성공 ~~"); }else { // 답글 입력 실패 ->
	 * 재입력 유도 (rinsertForm) // => step, indent 값을 부모의 값으로 변경한 후, forward
	 * vo.setStep(vo.getStep()-1); vo.setIndent(vo.getIndent()-1);
	 * mv.addObject("message","~~ 답글 입력 실패 !! 다시하세요 ~~"); uri="board/rinsertForm"; }
	 * 
	 * mv.setViewName(uri); return mv; } //rinsert
	 */	
	// ** Board CRUD *****
	@RequestMapping(value = "/rlist")
	public ModelAndView rlist(ModelAndView mv, HttpServletRequest request, RootVO vo) {
		String r = "rlist";
		String type = vo.getType();
		List<RootVO> list = new ArrayList<RootVO>();
		if( vo.getType()==null || "".equals(vo.getType()) ) {
			mv.addObject("title","전체");
			list = service.selectList();
		}
		else{
			if("0".equals(type)) mv.addObject("title","홍보");
			else if("1".equals(type)) mv.addObject("title","리뷰");
			list = service.typeList(vo);
			r += "?type=" + type;
		}
    	
    	// => Mapper 는 null 을 return 하지 않으므로 길이로 확인 
    	if ( list!=null && list.size()>0 ) {
    		mv.addObject("banana", list);
    		mv.addObject("type", type);
    	}else mv.addObject("message", "~~ 출력 자료가 없습니다 ~~");
    	
    	if("rlist".equals(request.getParameter("R"))) {
			mv.addObject("R",r);
			mv.setViewName("home");
		}else mv.setViewName("board/rootList");
		return mv;
	} //rlist
	
	@RequestMapping(value = "/rdetail")
	public ModelAndView rdetail(HttpServletRequest request, ModelAndView mv, FollowVO fvo,RootVO vo, CommentsVO cvo) {
		String uri = "board/rootDetail";
		
		List<CommentsVO> list = new ArrayList<CommentsVO>();
    	list = cservice.selectList(cvo);
    	
    	if ( list!=null && list.size()>0 ) mv.addObject("banana", list);
		// ** Service 처리
    	// => 조회수 증가 추가하기 ( 조회수 증가의 조건 )
    	//    글보는이(loginID)와 글쓴이가 다를때 && jcode!="U" -> countUp 메서드
		String loginID = (String)request.getSession().getAttribute("loginID") ;		
		vo = service.selectOne(vo);
    	if ( vo!=null ) {
    		// 조회수 증가 추가
    		if ( !vo.getMember_id().equals(loginID) &&
    				!"U".equals(request.getParameter("jcode"))) {
    			// 조회수 증가
    			if ( service.countUp(vo) > 0 )
    				vo.setCnt(vo.getCnt()+1) ;
    		} //if
    		
    		mv.addObject("apple", vo);
    		// 글 수정인지 확인
    		if ( "U".equals(request.getParameter("jcode")) ) 
    			uri = "board/rupdateForm";
    	}else {
    		mv.addObject("message", "~~ 글번호에 해당하는 자료가 없습니다 ~~");
    	}
    	fvo.setFollower(vo.getMember_id());
    	fvo.setFollowing(loginID);
    	//following, follower 카운트
    	mv.addObject("following",fservice.countfollowing(fvo));
    	mv.addObject("follower",fservice.countfollower(fvo));
    	mv.addObject("followflag",fservice.followflag(fvo));
    	
		mv.setViewName(uri);
		return mv;
	} //rdetail
	
	@RequestMapping(value = "/rinsertf")
	public ModelAndView rinsertf(ModelAndView mv, RootVO vo) {
		mv.addObject("Type",vo.getType());
		mv.setViewName("board/rinsertForm");
		return mv;
	} //rinsertf
	
	@RequestMapping(value = "/rinsert")
	public ModelAndView rinsert(HttpServletRequest request, ModelAndView mv, RootVO vo, 
			RedirectAttributes rttr) throws IOException { 
		// 1. 요청처리 
			// => parameter : 매개변수로 ...
			// => 한글: web.xml 에서 <Filter> 로 ...
			
			// ** Uploadfile (Image) 처리
			// => MultipartFile 타입의 uploadfilef 의 정보에서 
			//    upload된 image 와 화일명을 get 처리,
			// => upload된 image 를 서버의 정해진 폴더 (물리적위치)에 저장 하고,  -> file1
			// => 이 위치에 대한 정보를 table에 저장 (vo의 UploadFile 에 set) -> file2
			// ** image 화일명 중복시 : 나중 이미지로 update 됨.  
			
			// ** Image 물리적위치 에 저장
			// 1) 현재 웹어플리케이션의 실행 위치 확인 : 
			// => eslipse 개발환경 (배포전)
			//    D:\MTest\MyWork\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Spring03\
			// => 톰캣서버에 배포 후 : 서버내에서의 위치가 됨
			//    D:\MTest\IDESet\apache-tomcat-9.0.41\webapps\Spring02\
			
	
		String uri = "redirect:rlist?type=" + vo.getType();
		String realPath = request.getRealPath("/"); // deprecated Method
		System.out.println("** realPath => "+realPath);
		
		// 2) 위 의 값을 이용해서 실제저장위치 확인 
		// => 개발중인지, 배포했는지 에 따라 결정
		if (realPath.contains(".eclipse."))
			 realPath = "D:/MTest/MyWork/Project/src/main/webapp/resources/uploadImage/";
	//		realPath = "C:/MTest/MyWork/Project/src/main/webapp/resources/uploadImage/";
		else realPath += "resources\\uploadImage\\";
		//uploadImage폴더에 상품사진 넣어놓기 
		// ** 폴더 만들기 (File 클래스활용)
		// => 위의 저장경로에 폴더가 없는 경우 (uploadImage가 없는경우)  만들어 준다
		File f1 = new File(realPath);
		if ( !f1.exists() ) f1.mkdir();
		// realPath 디렉터리가 존재하는지 검사 (uploadImage 폴더 존재 확인)
		// => 존재하지 않으면 디렉토리 생성
		
		// ** 기본 이미지 지정하기 
		String file1, file2="resources/uploadImage/banana.png";
		
		// ** MultipartFile
		// => 업로드한 파일에 대한 모든 정보를 가지고 있으며 이의 처리를 위한 메서드를 제공한다.
		//    -> String getOriginalFilename(), 
		//    -> void transferTo(File destFile),
		//    -> boolean isEmpty()
		
		MultipartFile filesf = vo.getFilesf();
		if ( filesf !=null && !filesf.isEmpty() ) {
			// Image 를 선택했음 -> Image 처리 (realPath+화일명)
			// 1) 물리적 위치에 Image 저장 
			file1 = realPath + vo.getMember_id() + "_" + filesf.getOriginalFilename(); //  전송된File명 추출 & 연결
	        filesf.transferTo(new File(file1)); // real 위치에 전송된 File 붙여넣기
	         // 2) Table 저장위한 경로 
	         file2 = "resources/uploadImage/" + vo.getMember_id() + "_" + filesf.getOriginalFilename();
		}
		vo.setFiles(file2);

		if ( service.insert(vo) > 0 ) { 
    		// 글등록 성공 -> rlist , redirect
    		rttr.addFlashAttribute("message", "~~ 새글 등록 완료 !!! ~~");
    	}else {
    		rttr.addFlashAttribute("message", "~~ 새글 등록 실패 !!! ~~");
    		uri = "redirect:rinsertf?" + vo.getType();
    	}
		mv.setViewName(uri);
		return mv;
	} //rinsert
	
	@RequestMapping(value = "/rupdate")
	public ModelAndView bupdate(HttpServletRequest request, ModelAndView mv, RootVO vo, RedirectAttributes rttr) throws IOException {
		
		String uri = "redirect:rlist?type=" + vo.getType();
		String realPath = request.getRealPath("/"); // deprecated Method
		System.out.println("** realPath => "+realPath);
		
		// 2) 위 의 값을 이용해서 실제저장위치 확인 
		// => 개발중인지, 배포했는지 에 따라 결정
		if (realPath.contains(".eclipse."))
			 realPath = "D:/MTest/MyWork/Project/src/main/webapp/resources/uploadImage/";
	//		realPath = "C:/MTest/MyWork/Project/src/main/webapp/resources/uploadImage/";
		else realPath += "resources\\uploadImage\\";
		//uploadImage폴더에 상품사진 넣어놓기 
		// ** 폴더 만들기 (File 클래스활용)
		// => 위의 저장경로에 폴더가 없는 경우 (uploadImage가 없는경우)  만들어 준다
		File f1 = new File(realPath);
		if ( !f1.exists() ) f1.mkdir();
		// realPath 디렉터리가 존재하는지 검사 (uploadImage 폴더 존재 확인)
		// => 존재하지 않으면 디렉토리 생성
		
		// ** 기본 이미지 지정하기 
		String file1, file2="resources/uploadImage/banana.png";
		
		// ** MultipartFile
		// => 업로드한 파일에 대한 모든 정보를 가지고 있으며 이의 처리를 위한 메서드를 제공한다.
		//    -> String getOriginalFilename(), 
		//    -> void transferTo(File destFile),
		//    -> boolean isEmpty()
		
		MultipartFile filesf = vo.getFilesf();
		if ( filesf !=null && !filesf.isEmpty() ) {
			// Image 를 선택했음 -> Image 처리 (realPath+화일명)
			// 1) 물리적 위치에 Image 저장 
			file1 = realPath + vo.getMember_id() + "_" + filesf.getOriginalFilename(); //  전송된File명 추출 & 연결
	        filesf.transferTo(new File(file1)); // real 위치에 전송된 File 붙여넣기
	         // 2) Table 저장위한 경로 
	         file2 = "resources/uploadImage/" + vo.getMember_id() + "_" + filesf.getOriginalFilename();
		}
		vo.setFiles(file2);
		if ( service.update(vo) > 0 ) { 
    		// 글수정 성공 -> blist : redirect
    		rttr.addFlashAttribute("message", "~~ 글수정 성공 !!! ~~");
    	}else {
    		rttr.addFlashAttribute("message", "~~ 글수정 실패 !!! 다시 하세요 ~~");
    		uri = "redirect:bdetail?jcode=U&root_seq="+vo.getRoot_seq();
    	}
		mv.setViewName(uri);
		return mv;
	} //rupdate
	
	@RequestMapping(value = "/rdelete")
	public ModelAndView rdelete(ModelAndView mv, RootVO vo, RedirectAttributes rttr) {
		
		String uri = "redirect:rlist?type=" + vo.getType();
		if ( service.delete(vo) > 0 ) { 
    		// 글삭제 성공 -> blist  : redirect
			rttr.addFlashAttribute("message", "~~ 글삭제 성공 !!! ~~");
    	}else {
    		rttr.addFlashAttribute("message", "~~ 글삭제 실패 !!! ~~");
    		uri = "redirect:rdetail?root_seq="+vo.getRoot_seq();
    	}
		mv.setViewName(uri);
		return mv;
	} //rdelete	

} //class
