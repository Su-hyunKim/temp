package com.green.zing;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import criteria.MultiCheckSearchCriteria;
import criteria.PageMakerE;
import service.MemberMailSendService;
import service.SellerService;
import vo.ProductVO;
import vo.SellerVO;

//=> Mapper 는 null 을 return 하지 않으므로 길이로 확인 

@Controller
public class SellerController {
	@Autowired
	SellerService service;
	@Autowired
	MemberMailSendService mailsender;
	
	@RequestMapping(value = "/ssearchlist")
	public ModelAndView ssearchlist(ModelAndView mv, MultiCheckSearchCriteria cri, PageMakerE pageMaker) {
		cri.setRowsPerPage(5);
		cri.setSnoEno();
		List<SellerVO> list = service.checkList(cri);
		// => Mapper 는 null 을 return 하지 않으므로 길이로 확인 
		if ( list != null && list.size()>0 ) mv.addObject("banana", list);
		else mv.addObject("message", "~~ 출력할 자료가 1건도 없습니다 ~~");	
		pageMaker.setCri(cri);
		pageMaker.setTotalRowCount(service.searchRowsCount(cri));
		mv.addObject("pageMaker", pageMaker);
		mv.setViewName("seller/sellerList");
		return mv;
	} //ssearchlist
	
	@RequestMapping(value = "/sdetail")
	public ModelAndView sdetail(ModelAndView mv, SellerVO vo, RedirectAttributes rttr) {
		String uri = "seller/sellerDetail";
		String id = vo.getMember_id();
		List<ProductVO> list = service.productList(vo);
		if(id==null) id = "";
		vo=service.selectOne(vo);
		if (vo!=null) {
			if ( list!=null && list.size()>0 ) vo.setProductList(list);
			mv.addObject("apple", vo);	
		}else {
			rttr.addFlashAttribute("message","~~ "+id+"님의 자료는 존재하지 않습니다 ~~");
			uri = "redirect:home";
		}
		mv.setViewName(uri);
		return mv;
	}

	@RequestMapping(value = "/sregf")
	public ModelAndView sregf(ModelAndView mv, HttpServletRequest request) {
		if("sregf".equals(request.getParameter("R"))) {
			mv.addObject("R","sregf");
			mv.setViewName("home");
		}else mv.setViewName("seller/registerForm");
		return mv;
	}
	
	// ** 판매자전환
	// Spring AOP Transaction 적용됨
	@RequestMapping(value = "/sreg")
	public ModelAndView sreg(HttpServletRequest request, ModelAndView mv, SellerVO vo,
			RedirectAttributes rttr) throws IOException {	
		// ** 거래중지 회원 확인
		if("6".equals(vo.getStatus())){
			service.delete(vo);
			mv.addObject("message","거래중지 회원입니다.");
			mv.setViewName("home");
			return mv;
		}
		
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
		String realPath = request.getRealPath("/"); // deprecated Method
		System.out.println("** realPath => "+realPath);
		
		// 2) 위 의 값을 이용해서 실제저장위치 확인 
		// => 개발중인지, 배포했는지 에 따라 결정
		if (realPath.contains(".eclipse."))
			 realPath = "D:/MTest/MyWork/Project/src/main/webapp/resources/uploadImage/";
	//		realPath = "C:/MTest/MyWork/Project/src/main/webapp/resources/uploadImage/";
		else realPath += "resources\\uploadImage\\";
		
		// ** 폴더 만들기 (File 클래스활용)
		// => 위의 저장경로에 폴더가 없는 경우 (uploadImage가 없는경우)  만들어 준다
		File f1 = new File(realPath);
		if ( !f1.exists() ) f1.mkdir();
		// realPath 디렉터리가 존재하는지 검사 (uploadImage 폴더 존재 확인)
		// => 존재하지 않으면 디렉토리 생성
		
		// ** 기본 이미지 지정하기 
		String file1, file2="resources/uploadImage/logo.png";
		
		// ** MultipartFile
		// => 업로드한 파일에 대한 모든 정보를 가지고 있으며 이의 처리를 위한 메서드를 제공한다.
		//    -> String getOriginalFilename(), 
		//    -> void transferTo(File destFile),
		//    -> boolean isEmpty()
		
		MultipartFile logof = vo.getLogof();
		if ( logof !=null && !logof.isEmpty() ) {
			// Image 를 선택했음 -> Image 처리 (realPath+화일명)
			// 1) 물리적 위치에 Image 저장 
			file1=realPath + vo.getMember_id() + "_" + vo.getEmployer_id()
				+ logof.getOriginalFilename().substring(logof.getOriginalFilename().lastIndexOf("."));
			logof.transferTo(new File(file1)); // real 위치에 전송된 File 붙여넣기
			// 2) Table 저장위한 경로 
			file2 = "resources/uploadImage/" + vo.getMember_id() + "_" + vo.getEmployer_id()
				+ logof.getOriginalFilename().substring(logof.getOriginalFilename().lastIndexOf("."));
		}
		vo.setLogo(file2);
		
		// 2. Service 처리
		String uri = "redirect:home";  
			
		if ( service.insert(vo) > 0 ) { // insert 성공
			// 인증 email 발송
			String key = mailsender.mailSendWithMemberKey(vo.getBusiness_email(),vo.getMember_id());
			if(key==null) key="";	
			mv.addObject("key",key);
			mv.addObject("R","sreg");
			// member_id값 저장(인증실패시 seller등록 취소를 하기위함)
			mv.addObject("member_id",vo.getMember_id());
			uri = "member/emailAuth";
			//rttr.addFlashAttribute("message", "~~ 회원가입 완료!!, 이메일 인증 후 이용해 해주세요 ~~");
			//rttr.addFlashAttribute("R","login"); // 성공시 홈으로 이동 후 로그인 form 클릭
		}else { 
			// insert 실패
			rttr.addFlashAttribute("message", "~~ 판매자전환 실패!!, 다시 하세요 ~~");
			rttr.addFlashAttribute("R","sregf");
		}
			mv.setViewName(uri);
			return mv;
	} //sreg
	
