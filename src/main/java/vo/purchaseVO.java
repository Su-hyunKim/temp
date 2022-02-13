package vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class purchaseVO {
	String pur_id; 			// 주문 아이디
	String addressee;		// 배송 받는사람의 이름
	String member_id;		// 주문한 사람의 아이디		
	String member_address1; // 주문한 사람의 배송주소
	String member_address2; // 주문한 사람의 배송주소
	String member_address3; // 주문한 사람의 배송주소
	String pur_status;		// 주문 상태 ('배송준비', '배송취소', '배송중','배송완료')
	int delivery_cost;		// 배송비
    int use_point;			// 주문시 회원이 사용한 포인트
    String pur_Date;		// 주문한 날짜
}
