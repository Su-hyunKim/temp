package vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class SellerVO extends MemberVO{
	private String company_name;
	private String representative;
	private String employer_id;
	private String corporation_id;
	private String launch_date;
	private String location1;
	private String location2;
	private String location3;
	private String business_email;
	private String business_phone;
	private String business_type;
	private String business_items;
	private String tax_office;
	private String logo;
	private MultipartFile logof;	
	private List<ProductVO> productList;
} //class
