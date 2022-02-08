package vo;


import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class RootVO {
	private int root_seq;
	private String type;
	private String title;
	private String member_id;
	private String regdate;
	private String content;
	private String files;
	private String product_id;
	private int good;
	private int cnt;
	private String status; 
	private MultipartFile filesf;
	
	private String[] check;
	// ** 배열타입 (CheckBox 처리) 
	// => 배열타입 검색조건 처리
	// ** 전송 자료가 {'A','B','C'} 가정하면
	// => Sql 
	// where lev='A' or lev='B' or lev='C' ..
	// where lev in ('A','B','C')
		
	
} //class
