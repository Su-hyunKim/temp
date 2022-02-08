package vo;

import lombok.Data;

@Data
public class FollowVO extends MemberVO {
	private int follow_seq;
	private String following; //팔로워를 한 사람
	private String follower; //팔로워를 당한 사람
	private String regdate; //팔로워한 일시

} //class
