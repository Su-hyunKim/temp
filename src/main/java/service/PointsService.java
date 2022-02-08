package service;

import vo.PointsVO;

public interface PointsService {
	
	// **  CRUD
	int mypoint (PointsVO pvo);
	int send(PointsVO pvo); //send 
	int updategiver(PointsVO pvo); //updategiver
	int updategrantee(PointsVO pvo); //updategrantee
	
}