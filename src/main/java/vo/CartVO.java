package vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class CartVO {
	private int cart_id; 		// 카트 아이디
	private String member_id;	// 멤버 아이디
	private int product_id;		// 상품 아이디
	private int product_count;	// 상품 선택 갯수
}
