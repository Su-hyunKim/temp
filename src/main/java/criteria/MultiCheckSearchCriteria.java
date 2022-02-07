package criteria;

import lombok.Data;

@Data
public class MultiCheckSearchCriteria extends Criteria {
	
	private String searchType;
	private String keyword;
	private String[] check1;
	private String[] range1;
	private String column;
	private String order;

} //class