	@RequestMapping(value = "/supdatef")
	public ModelAndView supdatef(ModelAndView mv, HttpServletRequest request, SellerVO vo) {
		// ** 마지막 접속시간 update
		service.updateLastAccess(vo);
		
		vo = service.selectOne(vo);
		mv.addObject("apple",vo);
		mv.setViewName("seller/updateForm");
		return mv;
	}
	
	// ** Seller Update
	@RequestMapping(value = "/supdate")
	public ModelAndView supdate(HttpServletRequest request, 
			ModelAndView mv, SellerVO vo, RedirectAttributes rttr) throws IOException {
		String uri = null; 

		MultipartFile logof = vo.getLogof();
		String file1, file2;
		if ( logof != null && !logof.isEmpty() ) {
			// 1) 저장폴더지정
			String realPath = request.getRealPath("/");
			if (realPath.contains(".eclipse."))
				realPath = "D:/MTest/MyWork/Project/src/main/webapp/resources/uploadImage/";
		//		realPath = "C:/MTest/MyWork/Project/src/main/webapp/resources/uploadImage/";
			else realPath += "resources\\uploadImage\\"; // 배포환경
			File f1 = new File(realPath);
			if ( !f1.exists() ) f1.mkdir();
			// 2) 전송된 file 처리
			// 2.1) Image 붙여넣기
			file1 = realPath + vo.getMember_id() + "_" + vo.getEmployer_id()
				+ logof.getOriginalFilename().substring(logof.getOriginalFilename().lastIndexOf("."));
			logof.transferTo(new File(file1));
			// 2.2) Table 저장위한 값 set
			file2 = "resources/uploadImage/" + vo.getMember_id() + "_" + vo.getEmployer_id()
				+ logof.getOriginalFilename().substring(logof.getOriginalFilename().lastIndexOf("."));
			vo.setLogo(file2);
		}	
		
		if ( service.update(vo) > 0 ) {
			 // update 성공
			 rttr.addFlashAttribute("message", "~~ 판매자정보 수정 완료 !!!  ~~") ; 
			 uri = "redirect:sdetail?member_id="+vo.getMember_id();  // redirect 로 처리함 (재요청처리)
		 }else { 
			 // update 실패 : 수정가능한 폼 출력할수있도록 요청 
			 rttr.addFlashAttribute("message", "~~ 판매자정보 수정 실패!!, 다시 해주세요 ~~");
			 uri="redirect:supdatef?member_id="+vo.getMember_id();
		 }		
		mv.setViewName(uri); 
		return mv;
	} //supdate
	
	@RequestMapping(value = "/swithdraw")
	public ModelAndView swithdraw(ModelAndView mv, SellerVO vo) {
		// ** 마지막 접속시간 update
		service.updateLastAccess(vo);
		service.delete(vo);
		mv.setViewName("redirect:srwithdraw?member_id="+vo.getMember_id());
		return mv;
	}
	
