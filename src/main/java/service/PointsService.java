package service;

import vo.PointsVO;

public interface PointsService {
	
	// **  CRUD
	int send(PointsVO vo); //send
	int updategiver(PointsVO vo); //updategiver
	int updategrantee(PointsVO vo); //updategrantee
	
}