package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mapperInterface.PointsMapper;
import vo.PointsVO;

@Service
public class PointsServiceImpl implements PointsService{
	
	@Autowired
	PointsMapper dao;
	
	@Override
	public int send(PointsVO pvo) {
		return dao.send(pvo) ;
	}

	@Override
	public int updategiver(PointsVO pvo) {
		return dao.updategiver(pvo);
	}

	@Override
	public int updategrantee(PointsVO pvo) {
		return dao.updategrantee(pvo);
	}

	@Override
	public int mypoint(PointsVO pvo) {
		return dao.mypoint(pvo);
	}

}
