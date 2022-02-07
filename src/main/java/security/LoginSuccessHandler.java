package security;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

// ** 로그인(인증) 성공이후 특정동작을 하도록 제어함
// => AuthenticationSuccessHandler interface 를 구현하여 작성함
// => 로그인한 사용자에게 부여된 권한(Authentication) 객체를 이용해서
//    사용자가 가진 모든 권한을 문자열로 확인하고 처리해줌. 
// 
// ** Authentication (입증, 증명, 인증) 
// => interface
// => 메서드 getAuthorities() return Type
//	  : Collection<? extends GrantedAuthority> 
//		Collection 타입제한, 타입인자로 GrantedAuthority 또는 이를 상속하는 클래스만 올 수 있음

// ** GrantAuthority (i)
// => 현재 사용자(principal)가 가지고 있는 권한을 의미
// => 특정 자원에 대한 권한이 있는지를 검사하여 접근 허용 여부를 결정한다.
// => 계층도
//    Serializable (i) -> GrantAuthority (i) -> SimpleGrantedAuthority 구현클래스

public class LoginSuccessHandler implements AuthenticationSuccessHandler {
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		String id = request.getParameter("username");
		HttpSession session = request.getSession();
		List<String> roleNames = new ArrayList<>();
		
		// authentication.getAuthorities() : Collection<....>
		authentication.getAuthorities().forEach(
				authority -> { roleNames.add(authority.getAuthority()); });
		// authentication.getAuthorities() 객체의 값들을 하나씩 roleNames 에 담는 반복문 
		// => for 문으로 변형해보면
		// 		for (String authority : authentication.getAuthorities()) {
		//       		roleNames.add(authority); }
		
		/* *** 람다식, 또는 람다 함수 
		   => 익명 함수(Anonymous functions)를 지칭하는 용어로써 JAVA8 버전부터 지원.
		   => 매개변수 -> {실행문 ...}
		      매개 변수를 이용해서 중괄호 블록을 실행한다는 의미
		      예제 : for (String s : list) {  System.out.println(s);  }
		      		list.forEach(s -> System.out.println(s));*/
		
		session.setAttribute("loginID",id);
		session.setAttribute("role",roleNames);
		
		// response 의 한글 처리
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		JsonObject json = new JsonObject();
		json.addProperty("loginSuccess", "T");
		json.addProperty("id", id);
		out.write(new Gson().toJson(json));
		out.flush();
	}
} //class
