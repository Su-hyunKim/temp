package vo;

import lombok.Data;

@Data
public class CommentsVO {
	private int reply_seq;
	private int root_seq;
	private String member_id;
	private String regdate;
	private String texts;
	private String rating;
} //class
