package vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class ProductVO extends MemberVO{

	private String product_id ;
	private MultipartFile product_imgfile;
	private String detprod_num;
	private String idtprod_num;
	private String category;
	private String name;
	private String currency;
	private int price;
	private int quantity;
	private String regdate;
	private String member_id; 
	private String status;
	private String product_desc;
	private int cnt;
	
	private String[] check;	
}
