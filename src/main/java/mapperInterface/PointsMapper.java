package mapperInterface;

import vo.PointsVO;

public interface PointsMapper {
	
	// **  CRUD
	int send(PointsVO vo); //send
	int updategiver(PointsVO vo);
	int updategrantee(PointsVO vo);
	
} //interface
