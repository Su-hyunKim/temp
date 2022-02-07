package vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class PurchaseVO {
	
	private String purchase_id;
	private String addressee;
	private String member_id;
	private String adress1;
	private String adress2;
	private String adress3;
	private String purchase_status;
	private int delivery_cost;
	private int usePoint;
	private Date purchaseDate;	

} //class