package service;

import java.util.Random;

import javax.mail.Message.RecipientType;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class MemberMailSendService {
	@Autowired
	private JavaMailSender mailSender;
//	@Autowired
//	private MemberMapper dao;
	
	// 이메일 난수 만드는 메서드
	private String init() {
		Random ran = new Random();
		StringBuffer sb = new StringBuffer();
		int num = 0;

		do {
			num = ran.nextInt(75) + 48;
			if ((num >= 48 && num <= 57) || (num >= 65 && num <= 90) || (num >= 97 && num <= 122)) {
				sb.append((char) num);
			} else {
				continue;
			}

		} while (sb.length() < size);
		if (lowerCheck) {
			return sb.toString().toLowerCase();
		}
		return sb.toString();
	}

	// 난수를 이용한 키 생성
	private boolean lowerCheck;
	private int size;

	public String getKey(boolean lowerCheck, int size) {
		this.lowerCheck = lowerCheck;
		this.size = size;
		return init();
	}

	// 회원가입, 판매자전환 시 발송 이메일(인증키 발송)
	public String mailSendWithMemberKey(String email, String member_id) {
		
		String key = getKey(false, 20);
		//dao.GetKey(vo.getKey(vo)); 
		MimeMessage mail = mailSender.createMimeMessage();
		String htmlStr = "<h2>안녕하세요 징검다리 입니다!</h2><br><br>"
				+ "<h3>" + member_id + "님</h3>" + "<p>"
				//+ "<h3>" + member_id + "님</h3>" + "<p>인증하기 버튼을 누르시면 로그인을 하실 수 있습니다 : " 
				//+ "<a href='http://localhost:8080" + request.getContextPath() + "/emailauth?member_id="+ member_id +"&member_key="+key+"'>인증하기</a></p>"
				+ "인증키는 "+key+" 입니다.<br>인증 절차를 완료해 주시기 바랍니다.</p>"
				+ "(혹시 잘못 전달된 메일이라면 이 이메일을 무시하셔도 됩니다)";
		try {
			mail.setSubject("[본인인증] 징검다리 인증메일입니다", "utf-8");
			mail.setText(htmlStr, "utf-8", "html");
			mail.addRecipient(RecipientType.TO, new InternetAddress(email));
			mailSender.send(mail);
			return key;
		} catch (MessagingException e) {
			e.printStackTrace();
			return null;
		}		
	} //mailSendWithMemberKey
	
	// 임시비밀번호 발송 이메일
	public String mailSendWithTempararyPW(String email, String member_id) {		
		String key = getKey(false, 15);
		MimeMessage mail = mailSender.createMimeMessage();
		String htmlStr = "<h2>안녕하세요 징검다리 입니다!</h2><br><br>"
				+ "<h3>" + member_id + "님</h3>" + "<p>"
				+ "임시비밀번호는 "+key+" 입니다.<br>임시비밀번호로 로그인 후 회원정보수정에서 비밀번호를 수정해 주시기 바랍니다.</p>"
				+ "(혹시 잘못 전달된 메일이라면 이 이메일을 무시하셔도 됩니다)";
		try {
			mail.setSubject("[임시비밀번호] 징검다리 임시비밀번호 발급 메일입니다", "utf-8");
			mail.setText(htmlStr, "utf-8", "html");
			mail.addRecipient(RecipientType.TO, new InternetAddress(email));
			mailSender.send(mail);
			return key;
		} catch (MessagingException e) {
			e.printStackTrace();
			return null;
		}		
	} //mailSendWithTempararyPW
}