	@RequestMapping(value = "/entrepreneurcheck")
	public ModelAndView entrepreneurcheck(ModelAndView mv, SellerVO vo, HttpServletResponse response) throws IOException {
		StringBuilder urlBuilder = new StringBuilder("https://api.odcloud.kr/api/nts-businessman/v1/validate"); /*URL*/
		// ** jsonView 사용시 response 의 한글 처리
		response.setContentType("text/html; charset=UTF-8");
		
		// 2. 오픈 API의요청 규격에 맞는 파라미터 생성, 발급받은 인증키 적용.
		//gR214+X/dVCCYEH9wwnr+ohOiI3tMd/D3yUYOdR+2KGZBCn8qG4MQRczOsT9hm/jhMiMjokwNqxJN++4Cf50xQ==
		//gR214%2BX%2FdVCCYEH9wwnr%2BohOiI3tMd%2FD3yUYOdR%2B2KGZBCn8qG4MQRczOsT9hm%2FjhMiMjokwNqxJN%2B%2B4Cf50xQ%3D%3D
	    urlBuilder.append("?serviceKey=gR214%2BX%2FdVCCYEH9wwnr%2BohOiI3tMd%2FD3yUYOdR%2B2KGZBCn8qG4MQRczOsT9hm%2FjhMiMjokwNqxJN%2B%2B4Cf50xQ%3D%3D"); /*Service Key*/
	    
	    // ** 요청
	    // 3. URL 객체 생성.
	    URL url = new URL(urlBuilder.toString());
	    // 4. 요청하고자 하는 URL과 통신하기 위한 Connection 객체 생성.
	    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	    // 5. 통신을 위한 메소드 SET.
	    conn.setRequestMethod("POST");
	    conn.setDoOutput(true); 
	    
	    // 6. 통신을 위한 Content-type, Accept SET. 
	    conn.setRequestProperty("Content-type", "application/json");
	    conn.setRequestProperty("Accept", "application/json");
	    
	    // 7. json형태의 request data stream
	    String launch_date = vo.getLaunch_date().replace("-", "");
	    String jsonString = "{"
		    					+ "\"businesses\":["
		    						+ "{"
			    						+ "\"b_no\":\"" + vo.getEmployer_id() + "\","
			    						+ "\"start_dt\":\"" + launch_date + "\","
			    						+ "\"p_nm\":\"" + vo.getRepresentative() + "\","					
			    						+ "\"b_nm\":\"" + vo.getCompany_name() + "\","
			    						+ "\"corp_no\":\"" + vo.getCorporation_id() + "\","
			    						+ "\"b_sector\":\"" + vo.getBusiness_type() + "\","
			    						+ "\"b_type\":\"" + vo.getBusiness_items() + "\""
			    					+ "}"
		    					+ "]"
	    					+ "}";
	    byte[] out = jsonString.getBytes(StandardCharsets.UTF_8);
	    int length = out.length;	    
	    conn.setFixedLengthStreamingMode(length);
	    
	    OutputStream os = conn.getOutputStream();
	    os.write(out);
	    os.flush();  
	    	    
	    // ** 응답 & 응답 결과 처리
	    // 8. 통신 응답 코드 확인.
	    System.out.println("Response code: " + conn.getResponseCode());
	    
	    // 9. 전달받은 데이터를 BufferedReader 객체로 저장.
	    BufferedReader rd;
	    if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
	        rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	    } else {
	        rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	    }
	    // 10. 저장된 데이터를 라인별로 읽어 StringBuilder 객체로 저장.
	    StringBuilder sb = new StringBuilder();
	    String line;
	    while ((line = rd.readLine()) != null) {
	        sb.append(line);
	    }
	    // 11. BufferedReader 객체 해제.
	    rd.close();
	    conn.disconnect();
	    // 12. 전달받은 데이터 확인.
	    // => Console 에서 줄바꿈이 안되면 우클릭 후 팝업메뉴에서 -> Word Wrap 을 선택
	    //System.out.println(sb.toString());
	    
	    // ** 전달된 자료를 JSON 형태로 변환 
	    // => 현재 sb 에 저장된 자료는 문자형태로 되어있지만, 
	    //    API 문서의 데이터 표준은 JSON 이므로 JSON 형태로 변환해야 사용가능함  
	    
	    // 1. 문자열 형태의 JSON을 파싱하기 위한 JSONParser 객체 생성.
	    JSONParser parser = new JSONParser();
	    JSONObject obj = null;
	    
	    // 2. JSON 을 파싱 : 문자열을 JSON 형태로 JSONObject 객체에 저장. 	
	    try {
	    	 obj = (JSONObject)parser.parse(sb.toString());  // Checked Exception
		} catch (ParseException e) {
			System.out.println("response 변환(파싱) 실패");
	        e.printStackTrace();
		}
	           
	    // 3. 필요한 자료들을 타입별로 가져와 사용하기 	    
	    // ** Jsp 사용시 model에 담아준다.
	    String status_code = (String)obj.get("status_code");
	    mv.addObject("status_code", status_code);
	    
	    JSONArray ja = (JSONArray)obj.get("data");
	    if(ja!=null) {
	    	JSONObject data = (JSONObject)ja.get(0);
	    	if(data!=null) {
	    		String valid = (String)data.get("valid");
	    		mv.addObject("valid", valid);
		    	JSONObject status = (JSONObject)data.get("status");
		    	if(status!=null) {
		    		String b_stt = (String)status.get("b_stt");
		    		mv.addObject("b_stt", b_stt);
		    	}
	    	}	    		
	    }
		
		mv.setViewName("jsonView");
		return mv;
	}
}
