package security;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

public class LoginFailureHandler implements AuthenticationFailureHandler {

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException authentication)
			throws IOException, ServletException {
		String message = "";
		
		if(authentication instanceof BadCredentialsException) message = "ID 나 Password를 다시 확인해주세요";
		else if(authentication instanceof DisabledException) message = "존재하지 않는 계정입니다.";
		else message = "다시 입력해주세요"; 
		
		// response 의 한글 처리
		response.setContentType("text/html; charset=UTF-8");
		
		PrintWriter out = response.getWriter();
		JsonObject json = new JsonObject();
		json.addProperty("loginSuccess", "F");
		json.addProperty("message", message);
		out.write(new Gson().toJson(json));
		out.flush();		
	}
	
} //class
