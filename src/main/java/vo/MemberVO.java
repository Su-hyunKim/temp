package vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class MemberVO{
	private int point;
	private String member_id;
	private String name;
	private String password;
	private String gender;
	private String birthday;
	private String address1;
	private String address2;
	private String address3;
	private String email;
	private String phone;
	private String interest;
	private String sns;
	private String profile;
	private String last_access;
	private String status; // "0":미인가
	private String remarks;
	private Boolean enabled; // '0':휴면(false) '1':active(true)
	private List<AuthVO> authList;
	private MultipartFile profilef;		
	private String[] check;
	// ** 배열타입 (CheckBox 처리) 
	// => 배열타입 검색조건 처리
	// ** 전송 자료가 {'A','B','C'} 가정하면
	// => Sql 
	// where lev='A' or lev='B' or lev='C' ..
	// where lev in ('A','B','C')
	
} //class
