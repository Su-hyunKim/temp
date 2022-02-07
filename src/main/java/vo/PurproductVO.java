package vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class PurproductVO {
	
	private int purchase_pid;	
	private String purchase_id; // 구매 id
	private String product_id; 	// 구매상품 id
	private int product_count; 	// 구매상품 선택 갯수
	private int price;         	// 구매상품 한개 가격
	private int product_dc;    	// 구매상품 할인률
	private int savePoint;     	// 구매상품 포인트 적립
} //class