package vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class purproductVO {
	private int purproduct_id; // 주문한 상품 id(auto)
	private String pur_id;	   // 주문 id
	private int product_id;	   // 주문한 상품 id
	private int product_count; // 주문한 상품 수량
	private int product_price; // 주문한 상품 한개 가격(원가)
	private double product_dc; // 주문한 상품 할인율(백분율 10%=0.10)
	private double save_point; // 적립 포인트
}
