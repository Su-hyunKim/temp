package mapperInterface;

import vo.PointsVO;

public interface PointsMapper {
	
	// **  CRUD
	int send(PointsVO pvo); //send
	int updategiver(PointsVO pvo);
	int updategrantee(PointsVO pvo);
	int mypoint(PointsVO pvo);
	
} //interface
